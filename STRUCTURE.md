# Structure of the BMO system

## How this document stands

- **Only the owner changes this document.** A worker, a co-worker or BMO never edits it on its own
  judgement; it is edited only by a job whose item the owner requested and which names this file.
- **Where the code says otherwise, the code is what differs.** A job that finds a unit behaving
  differently from a fact stated here does not rewrite this document to match the code, and does not
  change the code to match it either unless its item asks for that. It reports the difference.
- **This is the shape, not the detail.** It states what every unit must hold to; how each unit carries
  it out is that unit's own documents. It names no version, no route, no file and no folder below a
  repository's root, and a repository's internal layout is that repository's to decide.

## Terms

- **Unit (유닛)** — one repository: a base library, a content set, a service or a tool. A unit builds,
  tests and runs from its own repository, its own data and its own settings alone.
- **Base library (베이스 라이브러리)** — a unit other units may import. It supplies mechanism and a
  safe default, knows none of its consumers and depends on no service.
- **Service (서비스)** — a unit that runs, owns its data and serves one documented API. It publishes
  the client its callers take.
- **Tool (도구)** — one entry of work an agent may call, declared by its own manifest and served by the
  tool host. A tool stands in a repository of its own or in the service it is bound to.
- **Chat provider (챗 프로바이더)** — the side that supplies chat. One platform is one provider, and a
  platform with no implementation yet still has its place open. A provider declares for itself which
  read modes it reads by, what it can do and the dialect its rooms read; nothing outside it keeps a
  list of those.
- **Chat receiver (챗 리시버)** — the side that takes a message whichever provider hands it over,
  keeps the rooms and their rules, builds the turn an agent is handed, returns the answer to the room
  and wakes the agents a room's words, a quiet instruction or a job's end call for. It never reads
  which provider a message came from in order to decide anything.
- **Gate (게이트)** — the stage between the receiver and the agent, on the way in and on the way out:
  it sanitises what enters a model's context, picks the reference a turn is handed, checks the answer
  and records every judgement it makes.
- **Agency (에이전시)** — the service that supplies, places, carries and ends agent sessions, of every
  role and every model, under the limits each provider and tier is given.
- **Agent (에이전트)** — in ordinary use, any AI agent of the system, BMO and the workers included.
- **Chat agent (챗 에이전트)** — an agent that answers people in rooms, in a persona of its own, and relays
  work, directing it to be done through the workers. Every chat agent holds the supervisor role, and the
  supervisors of one account are equal: what one may do, every one of that account may do. Chat agents
  are added and removed by registration alone: no unit keeps a list of them, and adding one changes
  nothing elsewhere.
- **BMO (비모)** — the first chat agent of a deployment, one supervisor among equals, and the one a room
  falls to where its registration names no other.
- **Designated agent (지정된 에이전트)** — a chat agent a room names to answer in it. A room may designate
  any number, and each answers there by its own wake. No unit treats one chat agent apart from another by
  name.
- **Worker (워커)** — a general agent that can work inside one particular checkout, directed by a chat
  agent.
- **Co-worker (코워커)** — a sub-agent for a worker's use only, which a worker is assigned out of the
  co-worker pool.
- **User (사용자)** — a person with an account of their own on the system, in exactly one organisation
  unit of one company. The owner is the first user and the platform's superadmin, the one user who
  reaches every company.
- **Company (회사)** — the top unit of an organisation and the unit its data is isolated by. A
  deployment holds any number of companies, and nothing of one is seen from another.
- **Organisation unit (조직 단위)** — a folder in a company's tree below the company, of any depth. Every
  unit is the same kind of thing: the words a company calls them by, such as division, centre, team or
  part, are names only, and nothing reads a meaning into them. A unit is where a head's authority runs
  and its members are organised, never a boundary of collaboration inside its company. Any unit may have
  a head, and every head holds the same authority over their own unit and every unit below it: inviting
  members, opening and changing projects, and granting, room by room, the right to call one's supervisor
  into a group room. Each unit does its own kind of work, such as producing, inspecting another unit's
  results or research. A person belongs to exactly one unit.
- **Project (프로젝트)** — a body of work that belongs to one organisation unit or to one person. Every
  user may open projects of their own. A project is public or private, and private until made public. A
  unit's project gathers the public projects of the people and units below it, reading their summary
  and state and their full record on request. A private project is read by its members alone, whoever
  heads the units above it. A head above may add members to a unit's private project, and whoever is
  added reads it as a member, every change of members shown to all of them; the members of a person's
  own project are that person's alone to choose.
- **Work relation (일의 관계)** — a link between two projects, such as a handover, an inspection, a
  reference, a report or a change request. Work relations form a web of their own and never follow the
  organisation's tree.
- **Node (노드)** — a machine the system reaches: where an engine stands, where a card is lent, where a
  worker's checkout may be.

## One system, many repositories

