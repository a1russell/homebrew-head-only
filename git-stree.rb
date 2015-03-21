class GitStree < Formula
  homepage "https://github.com/tdd/git-stree"
  head "https://github.com/tdd/git-stree.git"

  def install
    bin.install "git-stree"
    bash_completion.install "git-stree-completion.bash" => "git-stree"
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

      system "git", "stree", "add", "mod", "-P", "mod", "../mod"
    end
  end
end
