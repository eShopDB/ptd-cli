class PtdCli < Formula
  desc "CLI for PT-Depiler browser extension via Native Messaging"
  homepage "https://github.com/pt-plugins/ptd-cli"
  version "0.1.0"
  license "MIT"

  SHA256S = {
    "aarch64-apple-darwin"      => "7d152087fcbd739f7b3fa9a75abed5073a1920e2cbac378407167dd1d003b2c5",
    "x86_64-apple-darwin"       => "032e5748c896d6eb0e2e1f75cc1be3327c255f810b6158082fa40ad08f4f4b4b",
    "aarch64-unknown-linux-gnu" => "0d2beb0718cd8fcd268e104ad777f3fb61af628497874c8bc9fa301f34776809",
    "x86_64-unknown-linux-gnu"  => "b1398a3374ca509be107d0a82ddf379a78f5a2ccf892b6d2b5fb586290d4203c",
  }.freeze

  on_macos do
    arch = Hardware::CPU.arm? ? "aarch64-apple-darwin" : "x86_64-apple-darwin"
    url "https://github.com/pt-plugins/ptd-cli/releases/download/v#{version}/ptd-cli-v#{version}-#{arch}.tar.gz"
    sha256 SHA256S[arch]
  end

  on_linux do
    arch = Hardware::CPU.arm? ? "aarch64-unknown-linux-gnu" : "x86_64-unknown-linux-gnu"
    url "https://github.com/pt-plugins/ptd-cli/releases/download/v#{version}/ptd-cli-v#{version}-#{arch}.tar.gz"
    sha256 SHA256S[arch]
  end

  def install
    libexec.install "ptd", "ptd-host"
    (bin/"ptd").write_env_script libexec/"ptd",
      PTD_NATIVE_HOST_PATH: opt_libexec/"ptd-host"
  end

  test do
    assert_match "ptd", shell_output("#{bin}/ptd --help")
  end
end
