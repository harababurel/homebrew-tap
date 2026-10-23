class Faro < Formula
  desc "Terminal client for Signal, built for people who live in tmux"
  homepage "https://getfaro.dev"
  version "0.1.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/harababurel/faro/releases/download/v0.1.6/faro-aarch64-apple-darwin.tar.xz"
      sha256 "19e72c3b65b0d5e9b99d3aa0329167a058e0338c267aca8f14ca9a3a385687c3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/harababurel/faro/releases/download/v0.1.6/faro-x86_64-apple-darwin.tar.xz"
      sha256 "cab3123aace9dc18027b397c057233985a9487aeea5603a7db39b94818ceac9a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/harababurel/faro/releases/download/v0.1.6/faro-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5c33b43d6546efae1f729c253521128ff6a2241b6867e17c6ed27bd319dd4278"
    end
    if Hardware::CPU.intel?
      url "https://github.com/harababurel/faro/releases/download/v0.1.6/faro-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "43dd29e07f0ba1356b4f73f560014b9ad4c953fb50dc5f23b1133614d22fe832"
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
