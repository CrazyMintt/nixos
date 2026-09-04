{
  programs.zen-browser = {    
    enable = true;

    policies = {
      EnableTrackingProtection = {
        "Value" = true;
        "Category" = "standard";
      };
      Extensions = {
        "Install" = [
          "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser@keepassxc.org/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/uBlock0@raymondhill.net/latest.xpi"
        ];
      };
      SearchEngines = {
        "Default" = "DuckDuckGo";
        "Remove" = [
          "Google"
          "Bing"
          "Perplexity"
          "Wikipedia (en)"
        ];
      };
      TranslateEnabled = false;
    };
    
  };
}