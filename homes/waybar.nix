{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
		sway
		swaylock
		pavucontrol
		wlogout
  ];

	security.pam.services.swaylock = {
		text = ''
			auth include login
		'';
	};
}
