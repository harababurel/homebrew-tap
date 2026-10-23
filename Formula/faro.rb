class Faro < Formula
  desc "Terminal client for Signal, built for people who live in tmux"
  homepage "https://getfaro.dev"
  version "0.1.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/harababurel/faro/releases/download/v0.1.5/faro-aarch64-apple-darwin.tar.xz"
      sha256 "b663e3e347e4604b684080e0186dcb0acfc8aa09178456b4c6f93db009b8def4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/harababurel/faro/releases/download/v0.1.5/faro-x86_64-apple-darwin.tar.xz"
      sha256 "c59556ddbabda28f48aa287aeb8b486b43d70e2281d3232ed22e54f611da08f9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/harababurel/faro/releases/download/v0.1.5/faro-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e1afbe19ddd3b11d65b04386fd4c17acc6b144cac2ce182d3356b9714b34e5a1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/harababurel/faro/releases/download/v0.1.5/faro-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "673323eba06ad303d122c03f915ec9f58d04335610bef2e60dcedaccd974bd0f"
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
