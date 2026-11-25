<p align="center">
  <a href="https://bmo.ahas.io/ko/"><img src="https://bmo.ahas.io/icon.svg" alt="BMO" width="120" height="120"></a>
</p>

<h1 align="center">BMO</h1>

<p align="center">내 기기에서 돌아가는 나만의 AI 팀: 사람마다 BMO 하나, 조직과 그 에이전트까지.</p>

<p align="center">
  <a href="https://bmo.ahas.io/ko/"><img alt="Website" src="https://img.shields.io/badge/website-bmo.ahas.io-6366f1?style=flat-square"></a>
  <a href="LICENSE"><img alt="License: MIT" src="https://img.shields.io/badge/license-MIT-22c55e?style=flat-square"></a>
  <a href="https://bmo.ahas.io/ko/releases/"><img alt="Version" src="https://img.shields.io/github/v/tag/ahas/bmo?include_prereleases&sort=semver&label=version&color=0ea5e9&style=flat-square"></a>
  <a href="https://github.com/sponsors/ahas"><img alt="Sponsor" src="https://img.shields.io/badge/Sponsor-EA4AAA?logo=githubsponsors&logoColor=fff&style=flat-square"></a>
  <img alt="Rust" src="https://img.shields.io/badge/Rust-servers-b7410e?style=flat-square&logo=rust&logoColor=white">
  <img alt="Nuxt" src="https://img.shields.io/badge/Nuxt-console-00dc82?style=flat-square&logo=nuxt&logoColor=white">
  <img alt="Languages" src="https://img.shields.io/badge/i18n-ko%20%C2%B7%20en%20%C2%B7%20ja%20%C2%B7%20zh-f59e0b?style=flat-square">
</p>

<p align="center">
  <a href="https://bmo.ahas.io/ko/">웹사이트</a> · <a href="https://bmo.ahas.io/ko/guide/">가이드북</a> · <a href="https://bmo.ahas.io/ko/api/">API 명세</a> · <a href="https://bmo.ahas.io/ko/releases/">릴리즈 노트</a>
</p>

<p align="center"><a href="README.md">English</a> | <b>한국어</b> | <a href="README.ja.md">日本語</a> | <a href="README.zh-CN.md">简体中文</a></p>

BMO 시스템은 저장소의 묶음입니다. 유닛 하나가 저장소 하나이고, 모두 이 폴더 안에 나란히 섭니다. 모든 유닛이 따르는 구조는 `STRUCTURE.md`에 있고, 각 유닛이 하는 일은 그 유닛의 README와 문서에 있습니다. 이 저장소는 구조와 이 목록, 설치 런북과 그 프리셋, 그리고 따로 떨어진 스크립트 하나만 추적합니다. 유닛은 여기서 추적하지 않으며, 각 유닛은 자기 이름으로 다른 유닛 옆에 클론합니다.

## 설치

BMO는 사람이 직접 설치하지 않고 코딩 에이전트가 설치합니다. BMO를 돌릴 컴퓨터에서 Claude Code나 Codex를 열고 아래 한 줄을 건네세요.

```
https://bmo.ahas.io/install.md 를 읽고 이 컴퓨터에 BMO를 설치해 줘.
```

에이전트는 `INSTALL.md`를 따릅니다. `presets.toml`에 있는 설치 종류 `personal`(개인), `team`(팀), `operator`(운영자) 중 무엇을 원하는지 묻고, 당신만 가진 것만 물은 뒤, 끝나면 콘솔 주소를 알려 줍니다.

## 폴더 구성

| 폴더 | 담는 것 |
|---|---|
| `base/` | 기반 라이브러리. 다른 유닛이 가져다 쓸 수 있는 유일한 종류의 유닛 |
| `resources/` | 내용물만 담고, 읽는 쪽이 찾는 자리에 놓이며, 아무것도 실행하지 않음 |
| `services/` | 서비스 하나당 폴더 하나. 플랫폼 자체의 장치도 여기에 있음 |
| `tools/` | 도구를 두는 열린 공간. 도구 하나당 폴더 하나이며, 다른 유닛을 바꾸지 않고 더하거나 뺄 수 있음 |

## 유닛

