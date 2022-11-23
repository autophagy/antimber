{ pkgs, ... }:

let
  jq = "${pkgs.jq}/bin/jq";
  tailscale = "${pkgs.tailscale}/bin/tailscale";
in
pkgs.writeShellScriptBin "vpnstatus" ''
  STATE=$(${tailscale} status --json | ${jq} -r '.BackendState')
  if [[ "$STATE" == "Running" ]]; then
      IP=$(${tailscale} ip -4)
      echo "VPN $IP"
  else
      echo ""
  fi
''
