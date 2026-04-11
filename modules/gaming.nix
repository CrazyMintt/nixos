{ pkgs, ... }:

{
   programs.steam.enable = true;

   users.users.bruno.packages = with pkgs; [
      discord
      steam
   ];
}