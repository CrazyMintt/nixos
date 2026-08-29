{
  programs.opencode = {
    enable = true;
    tui.theme = "system";
    settings = {
      permission = {
        "edit" = "ask";
        "bash" = "ask";
        "external_directory" = "ask";
      };
    };
  };
}