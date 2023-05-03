#!/bin/sh

set -u

readonly OWNER_NAME=shoot16625
readonly REPO_NAME=pc_setting
readonly LICENSE=MIT
readonly DEFAULT_BRANCH=main
readonly DESCRIPTION="PC の設定ファイル一覧"
readonly TOPICS="mac,zsh,karabiner"

# create repo
gh repo create $REPO_NAME --add-readme --public --license $LICENSE

# update repo
gh repo edit $OWNER_NAME/$REPO_NAME --add-topic $TOPICS --default-branch $DEFAULT_BRANCH --delete-branch-on-merge --description "$DESCRIPTION"

# create a branch protection rule
repositoryId=$(gh api graphql -f query='
{
	repository(owner:"'$OWNER_NAME'", name:"'$REPO_NAME'"){id}
}
' -q .data.repository.id)

_=$(gh api graphql -f query='
mutation($repositoryId:ID!,$branch:String!) {
	createBranchProtectionRule(input: {
		repositoryId: $repositoryId
		pattern: $branch
	}) { clientMutationId }
}
' -f repositoryId="$repositoryId" -f branch="$DEFAULT_BRANCH")
