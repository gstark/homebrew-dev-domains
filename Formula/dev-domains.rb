class DevDomains < Formula
  desc "Friendly local domains for multiple dev servers using Caddy and dnsmasq"
  homepage "https://github.com/gstark/dev-domains"
  url "https://github.com/gstark/dev-domains/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "REPLACE_WITH_TARBALL_SHA256"
  license "MIT"

  depends_on "caddy"
  depends_on "dnsmasq"

  def install
    pkgshare.install "caddy", "dnsmasq", "docs", "scripts", "README.md", "LICENSE", "CONTRIBUTING.md", "CODE_OF_CONDUCT.md", "Makefile"
    inreplace "bin/dev-domains", "__DEV_DOMAINS_ROOT__", pkgshare.to_s
    bin.install "bin/dev-domains"
  end

  def caveats
    <<~EOS
      dev-domains installs caddy and dnsmasq automatically via Homebrew dependencies.

      Important paths:
        #{opt_pkgshare}/caddy/Caddyfile
        #{opt_pkgshare}/caddy/apps
        #{opt_pkgshare}/dnsmasq/dev.conf
        #{opt_pkgshare}/docs

      First-time setup:
        dev-domains setup

      That command will:
        - install the bundled dnsmasq config into Homebrew's dnsmasq directory
        - create /etc/resolver/test (sudo required)
        - restart dnsmasq
        - start or restart caddy

      Note: Homebrew install itself should not modify /etc/resolver during formula installation,
      so the privileged setup step remains an explicit follow-up command.
    EOS
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/dev-domains help")
  end
end
