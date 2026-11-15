{ ... }:
{
  services = {
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "prohibit-password";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        LoginGraceTime = "30s";
        MaxAuthTries = 3;
      };
    };
    fail2ban.enable = true;
  };
}
