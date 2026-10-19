class Faro < Formula
  desc "Terminal client for Signal, built for people who live in tmux"
  homepage "https://getfaro.dev"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/harababurel/faro/releases/download/v0.1.2/faro-aarch64-apple-darwin.tar.xz"
      sha256 "44b1771876dd2faf15a7b41a0ec1274361b9c5eefc8b49c62c65b9412bd4c820"
    end
    if Hardware::CPU.intel?
      url "https://github.com/harababurel/faro/releases/download/v0.1.2/faro-x86_64-apple-darwin.tar.xz"
      sha256 "92488a16982dd2f91f18b0da8ffcda368f372b2e7ba9c9b223dc2f5b2220972b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/harababurel/faro/releases/download/v0.1.2/faro-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "68200df59f9bcb7d67c046ac6a6d6a4063c879edc148b48f7ef9d9b1afa70ab6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/harababurel/faro/releases/download/v0.1.2/faro-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9661d9f92b7c43f3633b3787483ba328074450cfaae0cfcd9dba32c2e81dd555"
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
