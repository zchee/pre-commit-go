# pre-commit-go

A collection of [pre-commit](https://pre-commit.com) hooks for Go projects.

These hooks wrap the most common Go formatters and linters so you can drop them
into any repository with a few lines of YAML — no global tool installation
required. Each hook is implemented as a small Bash script that shells out to a
pinned, `go run`-fetched binary, so contributors get the same tool version
without managing their `$PATH`.

## Hooks

| ID                    | What it does                                                              | Tool                                                                                       |
| --------------------- | ------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| `gofumpt`             | Stricter `gofmt` — enforces additional formatting rules with `-extra`.    | [`mvdan.cc/gofumpt`](https://github.com/mvdan/gofumpt)                                     |
| `goimports-rereviser` | Formats imports, removes unused ones, and sets package aliases.           | [`zchee/goimports-rereviser`](https://github.com/zchee/goimports-rereviser)                |
| `golangci-lint`       | Runs the configured `golangci-lint` linters against the whole module.     | [`golangci/golangci-lint`](https://github.com/golangci/golangci-lint)                      |

All hooks match `\.go$` files and run as `language: script`.

## Requirements

- [pre-commit](https://pre-commit.com) ≥ 3.0 (or [`prek`](https://github.com/j178/prek))
- Go toolchain on `$PATH` (the linter hooks use `go run` to fetch their tools)
- `gofumpt` available on `$PATH` for the `gofumpt` hook

## Usage

Add this repository to your `.pre-commit-config.yaml`:

```yaml
repos:
  - repo: https://github.com/zchee/pre-commit-go
    rev: main  # pin to a tag or commit SHA in production
    hooks:
      - id: gofumpt
      - id: goimports-rereviser
      - id: golangci-lint
        args: [".golangci.yaml"]  # path to your golangci-lint config
```

Then install the git hook and run it once across the repo:

```sh
pre-commit install
pre-commit run --all-files
```

After that, the hooks run automatically on every `git commit`.

### Picking only what you need

Each hook is independent — enable the ones you want and skip the rest. A
minimal setup that just enforces formatting:

```yaml
- repo: https://github.com/zchee/pre-commit-go
  rev: main
  hooks:
    - id: gofumpt
    - id: goimports-rereviser
```

## How the hooks behave

- **`gofumpt`** — runs `gofumpt -l -w -extra` on staged Go files. Files that
  were rewritten are printed, and the hook exits non-zero so the commit is
  blocked until you stage the changes.
- **`goimports-rereviser`** — runs recursively from the repo root with
  `-format -rm-unused -set-alias` and a local cache for speed. Any modified
  file aborts the commit so you can review and stage the result.
- **`golangci-lint`** — takes the path to your `golangci-lint` config as a
  positional argument and runs `golangci-lint run ./...`. Any findings fail the
  hook.

## Local development

To work on the hooks themselves, this repo dogfoods its own configuration via
[`.pre-commit-config.yaml`](./.pre-commit-config.yaml). Install the hooks and
run them locally:

```sh
pre-commit install
pre-commit run --all-files
```

CI (`.github/workflows/lint.yaml`) validates the manifest with `prek` and runs
`shellcheck` over every script.

## License

[Apache License 2.0](./LICENSE)
