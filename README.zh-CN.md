<p align="center">
  <a href="https://bmo.ahas.io/zh/"><img src="https://bmo.ahas.io/icon.svg" alt="BMO" width="120" height="120"></a>
</p>

<h1 align="center">BMO</h1>

<p align="center">运行在你自己机器上的专属 AI 团队：每个人一个 BMO，还有组织及其智能体。</p>

<p align="center">
  <a href="https://bmo.ahas.io/zh/"><img alt="Website" src="https://img.shields.io/badge/website-bmo.ahas.io-6366f1?style=flat-square"></a>
  <a href="LICENSE"><img alt="License: MIT" src="https://img.shields.io/badge/license-MIT-22c55e?style=flat-square"></a>
  <a href="https://bmo.ahas.io/zh/releases/"><img alt="Version" src="https://img.shields.io/github/v/tag/ahas/bmo?include_prereleases&sort=semver&label=version&color=0ea5e9&style=flat-square"></a>
  <a href="https://github.com/sponsors/ahas"><img alt="Sponsor" src="https://img.shields.io/badge/Sponsor-EA4AAA?logo=githubsponsors&logoColor=fff&style=flat-square"></a>
  <img alt="Rust" src="https://img.shields.io/badge/Rust-servers-b7410e?style=flat-square&logo=rust&logoColor=white">
  <img alt="Nuxt" src="https://img.shields.io/badge/Nuxt-console-00dc82?style=flat-square&logo=nuxt&logoColor=white">
  <img alt="Languages" src="https://img.shields.io/badge/i18n-ko%20%C2%B7%20en%20%C2%B7%20ja%20%C2%B7%20zh-f59e0b?style=flat-square">
</p>

<p align="center">
  <a href="https://bmo.ahas.io/zh/">网站</a> · <a href="https://bmo.ahas.io/zh/guide/">指南</a> · <a href="https://bmo.ahas.io/zh/api/">API 参考</a> · <a href="https://bmo.ahas.io/zh/releases/">发布说明</a>
</p>

<p align="center"><a href="README.md">English</a> | <a href="README.ko.md">한국어</a> | <a href="README.ja.md">日本語</a> | <b>简体中文</b></p>

BMO 系统是一组仓库：每个单元一个仓库，全部并排放在这个文件夹里。所有单元遵循的结构见 `STRUCTURE.md`，每个单元的职责见它自己的 README 与文档。本仓库只跟踪结构、这份索引、安装手册及其预设和一个独立脚本；这里不跟踪任何单元，每个单元都以自己的名字克隆到其他单元旁边。

## 安装

BMO 由编程智能体安装，而不是手动安装。在将要运行 BMO 的机器上打开 Claude Code 或 Codex，把下面这一行交给它：

```
阅读 https://bmo.ahas.io/install.md，在这台机器上安装 BMO。
```

智能体按照 `INSTALL.md` 进行：它会问你要 `presets.toml` 中列出的哪种安装——`personal`（个人）、`team`（团队）或 `operator`（运营者），只向你索取只有你才有的东西，完成后告诉你控制台的地址。

## 文件夹

| 文件夹 | 内容 |
|---|---|
| `base/` | 基础库，是其他单元唯一可以引入的一类单元 |
| `resources/` | 只放内容，放在读取方查找的位置，不运行任何东西 |
| `services/` | 每个服务一个文件夹，平台自身的机制也在其中 |
| `tools/` | 工具的开放空间：每个工具一个文件夹，增删时无需改动其他单元 |

## 单元

