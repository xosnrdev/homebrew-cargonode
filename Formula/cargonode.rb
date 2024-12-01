class Cargonode < Formula
  desc "Unified tooling for Node.js"
  homepage "https://github.com/xosnrdev/cargonode"
  url "https://github.com/xosnrdev/cargonode/archive/refs/tags/0.1.1.tar.gz"
  sha256 "3a0d0a4d298c67e921e636841bf5a681057625a961f5a1359d0d7b6ef1b67a26"
  license "Apache-2.0"
  head "https://github.com/xosnrdev/cargonode.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "rust" => :build
  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system "bin/cargonode", "--version"
  end
end
