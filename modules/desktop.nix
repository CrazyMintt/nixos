{ config, pkgs, ... }:

{
    networking.hostName = "my-desktop";

    users.users.bruno.packages = with pkgs; [
	gemini-cli
	vivaldi
    ];
}
