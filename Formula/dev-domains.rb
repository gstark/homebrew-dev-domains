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
      dev-domains installs config templates and helper scripts.

      Important paths:
        #{opt_pkgshare}/caddy/Caddyfile
        #{opt_pkgshare}/caddy/apps
        #{opt_pkgshare}/dnsmasq/dev.conf
        #{opt_pkgshare}/docs

      Typical first-time setup:
        dev-domains paths
        sudo mkdir -p /etc/resolver
        dev-domains setup
        dev-domains run

      Note: Homebrew formulas should not modify /etc/resolver or start services during install,
      so setup remains a manual post-install step.
    EOS
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/dev-domains help")
  end
end
