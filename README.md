# bmo

The BMO system as a set of repositories, one unit each, standing together in this folder. The shape
every unit holds to is `STRUCTURE.md`; what each unit does is that unit's own README and documents.
This repository tracks the structure, this index and the one loose script; no unit is tracked here,
and a unit is cloned by its own name beside the others.

## The folders

| Folder | Holds |
|---|---|
| `base/` | The base libraries, the one kind of unit another unit may import |
| `resources/` | Content only, placed where its readers look; runs nothing |
| `services/` | The services, one each, and the platform's own mechanism among them |
| `tools/` | The open space for tools: one folder per tool, added or removed without any other unit changing |

## The units

| Folder | Repository | Role |
|---|---|---|
| `base/chat` | bmo-chat | The chat protocol between a provider and the receiver, and its client |
| `base/text` | bmo-text | Markdown and text read and written the way rooms, the console and the archive read them |
| `base/ui` | bmo-ui | The console's Nuxt layer: tokens, components and behaviours every screen is built from |
| `resources/persona` | bmo-persona | The persona layers and the lore library of a chat agent |
| `resources/skills` | bmo-skills | The skills a worker is given, and the placer that hands them over |
| `services/agency` | bmo-agency | Agent sessions supplied, placed, carried and ended; the co-worker pool |
| `services/arbiter` | bmo-arbiter | The card arbiter of the GPU nodes whose cards the engines share |
| `services/artifact` | bmo-artifact | Documents kept, searched and shared |
| `services/brain` | bmo-brain | Memory as middleware: rows, notes, watches, reminders, reference text |
| `services/cache-siren` | bmo-cache-siren | The live watch of prompt-cache hits and new tokens |
| `services/cache-warmer` | bmo-cache-warmer | The keepalive scheduler of prompt caches |
| `services/cli` | bmo-cli | The entry command, which finds each unit's own command |
| `services/discord` | bmo-discord | The Discord chat provider |
| `services/drive` | bmo-drive | The file viewer over drives, object storage and the nodes' volumes |
| `services/explorer` | bmo-explorer | Web reading as an upstream: search, page, preview, picture |
| `services/face` | bmo-face | The face on the case's screen, its editor and its server |
| `services/gate` | bmo-gate | The gate stage of a turn, and the decision model it asks |
| `services/gate-harvest` | bmo-gate-harvest | The gate's training data that holds attack material; private |
| `services/graph` | bmo-graph | The code dependency graph of every repository, and the root graph |
| `services/job` | bmo-job | The TODO as middleware: items, queues, leases, questions, subscriptions |
| `services/kakaotalk` | bmo-kakaotalk | The KakaoTalk chat provider |
| `services/mail` | bmo-mail | Mail as a service over the accounts' mailboxes |
| `services/ms-teams` | bmo-ms-teams | The Microsoft Teams chat provider |
| `services/node` | bmo-node | The list of machines and the hardware monitor |
| `services/pocket` | bmo-pocket | The tool host, the toolbook and the tool SDK |
| `services/receiver` | bmo-receiver | The chat receiver: rooms, rules, windows, the turn and the wake |
| `services/remote` | bmo-remote | Terminal sessions and the remote desktop behind the console |
| `services/review` | bmo-review | Code review over the registered checkouts |
| `services/song` | bmo-song | Songs made in a named voice on a GPU node, and served |
| `services/lab-arena` | bmo-lab-arena | The text-generation engine the arbiter places on the nodes |
| `services/telegram` | bmo-telegram | The Telegram chat provider |
| `services/testbed` | bmo-testbed | The testbed: the queue, the suite, the quick checks and the deployment |
| `services/tui` | bmo-tui | The terminal screen an agency session stands in |
| `services/voice` | bmo-voice | The voice engine: trained voices and synthesis on the voice nodes |
| `services/web` | bmo-web | The console: the account service, the language packs and the screens |
| `services/word-chain` | bmo-word-chain | The word-chain game a room plays with its agent |
| `tools/news` | bmo-news | The morning news edition, filed as a shared page |
| `tools/stock-index` | bmo-stock-index | The daily closes of the Seoul and New York indices |
| `tools/bmo-ear` | bmo-ear | The listening tool: a saved voice file answered as Korean text |
| `tools/privacy-scan` | this repository | One script: the privacy scan of a checkout and its history |
