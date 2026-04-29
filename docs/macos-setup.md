# macOS setup

## Install dependencies

```bash
brew install caddy dnsmasq
```

## Configure dnsmasq

This repo includes `dnsmasq/dev.conf`:

```ini
address=/.test/127.0.0.1
```

The setup script copies it into Homebrew's dnsmasq config directory.

## Configure the macOS resolver

Create `/etc/resolver/test` with:

```text
nameserver 127.0.0.1
```

That tells macOS to send `.test` DNS requests to local dnsmasq.

## Start services

```bash
brew services start dnsmasq
brew services start caddy
```

Or run Caddy manually:

```bash
make run-caddy
```

## Verify DNS

```bash
dig flux.test @127.0.0.1
```

Expected result includes:

```text
127.0.0.1
```

## Verify proxying

Start the app on port `3000`, then open:

```text
http://flux.test
```

## Optional: enable local HTTPS trust

```bash
caddy trust
```

Then you can use `https://flux.test` style URLs.

## Reloading Caddy after config changes

```bash
make reload-caddy
```
