# Installing BMO

This runbook is for a coding agent (Claude Code, Codex or another) installing BMO on the machine it runs on. A
person hands you one line, "Read https://bmo.ahas.io/install.md and install BMO on this machine", and you carry out
everything below yourself. Read it whole before the first command.

## How you work

- **You run every command.** Never ask the person to run a command, edit a file or follow steps. Ask them only for
  what only they have: which kind of install they want, a chat bot's token, their own account names, a password they
  choose, a domain, a sign-in in a browser, and root's password where the machine asks for one.
- **Ask everything you need at once.** Gather the questions of a stage into one message, in the person's language,
  rather than one at a time.
- **A secret never stands in a command line, a log or your answers.** Write a value the person gives you into a
  temporary file with your file-writing tool, hand the file to the command on standard input, then delete it.
  Never print a token file, a settings file or a secret back.
- **Everything is idempotent.** Every step below checks first and does nothing where its work stands. When
  anything fails, mend what the message names and run the same step again; a rerun continues where the last one
  stopped.
- **Never stop at a failure without saying why.** Where you cannot mend something yourself, tell the person in one
  sentence what is missing and what it is for.

## 1. Ask which install

Ask the person one question, offering the three presets in one line each, in their language:

| Preset | For |
|---|---|
| `personal` | One person and their own BMO: the console, memory, coding agents, one chat service, documents, notes, calendar, files, mail and remote desktop. No organisations, no customers' voice, no face, nothing that needs a GPU |
| `team` | Personal, plus companies, organisation units, members and room permissions, code review and research |
| `operator` | Everything public: the customers' voice, BMO's face, voice and vision on GPU nodes, GPU card sharing, the node monitor, the video store and the remote machine hub. Needs GPU machines, a domain and a reverse proxy |

For `personal` and `team`, ask in the same message which chat service they will talk to BMO through besides the
web console: Telegram (`bmo-telegram`) or Discord (`bmo-discord`). `operator` installs both.

Note the person's language: BMO answers them in it (the receiver's `receiver.language` input below).

## 2. Check the machine

Run each check; what to do where it fails stands beside it.

| Check | Command | Where it fails |
|---|---|---|
| Linux | `uname -s` | BMO runs on Linux. Tell the person this machine cannot host it |
| systemd | `test -d /run/systemd/system` | Without systemd the set runs under the testbed's supervisor: follow 「A machine without systemd」 below |
| A Debian or Ubuntu family system | `. /etc/os-release && echo "$ID $VERSION_ID"` | The package names below are Debian's and Ubuntu's; on another family, install the same programs with its package manager |
| 64-bit x86 or ARM | `uname -m` (`x86_64` or `aarch64`) | Tell the person the machine is not supported |
| Not root | `test "$(id -u)" -ne 0` | Install as an ordinary user; ask the person which user owns BMO, and work as that user |
| Memory | `free -g` shows 16 GB or more in total | Builds may be killed with less; say so, and go on only if the person agrees |
| Disk | `df -BG --output=avail "$HOME"` shows 60 GB or more | Builds and releases need the room; ask the person to free some or pick another machine |
| Root for packages | `sudo -n true` | See 「Getting root once」 |
| GitHub reachable | `git ls-remote https://github.com/ahas/bmo.git HEAD` | Where the network is down, say so. Where it asks for credentials, the repositories are not public to this person yet: ask them to sign in with `gh auth login` in a browser (`gh` from the `gh` package), then retry |

### Getting root once

Installing packages and turning on lingering need root. Where `sudo -n true` fails, ask the person to let this
session use sudo: in Claude Code they type `! sudo -v` in the prompt, which asks for their password on their own
terminal; in another harness, ask them how it lets a command run as root. Never ask for the password itself in the
chat. Then check `sudo -n true` again.

## 3. Install the prerequisites

Install only what is missing; each line's first command checks.