| 폴더 | 저장소 | 역할 |
|---|---|---|
| `base/chat` | [bmo-chat](https://github.com/ahas/bmo-chat) | 프로바이더와 리시버 사이의 채팅 프로토콜과 그 클라이언트 |
| `base/text` | [bmo-text](https://github.com/ahas/bmo-text) | 방, 콘솔, 아카이브가 읽는 방식대로 읽고 쓰는 마크다운과 텍스트 |
| `base/ui` | [bmo-ui](https://github.com/ahas/bmo-ui) | 콘솔의 Nuxt 레이어: 모든 화면을 이루는 토큰, 컴포넌트, 동작 |
| `resources/persona` | [bmo-persona](https://github.com/ahas/bmo-persona) | 채팅 에이전트의 페르소나 레이어와 설정집 |
| `resources/skills` | [bmo-skills](https://github.com/ahas/bmo-skills) | 워커가 받는 스킬과, 그것을 건네주는 배치 도구 |
| `services/agency` | [bmo-agency](https://github.com/ahas/bmo-agency) | 에이전트 세션의 공급, 배치, 진행, 종료와 협업자 풀 |
| `services/arbiter` | [bmo-arbiter](https://github.com/ahas/bmo-arbiter) | 엔진들이 카드를 나눠 쓰는 GPU 노드의 카드 중재자 |
| `services/artifact` | [bmo-artifact](https://github.com/ahas/bmo-artifact) | 문서의 보관, 검색, 공유 |
| `services/brain` | [bmo-brain](https://github.com/ahas/bmo-brain) | 미들웨어로서의 기억: 행, 노트, 감시, 알림, 참고 텍스트 |
| `services/cache-siren` | [bmo-cache-siren](https://github.com/ahas/bmo-cache-siren) | 프롬프트 캐시 적중과 새 토큰의 실시간 감시 |
| `services/cache-warmer` | [bmo-cache-warmer](https://github.com/ahas/bmo-cache-warmer) | 프롬프트 캐시를 유지하는 스케줄러 |
| `services/calendar` | [bmo-calendar](https://github.com/ahas/bmo-calendar) | 캘린더, 일정, 알림, 예약 |
| `services/cli` | [bmo-cli](https://github.com/ahas/bmo-cli) | 각 유닛의 명령을 찾아 주는 진입 명령 |
| `services/discord` | [bmo-discord](https://github.com/ahas/bmo-discord) | Discord 채팅 프로바이더 |
| `services/drive` | [bmo-drive](https://github.com/ahas/bmo-drive) | 드라이브, 오브젝트 스토리지, 노드 볼륨을 아우르는 파일 뷰어 |
| `services/explorer` | [bmo-explorer](https://github.com/ahas/bmo-explorer) | 상류로서의 웹 읽기: 검색, 페이지, 미리보기, 그림 |
| `services/eye` | [bmo-eye](https://github.com/ahas/bmo-eye) | 보기: 비전 모델이 읽는 그림과 영상 |
| `services/face` | [bmo-face](https://github.com/ahas/bmo-face) | 케이스 화면의 얼굴, 그 편집기와 서버 |
| `services/gate` | [bmo-gate](https://github.com/ahas/bmo-gate) | 턴의 게이트 단계: 참고 자료, 번역, 기록 |
| `services/job` | [bmo-job](https://github.com/ahas/bmo-job) | 미들웨어로서의 TODO: 항목, 대기열, 임대, 질문, 구독 |
| `services/mail` | [bmo-mail](https://github.com/ahas/bmo-mail) | 계정 메일함 위의 메일 서비스 |
| `services/node` | [bmo-node](https://github.com/ahas/bmo-node) | 머신 목록과 하드웨어 모니터 |
| `services/note` | [bmo-note](https://github.com/ahas/bmo-note) | BlockSuite 편집기 기반 노트, AFFiNE의 포크 |
| `services/pocket` | [bmo-pocket](https://github.com/ahas/bmo-pocket) | 도구 호스트, 도구 목록, 도구 SDK |
| `services/receiver` | [bmo-receiver](https://github.com/ahas/bmo-receiver) | 채팅 리시버: 방, 규칙, 대화 창, 턴, 깨우기 |
| `services/remote` | [bmo-remote](https://github.com/ahas/bmo-remote) | 콘솔 뒤의 터미널 세션과 원격 데스크톱 |
| `services/research` | [bmo-research](https://github.com/ahas/bmo-research) | 문서로 남는 리서치 |
| `services/review` | [bmo-review](https://github.com/ahas/bmo-review) | 등록된 체크아웃에 대한 코드 리뷰 |
| `services/site` | [bmo-site](https://github.com/ahas/bmo-site) | bmo.ahas.io 프로젝트 사이트 |
| `services/telegram` | [bmo-telegram](https://github.com/ahas/bmo-telegram) | Telegram 채팅 프로바이더 |
| `services/testbed` | [bmo-testbed](https://github.com/ahas/bmo-testbed) | 테스트베드: 대기열, 전체 테스트, 빠른 검사, 배포 |
| `services/theater` | [bmo-theater](https://github.com/ahas/bmo-theater) | 영상 보관함: 재생 목록, 이어보기, 자막 |
| `services/voc` | [bmo-voc](https://github.com/ahas/bmo-voc) | 고객의 소리: 제조사에게 보내는 버그 신고와 건의 |
| `services/voice` | [bmo-voice](https://github.com/ahas/bmo-voice) | 음성 엔진: 음성 노드에서의 학습된 목소리와 합성 |
| `services/web` | [bmo-web](https://github.com/ahas/bmo-web) | 콘솔: 계정 서비스, 언어 팩, 화면 |
| `tools/privacy-scan` | 이 저장소 | 스크립트 하나: 체크아웃과 그 이력의 개인정보 검사 |

일부 서비스와 도구는 비공개로 두며 여기에 싣지 않습니다.
