class FirefoxBookmarks < Formula
  desc "Convert Firefox bookmark backup files directly to HTML format"
  homepage "https://github.com/panz3r/firefox-bookmarks"
  url "https://github.com/panz3r/firefox-bookmarks/archive/refs/tags/v1.0.4.tar.gz"
  sha256 "85bd0a21eac79b3510444b3b62a5ed06b04dbeafe0ed20b7c6e499ba6af07fd6"
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
