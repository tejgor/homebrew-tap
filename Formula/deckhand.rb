class Deckhand < Formula
  desc "A lightweight agent workbench for your IDE terminal: Claude Code, Codex and Pi sessions in git worktrees"
  homepage "https://github.com/tejgor/deckhand"
  version "3.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tejgor/deckhand/releases/download/v3.3.0/deckhand-aarch64-apple-darwin.tar.xz"
      sha256 "dec8794a7078be16dceb5b44a1cd775fd41054259cd12216ebff152dcfa5b4ba"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tejgor/deckhand/releases/download/v3.3.0/deckhand-x86_64-apple-darwin.tar.xz"
      sha256 "2e0504d3313a52daa2e5b4cca91d3d395cd2af3839305a94f3476221983acc9d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tejgor/deckhand/releases/download/v3.3.0/deckhand-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "791c18d9e4a7286a6be3e21d34a99d150dcaddf353deec55bd8e4e89c1103161"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tejgor/deckhand/releases/download/v3.3.0/deckhand-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cd5786be3a6137fd907fdef83a3b4268977a5b6b59abc31078d347a4553de33a"
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
