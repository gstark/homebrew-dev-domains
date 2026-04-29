# Homebrew installation

Yes, `dev-domains` can be installed from GitHub with Homebrew.

## Recommended approach: a tap repo

Create a separate tap repository:

```text
homebrew-dev-domains
```

Under that repo, place:

```text
Formula/dev-domains.rb
```

Then users can install with:

```bash
brew tap gstark/dev-domains https://github.com/gstark/homebrew-dev-domains
brew install dev-domains
```

This will also install:

- `caddy`
- `dnsmasq`

Or, if you use standard tap naming, often just:

```bash
brew tap gstark/dev-domains
brew install dev-domains
```

## Why use a tap?

A tap is the most normal Homebrew distribution model for small open source tools.

It gives you:

- a stable install command
- versioned formulas
- easy upgrades
- a clean GitHub story

## Alternative: install formula directly from a raw URL

Possible, but less polished:

```bash
brew install https://raw.githubusercontent.com/gstark/homebrew-dev-domains/main/Formula/dev-domains.rb
```

## Important limitation

Homebrew can install dependencies automatically, but it should not silently perform privileged machine setup during formula installation.

In particular, formula installation should not modify `/etc/resolver` behind the user's back.

So the formula installs files and helper commands, then the user runs:

```bash
dev-domains setup
```

That command performs the machine-local setup, asks for sudo when needed, and starts the relevant Homebrew services.

## Release flow

For each release:

1. Tag and push the main repo release, for example `v0.1.0`
2. Render the formula from that tag
3. Commit the rendered formula in the tap repo, or let GitHub Actions do it for you

### Render locally

```bash
scripts/render-homebrew-formula.sh v0.1.0 Formula/dev-domains.rb
```

That script:

- downloads the GitHub release tarball for the tag
- computes `sha256`
- writes a ready-to-publish `Formula/dev-domains.rb`

### Render from GitHub Actions

This repo includes `.github/workflows/release-homebrew.yml`.

On each published GitHub release it will:

- render `Formula/dev-domains.rb`
- upload it as a workflow artifact
- show the generated formula in the workflow summary
- optionally commit it to your tap repo automatically

To enable automatic tap updates, configure:

- repository variable `HOMEBREW_TAP_REPO` — for example `gstark/homebrew-dev-domains`
- repository secret `HOMEBREW_TAP_TOKEN` — a token with push access to that tap repo

## Formula in this repo

`Formula/dev-domains.rb` is generated from the release tag and tarball checksum.
Use `scripts/render-homebrew-formula.sh` before publishing or rely on the release workflow artifact.

## Packaging note

The formula installs:

- docs into `pkgshare`
- templates into `pkgshare`
- `dev-domains` CLI into Homebrew `bin`

The CLI wraps the bundled setup and Caddy commands.
