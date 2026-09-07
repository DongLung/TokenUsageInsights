class Tokenusageinsights < Formula
  desc "Local-first dashboard for AI coding agent token usage"
  homepage "https://github.com/DongLung/TokenUsageInsights"
  license "MIT"
  url "https://github.com/DongLung/TokenUsageInsights/archive/refs/tags/v0.0.0.tar.gz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: ".", root: libexec)

    (bin/"tokenusageinsights").write <<~EOS
      #!/bin/bash
      cd "#{pkgshare}" || exit 1
      exec "#{libexec}/bin/token-usage-insights" "$@"
    EOS
    chmod 0755, bin/"tokenusageinsights"

    bin.install_symlink bin/"tokenusageinsights" => "token-usage-insights"
    bin.install libexec/"bin/token-usage-insights-cli"

    pkgshare.install "static", "pricing.csv", "shell", "scripts", "README.md", "LICENSE"
  end

  test do
    output = shell_output("#{bin}/token-usage-insights-cli --help")
    assert_match "token-usage-insights-cli", output
  end
end
