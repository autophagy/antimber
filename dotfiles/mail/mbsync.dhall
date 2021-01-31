let mbsync =
      https://raw.githubusercontent.com/autophagy/dhall-mbsync/main/package.dhall sha256:2f8ebc728c7384a86b2735783eabfd582c0f94d9fc73ad29f83cb5662307a9a8

let autophagy = ./mbsync-autophagy.dhall

let deadcells = ./mbsync-deadcells.dhall

in  ''
    # mail@autophagy.io

    ${mbsync.mkMbsync autophagy}


    # mail@deadcells.org

    ${mbsync.mkMbsync deadcells}
    ''
