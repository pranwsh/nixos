{ config, pkgs, ... }:

{
  programs.gpg.enable = true;
  
  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  programs.password-store = {
    enable = true;
  };

  programs.himalaya = {
    enable = true;
    
    settings = {
      accounts.ucdavis = {
        default = true;
        
        email = "srikumar@ucdavis.edu";
        display-name = "Pranesh Kumar";
        
        # Backend configuration
        backend.type = "imap";
        
        imap = {
          host = "imap.gmail.com";
          port = 993;
          encryption = "tls";
          login = "srikumar@ucdavis.edu";
          passwd.keyring = "email/ucdavis";  # Uses pass
        };
        
        smtp = {
          host = "smtp.gmail.com";
          port = 465;
          encryption = "tls";
          login = "srikumar@ucdavis.edu";
          passwd.keyring = "email/ucdavis";  # Uses pass
        };
        
        folder.alias = {
          inbox = "INBOX";
          sent = "[Gmail]/Sent Mail";
          drafts = "[Gmail]/Drafts";
          trash = "[Gmail]/Trash";
        };
      };
    };
  };
}
