{
  programs.opencode = {
    enable = true;
    # tui.theme = "system";
    cli.settings = {
      permission = {
        "edit" = "ask";
        "bash" = "ask";
        "external_directory" = "ask";
      };
      theme = {
        "name" = "system";
      };
    };
  };
}