#!/bin/bash

##
## VARS
##
## - GH_AUTHOR_USERNAME
## - GH_ORG_NAME
## - GH_REPO_NAME
## - ${1}
##

set -e

source .gh.env

GH_SEARCH_START_DATE="${1}"

exec \
gh api \
  -H "Accept: application/vnd.github-commitcomment.text+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" "/repos/${GH_ORG_NAME}/${GH_REPO_NAME}/pulls/comments?sort=updated_at&direction=asc&since=${GH_SEARCH_START_DATE}T00:00:00Z&per_page=100000" \
| jq ".[] | select(.user.login == \"${GH_AUTHOR_USERNAME}\") | {updated_at: (.updated_at), body_text: (.body_text), pull_request_url: (.pull_request_url)}"
