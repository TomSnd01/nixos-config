# Daemon service to mount google drive on startup
{ pkgs }:
{
  systemd.services.rclone-gdrive = {
    description = "rclone: Mount Google Drive to /home/tosa/gdrive";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];

    serviceConfig = {
      Type = "simple";
      User = "tosa";
      Group = "users";
      # Ensure the directory exists before trying to mount
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p /home/tosa/gdrive";
      # Use the full path for fusermount3
      Environment = "PATH=/run/wrappers/bin:/bin:/usr/bin:${pkgs.coreutils}/bin:${pkgs.fuse}/bin";
      ExecStart = "${pkgs.rclone}/bin/rclone mount gdrive: /home/tosa/gdrive --config /home/tosa/.config/rclone/rclone.conf --vfs-cache-mode writes --vfs-cache-max-size 100M --log-level INFO --log-file /tmp/rclone-gdrive.log --umask 022 --allow-other";
      # Use the full path for fusermount3
      ExecStop = "/run/wrappers/bin/fusermount3 -u /home/tosa/gdrive";
    };

    wantedBy = [ "multi-user.target" ];
  };

  environment.etc."fuse.conf".text = ''
    user_allow_other
  '';
}
