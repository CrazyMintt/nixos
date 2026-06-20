{ config, inputs, ...}:

{
    # Noctalia
    imports = [
        inputs.noctalia.homeModules.default
    ];

    programs.noctalia.enable = true;
    xdg.stateFile."noctalia/settings.toml".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/modules/config/noctalia/settings.toml";
}