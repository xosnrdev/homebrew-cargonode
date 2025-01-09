class Cargonode < Formula
  desc "Unified tooling for Node.js.
"
  homepage "https://github.com/xosnrdev/cargonode?tab=readme-ov-file#readme"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xosnrdev/cargonode/releases/download/0.1.3/cargonode-aarch64-apple-darwin.tar.xz"
      sha256 "d4af417ff53fe242501c7fba22b62545b1709674bb11446904bfbed25fc1b1fd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xosnrdev/cargonode/releases/download/0.1.3/cargonode-x86_64-apple-darwin.tar.xz"
      sha256 "cfac54e01cb2b94a0d5c86ff9998783d46db3af2159e0c31c02b3495fa83e205"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/xosnrdev/cargonode/releases/download/0.1.3/cargonode-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "65b207c633c123766af9da6340794b484423f7fe6be17cedef4ec1d50c9db5e2"
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "cargonode" if OS.mac? && Hardware::CPU.arm?
    bin.install "cargonode" if OS.mac? && Hardware::CPU.intel?
    bin.install "cargonode" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
