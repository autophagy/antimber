let Prelude =
      https://prelude.dhall-lang.org/v20.0.0/package.dhall sha256:21754b84b493b98682e73f64d9d57b18e1ca36a118b81b33d0a243de8455814b

let mbsync =
      https://raw.githubusercontent.com/autophagy/dhall-mbsync/main/package.dhall sha256:22bfeccc3e38a478b254d8566be3e932189d4c57831ba432378b3d35ecc30269

let maildir =
      mbsync.MaildirStore::{
      , name = "autophagy-local"
      , path = Some "~/mail/autophagy/"
      , inbox = "~/mail/autophagy/INBOX"
      , subFolders = Some mbsync.Subfolders.Verbatim
      }

let account =
      mbsync.Account::{
      , name = "autophagy"
      , host = Some "mail.gandi.net"
      , user = "mail@autophagy.io"
      , passCmd = Some
          "gpg --quiet --for-your-eyes-only --no-tty --decrypt ~/.msmtp-autophagy.gpg"
      , sslType = mbsync.SSLType.IMAPS
      , sslVersions = [ mbsync.SSLVersion.TLSv1_2 ]
      }

let imapStore =
      mbsync.IMAPStore::{ name = "autophagy-remote", account = "autophagy" }

let createChannel =
      λ(channel : Text) →
        mbsync.Channel::{
        , name = "autophagy-" ++ Prelude.Text.replace "/" "!" channel
        , far = ":autophagy-remote:" ++ Text/show channel
        , near = ":autophagy-local:" ++ channel
        , create = mbsync.FarNear.Both
        , expunge = mbsync.FarNear.None
        , syncState = "*"
        }

let channels =
      [ "INBOX"
      , "Sifetha"
      , "INBOX/mailing-lists"
      , "INBOX/mailing-lists/arch-announce"
      , "INBOX/mailing-lists/haskell-cafe"
      , "INBOX/mailing-lists/qutebrowser"
      , "INBOX/mailing-lists/nixos"
      , "INBOX/mailing-lists/flink-dev"
      , "INBOX/mailing-lists/flink-user"
      , "INBOX/github"
      , "INBOX/newsletters"
      , "Archives"
      , "Drafts"
      , "Sent"
      , "Trash"
      , "Junk"
      ]

let group =
      mbsync.Group::{
      , name = "autophagy"
      , channels =
          Prelude.List.map
            Text
            Text
            (λ(c : Text) → "autophagy-" ++ Prelude.Text.replace "/" "!" c)
            channels
      }

in  mbsync.mkMbsync
      mbsync.Mbsync::{
      , maildirStores = [ maildir ]
      , accounts = [ account ]
      , imapStores = [ imapStore ]
      , channels =
          Prelude.List.map Text mbsync.Channel.Type createChannel channels
      , groups = [ group ]
      }