```sh
# The system's packages.
command -v git && command -v cc && command -v pkg-config && command -v curl && command -v jq && command -v zstd \
  || sudo apt-get install -y git build-essential pkg-config libssl-dev curl jq ca-certificates unzip zstd

# PostgreSQL, with a role for this user who may make databases.
command -v psql || sudo apt-get install -y postgresql postgresql-contrib
psql --dbname=postgres --command='select 1' >/dev/null 2>&1 \
  || { sudo -u postgres createuser --createdb "$(id -un)" && createdb "$(id -un)"; }

# Valkey (or Redis), which keeps the console's sessions.
command -v valkey-server || command -v redis-server \
  || sudo apt-get install -y valkey-server || sudo apt-get install -y redis-server

# Lingering, so the services run without a login and start at boot; on a machine with systemd only.
test -d /run/systemd/system || echo "no systemd: see 「A machine without systemd」"
test ! -d /run/systemd/system \
  || test "$(loginctl show-user "$(id -un)" --property=Linger --value)" = yes || sudo loginctl enable-linger "$(id -un)"

# Rust, for this user.
command -v cargo || { curl -fsSL https://sh.rustup.rs | sh -s -- -y && . "$HOME/.cargo/env"; }

# Bun, at ~/.bun/bin/bun, where the services look for it.
test -x "$HOME/.bun/bin/bun" || curl -fsSL https://bun.sh/install | bash
```

The preset's own needs are checked by the install itself (step 5): every program a repository needs is a `needs:`
line naming what it is and where it comes from. Install each one it names, as above, and run the install again.
Among them:

- **Claude Code (`claude`)**, which runs BMO's agents: install it as its documentation says, then make sure it is
  signed in for this user. Signing in opens a browser: ask the person to complete that sign-in, the one step only
  they can do.
