class GitPlus < Formula
  homepage "https://github.com/tkrajina/git-plus"
  head "https://github.com/tkrajina/git-plus.git"

  depends_on :python if MacOS.version <= :snow_leopard

  def install
    site_packages = libexec/"lib/python2.7/site-packages"
    libexec_bin = libexec/"bin"

    ENV.prepend_create_path "PYTHONPATH", site_packages

    site_packages.install "gitutils.py"
    libexec_bin.install Dir["git-*"]

    bin.install Dir[libexec_bin/"*"]
    bin.env_script_all_files libexec_bin, :PYTHONPATH => ENV["PYTHONPATH"]
  end

  test do
    mkdir "testme" do
      system "git", "init"
      touch "README"
      system "git", "add", "README"
      system "git", "commit", "-m", "testing"
      rm "README"
    end

    assert_match /D README/, shell_output("#{bin}/git-multi")
  end
end
