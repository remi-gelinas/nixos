{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git-crypt
    gnupg
  ];

  documentation.dev.enable = true;
}
