{
  config,
  osConfig,
  pkgs,
  inputs,
  ...
}:
let
  profileName = osConfig.my.user.zenProfileName;
  theme = config.style;
in
{
  imports = [
    inputs.zen-browser.homeModules.default
  ];

  programs.zen-browser = {
    enable = true;

    policies.ExtensionSettings = {
      "uBlock0@raymondhill.net" = {
        installation_mode = "force_installed";
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
      };
      "addon@darkreader.org" = {
        installation_mode = "force_installed";
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
      };
    };

    profiles.${profileName} = {
      isDefault = true;
      search = {
        force = true;
        default = "ddg";
      };
      settings = {
        "browser.aboutConfig.showWarning" = false;
        "browser.bookmarks.restore_default_bookmarks" = false;
        "browser.bookmarks.showMobileBookmarks" = false;
        "browser.contentblocking.category" = "standard";
        "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.urlbar.suggest.bookmark" = false;
        "browser.urlbar.suggest.openpage" = false;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.tabs.allow_transparent_browser" = true;
        "browser.theme.content-theme" = 0;
        "browser.theme.toolbar-theme" = 0;
        "devtools.chrome.enabled" = true;
        "devtools.debugger.remote-enabled" = true;
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        "network.dns.disablePrefetch" = true;
        "network.http.speculative-parallel-limit" = 0;
        "network.predictor.enabled" = false;
        "network.prefetch-next" = false;
        "privacy.clearOnShutdown_v2.formdata" = true;
        "privacy.history.custom" = true;
        "signon.generation.enabled" = false;
        "signon.management.page.breach-alerts.enabled" = false;
        "signon.rememberSignons" = false;
        "zen.splitView.enable-tab-drop" = false;
        "zen.theme.content-element-separation" = 0;
        "zen.view.grey-out-inactive-windows" = false;
        "zen.welcome-screen.seen" = true;
        "zen.widget.linux.transparency" = true;
        "lacuna.tab.default-audio-indicator" = true;
        "lacuna.urlbar.smaller-compact-mode" = true;
      };
    };
  };

  home.file.".zen/${profileName}/chrome" = {
    source = ./config/chrome;
    recursive = true;
  };
  home.file.".zen/${profileName}/chrome/nix-colors.css" = {
    text = ''
      :root {
        --nix-background: rgba(${theme.backgroundRgb},${toString theme.opacity});
      }
    '';
  };
}
