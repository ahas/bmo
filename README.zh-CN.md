[English](README.md) | [한국어](README.ko.md) | [日本語](README.ja.md) | **简体中文**

# bmo

BMO 系统是一组仓库：每个单元一个仓库，全部并排放在这个文件夹里。所有单元遵循的结构见 `STRUCTURE.md`，每个单元的职责见它自己的 README 与文档。本仓库只跟踪结构、这份索引和一个独立脚本；这里不跟踪任何单元，每个单元都以自己的名字克隆到其他单元旁边。

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
| `base/chat` | bmo-chat | 提供方与接收方之间的聊天协议及其客户端 |
| `base/text` | bmo-text | 按房间、控制台和归档的读法来读写的 Markdown 与文本 |
| `base/ui` | bmo-ui | 控制台的 Nuxt 层：构成每个界面的设计令牌、组件与行为 |
| `resources/persona` | bmo-persona | 聊天智能体的人设层与设定集 |
| `resources/skills` | bmo-skills | 交给工作者的技能，以及分发它们的放置工具 |
| `services/agency` | bmo-agency | 智能体会话的供给、放置、推进与结束，以及协作者池 |
| `services/arbiter` | bmo-arbiter | 多个引擎共享显卡的 GPU 节点的显卡仲裁 |
| `services/artifact` | bmo-artifact | 文档的保存、搜索与分享 |
| `services/brain` | bmo-brain | 作为中间件的记忆：记录、笔记、监视、提醒、参考文本 |
| `services/cache-siren` | bmo-cache-siren | 实时监看提示缓存命中与新增 token |
| `services/cache-warmer` | bmo-cache-warmer | 保持提示缓存有效的调度器 |
| `services/calendar` | bmo-calendar | 日历、日程、提醒与预约 |
| `services/cli` | bmo-cli | 入口命令，为每个单元找到它自己的命令 |
| `services/discord` | bmo-discord | Discord 聊天提供方 |
| `services/drive` | bmo-drive | 横跨网盘、对象存储与节点卷的文件浏览器 |
| `services/explorer` | bmo-explorer | 作为上游的网页读取：搜索、页面、预览、图片 |
| `services/eye` | bmo-eye | 视觉：由视觉模型读取的图片与视频 |
| `services/face` | bmo-face | 机身屏幕上的脸，以及它的编辑器与服务器 |
| `services/gate` | bmo-gate | 一轮对话的闸门阶段：参考资料、翻译与记录 |
| `services/job` | bmo-job | 作为中间件的待办：条目、队列、租约、提问、订阅 |
| `services/mail` | bmo-mail | 基于各账号邮箱的邮件服务 |
| `services/node` | bmo-node | 机器列表与硬件监控 |
| `services/note` | bmo-note | 基于 BlockSuite 编辑器的笔记，AFFiNE 的分支 |
| `services/pocket` | bmo-pocket | 工具宿主、工具目录与工具 SDK |
| `services/receiver` | bmo-receiver | 聊天接收方：房间、规则、对话窗口、轮次与唤醒 |
| `services/remote` | bmo-remote | 控制台背后的终端会话与远程桌面 |
| `services/research` | bmo-research | 以文档形式留存的调研 |
| `services/review` | bmo-review | 针对已登记检出的代码审查 |
| `services/site` | bmo-site | bmo.ahas.io 项目网站 |
| `services/telegram` | bmo-telegram | Telegram 聊天提供方 |
| `services/testbed` | bmo-testbed | 测试台：队列、完整测试、快速检查与部署 |
| `services/theater` | bmo-theater | 视频库：播放列表、续播与字幕 |
| `services/voc` | bmo-voc | 客户之声：发给制造方的缺陷报告与建议 |
| `services/voice` | bmo-voice | 语音引擎：语音节点上训练好的声音与合成 |
| `services/web` | bmo-web | 控制台：账号服务、语言包与各个界面 |
| `tools/privacy-scan` | 本仓库 | 一个脚本：检查检出及其历史中的个人信息 |

部分服务与工具保持私有，未列于此处。
