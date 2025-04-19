{ config, pkgs, ... }:

{
  # Watch email folder change
  # services.himalaya-watch.enable = true;

  # Enable himalaya
  programs.himalaya.enable = true;
  # Enable thunderbird
  programs.thunderbird = {
    enable = true;
    profiles.default = {
      isDefault = true;
    };
  };

  accounts.email.accounts = {
    umd = {
      primary = true;
      address = "zli12330@terpmail.umd.edu";
      realName = "Zekun Li";
      userName = "zli12330@terpmail.umd.edu";
      passwordCommand = "pass show email/umd";
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

      himalaya.enable = true;
      thunderbird.enable = true;
    };

    gmail = {
      address = "yucklys687@gmail.com";
      realName = "Zekun Li";
      userName = "yucklys687@gmail.com";
      passwordCommand = "pass show email/gmail";
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

      himalaya.enable = true;
      thunderbird.enable = true;
    };

    startmail = {
      address = "yucklys@startmail.com";
      realName = "Zekun Li";
      userName = "yucklys@startmail.com";
      passwordCommand = "pass show email/startmail";
      imap = {
        host = "imap.startmail.com";
        port = 993;
        tls.enable = true;
      };

      smtp = {
        host = "smtp.startmail.com";
        port = 465;
        tls.enable = true;
      };

      himalaya.enable = true;
      thunderbird.enable = true;
    };

    outlook = {
      address = "yucklys687@outlook.com";
      realName = "Zekun Li";
      userName = "yucklys687@outlook.com";
      passwordCommand = "pass show email/outlook";
      imap = {
        host = "outlook.office365.com";
        port = 993;
        tls.enable = true;
      };

      smtp = {
        host = "smtp.office365.com";
        port = 587;
        tls.enable = true;
        tls.useStartTls = true;
      };

      himalaya.enable = true;
      thunderbird.enable = true;
    };
  };
}
