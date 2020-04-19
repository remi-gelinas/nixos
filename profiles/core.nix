{ config, lib, pkgs, ... }:

{
  nix.package = pkgs.nixFlakes;

  nix.systemFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];

  imports = [ ../local/locale.nix ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    tmpOnTmpfs = true;

    kernel.sysctl."kernel.sysrq" = 1;
  };

  environment = {
    systemPackages = with pkgs; [
      binutils
      coreutils
      curl
      dosfstools
      dnsutils
      fd
      git
      gotop
      gptfdisk
      iputils
      manpages
      moreutils
      ripgrep
      stdmanpages
      utillinux
      bat
    ];
  };

  fonts = {
    fonts = with pkgs; [ pragmata_pro ];

    fontconfig.defaultFonts = {
      monospace = [ "PragmataPro Mono Liga" ];
      sansSerif = [ "PragmataPro Liga" ];
    };
  };

  nix = {
    autoOptimiseStore = true;

    gc.automatic = true;

    optimise.automatic = true;

    useSandbox = true;

    allowedUsers = [ "@wheel" ];

    trustedUsers = [ "root" "@wheel" ];

    extraOptions = ''
      experimental-features = nix-command flakes ca-references
    '';
  };

  security = {
    hideProcessInformation = true;

    protectKernelImage = true;

    sudo = {
      enable = true;

      extraConfig = ''
        Default       lecture_file = /etc/nixos/local/sudo.lecture
      '';
    };
  };

  users.mutableUsers = false;
}
