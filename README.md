# github_manager

レポジトリの作成やブランチ保護などの設定をコマンドで管理する。

![Image](/image/t-rec.gif)

## Command

### Setup

```zsh
make init
make login
```

### Exec

```zsh
# レポジトリ操作
make exec_query REPO_NAME=repository_name

# 全てのレポジトリ操作
make exec_all_queries
```

## Reference

- <https://docs.github.com/ja/graphql/overview/about-the-graphql-api>
