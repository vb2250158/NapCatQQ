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

- 这是第三方 QQNT / OneBot 11 方案，不是官方 QQBot，账号存在风控与稳定性风险。
- 上游不再修 bug。QQ 客户端升级后协议可能失效，届时 `packages/napcat-protocol`、`napcat-native` 需要自己跟进。
- 构建沿用原仓库：`pnpm i` 后按根 `package.json` 的脚本执行（`build:shell`、`build:framework`、`build:webui`、`build:plugin-builtin`）。
- 本机已部署的安装包是 `NapCat.44498.Shell`（QQ 9.9.26-44498），与本源码基线不必完全对应，改动前先核对。

## 相关

- `vb2250158/NapCatQQ-empty`：同一 fork 网络里的空壳占位（上游清空后 fork 所得，只有 README），保留作对照，不代表可用代码。
