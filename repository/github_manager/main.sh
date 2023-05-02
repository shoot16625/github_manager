#!/bin/sh

set -u

readonly ACCOUNT_NAME=shoot16625
readonly REPO_NAME=github_manager
readonly LICENSE=MIT
readonly DEFAULT_BRANCH=main
readonly DESCRIPTION="Github を管理するレポジトリ"
readonly TOPICS="github"

gh repo create $REPO_NAME --add-readme --public --license $LICENSE

gh repo edit $ACCOUNT_NAME/$REPO_NAME --add-topic $TOPICS --default-branch $DEFAULT_BRANCH --delete-branch-on-merge --description "$DESCRIPTION"
