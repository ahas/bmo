#!/usr/bin/env bash
# Privacy scan for a git checkout.
#
# Scans the working tree (tracked and untracked-but-not-ignored files), every commit's
# content, every commit message and every author/committer identity for personal,
# contact, network and credential patterns. Prints counts only; never prints a match.
#
# Usage: scan.sh [repository] [--history-only]
# Exit: 0 when no hit, 1 when any hit, 2 on bad input.

set -uo pipefail

repo="${1:-.}"
mode="${2:-}"
if [ ! -d "$repo/.git" ] && ! git -C "$repo" rev-parse --git-dir >/dev/null 2>&1; then
  echo "not a git checkout: $repo" >&2
  exit 2
fi
repo=$(git -C "$repo" rev-parse --show-toplevel) || exit 2

# Allowed identity: the owner, read from the global git configuration (a repository may commit under a
# neutral identity of its own), so the script carries no name or address of its own.
allowed_name=$(git config --global user.name)
allowed_mail=$(git config --global user.email)
allowed_mail_re="^$(printf '%s' "$allowed_mail" | sed 's/[.[\*^$]/\\&/g')\$"

# Generic patterns. They describe a shape, never a real value.
email='[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}'
home='/(home|Users)/[A-Za-z0-9._-]+'
ipv4='([0-9]{1,3}\.){3}[0-9]{1,3}'
phone='(\+[0-9][0-9 ()-]{6,}[0-9]|(^|[^0-9])01[016789][- ]?[0-9]{3,4}[- ]?[0-9]{4}([^0-9]|$)|(^|[^0-9])[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}([^0-9]|$))'
token='(gh[pousr]_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{20,}|sk-[A-Za-z0-9]{20,}|AKIA[0-9A-Z]{16}|xox[abprs]-[A-Za-z0-9-]{10,}|-----BEGIN [A-Z ]*PRIVATE KEY-----|eyJ[A-Za-z0-9_-]{20,}\.[A-Za-z0-9_-]{10,})'
uuid='[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}'
mac='([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}'
domain='\b([A-Za-z0-9-]+\.)+(com|io|net|org|dev|app|cloud|local|lan|internal)\b'
handle='@[A-Za-z0-9_][A-Za-z0-9_-]{2,}(?![/.A-Za-z0-9_-])'
jsdoc='^@(description|enum|generated|param|returns|throws|type|deprecated|example|default|format|title|summary|see|since|tags|schema|extends|template|internal|public|private|readonly|override|abstract|implements|argument|typedef|callback|property|class|module|requires|exports|file|fileoverview|preserve|ts-check|ts-ignore|ts-expect-error)$'
conversation='19:[A-Za-z0-9_-]{8,}'"@"'thread[^ ]*'

allowed_domains='(^|\.)(example\.(com|org|net)|microsoftonline\.com|botframework\.com|graph\.microsoft\.com|github\.com|githubusercontent\.com|crates\.io|rust-lang\.org|docs\.rs|npmjs\.com|bun\.sh|profile\.dev|rustup\.rs)$'

worktree_hits=0
history_hits=0

say() { printf '%s\n' "$*"; }

# Count matches of an extended pattern over an explicit file list.
count_files() {
  local pat="$1" filter="$2"
  shift 2
  [ "$#" -eq 0 ] && { echo 0; return; }
  local n
  n=$(rg -o --no-filename -P -e "$pat" -- "$@" 2>/dev/null | { if [ -n "$filter" ]; then grep -Ev "$filter"; else cat; fi; } | wc -l)
  echo "${n:-0}"
}

# Count matches of an extended pattern over a commit's tree, lock files aside.
count_commit() {
  local c="$1" pat="$2" filter="$3"
  local out
  out=$(git -C "$repo" grep -h -o -P -I -e "$pat" "$c" -- . ':!Cargo.lock' ':!*/bun.lock' ':!package-lock.json' 2>/dev/null | { if [ -n "$filter" ]; then grep -Ev "$filter"; else cat; fi; } | wc -l)
  echo "${out:-0}"
}

# Count matches in every commit message.
count_messages() {
  local pat="$1" filter="$2"
  local out
  out=$(git -C "$repo" log --all --format='%B' | rg -o -P -e "$pat" 2>/dev/null | { if [ -n "$filter" ]; then grep -Ev "$filter"; else cat; fi; } | wc -l)
  echo "${out:-0}"
}

