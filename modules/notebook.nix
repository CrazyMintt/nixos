{ config, pkgs, ... }:

{
    # Exemplo: Defina um hostname específico para o notebook
    networking.hostName = "my-notebook";

    users.users.bruno.packages = with pkgs; [
        bruno
        gemini-cli
        taskwarrior3
        taskwarrior-tui
        vscode
    ];
}