{ config, pkgs, lib, ... }:

let
  # ======= EDIT THESE =======
  email = "srikumar@ucdavis.edu";
  realName = "Pranesh Kumar";

  # Pick ONE:
  useDavisMailGmail = true;  # true = DavisMail (Google), false = Office365

  # Where you store the password in `pass`:
  # - If DavisMail: store your GOOG passphrase
  # - If Office365: store your Kerberos passphrase
  passEntry = "email/ucdavis";
  # ==========================

  userEnc = lib.replaceStrings [ "@" ] [ "%40" ] email; # aerc URLs must be URL-encoded :contentReference[oaicite:3]{index=3}

  imapHost = if useDavisMailGmail then "imap.gmail.com" else "outlook.office365.com";
  smtpHost = if useDavisMailGmail then "smtp.gmail.com" else "smtp.office365.com";
in
{
  programs.aerc = {
    enable = true;

    # Accounts live in ~/.config/aerc/accounts.conf :contentReference[oaicite:4]{index=4}
    extraAccounts = ''
      [UCDavis]
      source = imaps://${userEnc}@${imapHost}:993
      source-cred-cmd = pass ${passEntry}

      outgoing = smtp://${userEnc}@${smtpHost}:587
      outgoing-cred-cmd = pass ${passEntry}

      from = ${realName} <${email}>
      default = INBOX
      copy-to = Sent
      cache-headers = true
    '';

    # aerc.conf (global UI/settings)
    extraConfig = ''
      set editor ${pkgs.neovim}/bin/nvim
      set pager ${pkgs.less}/bin/less -R
    '';
  };

  home.packages = with pkgs; [
    aerc
    pass
    gnupg
  ];
}
