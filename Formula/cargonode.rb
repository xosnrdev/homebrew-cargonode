class Cargonode < Formula
  desc "Unified tooling for Node.js"
  homepage "https://github.com/xosnrdev/cargonode"
  url "https://github.com/xosnrdev/cargonode/archive/refs/tags/0.1.2.tar.gz"
  sha256 "b059aaf96b5b718360b8138c88744df789002c1dc28e7215d69d8eac87871743"
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
