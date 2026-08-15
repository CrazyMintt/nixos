{ pkgs, ... }:

{
  programs.keepassxc = {
    enable = true;
    settings = {
      Browser = {
        Enabled = true;
      };
      GUI = {
        ApplicationTheme = "dark";
        HidePasswords = true;
      };
    };
  };

  home.file = {
    ".mozilla/native-messaging-hosts/org.keepassxc.keepassxc_browser.json".source =
      "${pkgs.keepassxc}/lib/mozilla/native-messaging-hosts/org.keepassxc.keepassxc_browser.json";

    ".zen/native-messaging-hosts/org.keepassxc.keepassxc_browser.json".source =
      "${pkgs.keepassxc}/lib/mozilla/native-messaging-hosts/org.keepassxc.keepassxc_browser.json";
  };
}
