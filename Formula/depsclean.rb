class Depsclean < Formula
  desc "Fast, interactive CLI/TUI for discovering and removing dependency directories"
  homepage "https://github.com/panz3r/depsclean"
  url "https://github.com/panz3r/depsclean/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "788f0567584043e185c772b6b5eb4352196fc0367db0bc1998f5d410b60dc4ff"
  license "MPL-2.0"
  head "https://github.com/panz3r/depsclean.git", branch: "main"

  depends_on "go" => :build

  deny_network_access! [:postinstall]

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X github.com/panz3r/depsclean/internal/update.Version=#{version}"), "./cmd/depsclean"

    generate_completions_from_executable(bin/"depsclean", "completion", shell_parameter_format: :cobra)
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
