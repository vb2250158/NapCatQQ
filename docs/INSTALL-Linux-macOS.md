# NapCat 4.18.4 — Linux / macOS

这份包是 NapCat 4.18.4 的跨平台部分，来自 https://github.com/vb2250158/NapCatQQ
（上游 `NapNeko/NapCatQQ` 已于 2026-11-12 清空仓库并删除 Releases）。

## 原理

QQ 是 Electron 应用。把它的 `resources/app/package.json` 里的 `main` 指向 NapCat 入口，
QQ 启动时就会先加载 NapCat，由 NapCat 接管协议并对外暴露 OneBot 11 接口。

Windows 上的 `NapCatWinBootMain.exe` 只是替你做这件事的启动器；
Linux / macOS 直接改 `package.json` 即可，不需要额外的 exe / dll。

## Linux

1. 安装官方 QQNT（deb / rpm / AppImage），先正常启动一次再退出。
2. 找到资源目录，常见位置：
   - deb / rpm：`/opt/QQ/resources/app`
   - AppImage：挂载后的 `squashfs-root/resources/app`
3. 备份原配置：
   ```bash
   cd /opt/QQ/resources/app
   sudo cp package.json package.json.bak
   ```
4. 把本包解压出的 `napcat/` 整个目录放进去：
   ```bash
   sudo cp -r napcat /opt/QQ/resources/app/
   ```
5. 把 `main` 指向 NapCat 入口：
   ```bash
   sudo sed -i 's#"main": *"[^"]*"#"main": "./napcat/napcat.mjs"#' /opt/QQ/resources/app/package.json
   grep '"main"' /opt/QQ/resources/app/package.json
   ```
   结果应为 `"main": "./napcat/napcat.mjs"`。
6. 启动 QQ。控制台会打印 WebUI 地址与 token，默认 `http://127.0.0.1:6099/webui`。

## macOS

1. 安装官方 QQNT（dmg），启动一次再退出。
2. 资源目录：`/Applications/QQ.app/Contents/Resources/app`
3. 备份并安装：
   ```bash
   cd /Applications/QQ.app/Contents/Resources/app
   sudo cp package.json package.json.bak
   sudo cp -r /path/to/napcat ./napcat
   sudo sed -i '' 's#"main": *"[^"]*"#"main": "./napcat/napcat.mjs"#' package.json
   ```
4. 必须重新签名，否则 QQ 拒绝启动：
   ```bash
   sudo codesign --force --deep --sign - /Applications/QQ.app
   ```
5. 启动 QQ，看控制台输出的 WebUI 地址。

macOS 的 QQ 在 Electron 里以 `QQ Helper` 子进程运行，NapCat 已按这个模型处理
（见 `packages/napcat-shell/process-api.ts`）。

## 数据目录

- Linux：`~/.config/QQ`
- macOS：`~/Library/Application Support/QQ`

NapCat 的配置、日志、插件都在这里，与 Windows 的 `nt_qq/global` 布局不同（代码里有分支处理）。

## 限制

- 本包在 Windows 上构建。原生库覆盖 `linux-x64`、`linux-arm64`、`darwin-x64`、`darwin-arm64`、`win32-x64`。
- `native/pty` 只有 linux 与 win32 目录，**macOS 的 WebUI 终端面板不可用**，不影响消息收发。
- macOS 改动 `.app` 内容会破坏签名，必须重签；QQ 自动更新后需要重做一遍。
- 未在真实 Linux / macOS 机器上验证（构建机是 Windows）。遇到问题请到仓库开 issue，
  附上启动日志与 `ldd`（Linux）/ `otool -L`（macOS）的输出。
- 第三方实现，不是官方 QQBot。账号有风控风险，请用专用小号。

## 回滚

把 `package.json.bak` 改回 `package.json`，删掉 `napcat/` 目录即可。
macOS 再执行一次 `codesign --force --deep --sign - /Applications/QQ.app`。
