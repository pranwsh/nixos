{ config, pkgs, ... }:

let
  maildir = "${config.home.homeDirectory}/.mail";
in
{
  home.packages = with pkgs; [
    pass
    gnupg
  ];

  # Generates configs for mbsync (isync), msmtp, and neomutt
  accounts.email = {
    maildirBasePath = maildir;

    accounts.ucdavis = {
      primary = true;

      address = "srikumar@ucdavis.edu";
      realName = "Pranesh Kumar";
      userName = "srikumar@ucdavis.edu";

      # Gmail / DavisMail (UC Davis)
      imap = {
        host = "imap.gmail.com";
        port = 993;
        tls.enable = true;
      };

      smtp = {
        host = "smtp.gmail.com";
        port = 465;
        tls.enable = true;
      };

      # Store your *app password* (or UC Davis Google passphrase) in pass:
      # pass insert email/ucdavis
      passwordCommand = "${pkgs.pass}/bin/pass show email/ucdavis";

      maildir = {
        enable = true;
        path = "ucdavis";
      };

      mbsync = {
        enable = true;
        create = "maildir";
        expunge = "both";
        patterns = [ "*" ];
        extraConfig.account = {
          Timeout = 120;
          PipelineDepth = 50;
        };
      };

      msmtp.enable = true;

      neomutt = {
        enable = true;
        mailboxName = "UC Davis";
        extraConfig = ''
          set from="srikumar@ucdavis.edu"
          set realname="Pranesh Kumar"

          set folder="${maildir}/ucdavis"
          set spoolfile="+INBOX"
          set record="+[Gmail]/Sent Mail"
          set postponed="+[Gmail]/Drafts"
          set trash="+[Gmail]/Trash"

          set smtp_authenticators="login"
          set sendmail="${pkgs.msmtp}/bin/msmtp"
          set use_from=yes
          set envelope_from=yes

          set sidebar_visible=yes
          set sidebar_width=28
          set sidebar_short_path=yes
          set mail_check=60
          set timeout=10

          mailboxes "+INBOX" "+[Gmail]/Sent Mail" "+[Gmail]
