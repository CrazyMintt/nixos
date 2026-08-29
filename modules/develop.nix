{ pkgs, ... }:

{
  imports = [
      ./programs/zed.nix
      ./programs/opencode.nix
  ];
  
  home.packages = with pkgs; [
    devenv
    docker
    python3
    nodejs_24
  ];
}