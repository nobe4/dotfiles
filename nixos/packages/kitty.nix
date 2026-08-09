{ pkgs, config, ... }:
{
  users.users.nobe4.packages = with pkgs; [
    kitty
    # (kitty.overrideAttrs (old: {
    #   patches = (old.patches or [ ]) ++ [
    #     ../patches/kitty_bg_alpha.patch
    #   ];
    # }))
  ];

  ln = with config; [
    [
      "kitty"
      "${home}/.config/kitty"
    ]
  ];
}
