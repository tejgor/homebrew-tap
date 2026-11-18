class Deckhand < Formula
  desc "A lightweight agent workbench for your IDE terminal: Claude Code, Codex and Pi sessions in git worktrees"
  homepage "https://github.com/tejgor/deckhand"
  version "3.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tejgor/deckhand/releases/download/v3.6.0/deckhand-aarch64-apple-darwin.tar.xz"
      sha256 "1be7e15a4ffd4dcff86b2ab960bc7c2515c4b08856faa1654ab68b92306b6c7c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tejgor/deckhand/releases/download/v3.6.0/deckhand-x86_64-apple-darwin.tar.xz"
      sha256 "9d4abab63d188b22ec5189e93517d6d21c02e6f4077cae8e6eec32e214be1bee"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tejgor/deckhand/releases/download/v3.6.0/deckhand-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4c85e441602d59e6f8803f19e1358fcf9aea42154a828858ba4807cac36e1296"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tejgor/deckhand/releases/download/v3.6.0/deckhand-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6d7db10e69f94d57eba8b9528614263853eabe777e4f29e390a9676848dbaabe"
    end
  end
  license "MIT"

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
      bin.install "deckhand"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "deckhand"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "deckhand"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "deckhand"
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
