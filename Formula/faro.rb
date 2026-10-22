class Faro < Formula
  desc "Terminal client for Signal, built for people who live in tmux"
  homepage "https://getfaro.dev"
  version "0.1.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/harababurel/faro/releases/download/v0.1.4/faro-aarch64-apple-darwin.tar.xz"
      sha256 "0e7421eb6c33e5324688f74f32ca22967643edef0439e556af8314f2b7305f81"
    end
    if Hardware::CPU.intel?
      url "https://github.com/harababurel/faro/releases/download/v0.1.4/faro-x86_64-apple-darwin.tar.xz"
      sha256 "a37ce8f06ceb596ddc61fc24fb5bc2bbd85c7006563caad196d27a6d08e2f036"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/harababurel/faro/releases/download/v0.1.4/faro-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2d471ee0625b3442ca91426c58321f244787dd3bda8bfdba519e40e9a1f5d994"
    end
    if Hardware::CPU.intel?
      url "https://github.com/harababurel/faro/releases/download/v0.1.4/faro-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c7d1f21de9285dbcb1e80ab76d802fe1fce234e86f7d849b18b50e5d528d327c"
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
