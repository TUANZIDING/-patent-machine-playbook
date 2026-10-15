---
name: patent-machine-playbook
description: "专利战术板：把原有项目改进成发明专利交底书的总调度技能。串联 patent-disclosure-skill（挖点/查新/交底书）与 machine-skill（3D 建模/物理求解），并强制执行申请前不公开、诊疗方法改写为装置/系统、仿真数据如实标注等规则。| Orchestrates patent-disclosure-skill and machine-skill into an invention-patent disclosure workflow."
version: "0.1.0"
user-invocable: true
argument-hint: "[项目资料路径] [可选：类型=发明|实用新型]"
allowed-tools: Read, Write, Edit, Grep, Glob, WebSearch, Bash
---

# 专利战术板 · Patent Playbook（四分卫 / 总调度）

本技能**不自己写交底正文、不自己建模**。它只负责路线、规则和交接：
- 专利正文 → `patent-disclosure-skill`（跑卫 RB）
- 3D 模型与量化数值 → `machine-skill`（外接手 WR，`/machine`）

依赖未安装时，先提示用户运行本仓库 `scripts/install.sh`。

## 铁律（每一步都检查）

1. **申请前不公开**：machine-skill 生成的 HTML、视频、截图只保存在本地 `outputs/`；禁止上传 airsup.ai、GitHub Pages、社交媒体或任何公开地址；禁止运行会发布内容的命令。
2. **诊疗方法不可专利**（专利法第 25 条）：若方案本质是疾病诊断或治疗方法，必须改写为「装置 / 系统 / 器械 / 计算机系统」的权利主题，并在交底书中提示代理人。
3. **仿真≠实验**：machine-skill 求解器给出的数值一律标注「仿真计算结果（模型假设见附录）」，并列出公式、输入与假设；不得写成实验或临床结论。
4. **不编造**：现有技术只引用查新真实检索到的公开号；数据缺失写「待补充」，不得臆造。
5. **用户拍板点**：第 2 步（选专利点）和第 6 步（交代理人前）必须停下来等用户确认。

## 六步路线

| 步 | 动作 | 执行者 | 产出 |
|---|---|---|---|
| 01 | 整理原项目：读取用户给的路径，列出原方案结构、痛点、已有数据 | 本技能 | `outputs/01_项目摘要.md` |
| 02 | 挖点 + 查新：调用 patent-disclosure-skill 模式 A（类型默认发明），给出 3–5 个候选点与国知局对比 | patent-disclosure-skill | 候选点表 → **等用户选** |
| 03 | 3D 建模验证：对选定改进点调用 `/machine`，描述改进后结构；记录求解器公式、输入、输出 | machine-skill | `outputs/03_model.html` + `outputs/03_仿真记录.md` |
| 04 | 回填技术效果：把 03 的数值按铁律 3 写入交底书「技术效果」；剖视图只作附图参考，不直接入文 | patent-disclosure-skill（迭代模式） | 交底书新版本 |
| 05 | 成稿 + 自检：md + docx；方法用 mermaid 流程图；结构类走 figure_plan 线稿 | patent-disclosure-skill | `{案件名}_{时间戳}.md/.docx` |
| 06 | 交付清单：列出需用户补充的实验/临床数据、待代理人确认的权利要求要点、公开风险自查 | 本技能 | `outputs/06_交付清单.md` → **等用户确认** |

## 调用方式

```
/patent-machine-playbook <项目资料路径>
```

或自然语言：「用专利战术板把 <路径> 里的项目改成发明专利交底书」。

## 第 3 步给 /machine 的描述模板

```
/machine <改进后器械名称>，<核心结构一句话>，重点展示 <改进部件> 的工作原理，
求解 <关键物理量，如压力/流量/力/温度> 随 <变量> 的变化；只在本地保存，不录制公开视频。
```

## 第 6 步交付清单模板

见 `templates/交付清单.md`。
