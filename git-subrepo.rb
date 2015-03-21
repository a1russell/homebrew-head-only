class GitSubrepo < Formula
  homepage "https://github.com/ingydotnet/git-subrepo"
  head "https://github.com/ingydotnet/git-subrepo.git"

  head do
    # Allow symbolic linking of git-subrepo script.
    # https://github.com/ingydotnet/git-subrepo/issues/75
    patch do
      url "https://github.com/a1russell/git-subrepo/commit/393adca1ba49a53d01a8192900f500c4ed53fc27.diff"
      sha256 "2ba7666fa5eb34e2e84777e7e9fcd1c4a0248400e1af50b10f670a11494b1e17"
    end
  end

  def install
    mkdir_p libexec
    system "make", "PREFIX=#{prefix}", "INSTALL_LIB=#{libexec}", "install"
    bin.install_symlink libexec/"git-subrepo"
  end

  test do
    mkdir "mod" do
      system "git", "init"
      touch "HELLO"
      system "git", "add", "HELLO"
      system "git", "commit", "-m", "testing"
    end

    mkdir "container" do
      system "git", "init"
      touch ".gitignore"
      system "git", "add", ".gitignore"
      system "git", "commit", "-m", "testing"

      assert_match(/cloned into/,
                   shell_output("git subrepo clone ../mod mod"))
    end
  end
end
