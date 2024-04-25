{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
		sway
		swaylock-effects
		pavucontrol
		wlogout
  ];

	security.pam.services.swaylock = {
		text = ''
			auth include login
		'';
	};
}
