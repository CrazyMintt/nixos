{ pkgs, ... }:

{
  imports = [
      ./programs/zed.nix
  ];
  
  home.packages = with pkgs; [
    devenv
    docker
    python3
    nodejs_24
  ];
}