- **The system is a set of repositories, one unit each.** The whole has no repository, no build and no
  process of its own; it is the units standing together and reaching each other as this document says.
- **Four kinds of folder hold the units,** and a unit is of exactly one kind:
  - `base/` — the base libraries, the one kind of unit another unit may import;
  - `resources/` — content only: persona, skills and the like, which run nothing and are placed
    where their readers look;
  - `services/` — the services, one each, and the platform's own mechanism among them;
  - `tools/` — the open space for tools: one folder per tool, in any language, added or removed
    without any other unit changing.
- **A unit reaches another only through what the other documents:** its HTTP API, its events, its
  published client or its command. Nothing imports another unit's code, reads its files, its paths or
  its tables, except that any unit may import a base library and a caller may import a service's
  published client.
- **Upstream never intrudes on downstream.** A unit calls only what the unit below it documents, never
  reaches into its data and never decides what is that unit's to decide. A base never depends on a
  service, and a base never knows its consumers.
- **What differs per unit stands in that unit.** A shared mechanism supplies the default; the unit
  supplies the policy. No central table names the units, no base branches on a consumer's name, and no
  unit names an agent, an owner or a host: those come from registration and settings.
- **A unit holds only what it uses, and no copy of what an upstream serves.** Two units holding the
  same thing is a fault; the thing moves to a base library or to the one unit that owns it.
- **Each repository carries its own canonical documents, and the documents come before the code.** A
  change that would make a document wrong repairs the document first. Each repository also carries its
  own version and its own declaration of how it is tested, checked, built and deployed.
- **Inside a unit everything is English:** code, comments, tests, documents and commits. What a person
  reads in another language is a language pack, held by the console alone; what a machine reads is a
  code. Korean stands only where the code inherently reads Korean, and is counted.
- **No personal data in any repository:** no names, addresses, paths, devices, tokens or network
  details of any person, machine or agent. Such values come from a deployment's own settings.

## The platform's mechanism

- **One testbed** serves every repository on a machine: one queue for every heavy build and test, one
  shared build directory, quick static checks and a release-based deployment. It knows no repository
  by name; whatever differs per repository is that repository's declaration.
- **One entry command** finds each unit's own command and hands over to it, so a unit added later
  needs no change to the entry.
- **One code graph** per repository, generated in the checkout, and one root graph over every
  registered repository's boundaries.

## How a turn goes

1. A room's words reach the provider that serves that platform.
2. The provider hands them to the receiver, which keeps the room and decides whom the words wake.
3. The receiver builds the turn and hands it through the gate on its way in; the gate sanitises it and
   picks its reference out of what the memory service serves and what the persona layers say.
4. The agency carries the turn in a session of the designated agent's role and model, with the tools
   the tool host serves to that session.
5. The answer passes the gate on its way out, returns to the receiver, and the receiver sends it into
   the room through the provider.

Every step is one unit, every hand-over is a documented call, and no unit decides anything by the
name of the provider or the agent.

## How work goes

- **The TODO is a service that stores and serves, and never executes.** Items, their questions and
  replies, the queues they wait in and the leases on them are its whole business.
- **A chat agent turns every ordinary request into an item** and directs a worker to do it. Without an
  explicit instruction to do it directly, it uses the TODO. When the owner tells it to do something itself,
  it may do it directly. For a change to the BMO system itself this is absolute: such a change goes through
  the TODO.
- **A worker takes work from the TODO,** pushed by a subscription or pulled by a lease, works inside the
  one checkout its item names, closes the item with what it did, and the receiver wakes the chat agent that
  filed it when the job ends.
- **Workers and co-workers are sessions the agency supplies,** placed where the co-worker pool allows,
  reading the skills the content units place for them.

## How a tool stands

- **A tool declares itself by a manifest** and is served by the tool host under the namespaces,
  capabilities and grants of the session calling it. The host reads manifests and knows no tool by
  name.
- **A session is shown a few resident tools and reaches every other through its toolbook,** so adding
  or removing a tool never changes what a running session's prompt begins with.
- **A tool that needs the web, a document store, a market feed or any other upstream reaches it as a
  unit,** through that unit's documented API, never by its own copy.

## No clock bounds

- **Nothing is bounded by a clock.** No run, turn, call, synthesis, lease, seat or wait is stopped,
  refused, abandoned or failed because a span of time has passed. Work ends when it finishes, when it
  fails on its own, or when someone stops it.
- **A wait waits for its event:** a process that ends, a connection that closes, a holder that gives
  back, an answer that arrives. Where the event cannot be observed, what is missing is a way to observe
  it, never a clock standing in for it.
- **A request to another host waits for its answer.** Its end is the answer, a refused or broken
  connection, or the other end gone; no request timeout cuts it short.
- **Telling that the other end is gone is observing an event.** A transport's heartbeat (a keep-alive
  probe, a stream's keep-alive line whose absence means the peer has dropped) detects a dead peer and is
  kept; it never stands in for a bound on how long a live peer may take.
