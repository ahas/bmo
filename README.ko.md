[English](README.md) | **한국어** | [日本語](README.ja.md) | [简体中文](README.zh-CN.md)

# bmo

BMO 시스템은 저장소의 묶음입니다. 유닛 하나가 저장소 하나이고, 모두 이 폴더 안에 나란히 섭니다. 모든 유닛이 따르는 구조는 `STRUCTURE.md`에 있고, 각 유닛이 하는 일은 그 유닛의 README와 문서에 있습니다. 이 저장소는 구조와 이 목록, 그리고 따로 떨어진 스크립트 하나만 추적합니다. 유닛은 여기서 추적하지 않으며, 각 유닛은 자기 이름으로 다른 유닛 옆에 클론합니다.

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
| `base/chat` | bmo-chat | 프로바이더와 리시버 사이의 채팅 프로토콜과 그 클라이언트 |
| `base/text` | bmo-text | 방, 콘솔, 아카이브가 읽는 방식대로 읽고 쓰는 마크다운과 텍스트 |
| `base/ui` | bmo-ui | 콘솔의 Nuxt 레이어: 모든 화면을 이루는 토큰, 컴포넌트, 동작 |
| `resources/persona` | bmo-persona | 채팅 에이전트의 페르소나 레이어와 설정집 |
| `resources/skills` | bmo-skills | 워커가 받는 스킬과, 그것을 건네주는 배치 도구 |
| `services/agency` | bmo-agency | 에이전트 세션의 공급, 배치, 진행, 종료와 협업자 풀 |
| `services/arbiter` | bmo-arbiter | 엔진들이 카드를 나눠 쓰는 GPU 노드의 카드 중재자 |
| `services/artifact` | bmo-artifact | 문서의 보관, 검색, 공유 |
| `services/brain` | bmo-brain | 미들웨어로서의 기억: 행, 노트, 감시, 알림, 참고 텍스트 |
| `services/cache-siren` | bmo-cache-siren | 프롬프트 캐시 적중과 새 토큰의 실시간 감시 |
| `services/cache-warmer` | bmo-cache-warmer | 프롬프트 캐시를 유지하는 스케줄러 |
| `services/calendar` | bmo-calendar | 캘린더, 일정, 알림, 예약 |
| `services/cli` | bmo-cli | 각 유닛의 명령을 찾아 주는 진입 명령 |
| `services/discord` | bmo-discord | Discord 채팅 프로바이더 |
| `services/drive` | bmo-drive | 드라이브, 오브젝트 스토리지, 노드 볼륨을 아우르는 파일 뷰어 |
| `services/explorer` | bmo-explorer | 상류로서의 웹 읽기: 검색, 페이지, 미리보기, 그림 |
| `services/eye` | bmo-eye | 보기: 비전 모델이 읽는 그림과 영상 |
| `services/face` | bmo-face | 케이스 화면의 얼굴, 그 편집기와 서버 |
| `services/gate` | bmo-gate | 턴의 게이트 단계: 참고 자료, 번역, 기록 |
| `services/job` | bmo-job | 미들웨어로서의 TODO: 항목, 대기열, 임대, 질문, 구독 |
| `services/mail` | bmo-mail | 계정 메일함 위의 메일 서비스 |
| `services/node` | bmo-node | 머신 목록과 하드웨어 모니터 |
| `services/note` | bmo-note | BlockSuite 편집기 기반 노트, AFFiNE의 포크 |
| `services/paint` | bmo-paint | GPU 노드에서 그리는 그림 |
| `services/pocket` | bmo-pocket | 도구 호스트, 도구 목록, 도구 SDK |
| `services/receiver` | bmo-receiver | 채팅 리시버: 방, 규칙, 대화 창, 턴, 깨우기 |
| `services/remote` | bmo-remote | 콘솔 뒤의 터미널 세션과 원격 데스크톱 |
| `services/research` | bmo-research | 문서로 남는 리서치 |
| `services/review` | bmo-review | 등록된 체크아웃에 대한 코드 리뷰 |
| `services/site` | bmo-site | bmo.ahas.io 프로젝트 사이트 |
| `services/song` | bmo-song | GPU 노드에서 지정한 목소리로 만들어 내놓는 노래 |
| `services/telegram` | bmo-telegram | Telegram 채팅 프로바이더 |
| `services/testbed` | bmo-testbed | 테스트베드: 대기열, 전체 테스트, 빠른 검사, 배포 |
| `services/theater` | bmo-theater | 영상 보관함: 재생 목록, 이어보기, 자막 |
| `services/tui` | bmo-tui | 에이전시 세션이 서 있는 터미널 화면 |
| `services/voc` | bmo-voc | 고객의 소리: 제조사에게 보내는 버그 신고와 건의 |
| `services/voice` | bmo-voice | 음성 엔진: 음성 노드에서의 학습된 목소리와 합성 |
| `services/web` | bmo-web | 콘솔: 계정 서비스, 언어 팩, 화면 |
| `services/word-chain` | bmo-word-chain | 방에서 에이전트와 하는 끝말잇기 |
| `tools/privacy-scan` | 이 저장소 | 스크립트 하나: 체크아웃과 그 이력의 개인정보 검사 |

일부 서비스와 도구는 비공개로 두며 여기에 싣지 않습니다.
