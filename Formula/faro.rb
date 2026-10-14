class Faro < Formula
  desc "Terminal client for Signal, built for people who live in tmux"
  homepage "https://getfaro.dev"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/harababurel/faro/releases/download/v0.1.1/faro-aarch64-apple-darwin.tar.xz"
      sha256 "9f469d16356245a2eb78e71ac76b2e73695cff564eb40a4d39a9a105b9e46981"
    end
    if Hardware::CPU.intel?
      url "https://github.com/harababurel/faro/releases/download/v0.1.1/faro-x86_64-apple-darwin.tar.xz"
      sha256 "51e74d6ce54d14c9f4b68cfce6b50faba76deb87a85860659c48fe210929db38"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/harababurel/faro/releases/download/v0.1.1/faro-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3d6e62a078ce0a53ef74f2f5f4d2766a96a1de6827577468a0b1164aac4c538f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/harababurel/faro/releases/download/v0.1.1/faro-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5db21c075d33882173e61b10f15e8c87cc36640b2e179c3ae0fc0090b8e18e2b"
    end
  end
  license "AGPL-3.0-only"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "faro"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "faro"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "faro"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "faro"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