- **`herdr`**, the terminal host the agents run in (https://github.com/herdrdev/herdr), at `~/.local/bin/herdr`. The
  install builds it itself from its repository at the release `bmo-agency` declares; its build needs **Zig 0.16.0**
  on the `PATH` (https://ziglang.org/download/), and the Rust toolchain its repository pins, which `rustup` fetches
  on its own. Where its `needs:` line says the build failed, install what it names and run the install again.
- **`litellm`**, the model gateway: `uv tool install 'litellm[proxy]'` (with `uv` from https://docs.astral.sh/uv/).
- **`tmux`** and **gnome-remote-desktop** (`grdctl`) for the remote desktop, **`ffmpeg`** for the video units.

## 4. Lay down the index and build the installer

The index is the folder every repository is cloned into, `~/bmo` unless the person names another.

```sh
test -d ~/bmo/.git || git clone https://github.com/ahas/bmo.git ~/bmo
git -C ~/bmo pull --ff-only
```

The installer is the testbed's `install` verb. Until BMO is installed, build it from source:

```sh
cd ~/bmo
for pair in base/text:bmo-text base/chat:bmo-chat base/ui:bmo-ui services/testbed:bmo-testbed; do
  folder=${pair%%:*}; name=${pair##*:}
  test -d "$folder/.git" || git clone "https://github.com/ahas/$name.git" "$folder"
done
cargo build --release --manifest-path services/testbed/Cargo.toml -p bmo-testbed-cli
installer="$HOME/bmo/services/testbed/target/release/bmo-testbed"
```

Once the entry command and the testbed are installed (step 5 does them first), the same verb is `bmo install`, and
you use that from then on, with `~/.local/bin` on the `PATH` (`export PATH="$HOME/.local/bin:$PATH"` where a fresh
shell does not hold it yet).

### A machine without systemd

Where step 2 found no systemd, the set runs under the testbed's supervisor (bmo-testbed's `docs/supervise.md`): it
runs the same unit files, and stand-ins for `systemctl`, `systemd-run` and `journalctl` on the PATH carry every
call of the install and of the services to it. PostgreSQL and Valkey are started by their own service scripts
(`sudo service postgresql start`, `sudo service valkey-server start`) where nothing starts them.

Start the supervisor in the background, detached from your session, then put your shell under it before step 5:

```sh
setsid "$installer" supervise serve > /dev/null 2>&1 < /dev/null &
"$installer" supervise status
supervised() { "$installer" supervise env | sed -n "s/^$1=//p"; }
export PATH="$(supervised PATH)" BMO_SUPERVISOR="$(supervised BMO_SUPERVISOR)" \
  XDG_RUNTIME_DIR="$(supervised XDG_RUNTIME_DIR)"
```

The three exports are the lines `"$installer" supervise env` prints: the stand-ins first on the PATH, the
supervisor's socket, and the runtime directory every service reads. Where your harness does not keep a shell's
environment from one command to the next, run these lines before each command of step 5. Tell the person that nothing starts the
supervisor when the machine starts: whatever starts their session must run `bmo-testbed supervise serve`, as the
all-in-one desktop app does.

## 5. Run the install

First a dry run, which changes nothing and shows the whole plan:

```sh
"$installer" install --preset personal --with bmo-telegram --index ~/bmo --dry-run
```

Then the install itself, the same words without `--dry-run`. Name the preset the person chose, and for `personal`
and `team` the chat service with `--with`.

Every step prints one JSON line: `step`, `status`, `detail` and `next`. Read every line and act on its status:

| Status | What you do |
|---|---|
| `ok` | Nothing; it is done |
| `planned` | In a dry run, what would be done. In a real run, a settings file waiting for a file a service makes once it runs; it is written later in the same run |
| `needs-input` | A value only the person has. `detail` says what it is and where they find it; `next` is the command that keeps it. Gather every `needs-input` of the run, ask the person for all of them in one message, and keep each as below |
| `failed` | `detail` says what went wrong and `next` what to do. Mend it, then run the install again |

The run stops at the end of a stage where a step failed or waits for input, and the last line, `done`, says how it
stands. Exit codes: 0 done, 1 a step failed, 2 the words were refused, 3 waiting for input.

### Keeping an input

Write the value into a temporary file with your file-writing tool, then:

```sh
"$installer" install --set <name> --index ~/bmo < /path/to/the-temporary-file && rm /path/to/the-temporary-file
```

The value is kept where the repository's declaration says, in the secret store (`~/.local/share/bmo/data/env/`) for
a secret. The inputs a preset asks for are these; each line's `detail` says the rest:

| Input | What it is |
|---|---|
| `web.owner-name`, `web.owner-password` | The name and password the person signs in to the console with; they choose both |
| `web.public-address` | The console's address as the person will open it; `http://127.0.0.1:3210/bmo/` unless they put it behind a domain |
| `persona.owner-name` | What BMO calls the person in conversation |
| `receiver.owner-sender`, `receiver.language` | The person's own id on their chat service, and the language BMO answers them in |
| `telegram.bot`, `telegram.owner-id` | Telegram: the bot's token from @BotFather, and the person's numeric Telegram id |
| `discord.bot`, `discord.owner-id`, `discord.owner-channel` | Discord: the bot's token, the person's id and the channel of their direct messages with the bot |
| `remote.desktop-password` | The password of the remote desktop the console opens |
| `voice.*`, `eye.*`, `jake.*` | Operator only: the voice node, a Hugging Face sign-in, a vision key; the remote machine hub's public name, the HTTPS address its agent downloads are served at and the folder they are published into. None has a default: every address is the person's own deployment's |

Never invent a value. Where the person does not know one, tell them where `detail` says it is found.

### What the install does, in order

1. Resolves the preset and keeps it in `~/.local/share/bmo/data/install/preset.json`.
2. Clones every repository the preset names into the index (`~/bmo/base/…`, `~/bmo/services/…`).
3. Reads each repository's `install.toml`: the programs, ports, tokens, inputs, databases and settings it needs.
4. Checks every program (`needs:`), every port (`port:`) and every input (`input:`).
5. Makes the tokens, the PostgreSQL databases and every settings file, and the console features file that leaves
   out what the preset does not hold.
6. Puts each repository's first release live, one at a time, in the preset's order, through the testbed's
   deployment, and runs its after-steps: the first console account, the first chat agent, the owner's room.
7. Asks every service's health and runs the repositories' own verifications, among them a test message into the
   person's own room.

## 6. Verify

Once the last line is `done` with status `ok`:

```sh
bmo install --status --index ~/bmo
```

Every line must be `ok`. Then check by hand what a person would see:

- Open the console's address (the `done` line's `next`) with `curl -fsS -o /dev/null -w '%{http_code}\n' <address>login`;
  it answers 200.
- The verification lines `verify:bmo-receiver:…` passed: a test message stands in the person's own room.
- For `operator`, the `verify:…:proxy` lines passed: the install writes the web paths of the face and the script
  studio as files under the data root's `proxy/` folder, and the machine's nginx includes them once. Where the line
  failed, ask the person to let you use root (「Getting root once」), add `include <data root>/proxy/*.conf;` inside
  the nginx server block that serves the console's address, check it with `sudo nginx -t`, reload nginx with
  `sudo systemctl reload nginx` and run the install again.
- For the chat service, the verification line of `bmo-telegram` or `bmo-discord` passed. Ask the person to send
  their bot one message and check that BMO answers.

## 7. Report to the person

Tell them, in their language and in a few lines:

- the console's address and the name they sign in with (never the password);
- the preset installed and the chat service;
- anything left for later that the install named, such as a part that needs a domain or a GPU.

## What the install keeps true

These hold for every install, and a program that packages BMO for one person's computer relies on them as you do:

- **Everything stands under one data root and one prefix.** Settings, tokens, inputs and the install's own state
  stand under the data root (`--data-root`, `~/.local/share/bmo/data` by default); every service's releases stand
  under the prefix (`--prefix`, `~/.local/share` by default). A repository placed anywhere else is a failed `place:`
  line, never a silent split.
- **PostgreSQL and Valkey are whichever the words name.** `--postgres-host`, `--postgres-port` and `--valkey` (or
  `PGHOST`, `PGPORT` and `BMO_INSTALL_VALKEY`) point the install and every service at a server of the person's own
  or one bundled with BMO; the system's are only the default.
- **No port is fixed.** A port another program holds moves to the next free one, and every port chosen is kept in
  `install/ports.json` under the data root, which `--status` lists.
- **Progress is data.** Every step is one JSON line and `--status` answers each repository and port as one, so a
  progress screen reads `step` and `status` and shows `detail` to the person.
- **Services are programs.** On a server each service runs as a systemd user unit its deployment keeps; each runs
  one program reading its settings from the data root.
- **A machine without systemd runs the set under the testbed's supervisor.** It runs the same unit files, and its
  stand-ins carry every `systemctl --user`, `systemd-run --user` and `journalctl --user` call of the install and
  the services to it, so the install takes the same steps (「A machine without systemd」). The all-in-one desktop
  app installs and runs the personal preset this way on a person's own computer, and on Windows inside a WSL 2
  distribution of its own.
- **No address points at another deployment.** Every address a service, an installer or a download names is the
  person's own deployment's, given as an input; none has a default naming anybody else's servers.

## Later

- **Continue a stopped install:** run the same `bmo install --preset …` again.
- **Add one repository:** `bmo install --add <repository> --index ~/bmo`, for example `bmo-research`. It is cloned,
  set up and put live, and the console shows what it turns on. Once BMO runs on the machine, this is BMO's own work,
  the supervisor's alone: it runs `--add` only on the person's approval for that one repository, and none of its
  jobs or workers ever runs it. Run it yourself only while you are installing, before BMO answers.
- **See how it stands:** `bmo install --status --index ~/bmo`.
- **Newer releases** are not the installer's: each repository's later commits go live through the testbed's
  deployment.

## When something fails

| Line | Likely cause and mend |
|---|---|
| `clone:…` failed | No network, or no access to the repository: see the GitHub check in step 2 |
| `needs:…` failed | Install the program its `detail` names, then rerun |
| `port:…` failed | Another program listens on that port: find it with `ss -ltnp 'sport = :<port>'` and tell the person which program it is before stopping anything |
| `database:…` failed | PostgreSQL is not running (`systemctl status postgresql`) or the user may not make databases (step 3) |
| `deploy:…` failed | Read the deployment's journal, the command in `next`; mend what it names, then rerun. A build that ran out of memory says so there |
| `after:…` failed | Its `detail` quotes what the step said; mend it and rerun. Never delete a settings file to start over: settings are written once and kept |
| `verify:…` failed | The service is up but does not do its work yet: read its journal with `journalctl --user -u <unit>` |
