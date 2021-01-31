let Prelude =
      https://prelude.dhall-lang.org/v20.0.0/package.dhall sha256:21754b84b493b98682e73f64d9d57b18e1ca36a118b81b33d0a243de8455814b

let mbsync =
      https://raw.githubusercontent.com/autophagy/dhall-mbsync/main/package.dhall sha256:2f8ebc728c7384a86b2735783eabfd582c0f94d9fc73ad29f83cb5662307a9a8

let maildir =
      mbsync.MaildirStore::{
      , name = "deadcells-local"
      , path = Some "~/mail/deadcells/"
      , inbox = "~/mail/deadcells/INBOX"
      , subFolders = Some mbsync.Subfolders.Verbatim
      }

let account =
      mbsync.Account::{
      , name = "deadcells"
      , host = Some "mail.gandi.net"
      , user = "mail@deadcells.org"
      , passCmd = Some
          "gpg --quiet --for-your-eyes-only --no-tty --decrypt ~/.msmtp-deadcells.gpg"
      , sslType = mbsync.SSLType.IMAPS
      , sslVersions = [ mbsync.SSLVersion.TLSv1_2 ]
      }

let imapStore =
      mbsync.IMAPStore::{ name = "deadcells-remote", account = "deadcells" }

let ChannelDef = { r : Text, l : Text }

let createChannel =
      \(c : ChannelDef) ->
        mbsync.Channel::{
        , name = "deadcells-" ++ Prelude.Text.replace "/" "!" c.l
        , master = ":deadcells-remote:" ++ Text/show c.r
        , slave = ":deadcells-local:" ++ c.l
        , create = mbsync.MasterSlave.Both
        , expunge = mbsync.MasterSlave.None
        , syncState = "*"
        }

let channels =
      [ { r = "Inbox", l = "INBOX" }
      , { r = "Archives", l = "archive" }
      , { r = "Drafts", l = "drafts" }
      , { r = "Sent", l = "sent" }
      , { r = "Trash", l = "trash" }
      , { r = "Junk", l = "junk" }
      ]

let group =
      mbsync.Group::{
      , name = "deadcells"
      , channels =
          Prelude.List.map
            ChannelDef
            Text
            ( \(c : ChannelDef) ->
                "deadcells-" ++ Prelude.Text.replace "/" "!" c.l
            )
            channels
      }

in  mbsync.Mbsync::{
    , maildirStores = [ maildir ]
    , accounts = [ account ]
    , imapStores = [ imapStore ]
    , channels =
        Prelude.List.map ChannelDef mbsync.Channel.Type createChannel channels
    , groups = [ group ]
    }
