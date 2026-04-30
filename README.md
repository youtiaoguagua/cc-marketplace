# CC Kit

给 Claude Code 用的插件集合。

## 安装

```bash
# 1. 添加市场
/plugin marketplace add https://github.com/youtiaoguagua/cc-marketplace

# 2. 安装插件
/plugin install main-rule@youtiaoguagua-marketplace
/plugin install work-skill@youtiaoguagua-marketplace
```

## 插件列表

### main-rule

> 基础规则插件，提供自动加载的 skill 和 session 启动钩子。

**包含内容：**
- `skills/basic-rule/SKILL.md` — 基础编码规则
- `hooks/hooks.json` — 自动加载 skill 的钩子
- `scripts/start-auto-load-skill.sh` — 启动脚本

**使用方式：** 安装后，每次会话启动自动注入基础规则。

---

### work-skill

> 工作流 skill 包。基于 [Claude Code Best Practices](https://code.claude.com/docs/en/best-practices) 提炼 12 个技能，覆盖完整开发工作流。

**维度一：工作流阶段（核心闭环）**

| Skill | 触发时机 | 解决什么问题 | 描述 |
|-------|---------|-------------|------|
| [`/explore`](work-skill/skills/explore/SKILL.md) | 接触陌生代码时 | 直接开写，改错文件、破坏既有模式、塞爆上下文 | 只读探索，映射结构与模式。用 subagent 隔离上下文。绝不编辑文件。 |
| [`/think`](work-skill/skills/think/SKILL.md) | 动手构建前 | 需求没想清楚就开始写，写到一半发现方向错了 | 质疑需求 → 压力测试设计 → 产出书面计划。模糊需求用 interview 模式深挖。 |
| [`/code`](work-skill/skills/code/SKILL.md) | 实现阶段 | 写好几百行才跑测试，结果一堆错，改不动了 | 先写测试 → 实现 → 验证 → 下一步。失败即停，不堆积问题。 |
| [`/check`](work-skill/skills/check/SKILL.md) | 完成任务后、合并前 | "看起来能用了"但实际有遗留 debug 代码、硬编码、未覆盖的边界情况 | 审查 diff → 跑测试 → 标记危险操作 → 用证据说话。 |
| [`/debug`](work-skill/skills/debug/SKILL.md) | 任何 bug 或异常 | 连猜带试修了好几次，最后加了堆 workaround，bug 还在 | 复现 → 隔离 → 根因 → 修复 → 验证。不治标，只治本。 |

**维度二：会话与环境治理**

| Skill | 触发时机 | 解决什么问题 | 描述 |
|-------|---------|-------------|------|
| [`/session`](work-skill/skills/session/SKILL.md) | 上下文管理 | 一个会话里塞了三个任务，Claude 开始忘事了、质量下降 | clear / compact / rewind / resume。上下文是最稀缺资源。 |
| [`/health`](work-skill/skills/health/SKILL.md) | 审计配置 | CLAUDE.md 臃肿到 Claude 根本不看、规则互相冲突、memory 长期没清理 | 检查 CLAUDE.md、rules、auto memory、hooks、MCP、权限。按严重程度分级。 |

**维度三：规模化**

| Skill | 触发时机 | 解决什么问题 | 描述 |
|-------|---------|-------------|------|
| [`/scale`](work-skill/skills/scale/SKILL.md) | 批量任务、CI | 手上 200 个文件要迁移，一个个手动跑不现实 | Non-interactive 模式、fan-out 并行、Writer/Reviewer 双会话。 |

**维度四：领域专项**

| Skill | 触发时机 | 解决什么问题 | 描述 |
|-------|---------|-------------|------|
| [`/design`](work-skill/skills/design/SKILL.md) | 构建前端界面 | 写出来的 UI 千篇一律，看不出任何设计意图 | 有明确美学方向，screenshot 自验证闭环。不产 generic 默认样式。 |
| [`/learn`](work-skill/skills/learn/SKILL.md) | 深入陌生领域 | 看了一堆资料但知识点散装，串不起来，看完就忘 | 六阶段研究流程：采集→消化→大纲→填充→精炼→自审→发布。 |
| [`/read-url`](work-skill/skills/read-url/SKILL.md) | 任何网页 | URL 抓下来格式混乱、JS 重页面抓不到、GitHub 触发限速 | Exa → Jina Reader → WebFetch 三级降级，选对工具。 |
| [`/write`](work-skill/skills/write/SKILL.md) | 写作或编辑 | 写出来的文字僵硬公式化，像机器翻译，不像人说的话 | 中英文自然表达，消除僵硬公式化措辞。 |

<details>
<summary><b>最佳使用范式</b></summary>

**范式一：从零开发新功能**

```
/explore → /think → /code → /check
  ↓         ↓        ↓        ↓
摸清地形   产出计划   步步验证   合并前审查
```

**范式二：修 bug**

```
/debug → /check
  ↓       ↓
找到根因  验证修复
```

> 两次修不好就 `/clear` 清上下文，不要在失败的上下文里死磕。

**范式三：日常维护**

```
/health → /session → 开始真正的工作
```

**范式四：批量操作**

```
/think → /scale
```

> 先在 2-3 个文件上验证 prompt，再全量跑。

**范式五：学习新技术/代码库**

```
/explore → /read-url → /learn
```

</details>

<details>
<summary><b>核心理念与设计决策</b></summary>

所有技能围绕一个约束设计：**Claude 的 context window 是最稀缺资源**。性能随上下文增长而下降。

1. **验证闭环** — `/code` 和 `/check` 强制可验证的成功标准，不给"看起来好了"任何空间
2. **Plan Mode 前置** — `/think` 分 interview（澄清需求）和 design（技术方案）两个子阶段
3. **失败模式防御** — `/debug` 内建"两次修正即清上下文"规则
4. **CLAUDE.md 减肥** — `/health` 核心原则：删掉 Claude 自己能推断的东西
5. **上下文即资源** — `/session` 独立成 skill，覆盖 clear / compact / rewind / resume

</details>

## 参考

- [Claude Code Best Practices](https://code.claude.com/docs/en/best-practices)
- [How Claude remembers your project](https://code.claude.com/docs/en/memory)
- [How Claude Code Works](https://code.claude.com/docs/en/how-it-works)
- [Extend Claude Code](https://code.claude.com/docs/en/extend)
