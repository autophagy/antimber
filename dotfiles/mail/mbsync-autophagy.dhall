let Prelude =
      https://prelude.dhall-lang.org/v20.0.0/package.dhall sha256:21754b84b493b98682e73f64d9d57b18e1ca36a118b81b33d0a243de8455814b

let mbsync =
      https://raw.githubusercontent.com/autophagy/dhall-mbsync/main/package.dhall sha256:2f8ebc728c7384a86b2735783eabfd582c0f94d9fc73ad29f83cb5662307a9a8

let maildir =
      mbsync.MaildirStore::{
      , name = "autophagy-local"
      , path = Some "~/mail/autophagy/"
      , inbox = "~/mail/autophagy/Inbox"
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
        , master = ":autophagy-remote:" ++ Text/show channel
        , slave = ":autophagy-local:" ++ channel
        , create = mbsync.MasterSlave.Both
        , expunge = mbsync.MasterSlave.None
        , syncState = "*"
        }

let channels =
      [ "Inbox"
      , "Sifetha"
      , "Inbox/mailing-lists"
      , "Inbox/mailing-lists/arch-announce"
      , "Inbox/mailing-lists/haskell-announce"
      , "Inbox/mailing-lists/haskell-cafe"
      , "Inbox/mailing-lists/qutebrowser"
      , "Inbox/mailing-lists/nixos"
      , "Inbox/github"
      , "Inbox/newsletters"
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

in  mbsync.Mbsync::{
    , maildirStores = [ maildir ]
    , accounts = [ account ]
    , imapStores = [ imapStore ]
    , channels =
        Prelude.List.map Text mbsync.Channel.Type createChannel channels
    , groups = [ group ]
    }
