#!/bin/bash
# PreToolUse hook: unconditionally blocks every PR-merge tool call. Patrick merges PRs
# himself, always, no exceptions. This has no conditional logic on purpose: it does not
# try to judge "safe" merges, it fails every one.
#
# Matches:
#   - the mcp__github__merge_pull_request MCP tool
#   - `gh pr merge` (Bash)
#   - `gh api ... /merge` (Bash, the REST path the MCP tool and `gh pr merge` both use
#     under the hood, e.g. `gh api -X PUT repos/o/r/pulls/1/merge`)

set -eou pipefail

input=$(cat)
tool_name=$(echo "$input" | jq -r '.tool_name')

blocked=""
if [[ "$tool_name" == "mcp__github__merge_pull_request" ]]; then
  blocked="1"
elif [[ "$tool_name" == "Bash" ]]; then
  command=$(echo "$input" | jq -r '.tool_input.command')
  if echo "$command" | grep -qE '(^|[[:space:]])gh pr merge([[:space:]]|$)' \
    || echo "$command" | grep -qE '/(pulls|merge-queue-entries)/[^[:space:]]*/merge([[:space:]"'"'"'/?]|$)'; then
    blocked="1"
  fi
fi

if [[ -n "$blocked" ]]; then
  jq -n '{
    hookSpecificOutput: {
      hookEventName: "PreToolUse",
      permissionDecision: "deny",
      permissionDecisionReason: "Blocked: PR merges are never performed by the agent. Patrick merges every PR himself. There are no exceptions to ask for."
    }
  }'
fi
