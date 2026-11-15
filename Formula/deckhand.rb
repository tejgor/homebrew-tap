class Deckhand < Formula
  desc "A lightweight agent workbench for your IDE terminal: Claude Code, Codex and Pi sessions in git worktrees"
  homepage "https://github.com/tejgor/deckhand"
  version "3.4.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tejgor/deckhand/releases/download/v3.4.5/deckhand-aarch64-apple-darwin.tar.xz"
      sha256 "fdcd8f2d87bf66de0229ab1332cf58448a9bc721484c503a26a62afa8c090e39"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tejgor/deckhand/releases/download/v3.4.5/deckhand-x86_64-apple-darwin.tar.xz"
      sha256 "3d25a108cc872f338de7dc6e645f3d177d76cd37c27bc5d8fe0f4fc06d27345b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tejgor/deckhand/releases/download/v3.4.5/deckhand-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "35792d147fc8c0270dd8b7e808d32c2f04d896ce4fd41f05ba73baab907b34ab"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tejgor/deckhand/releases/download/v3.4.5/deckhand-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fee97f63181b7281071b09b5d20d244474a592788be78ad3de7c7c82b8535137"
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
