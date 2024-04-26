{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
		sway
		swaylock-effects
		pavucontrol
		wlogout
		playerctl
  ];

	security.pam.services.swaylock = {
		text = ''
			auth include login
		'';
	};
}
