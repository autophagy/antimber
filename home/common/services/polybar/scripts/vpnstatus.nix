{ pkgs, ... }:

let
  jq = "${pkgs.jq}/bin/jq";
  tailscale = "${pkgs.tailscale}/bin/tailscale";
in
pkgs.writeShellScriptBin "vpnstatus" ''
  STATUS=$(${tailscale} status --json)
  STATE=$(echo "$STATUS" | ${jq} -r '.BackendState')
  if [[ "$STATE" == "Running" ]]; then
      DNS_NAME=$(echo "$STATUS" | ${jq} -r '.Self.DNSName')
      EXIT_NODE_STATUS=$(echo "$STATUS" | ${jq} -r '.ExitNodeStatus.Online' || echo "false")
          if [[ "$EXIT_NODE_STATUS" == "true" ]]; then
              echo "VPN $DNS_NAME ▶"
          else
              echo "VPN $DNS_NAME"
          fi
  else
      echo ""
  fi
''
