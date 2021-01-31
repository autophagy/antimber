let mkMsmtprc = \(name : Text) -> \(user : Text) -> ''
account ${name}
host mail.gandi.net
port 465
protocol smtp
auth on
user ${user}
passwordeval gpg --quiet --for-your-eyes-only --no-tty --decrypt ~/.msmtp-${name}.gpg
from ${user}
tls on
tls_starttls off
''

in ''
${mkMsmtprc "autophagy" "mail@autophagy.io"}
${mkMsmtprc "deadcells" "mail@deadcells.org"}
''
