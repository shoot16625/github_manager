#!/bin/sh

set -u

readonly OWNER_NAME=shoot16625
readonly REPO_NAME=github_manager
readonly LICENSE=MIT
readonly DEFAULT_BRANCH=main
readonly DESCRIPTION="Github を管理するレポジトリ"
readonly TOPICS="github"

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

# update a branch protection rule
branchProtectionRuleId=$(gh api graphql -f query='
{
	repository(owner:"'$OWNER_NAME'", name:"'$REPO_NAME'"){
		branchProtectionRules(first:100){
			nodes{
				id,
				pattern
			}
		}
	}
}
' -q ' .data.repository.branchProtectionRules.nodes.[] | select(.pattern=="'$DEFAULT_BRANCH'") | .id ')

_=$(gh api graphql -f query='
mutation($branchProtectionRuleId:ID!) {
	updateBranchProtectionRule(input: {
		branchProtectionRuleId: $branchProtectionRuleId
		requiresApprovingReviews: true
		requiredApprovingReviewCount: 1
		requiresCodeOwnerReviews: true
		isAdminEnforced: false
	}) { clientMutationId }
}
' -f branchProtectionRuleId="$branchProtectionRuleId")
