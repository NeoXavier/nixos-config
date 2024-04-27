{ pkgs, inputs, ... }:

{
  # https://github.com/nix-community/home-manager/pull/2408
  # environment.pathsToLink = [ "/share/fish" ];

  # Add ~/.local/bin to PATH
  environment.localBinInPath = true;

  # Since we're using fish as our shell
  # programs.fish.enable = true;
  programs.zsh.enable = true;

  users.users.xavier = {
    isNormalUser = true;
    home = "/home/xavier";
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    initialPassword = "password";
  };
}
