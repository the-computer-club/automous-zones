{ self, config, lib, pkgs, ... }:
let cfg = config.services.wgsd-client;
in
{
  options.services.wgsd-client = {
    enable = lib.mkEnableOption "wgsd-client service";

    package = lib.mkOption {
      type = lib.types.package;
      default = self.packages.${pkgs.system}.wgsd;
      description = "The wgsd package to use";
    };

    interval = lib.mkOption {
      type = lib.types.str;
      default = "5min";
      description = "How often to run wgsd-client";
    };

    user = lib.mkOption {
      type = lib.types.str;
      default = "wgsd";
      description = "User to run wgsd-client as";
    };

    group = lib.mkOption {
      type = lib.types.str;
      default = "wgsd";
      description = "Group to run wgsd-client as";
    };
  };

  config = lib.mkIf cfg.enable {
    # Create user and group
    users.users.${cfg.user} = {
      isSystemUser = true;
      group = cfg.group;
      description = "wgsd-client service user";
    };

    users.groups.${cfg.group} = {};

    # Systemd service
    systemd.services.wgsd-client = {
      description = "wgsd-client service";
      serviceConfig = {
        Type = "oneshot";
        User = cfg.user;
        Group = cfg.group;
        ExecStart = "${cfg.package}/bin/wgsd-client";
        PrivateTmp = true;
        ProtectSystem = "strict";
        ProtectHome = true;
        NoNewPrivileges = true;
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
        ProtectControlGroups = true;
      };
      # Don't want this to run on boot, only via timer
      wantedBy = lib.mkForce [];
    };

    # Systemd timer
    systemd.timers.wgsd-client = {
      description = "Timer for wgsd-client service";
      timerConfig = {
        OnBootSec = cfg.interval;
        OnUnitActiveSec = cfg.interval;
        Persistent = true;
      };
      wantedBy = [ "timers.target" ];
    };
  };
}
