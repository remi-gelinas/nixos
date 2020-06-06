{ pkgs ? import <nixpkgs> {} }:
let
  flakes = import "${pkgs.path}/nixos" { configuration.nix.package = pkgs.nixFlakes; };
in
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [ git git-crypt ];
  buildInputs = with flakes; with config.system.build; [ nixos-rebuild ];

  NIX_CONF_DIR = let
    current = pkgs.lib.optionalString (builtins.pathExists /etc/nix/nix.conf)
      (builtins.readFile /etc/nix/nix.conf);

    nixConf = pkgs.writeTextDir "opt/nix.conf" ''
      ${current}
      experimental-features = nix-command flakes ca-references
    '';
  in "${nixConf}/opt";
}
