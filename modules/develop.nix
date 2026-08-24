{ pkgs, ... }:

{
  imports = [
      ./programs/zed.nix
  ];
  
  home.packages = with pkgs; [
    antigravity-cli
    devenv
    docker
    python3
    nodejs_24
  ];
}