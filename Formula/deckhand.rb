class Deckhand < Formula
  desc "A lightweight agent workbench for your IDE terminal: Claude Code, Codex and Pi sessions in git worktrees"
  homepage "https://github.com/tejgor/deckhand"
  version "3.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tejgor/deckhand/releases/download/v3.0.1/deckhand-aarch64-apple-darwin.tar.xz"
      sha256 "596d56a1fef33dfaeaa3bf1edd9c9810d589fde9650c017f50cdae980afc03bf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tejgor/deckhand/releases/download/v3.0.1/deckhand-x86_64-apple-darwin.tar.xz"
      sha256 "e47c5ddab2c697b70bb5fdcbe5c3ce8c860263b6eb5ca28d9521133fa0736be4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tejgor/deckhand/releases/download/v3.0.1/deckhand-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "90b97bca02478e340eb9a129beae882941bfe4f39a824ebdbd50bef1fad943c0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tejgor/deckhand/releases/download/v3.0.1/deckhand-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3a0ed36370cbbbd21401e12fe42c889d17276c6eca9ef2477bb371c012669a17"
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
