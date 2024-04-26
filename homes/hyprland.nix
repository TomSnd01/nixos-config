{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    waybar
    rofi-wayland
    dunst
    libnotify
    swww
    networkmanagerapplet
		grim
		slurp
		wl-clipboard
		libsForQt5.qt5.qtgraphicaleffects
  ];
}