| 文件夹 | 仓库 | 职责 |
|---|---|---|
| `base/chat` | [bmo-chat](https://github.com/ahas/bmo-chat) | 提供方与接收方之间的聊天协议及其客户端 |
| `base/text` | [bmo-text](https://github.com/ahas/bmo-text) | 按房间、控制台和归档的读法来读写的 Markdown 与文本 |
| `base/ui` | [bmo-ui](https://github.com/ahas/bmo-ui) | 控制台的 Nuxt 层：构成每个界面的设计令牌、组件与行为 |
| `resources/persona` | [bmo-persona](https://github.com/ahas/bmo-persona) | 聊天智能体的人设层与设定集 |
| `resources/skills` | [bmo-skills](https://github.com/ahas/bmo-skills) | 交给工作者的技能，以及分发它们的放置工具 |
| `services/agency` | [bmo-agency](https://github.com/ahas/bmo-agency) | 智能体会话的供给、放置、推进与结束，以及协作者池 |
| `services/arbiter` | [bmo-arbiter](https://github.com/ahas/bmo-arbiter) | 多个引擎共享显卡的 GPU 节点的显卡仲裁 |
| `services/artifact` | [bmo-artifact](https://github.com/ahas/bmo-artifact) | 文档的保存、搜索与分享 |
| `services/brain` | [bmo-brain](https://github.com/ahas/bmo-brain) | 作为中间件的记忆：记录、笔记、监视、提醒、参考文本 |
| `services/cache-siren` | [bmo-cache-siren](https://github.com/ahas/bmo-cache-siren) | 实时监看提示缓存命中与新增 token |
| `services/cache-warmer` | [bmo-cache-warmer](https://github.com/ahas/bmo-cache-warmer) | 保持提示缓存有效的调度器 |
| `services/calendar` | [bmo-calendar](https://github.com/ahas/bmo-calendar) | 日历、日程、提醒与预约 |
| `services/cli` | [bmo-cli](https://github.com/ahas/bmo-cli) | 入口命令，为每个单元找到它自己的命令 |
| `services/discord` | [bmo-discord](https://github.com/ahas/bmo-discord) | Discord 聊天提供方 |
| `services/drive` | [bmo-drive](https://github.com/ahas/bmo-drive) | 横跨网盘、对象存储与节点卷的文件浏览器 |
| `services/explorer` | [bmo-explorer](https://github.com/ahas/bmo-explorer) | 作为上游的网页读取：搜索、页面、预览、图片 |
| `services/eye` | [bmo-eye](https://github.com/ahas/bmo-eye) | 视觉：由视觉模型读取的图片与视频 |
| `services/face` | [bmo-face](https://github.com/ahas/bmo-face) | 机身屏幕上的脸，以及它的编辑器与服务器 |
| `services/gate` | [bmo-gate](https://github.com/ahas/bmo-gate) | 一轮对话的闸门阶段：参考资料、翻译与记录 |
| `services/job` | [bmo-job](https://github.com/ahas/bmo-job) | 作为中间件的待办：条目、队列、租约、提问、订阅 |
| `services/mail` | [bmo-mail](https://github.com/ahas/bmo-mail) | 基于各账号邮箱的邮件服务 |
| `services/node` | [bmo-node](https://github.com/ahas/bmo-node) | 机器列表与硬件监控 |
| `services/note` | [bmo-note](https://github.com/ahas/bmo-note) | 基于 BlockSuite 编辑器的笔记，AFFiNE 的分支 |
| `services/pocket` | [bmo-pocket](https://github.com/ahas/bmo-pocket) | 工具宿主、工具目录与工具 SDK |
| `services/receiver` | [bmo-receiver](https://github.com/ahas/bmo-receiver) | 聊天接收方：房间、规则、对话窗口、轮次与唤醒 |
| `services/remote` | [bmo-remote](https://github.com/ahas/bmo-remote) | 控制台背后的终端会话与远程桌面 |
| `services/research` | [bmo-research](https://github.com/ahas/bmo-research) | 以文档形式留存的调研 |
| `services/review` | [bmo-review](https://github.com/ahas/bmo-review) | 针对已登记检出的代码审查 |
| `services/site` | [bmo-site](https://github.com/ahas/bmo-site) | bmo.ahas.io 项目网站 |
| `services/telegram` | [bmo-telegram](https://github.com/ahas/bmo-telegram) | Telegram 聊天提供方 |
| `services/testbed` | [bmo-testbed](https://github.com/ahas/bmo-testbed) | 测试台：队列、完整测试、快速检查与部署 |
| `services/theater` | [bmo-theater](https://github.com/ahas/bmo-theater) | 视频库：播放列表、续播与字幕 |
| `services/voc` | [bmo-voc](https://github.com/ahas/bmo-voc) | 客户之声：发给制造方的缺陷报告与建议 |
| `services/voice` | [bmo-voice](https://github.com/ahas/bmo-voice) | 语音引擎：语音节点上训练好的声音与合成 |
| `services/web` | [bmo-web](https://github.com/ahas/bmo-web) | 控制台：账号服务、语言包与各个界面 |
| `tools/privacy-scan` | 本仓库 | 一个脚本：检查检出及其历史中的个人信息 |

部分服务与工具保持私有，未列于此处。
