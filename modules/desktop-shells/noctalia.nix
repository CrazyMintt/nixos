{ config, inputs, ...}:

{
    # Noctalia
    imports = [
        inputs.noctalia.homeModules.default
    ];
    
    programs.noctalia-shell.enable = true;
    xdg.configFile."noctalia".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/modules/config/noctalia";
}