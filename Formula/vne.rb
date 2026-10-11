require "json"
require "shellwords"

class Vne < Formula
  desc "Let your coding agent work on .env files without reading them"
  homepage "https://github.com/pro-vi/vne"
  url "https://github.com/pro-vi/vne/releases/download/v0.1.1/vne-0.1.1-aarch64-apple-darwin.tar.gz"
  sha256 "7b027ba753572d11d92170bf09d41a4f9d312b7f7038aae7c2f0de908267ddd3"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "vne"
  end

  test do
    executable = (bin/"vne").to_s.shellescape
    assert_match "vne 0.1.1", shell_output("#{executable} --version")
    payload = "release-synthetic-value"
    (testpath/".env").write("RELEASE_TEST_KEY=#{payload}\n")
    output = shell_output("#{executable} check .env --json")
    refute_includes output, payload
    parsed = JSON.parse(output)
    refute_includes parsed.inspect, payload
    entry = parsed.fetch("file").fetch("entries").find { |item| item.fetch("key") == "RELEASE_TEST_KEY" }
    assert_equal "set", entry.fetch("valueState")
  end
end