- **A stop asked of a process waits for the process to end.** A polite stop is not escalated to a kill
  after a grace period; a stop that must be immediate kills at once.
- **A deployment is up when its health check answers ready,** not when it has stayed up for a span.
- **Access and retention are not work.** A login's or a share link's lifetime, a grant's end, and how
  long an abandoned upload is kept are ends of access or storage, and stand.
- **A rule's own window is not a bound on work.** A game's recruiting window or a room's conversation
  window is the rule itself, and a long poll that returns empty and is asked again only paces.
- **What is bounded is how much runs at once, by count.** The co-worker pool bounds how many models of
  each tier run at the same time; work beyond that waits in line for a place, however long that takes,
  and is never turned away for having waited.
- **A clock may pace, never end.** A schedule, a polling interval, a retry's back-off, or a notice that
  something has been quiet says when to look again; none of them gives up on the work.
- **A span someone else imposes** — a provider's cache lifetime, an upstream's own ceiling — is that
  party's fact, read and worked around, and never copied into a bound of ours.

## Accounts, companies and units

- **An account stands on its own.** Its roles, its agents and their settings, its sessions and the
  count its pool bounds are its own. One account's sessions never take another account's place, and a
  new account is a registration that changes nothing elsewhere.
- **An account's sessions run only on the node its account is bound to.** By default that is the
  person's own machine, proven by the node agent installed there; only the owner binds an account to
  another node. An account whose node is not yet proven, or whose node is gone, cannot be used until a
  node is proven again, and then carries on as it was.
- **A user is one person across providers:** each identity on a platform is linked to their one
  account, so what they may do and what an agent knows of them follow the person. An identity linked to
  no account is an ordinary member of the room it speaks in.
- **The company is the unit of isolation.** Projects, rooms, meeting records, memories, people and
  search belong to one company, and nothing crosses from one company to another. The owner, as
  superadmin, reaches every company.
- **A shared engine serves every company and mixes none.** Every request to it carries its company and
  its account; an account reads only its own requests and logs; sessions and caches of a shared engine
  are never shared across companies.
- **Inside a company, collaboration crosses units.** Anyone may be made a member of a project, a meeting
  or a chat in their company, with no consent of their unit's head.
- **Grants come from the owner, and a unit's head grants within their own unit and below.** The owner
  places companies, their organisation units and people. The head of a unit invites members to it or to
  a unit below it, opens and changes projects there, and grants a member the right to call their own
  supervisor into a group room. That right is granted room by room, by the room's opener or the head of
  the unit the room belongs to, as a person is invited or afterwards. What a user may have an agent do
  is granted by permission, and nothing is open until it is granted; a grant names exactly what it opens
  and may carry an end.
- **Any number of chat agents, each one across its account's rooms.** An agent has one session and one
  persona in every room of its company and on every provider, so what a person said to it in a group
  room carries on in that person's private chat with it. A new agent is a registration and its persona
  layers, never a change to a provider, the receiver, the gate or the agency.
- **What is said in one room is not told in another,** with two exceptions: in their own private chat
  with an agent, a user may carry on what they and that agent said to each other in a group room they
  are in, only their own words and the agent's answers to them; and the record of a meeting is read by
  the supervisors of its participants, each of whom tells its own user what the meeting decided for
  them.
- **A supervisor keeps its user's confidence.** What its user said to it alone never reaches another
  user, a meeting record or a project, and a private project is never read from above. When a user
  leaves their company their account is archived, and the head of the unit they belonged to reads what
  of it was never private: their public projects, the meetings they took part in, their tasks and the
  record of their work relations. Their private projects and what they said to their supervisor alone
  stay sealed.
- **The console is where a user signs in,** where the companies, their units, the accounts and the
  grants stand, and where every unit's screen is shown; the accounts are served to the other units, and
  no other unit keeps its own.

## When a designated agent wakes

- The receiver recognises a designated agent's name mechanically, by the names its registration declares,
  and passes the message to that agent through the gate.
- Apart from that, a message in a chat room never wakes a designated agent on its own. The exception is an
  agent woken by a tool or by the end of a job it filed.
- Where a user talks with one designated agent alone, that agent answers whatever they say: in that
  user's private chat with it, and in a room that designates it alone.
- A room that woke an agent keeps a window, for a set length of time, in which the conversation goes
  on without the agent being called by name. That window exists for each room and each agent
  separately.
- The end of a meeting wakes the supervisor of every participant with a quiet instruction, as the end
  of a job wakes the agent that filed it.

## Where the machines stand

- **The node service is the one list of machines** every other unit reads, with what is known of each.
- **An engine stands on a node, and a service holds no process there.** The card arbiter places the
  engines that share a node's cards and keeps each card's lock; a service asks for a place and is told
  where its engine stands.
- **Weights, datasets and run output never enter a repository.** They stand where a deployment places
  them, and a repository holds only the declaration of where that is.
