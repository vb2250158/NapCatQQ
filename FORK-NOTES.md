# 这个仓库是什么

`NapNeko/NapCatQQ` 上游已于 2026-11-10 宣布停止维护（README 只剩 "Ending"），并在 2026-11-12 把仓库清空、历史重写为只剩 README 的孤儿提交（`Keep README only` → `docs: ending`）。原仓库现在 `size=1`，没有可用的代码。

本仓库是清空前的代码副本。

- 基线提交：`72912f2`（`docs: ending`，2026-11-10 09:06 +0800）——上游最后一份完整源码树
- 来源：`renmoren/NapCatQQ-old`（清空之前 fork，历史未被重写）
- 内容：1111 个文件，26 个 package，`packages/` 完整
- 本仓库只有一个提交：浅克隆缺少父提交对象，无法直接推送上游父链，因此按同一棵树重建，作者与日期沿用原作者（MliKiowa）

## 上游原话

> 如果感兴趣可以自行 Fork，不再提供除版本更新以外内容，直到失效。如果追求稳定性更推荐官方 Bot，非常感谢一路陪伴。

## 使用注意

- 这是第三方 QQNT / OneBot 11 方案，不是官方 QQBot，账号存在风控与稳定性风险。用专用小号。
- 上游不再修 bug。QQ 客户端升级后协议可能失效，届时 `packages/napcat-protocol`、`napcat-native` 需要自己跟进。
- 本副本对应 **NapCat 4.18.4 / QQ 9.9.26-44498**。

## 怎么拿到能跑的东西

不想构建就用 Release：

- `NapCat.Shell.Windows.OneKey.zip` → 解压 → `NapCatInstaller.exe` → `NapCat.<build>.Shell\napcat.bat` → WebUI `127.0.0.1:6099` → 扫码
- 安装器需要系统里已有 QQNT 客户端（9.9.x）

## 从源码构建（已在本机验证）

```
pnpm i
pnpm build:webui        # 先出前端，shell 会把它复制进 dist
pnpm build:shell
pnpm build:framework
pnpm build:plugin-builtin
```

验证结果：`pnpm i` 36s、`build:webui` 28s、`build:shell` 17s，产物 `packages/napcat-shell/dist`（108 MB，含 webui + native + plugins），内嵌版本号 `4.18.4`。

### 上游没写、但必踩的两个坑

1. **pnpm 10+ 会拦下依赖的构建脚本**。`pnpm-workspace.yaml` 的 `allowBuilds` 必须让 `esbuild`、`@swc/core`、`sharp`、`ttf2woff2`、`unrs-resolver`、`@heroui/shared-utils` 为 `true`，否则 vite 直接构建失败。
2. **`node-pty` 装不上**（默认已设 `false`）。它的 postinstall 要从 GitHub Releases 拉预编译二进制，拉不到就退回 node-gyp，在 Windows + Node 22 上 `spawn EINVAL`。它只服务 WebUI 的终端面板，不影响消息收发。要终端就把该项改 `true`，在网络可达的环境重装。

另有一个非阻塞告警：`ttf2woff2` 的 node-gyp 在 Python 3.12+ 上因 `distutils` 被移除而失败。它只做字体子集化，失败不影响构建产物。

### 版本号来源已改

`packages/napcat-vite/vite-plugin-version.js` 原本从 `NapNeko/NapCatQQ` 的 tags 取版本，上游删库后回退成 `1.0.0-dev`。现在默认读本仓库 tags，兜底 `4.18.4`；需要换维护仓库时用 `NAPCAT_REPO_OWNER` / `NAPCAT_REPO_NAME` 覆盖。

## 相关

- `vb2250158/NapCatQQ-empty`：同一 fork 网络里的空壳占位（上游清空后 fork 所得，只有 README），保留作对照，不代表可用代码。
