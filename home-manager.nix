{ config, pkgs, lib, naersk-lib, stylua, ... }: {
  home.packages = with pkgs; [
    neovimTom
    rust-analyzer
    clang-tools
    nodePackages.bash-language-server
    rnix-lsp
    alejandra
    (naersk-lib.buildPackage {
      pname = "stylua";
      root = stylua;
    })
    shellcheck
    ripgrep
    cowsay
  ];

  home.sessionVariables.EDITOR = "nvim";
  home.sessionVariables.CHECK_ME = "yay";
}
