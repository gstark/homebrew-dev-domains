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

1. Tag the main repo, for example `v0.1.0`
2. Homebrew formula points at the release tarball
3. Update the formula `sha256`
4. Commit the formula update in the tap repo

## Formula in this repo

This repo includes a starter formula here:

```text
Formula/dev-domains.rb
```

Before publishing, update:

- `homepage`
- `url`
- `sha256`

## Packaging note

The formula installs:

- docs into `pkgshare`
- templates into `pkgshare`
- `dev-domains` CLI into Homebrew `bin`

The CLI wraps the bundled setup and Caddy commands.
