class Deckhand < Formula
  desc "A lightweight agent workbench for your IDE terminal: Claude Code, Codex and Pi sessions in git worktrees"
  homepage "https://github.com/tejgor/deckhand"
  version "3.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tejgor/deckhand/releases/download/v3.1.1/deckhand-aarch64-apple-darwin.tar.xz"
      sha256 "2887e71c822bb19273467990a5de53e3f7056c8ecb811beb6683855c621b5f0b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tejgor/deckhand/releases/download/v3.1.1/deckhand-x86_64-apple-darwin.tar.xz"
      sha256 "d9f776ba1b0b575b3fe955c752cd6cc0ccc06d937c658a13e6877b9d8d602446"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tejgor/deckhand/releases/download/v3.1.1/deckhand-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "815e2c1a69205875f6c4239444be7ba8c1a1f98fdc0a5129248142752571ff56"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tejgor/deckhand/releases/download/v3.1.1/deckhand-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c3c0dc489c57128240eb3e3c0a2daab08c04c56e3f777be0786fda58a6ba7cab"
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
