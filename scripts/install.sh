#!/usr/bin/env bash
# 专利战术板一键安装（macOS / Linux，需 git、node、python3）
set -e
SK="$HOME/.claude/skills"
mkdir -p "$SK"
echo "▶ 安装 machine-skill"
npx skills add AirsupHQ/machine-skill -g -a claude-code
echo "▶ 安装 patent-disclosure-skill"
if [ ! -d "$SK/patent-disclosure-skill" ]; then
  git clone https://github.com/TUANZIDING/patent-disclosure-skill.git "$SK/patent-disclosure-skill"
fi
python3 -m pip install -r "$SK/patent-disclosure-skill/requirements.txt"
echo "▶ 安装 patent-machine-playbook（本仓库）"
if [ ! -d "$SK/patent-machine-playbook" ]; then
  git clone https://github.com/TUANZIDING/-patent-machine-playbook.git "$SK/patent-machine-playbook"
fi
echo "✅ 完成。在 Claude Code 中输入：/patent-machine-playbook <项目资料路径>"
