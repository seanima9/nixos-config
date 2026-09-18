{ ... }:
{
  programs.steam.enable = true;
  programs.gamescope.enable = true;
  # Can use Gamescope as a nested compositor to avoid fractional scaling issues.
  # Add to Steam launch options, e.g. for a 4K 165Hz monitor:
  # gamescope -W 3840 -H 2160 -r 165 -f --backend wayland -- %command%

  allowedUnfree = [
    "steam"
    "steam-unwrapped"
  ];
}
