<img src="https://napneko.github.io/assets/newnewlogo.png" width = "305" height = "411" alt="NapCat" align=right />
<div align="center">

# NapCat

_Modern protocol-side framework implemented based on NTQQ._

> 云起兮风生，心向远方兮路未曾至.

</div>

---

> [!IMPORTANT]
> **这是上游停止维护后的恢复副本。**
>
> `NapNeko/NapCatQQ` 于 2026-11-10 宣布 Ending，2026-11-12 清空仓库内容并把历史重写为只剩 README 的孤儿提交，Releases 与 Tags 也一并删除。原仓库现在既取不到源码，也下不到安装包。
>
> 本仓库保存清空前的最后一份完整源码（上游提交 `72912f2`），并重新提供可用的安装包：
>
> - 直接使用：[Releases](https://github.com/vb2250158/NapCatQQ/releases)
>   - Windows：`NapCat.Shell.Windows.OneKey.zip`
>   - Linux / macOS：`NapCat.Shell.Linux-macOS.zip`
> - 源码基线、恢复过程与已知限制：[FORK-NOTES.md](./FORK-NOTES.md)
> - 上游原话是「如果感兴趣可以自行 Fork」，本仓库就是在做这件事。

## 从这个仓库安装

### Windows

1. 到 [Releases](https://github.com/vb2250158/NapCatQQ/releases) 下载 `NapCat.Shell.Windows.OneKey.zip`（约 29 MB）。
2. 解压到任意目录，得到 `NapCatInstaller.exe`、`NapCat.Shell.zip`、`7z.exe`、`7z.dll`。
3. 运行 `NapCatInstaller.exe`，解出 `NapCat.<build>.Shell` 目录。
4. 运行 `NapCat.<build>.Shell\napcat.bat`，它会拉起 QQ 并注入 NapCat。
5. 首次启动会打印 WebUI 地址与 token，浏览器打开 `http://127.0.0.1:6099/webui`，扫码登录专用 QQ 号（不要用主号）。
6. 在 WebUI 的「网络配置」里加 OneBot 服务：
   - HTTP Server：`127.0.0.1:3000`
   - WebSocket Client（反向 WS）：`ws://127.0.0.1:<你的网关端口>`
7. 验证：`POST http://127.0.0.1:3000/get_status` 能返回 JSON 即通。

### Linux / macOS

下载 `NapCat.Shell.Linux-macOS.zip`（约 33 MB），包内 `INSTALL-Linux-macOS.md` 是完整步骤。核心只有两步：

1. 把包里的 `napcat/` 放到 QQ 的 `resources/app/napcat`：
   - Linux：`/opt/QQ/resources/app`（deb / rpm），AppImage 为挂载后的 `squashfs-root/resources/app`
   - macOS：`/Applications/QQ.app/Contents/Resources/app`
2. 把该目录 `package.json` 的 `main` 改成 `./napcat/napcat.mjs`（改前先备份）。

macOS 还要重新签名，否则 QQ 拒绝启动：

```bash
sudo codesign --force --deep --sign - /Applications/QQ.app
```

数据目录：Linux `~/.config/QQ`，macOS `~/Library/Application Support/QQ`。

不需要 Windows 那套 exe / dll——QQ 本身是 Electron，改了 `main` 就会先加载 NapCat。Windows 的 `NapCatWinBootMain.exe` 只是替你干这件事。

本副本对应 **NapCat 4.18.4 / QQ 9.9.26-44498**。QQ 客户端升级后注入可能失效，换版本前先确认 `packages/napcat-protocol` 与 `packages/napcat-native` 是否覆盖。

## 从源码构建

```bash
pnpm i
pnpm build:shell        # 生成注入产物 napcat.mjs 等
pnpm build:webui        # WebUI 前端
pnpm build:framework
pnpm build:plugin-builtin
```

`pnpm-workspace.yaml` 的 `allowBuilds` 决定哪些依赖允许在安装期执行构建脚本。`esbuild`、`@swc/core`、`sharp`、`ttf2woff2`、`unrs-resolver`、`@heroui/shared-utils` 必须为 `true`，否则 vite 构建会失败。

`@homebridge/node-pty-prebuilt-multiarch` 默认 `false`：它的 postinstall 要从 GitHub Releases 拉预编译二进制，网络不可达时会退回本地 node-gyp 并在 Windows + Node 22 上 `spawn EINVAL`。它只服务 WebUI 的终端面板，不影响 QQ 消息收发。要用终端面板时，把该项改成 `true`，在网络可达的环境重新 `pnpm i`。

## Welcome

- NapCatQQ is a modern implementation of the Bot protocol based on NTQQ.
  - NapCatQQ 是现代化的基于 NTQQ 的 Bot 协议端实现

## Feature

- **Easy to Use**
  - 作为初学者能够轻松使用.
- **Quick and Efficient**
  - 在低内存操作系统长时运行.
- **Rich API Interface**
  - 完整实现了大部分标准接口.
- **Stable and Reliable**
  - 持续稳定的开发与维护.

## Quick Start

上游的 Release 页面已随仓库清空而失效，本仓库的安装包在 [Releases](https://github.com/vb2250158/NapCatQQ/releases) 提供，安装步骤见上方的「从这个仓库安装」。

**首次使用**请务必看完上面的安装步骤与 [FORK-NOTES.md](./FORK-NOTES.md) 里的版本与限制说明。

> 项目非盈利，涉及 对接问题/基础问题/下层框架问题 请自行搜索解决，本项目社区不提供此类解答。

## Link

| Docs | [![Github.IO](https://img.shields.io/badge/docs%20on-Github.IO-orange)](https://napneko.github.io/) | [![Cloudflare.Worker](https://img.shields.io/badge/docs%20on-Cloudflare.Worker-black)](https://doc.napneko.icu/) | [![Cloudflare.HKServer](https://img.shields.io/badge/docs%20on-Cloudflare.HKServer-informational)](https://napcat.napneko.icu/) |
|:-:|:-:|:-:|:-:|

| Docs | [![Cloudflare.Pages](https://img.shields.io/badge/docs%20on-Cloudflare.Pages-blue)](https://napneko.pages.dev/) | [![Server.Other](https://img.shields.io/badge/docs%20on-Server.Other-green)](https://napcat.top/) | [![NapCat.Top](https://img.shields.io/badge/docs%20on-NapCat.Top-red)](https://napcat.top/) |
|:-:|:-:|:-:|:-:|

| QQ Group | [![NapCat Family Group 4](https://img.shields.io/badge/NapCat%20Family%20Group%204-Join-blue)](https://qm.qq.com/q/E4nfkGD6oK) | [![NapCat Family Group 3](https://img.shields.io/badge/NapCat%20Family%20Group%203-Join-blue)](https://qm.qq.com/q/XyiyGPqa42) | [![NapCat Family Group 2](https://img.shields.io/badge/NapCat%20Family%20Group%202-Join-blue)](https://qm.qq.com/q/gq18RH7o7S) | [![NapCat Family Group 1](https://img.shields.io/badge/NapCat%20Family%20Group%201-Join-blue)](https://qm.qq.com/q/VwpnklcXqo) |
|:-:|:-:|:-:|:-:|:-:|

| Telegram | [![Telegram](https://img.shields.io/badge/Telegram-napcatqq-blue)](https://t.me/napcatqq) |
|:-:|:-:|

| DeepWiki | [![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/NapNeko/NapCatQQ) |
|:-:|:-:|

> QQ群因为特殊原因需要入群密钥，请在webui关于页面获取，仅最新的100个版本以内有效。

社区相关日后会进一步加强审核，并严格限制一定时间的入群人数，请具备一定编程基础和问题解决能力再申请入群。

[困困猫猫的高中](https://qm.qq.com/q/14aUVclRUA)

## Thanks

- [Lagrange](https://github.com/LagrangeDev/Lagrange.Core) 对本项目的大力支持 参考部分代码 已获授权

- [AstrBot](https://github.com/AstrBotDevs/AstrBot) 是完美适配本项目的LLM Bot框架 在此推荐一下

- [MaiBot](https://github.com/MaiM-with-u/MaiBot) 一只赛博群友 麦麦 Bot框架 在此推荐一下

- [qq-chat-exporter](https://github.com/shuakami/qq-chat-exporter/) 基于NapCat的消息导出工具 在此推荐一下

- 不过最最重要的 还是需要感谢屏幕前的你哦~

---
## Ending
如果感兴趣可以自行Fork，不再提供除版本更新以外内容，直到失效，如果追求稳定性更推荐官方Bot，非常感谢一路陪伴。

## License

本项目采用 混合协议 开源，因此使用本项目时，你需要注意以下几点：

1. 第三方库代码或修改部分遵循其原始开源许可.
2. 本项目获取部分项目授权而不受部分约束
2. 项目其余逻辑代码采用[本仓库开源许可](./LICENSE).

**本仓库仅用于提高易用性，实现消息推送类功能，此外，禁止任何项目未经仓库主作者授权基于 NapCat 代码开发。使用请遵守当地法律法规，由此造成的问题由使用者和提供违规使用教程者负责。**
