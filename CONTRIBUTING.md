# Contributing

Thanks for contributing to `dev-domains`.

## Development

### Requirements

- macOS
- Homebrew
- `caddy`
- `dnsmasq`

Install dependencies:

```bash
brew install caddy dnsmasq
```

## Local workflow

Set up the machine:

```bash
make setup
```

Run Caddy:

```bash
make run-caddy
```

Create a new app config:

```bash
make new-app NAME=example PORT=4321
```

## Pull requests

Please:

- keep changes focused
- update docs when behavior changes
- include reproduction steps for bug fixes
- test the setup flow when changing setup scripts

## Issues

When filing an issue, include:

- macOS version
- Homebrew version
- Caddy version
- dnsmasq version
- the exact command you ran
- relevant logs or error messages