scan_worktree() {
  local -a files
  mapfile -d '' -t files < <(git -C "$repo" ls-files -z --cached --others --exclude-standard)

  say "worktree files: ${#files[@]}"
  local n

  n=$(count_files "$email" "$allowed_mail_re" "${files[@]}"); say "worktree email: $n"; worktree_hits=$((worktree_hits + n))
  n=$(count_files "$home" '' "${files[@]}"); say "worktree home path: $n"; worktree_hits=$((worktree_hits + n))
  n=$(count_files "$ipv4" '^(127\.0\.0\.1|0\.0\.0\.0|255\.255\.255\.255)$' "${files[@]}"); say "worktree ipv4: $n"; worktree_hits=$((worktree_hits + n))
  n=$(count_files "$phone" '' "${files[@]}"); say "worktree phone: $n"; worktree_hits=$((worktree_hits + n))
  n=$(count_files "$token" '' "${files[@]}"); say "worktree token: $n"; worktree_hits=$((worktree_hits + n))
  n=$(count_files "$uuid" '^00000000-0000-0000-0000-00000000000[0-9]$' "${files[@]}"); say "worktree uuid: $n"; worktree_hits=$((worktree_hits + n))
  n=$(count_files "$mac" '' "${files[@]}"); say "worktree mac: $n"; worktree_hits=$((worktree_hits + n))
  n=$(count_files "$domain" "$allowed_domains" "${files[@]}"); say "worktree domain: $n"; worktree_hits=$((worktree_hits + n))
  n=$(count_files "$handle" "$jsdoc" "${files[@]}"); say "worktree handle: $n"; worktree_hits=$((worktree_hits + n))
  n=$(count_files "$conversation" '' "${files[@]}"); say "worktree conversation id: $n"; worktree_hits=$((worktree_hits + n))
}

scan_history() {
  local commits
  commits=$(git -C "$repo" rev-list --all | wc -l)
  say "history commits: $commits"

  local c n
  local -a totals=(0 0 0 0 0 0 0 0 0)
  local -a labels=("email" "home path" "ipv4" "phone" "token" "uuid" "mac" "domain" "handle" "conversation id")

  for c in $(git -C "$repo" rev-list --all); do
    totals[0]=$((totals[0] + $(count_commit "$c" "$email" "$allowed_mail_re")))
    totals[1]=$((totals[1] + $(count_commit "$c" "$home" '')))
    totals[2]=$((totals[2] + $(count_commit "$c" "$ipv4" '^(127\.0\.0\.1|0\.0\.0\.0|255\.255\.255\.255)$')))
    totals[3]=$((totals[3] + $(count_commit "$c" "$phone" '')))
    totals[4]=$((totals[4] + $(count_commit "$c" "$token" '')))
    totals[5]=$((totals[5] + $(count_commit "$c" "$uuid" '^00000000-0000-0000-0000-00000000000[0-9]$')))
    totals[6]=$((totals[6] + $(count_commit "$c" "$mac" '')))
    totals[7]=$((totals[7] + $(count_commit "$c" "$domain" "$allowed_domains")))
    totals[8]=$((totals[8] + $(count_commit "$c" "$handle" "$jsdoc")))
    totals[9]=$((totals[9] + $(count_commit "$c" "$conversation" '')))
  done

  local i
  for i in "${!totals[@]}"; do
    say "history ${labels[$i]}: ${totals[$i]}"
    history_hits=$((history_hits + totals[i]))
  done

  # Identities: every field must be the allowed one.
  local bad
  bad=$(git -C "$repo" log --all --format='%an%x09%ae%x09%cn%x09%ce' \
    | awk -F'\t' -v n="$allowed_name" -v m="$allowed_mail" \
        '($1!=n || $2!=m || $3!=n || $4!=m){c++} END{print c+0}')
  say "history author/committer: $bad"
  history_hits=$((history_hits + bad))

  # Commit messages.
  n=$(count_messages "$email" "$allowed_mail_re"); say "message email: $n"; history_hits=$((history_hits + n))
  n=$(count_messages "$home" ''); say "message home path: $n"; history_hits=$((history_hits + n))
  n=$(count_messages "$ipv4" '^(127\.0\.0\.1|0\.0\.0\.0)$'); say "message ipv4: $n"; history_hits=$((history_hits + n))
  n=$(count_messages "$phone" ''); say "message phone: $n"; history_hits=$((history_hits + n))
  n=$(count_messages "$token" ''); say "message token: $n"; history_hits=$((history_hits + n))
  n=$(count_messages "$uuid" ''); say "message uuid: $n"; history_hits=$((history_hits + n))
  n=$(count_messages "$mac" ''); say "message mac: $n"; history_hits=$((history_hits + n))
  n=$(count_messages "$domain" "$allowed_domains"); say "message domain: $n"; history_hits=$((history_hits + n))
  n=$(count_messages "$handle" "$jsdoc"); say "message handle: $n"; history_hits=$((history_hits + n))
}

scan() {
  cd "$repo" || exit 2
  if [ "$mode" != "--history-only" ]; then
    scan_worktree
  fi
  scan_history
  local unreachable
  unreachable=$(git fsck --unreachable --no-reflogs 2>/dev/null | wc -l)
  say "unreachable objects: $unreachable"
  history_hits=$((history_hits + unreachable))
  say "total worktree hits: $worktree_hits"
  say "total history hits: $history_hits"
  if [ "$worktree_hits" -gt 0 ] || [ "$history_hits" -gt 0 ]; then
    exit 1
  fi
  exit 0
}

scan
