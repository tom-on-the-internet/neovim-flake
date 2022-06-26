{inputs, ...}: final: prev: let
  inherit (prev.vimUtils) buildVimPluginFrom2Nix;

  treesitterGrammars = prev.tree-sitter.withPlugins (_: prev.tree-sitter.allGrammars);

  plugins = builtins.filter (s: (builtins.match "plugin:.*" s) != null) (builtins.attrNames inputs);
  plugName = input:
    builtins.substring
    (builtins.stringLength "plugin:")
    (builtins.stringLength input)
    input;

  buildPlug = name:
    buildVimPluginFrom2Nix {
      pname = plugName name;
      version = "master";
      src = builtins.getAttr name inputs;

      # Tree-sitter fails for a variety of lang grammars unless using :TSUpdate
      # For now install imperatively
      #postPatch =
      #  if (name == "nvim-treesitter") then ''
      #    rm -r parser
      #    ln -s ${treesitterGrammars} parser
      #  '' else "";
    };
in {
  neovimPlugins = builtins.listToAttrs (map
    (plugin: {
      name = plugName plugin;
      value = buildPlug plugin;
    })
    plugins);
}
