class FirefoxBookmarks < Formula
  desc "Convert Firefox bookmark backup files directly to HTML format"
  homepage "https://github.com/panz3r/firefox-bookmarks"
  url "https://github.com/panz3r/firefox-bookmarks/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "f56a20160366cf1678ebcc8193ecc3d7a0d6c226db9afeffa2141b2b55c5690d"
  license "MIT"
  head "https://github.com/panz3r/firefox-bookmarks.git", branch: "main"

  depends_on "go" => :build

  deny_network_access! [:postinstall]

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  def caveats
    if OS.mac?
      <<~MAC
        This binary is unsigned. You may need to authorize it in
        System Settings > Privacy & Security, or run:
          xattr -d com.apple.quarantine #{bin}/firefox-bookmarks
      MAC
    end
  end

  test do
    assert_match "firefox-bookmarks [-o OUTPUT_FILE] input_file", shell_output("#{bin}/firefox-bookmarks -help")
  end
end
