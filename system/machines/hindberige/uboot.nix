{ config, pkgs, ... }:

let
  uboot = "${pkgs.ubootRaspberryPi4_64bit}/u-boot.bin";
  firmware = "/dev/disk/by-label/FIRMWARE";
  installed = "u-boot-rpi4.bin";

  install-uboot = pkgs.writeShellApplication {
    name = "install-uboot";
    runtimeInputs = with pkgs; [
      util-linux
      diffutils
    ];
    text = ''
      mnt=$(mktemp -d)
      mount ${firmware} "$mnt"
      trap 'umount "$mnt"; rmdir "$mnt"' EXIT
      if cmp -s ${uboot} "$mnt/${installed}"; then
        echo "${installed} already matches ${uboot}"
        exit 0
      fi
      cp "$mnt/${installed}" "$mnt/${installed}.bak"
      cp ${uboot} "$mnt/${installed}"
      sync
      echo "installed ${uboot}; previous copy kept as ${installed}.bak"
      systemctl restart check-uboot
    '';
  };
in
{
  system.checks = [
    (pkgs.runCommand "check-kernel-fits-uboot" { } ''
      image=${config.boot.kernelPackages.kernel}/${config.system.boot.loader.kernelFile}
      addrs=$(grep -a -o -E '(scriptaddr|pxefile_addr_r|fdt_addr_r|ramdisk_addr_r)=0x[0-9a-fA-F]+' ${uboot} | sort -u | cut -d= -f2)
      if [ "$(echo "$addrs" | wc -l)" -ne 4 ]; then
        echo "could not read the memory layout from ${uboot}" >&2
        exit 1
      fi
      limit=$(for a in $addrs; do echo $((a)); done | sort -n | head -1)
      text_offset=$(od -An -t u8 -j 8 -N 8 "$image" | tr -d ' ')
      image_size=$(od -An -t u8 -j 16 -N 8 "$image" | tr -d ' ')
      end=$((0x200000 + text_offset + image_size))
      if [ "$end" -gt "$limit" ]; then
        printf 'kernel needs memory up to 0x%x, past 0x%x where U-Boot loads its next image (%s)\n' "$end" "$limit" ${uboot} >&2
        exit 1
      fi
      touch $out
    '')
  ];

  environment.systemPackages = [ install-uboot ];

  systemd.services.check-uboot = {
    description = "Check the U-Boot on the FIRMWARE partition matches the configured one";
    wantedBy = [ "multi-user.target" ];
    path = with pkgs; [
      util-linux
      diffutils
    ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      PrivateMounts = true;
      PrivateTmp = true;
    };
    script = ''
      mnt=$(mktemp -d)
      mount -o ro ${firmware} "$mnt"
      if ! cmp -s ${uboot} "$mnt/${installed}"; then
        echo "${installed} on FIRMWARE differs from ${uboot}; run install-uboot" >&2
        exit 1
      fi
    '';
  };
}
