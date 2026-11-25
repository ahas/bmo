<p align="center">
  <a href="https://bmo.ahas.io/"><img src="https://bmo.ahas.io/icon.svg" alt="BMO" width="120" height="120"></a>
</p>

<h1 align="center">BMO</h1>

<p align="center">Your own AI team: a BMO for every person, organisations and their agents, running on your own machines.</p>

<p align="center">
  <a href="LICENSE"><img alt="License: MIT" src="https://img.shields.io/badge/license-MIT-22c55e?style=flat-square"></a>
  <a href="https://bmo.ahas.io/releases/"><img alt="Version" src="https://img.shields.io/github/v/tag/ahas/bmo?include_prereleases&sort=semver&label=version&color=0ea5e9&style=flat-square"></a>
  <a href="https://github.com/sponsors/ahas"><img alt="Sponsor" src="https://img.shields.io/badge/Sponsor-EA4AAA?logo=githubsponsors&logoColor=fff&style=flat-square"></a>
  <a href="https://buymeacoffee.com/ahas"><img alt="Buy me a coffee" src="https://img.shields.io/badge/Buy_me_a_coffee-FFDD00?logo=buymeacoffee&logoColor=000&style=flat-square"></a>
</p>

<p align="center">
  <a href="https://bmo.ahas.io/">Website</a> · <a href="https://bmo.ahas.io/guide/">Guidebook</a> · <a href="https://bmo.ahas.io/api/">API reference</a> · <a href="https://bmo.ahas.io/releases/">Release notes</a>
</p>

<p align="center"><b>English</b> | <a href="README.ko.md">한국어</a> | <a href="README.ja.md">日本語</a> | <a href="README.zh-CN.md">简体中文</a></p>

The BMO system as a set of repositories, one unit each, standing together in this folder. The shape
every unit holds to is `STRUCTURE.md`; what each unit does is that unit's own README and documents.
This repository tracks the structure, this index, the install runbook with its presets and the one loose script; no unit is tracked here,
and a unit is cloned by its own name beside the others.

## Installing

BMO is installed by a coding agent, never by hand. On the machine that will run it, open Claude Code or Codex and
hand it this one line:

```
Read https://bmo.ahas.io/install.md and install BMO on this machine.
```

The agent follows `INSTALL.md`: it asks which install you want — `personal`, `team` or `operator`, the kinds
`presets.toml` lists — asks only for what only you have, and tells you the console's address when it is done.

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
| `base/chat` | [bmo-chat](https://github.com/ahas/bmo-chat) | The chat protocol between a provider and the receiver, and its client |
| `base/text` | [bmo-text](https://github.com/ahas/bmo-text) | Markdown and text read and written the way rooms, the console and the archive read them |
| `base/ui` | [bmo-ui](https://github.com/ahas/bmo-ui) | The console's Nuxt layer: tokens, components and behaviours every screen is built from |
| `resources/persona` | [bmo-persona](https://github.com/ahas/bmo-persona) | The persona layers and the lore library of a chat agent |
| `resources/skills` | [bmo-skills](https://github.com/ahas/bmo-skills) | The skills a worker is given, and the placer that hands them over |
| `services/agency` | [bmo-agency](https://github.com/ahas/bmo-agency) | Agent sessions supplied, placed, carried and ended; the co-worker pool |
| `services/arbiter` | [bmo-arbiter](https://github.com/ahas/bmo-arbiter) | The card arbiter of the GPU nodes whose cards the engines share |
| `services/artifact` | [bmo-artifact](https://github.com/ahas/bmo-artifact) | Documents kept, searched and shared |
| `services/brain` | [bmo-brain](https://github.com/ahas/bmo-brain) | Memory as middleware: rows, notes, watches, reminders, reference text |
| `services/cache-siren` | [bmo-cache-siren](https://github.com/ahas/bmo-cache-siren) | The live watch of prompt-cache hits and new tokens |
| `services/cache-warmer` | [bmo-cache-warmer](https://github.com/ahas/bmo-cache-warmer) | The keepalive scheduler of prompt caches |
| `services/calendar` | [bmo-calendar](https://github.com/ahas/bmo-calendar) | Calendars, events, alarms and bookings |
| `services/cli` | [bmo-cli](https://github.com/ahas/bmo-cli) | The entry command, which finds each unit's own command |
| `services/discord` | [bmo-discord](https://github.com/ahas/bmo-discord) | The Discord chat provider |
| `services/drive` | [bmo-drive](https://github.com/ahas/bmo-drive) | The file viewer over drives, object storage and the nodes' volumes |
| `services/explorer` | [bmo-explorer](https://github.com/ahas/bmo-explorer) | Web reading as an upstream: search, page, preview, picture |
| `services/eye` | [bmo-eye](https://github.com/ahas/bmo-eye) | Seeing: pictures and video read by vision models |
| `services/face` | [bmo-face](https://github.com/ahas/bmo-face) | The face on the case's screen, its editor and its server |
| `services/gate` | [bmo-gate](https://github.com/ahas/bmo-gate) | The gate stage of a turn: its reference, translation and the records |
| `services/job` | [bmo-job](https://github.com/ahas/bmo-job) | The TODO as middleware: items, queues, leases, questions, subscriptions |
| `services/mail` | [bmo-mail](https://github.com/ahas/bmo-mail) | Mail as a service over the accounts' mailboxes |
| `services/node` | [bmo-node](https://github.com/ahas/bmo-node) | The list of machines and the hardware monitor |
| `services/note` | [bmo-note](https://github.com/ahas/bmo-note) | Notes on the BlockSuite editor, a fork of AFFiNE |
| `services/pocket` | [bmo-pocket](https://github.com/ahas/bmo-pocket) | The tool host, the toolbook and the tool SDK |
| `services/receiver` | [bmo-receiver](https://github.com/ahas/bmo-receiver) | The chat receiver: rooms, rules, windows, the turn and the wake |
| `services/remote` | [bmo-remote](https://github.com/ahas/bmo-remote) | Terminal sessions and the remote desktop behind the console |
| `services/research` | [bmo-research](https://github.com/ahas/bmo-research) | Research runs filed as documents |
| `services/review` | [bmo-review](https://github.com/ahas/bmo-review) | Code review over the registered checkouts |
| `services/site` | [bmo-site](https://github.com/ahas/bmo-site) | The project site at bmo.ahas.io |
| `services/telegram` | [bmo-telegram](https://github.com/ahas/bmo-telegram) | The Telegram chat provider |
| `services/testbed` | [bmo-testbed](https://github.com/ahas/bmo-testbed) | The testbed: the queue, the suite, the quick checks and the deployment |
| `services/theater` | [bmo-theater](https://github.com/ahas/bmo-theater) | The video store: playlists, progress and subtitles |
| `services/voc` | [bmo-voc](https://github.com/ahas/bmo-voc) | The customers' voice: bug reports and suggestions sent to the maker |
| `services/voice` | [bmo-voice](https://github.com/ahas/bmo-voice) | The voice engine: trained voices and synthesis on the voice nodes |
| `services/web` | [bmo-web](https://github.com/ahas/bmo-web) | The console: the account service, the language packs and the screens |
| `tools/privacy-scan` | this repository | One script: the privacy scan of a checkout and its history |

Some services and tools are kept private and are not listed here.
