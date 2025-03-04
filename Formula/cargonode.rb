class Cargonode < Formula
  desc "A simple build tool for Node.js projects."
  homepage "https://github.com/xosnrdev/cargonode?tab=readme-ov-file#readme"
  version "1.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xosnrdev/cargonode/releases/download/v1.0.0/cargonode-aarch64-apple-darwin.tar.xz"
      sha256 "a84ef632c64f0ca3aa61f98527f913921621b6ed1b504d98f3b4b65a4832224c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xosnrdev/cargonode/releases/download/v1.0.0/cargonode-x86_64-apple-darwin.tar.xz"
      sha256 "a335859e91e209f39c9435b1e5350d7a9a2233e322384c845218448acffefd4f"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/xosnrdev/cargonode/releases/download/v1.0.0/cargonode-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "cfa323c66aa3d796a16c5aa0e4b0bb46f0d5d95c0c7e113a702511c86a9eefe4"
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
