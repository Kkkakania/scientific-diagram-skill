# Scientific Diagram Skill

[English](README.md) | [简体中文](README.zh-CN.md)

[![Quality](https://github.com/Kkkakania/scientific-diagram-skill/actions/workflows/quality.yml/badge.svg)](https://github.com/Kkkakania/scientific-diagram-skill/actions/workflows/quality.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

`scientific-diagram-skill` 是一个面向科研和工程示意图的 Codex skill。它适合让 agent 先用 Mermaid 草拟结构，再在需要可编辑源文件时转成 draw.io / diagrams.net 的 `.drawio` 文件。

它不负责画数据图。数据图更适合放在
[`matlab-plotting-skill`](https://github.com/Kkkakania/matlab-plotting-skill)
或 [`matlab-scientific-figures`](https://github.com/Kkkakania/matlab-scientific-figures)
里处理。这个仓库只处理方法流程图、系统框图、信号链路、实验流程、维护工作流这类“解释结构”的图。

## 为什么单独做一个仓库

科研项目里常见两类图。

第一类是数据图，问题通常是选什么图、坐标轴怎么写、导出格式是否清楚。第二类是示意图，风险不一样：可能不小心照着论文图重画，可能把私人路径或标记留在文件里，也可能只导出一张图片，后面没人能继续改。

这个 skill 处理第二类问题。它把 `.drawio` 源文件、SVG 预览和来源说明放在一起，方便维护者检查哪些内容可以公开。

## 安装

把 skill 目录复制到 Codex 的 skill 目录：

```bash
mkdir -p ~/.codex/skills
cp -R skills/scientific-diagram-skill ~/.codex/skills/
```

然后可以这样使用：

```text
Use scientific-diagram-skill to sketch this method pipeline.
Review this draw.io experiment diagram before I put it in a README.
Turn this system description into Mermaid first, then create an editable draw.io source.
```

项目内安装方式和检查命令见 [`docs/install-targets.md`](docs/install-targets.md)。
第一次使用后的反馈，先看 [`docs/first-use-feedback.md`](docs/first-use-feedback.md)，
再打开
[diagram feedback 表单](https://github.com/Kkkakania/scientific-diagram-skill/issues/new?template=diagram_feedback.md)。

## 仓库里有什么

- `SKILL.md`：skill 的触发说明和主要流程。
- `references/drawio-workflow.md`：写 `.drawio` 文件时需要注意的结构。
- `references/diagram-quality-checklist.md`：科研示意图审查清单。
- `references/export-and-provenance.md`：公开导出和来源说明规则。
- `assets/examples/research-method-flow.drawio`：一个可编辑示例。
- `assets/examples/research-method-flow.svg`：对应的 SVG 预览。
- `assets/examples/provenance.md`：说明示例如何生成、是否使用私人材料。

## 检查示例

修改示例前先运行：

```bash
python3 scripts/check_diagram_examples.py
./tests/test_scientific_diagram_skill.sh
./tests/test_scientific_diagram_examples.sh
```

检查脚本会解析 `.drawio` XML 和 SVG，确认关键标签存在，同时扫描邮箱、本地路径、平台痕迹、来源风险词和常见个人信息关键词。

## 贡献和安全边界

提交 PR 前看 [CONTRIBUTING.md](CONTRIBUTING.md)。如果发现隐私或来源风险，看
[SECURITY.md](SECURITY.md)。不要把私人示意图、截图、本地路径、邮箱或照着论文图重画的内容贴到公开 issue。

## 和其他绘图仓库的关系

这个仓库是科研绘图工作流里的 diagram 层：

- [`matlab-scientific-figures`](https://github.com/Kkkakania/matlab-scientific-figures)
  放 clean-room MATLAB 图表模板和 gallery。
- [`matlab-figure-ci`](https://github.com/Kkkakania/matlab-figure-ci)
  检查隐私、来源、禁用文件、gallery 和可选 MATLAB 渲染。
- [`matlab-plotting-skill`](https://github.com/Kkkakania/matlab-plotting-skill)
  帮 agent 选择和渲染 MATLAB 数据图。
- [`python-plotting-skill`](https://github.com/Kkkakania/python-plotting-skill)
  是 Python / Matplotlib 方向的对应 skill。

这里不写虚假的下载量、使用量或影响力。仓库保持小，是因为科研示意图更需要边界清楚，而不是模板越多越好。

## 公开内容规则

- 示例只使用合成标签和 clean-room 结构。
- 不照搬论文、幻灯片、截图、Nature/Science 示例或私人文件里的图。
- 不提交隐藏签名、邮箱、学校名、本地路径、logo、原始截图或二进制素材包。
- 文档里需要图时，尽量同时保留 `.drawio` 源文件和 SVG 预览。
- 公开示例要写简短来源说明。

## 当前限制

- 目前只带一个小示例。
- 不自动调用 diagrams.net。
- 没有人审查前，不声称图已经达到论文最终版。
- 这是 skill 包，不是完整画图软件。

## 许可证

MIT。
