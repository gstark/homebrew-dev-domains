# Troubleshooting

A good first step is:

```bash
dev-domains doctor
```

That checks for common setup problems.

## `*.test` does not resolve

Check the macOS resolver file:

```bash
cat /etc/resolver/test
```

It should contain:

```text
nameserver 127.0.0.1
```

Check dnsmasq is running:

```bash
brew services list | rg dnsmasq
```

Check lookup directly:

```bash
dig flux.test @127.0.0.1
```

You should see `127.0.0.1` in the answer.

## Caddy returns bad gateway

That usually means the target app is not running on the port in `caddy/Caddyfile`.

Example checks:

```bash
lsof -iTCP -sTCP:LISTEN -nP | rg '3000|3001|5173|8080'
```

## App rejects the hostname

Some dev servers only allow `localhost` by default. Configure the app to allow the custom hostname.

## Port 80 is already in use

Find the conflicting process:

```bash
sudo lsof -i :80
```

Stop it or run Caddy differently.

## I used `.local` and things are weird

Switch to `.test`.

`.local` often conflicts with Bonjour / mDNS on macOS.
