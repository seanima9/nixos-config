{ pkgs, ... }:
{
  programs = {
    ripgrep = {
      enable = true;
      arguments = [ "--smart-case" ];
    };
    fd.enable = true;
    gh.enable = true;
    lazygit.enable = true;
    btop.enable = true;
    tealdeer.enable = true;
    tmux = {
      enable = true;
      mouse = true;
      clock24 = true;
    };
    bat.enable = true;
    eza = {
      enable = true;
      enableFishIntegration = true;
      git = true;
      colors = "auto";
      extraOptions = [
        "--group-directories-first"
        "--classify=always"
      ];
    };
    jq.enable = true;
    fastfetch.enable = true;
  };

  home.packages = with pkgs; [
    procs
    age
    grok-build
    unzip
  ];
}
