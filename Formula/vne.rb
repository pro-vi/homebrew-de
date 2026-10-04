class Vne < Formula
  desc "Let your coding agent work on .env files without reading them"
  homepage "https://github.com/pro-vi/vne"
  url "https://github.com/pro-vi/vne/releases/download/v0.1.0/vne-0.1.0-aarch64-apple-darwin.tar.gz"
  sha256 "f8df9251602866fa09c93c1542a72b35fac31d4ebc41cc830f4790f282c9fcf3"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "vne"
  end

  test do
    assert_match "vne 0.1.0", shell_output("#{bin}/vne --version")
  end
end
