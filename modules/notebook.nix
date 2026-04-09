# /etc/nixos/modules/laptop.nix
{ config, pkgs, ... }:

{
    # Exemplo: Defina um hostname específico para o notebook
    networking.hostName = "my-notebook";

    users.users.bruno.packages = with pkgs; [
        bruno
    ];
    
    # services.xserver.libinput.enable = true; # Já está no common, mas é um exemplo
}
