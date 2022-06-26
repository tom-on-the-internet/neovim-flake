{ config, lib, pgks, ... }:
with lib;
with builtins; {
  imports = [ ./rust.nix ./nix.nix ./bash.nix ];
}
