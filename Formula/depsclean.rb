class Depsclean < Formula
  desc "Fast, interactive CLI/TUI for discovering and removing dependency directories"
  homepage "https://github.com/panz3r/depsclean"
  version "1.0.0"
  license "MPL-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/panz3r/depsclean/releases/download/v#{version}/depsclean_macos_arm64"
      sha256 "80711bde5671fbab059d169760161c8c4b4ee27421768d31dba1c091e0ef3207"
    else
      url "https://github.com/panz3r/depsclean/releases/download/v#{version}/depsclean_macos_intel"
      sha256 "18834142c66ff1924d63e887a28aaab7ff29a1f54f87b7ee158b31e88e09047f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/panz3r/depsclean/releases/download/v#{version}/depsclean_linux_arm64"
      sha256 "bf3d2fbe230a00ba7e3dbeec160efa0d4ba27c38735e72c51f7e6757c5003cb2"
    else
      url "https://github.com/panz3r/depsclean/releases/download/v#{version}/depsclean_linux_amd64"
      sha256 "cdc5100da32e4c994e356ff5a579245b754eb8ac51a3621fac959b51d4d482b5"
    end
  end

  def install
    binary_name = if OS.mac?
      Hardware::CPU.arm? ? "depsclean_macos_arm64" : "depsclean_macos_intel"
    else
      Hardware::CPU.arm? ? "depsclean_linux_arm64" : "depsclean_linux_amd64"
    end

    bin.install binary_name => "depsclean"
  end

  def caveats
    <<~EOS
      #{if OS.mac?
          <<~MAC
            This binary is unsigned. You may need to authorize it in
            System Settings > Privacy & Security, or run:
              xattr -d com.apple.quarantine #{bin}/depsclean
          MAC
      end}
      To remove global configuration on uninstall, run:
      rm -f ~/.config/depsclean/config.json
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/depsclean version")
  end
end
