{ pkgs, ... }:

let
  jq = "${pkgs.jq}/bin/jq";
  tailscale = "${pkgs.tailscale}/bin/tailscale";
in
pkgs.writeShellScriptBin "vpnstatus" ''
  STATUS=$(${tailscale} status --json)
  STATE=$(echo "$STATUS" | ${jq} -r '.BackendState')
  if [[ "$STATE" == "Running" ]]; then
      CURRENT_TAILNET=$(echo "$STATUS" | ${jq} -r '.CurrentTailnet.Name')
      HOSTNAME=$(echo "$STATUS" | ${jq} -r '.Self.HostName')
      echo "VPN $HOSTNAME@$CURRENT_TAILNET"
  else
      echo ""
  fi
''
