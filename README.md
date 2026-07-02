# Raycast Scripts

个人 Raycast Script Command 集合。

## 当前脚本

| 脚本 | 功能 |
|------|------|
| `copy-finder-path.sh` | 复制选中项或无选中时当前 Finder 窗口的 POSIX 路径 |
| `open-finder-in-vscode.sh` | 用 VS Code 打开选中项 |
| `open-finder-in-iterm2.sh` | 在 iTerm2 中打开选中项所在目录 |

## 安装

```bash
git clone https://github.com/longyijdos/raycast-scripts.git
```

Raycast 设置：**Extensions → Script Commands → Add Script Directory** → 选择克隆下来的目录

## 行为逻辑

- 有选中项 → 对选中项执行操作
- 无选中，但有 Finder 窗口 → 对最前台 Finder 窗口的目录执行
- 什么都没有 → 静默退出
