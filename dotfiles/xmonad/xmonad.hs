--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

import qualified Data.Map as M
import Data.Monoid
import System.Exit
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.Spacing
import XMonad.Layout.Grid (Grid(..))
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.SpawnOnce
import qualified XMonad.StackSet as W

myTerminal :: String
myTerminal = "urxvt"

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myClickJustFocuses :: Bool
myClickJustFocuses = False

myBorderWidth :: Dimension
myBorderWidth = 1

myModMask :: KeyMask
myModMask = mod4Mask

myWorkspaces :: [String]
myWorkspaces = map show [1 .. 9] ++ ["0"]

myNormalBorderColor :: String
myNormalBorderColor = "#000000"

myFocusedBorderColor :: String
myFocusedBorderColor = "#ffffff"

myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@XConfig {XMonad.modMask = modm} =
  M.fromList $
    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn "~/.xmonad/shell.sh"),
      -- launch rofi
      ((modm, xK_d), spawn "rofi -show drun"),
      -- launch gmrun
      ((modm .|. shiftMask, xK_d), spawn "gmrun"),
      -- close focused window
      ((modm .|. shiftMask, xK_c), kill),
      -- Rotate through the available layout algorithms
      ((modm, xK_space), sendMessage NextLayout),
      --  Reset the layouts on the current workspace to default
      ((modm .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf),
      -- Resize viewed windows to the correct size
      ((modm, xK_n), refresh),
      -- Move focus to the next window
      ((modm, xK_Tab), windows W.focusDown),
      -- Move focus to the next window
      ((modm, xK_j), windows W.focusDown),
      -- Move focus to the previous window
      ((modm, xK_k), windows W.focusUp),
      -- Move focus to the master window
      ((modm, xK_m), windows W.focusMaster),
      -- Swap the focused window and the master window
      ((modm, xK_Return), windows W.swapMaster),
      -- Swap the focused window with the next window
      ((modm .|. shiftMask, xK_j), windows W.swapDown),
      -- Swap the focused window with the previous window
      ((modm .|. shiftMask, xK_k), windows W.swapUp),
      -- Shrink the master area
      ((modm, xK_h), sendMessage Shrink),
      -- Expand the master area
      ((modm, xK_l), sendMessage Expand),
      -- Push window back into tiling
      ((modm, xK_t), withFocused $ windows . W.sink),
      -- Increment the number of windows in the master area
      ((modm, xK_comma), sendMessage (IncMasterN 1)),
      -- Deincrement the number of windows in the master area
      ((modm, xK_period), sendMessage (IncMasterN (-1))),
      -- Toggle the status bar gap
      -- Use this binding with uts from Hooks.ManageDocks.
      -- See also the statusBar function from Hooks.DynamicLog.
      --
      -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

      -- Quit xmonad
      -- , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

      -- Restart xmonad
      ((modm, xK_q), spawn "xmonad --recompile; xmonad --restart"),

      ((modm .|. shiftMask, xK_o), spawn "nim lock ~/.xmonad/lock.nims")
    ]
      ++
      --
      -- mod-[1..9], Switch to workspace N
      -- mod-shift-[1..9], Move client to workspace N
      --
      [ ((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) ([xK_1 .. xK_9] ++ [xK_0]),
          (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
      ]
      ++
      --
      -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
      -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
      --
      [ ((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0 ..],
          (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
      ]

myMouseBindings :: XConfig l -> M.Map (KeyMask, Button) (Window -> X ())
myMouseBindings XConfig {XMonad.modMask = modm} =
  M.fromList
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ( (modm, button1),
        \w ->
          focus w >> mouseMoveWindow w
            >> windows W.shiftMaster
      ),
      -- mod-button2, Raise the window to the top of the stack
      ((modm, button2), \w -> focus w >> windows W.shiftMaster),
      -- mod-button3, Set the window to floating mode and resize by dragging
      ( (modm, button3),
        \w ->
          focus w >> mouseResizeWindow w
            >> windows W.shiftMaster
      )
      -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

myLayout =
  smartBorders $ spacingRaw True (Border 0 4 4 4) True (Border 4 4 4 4) True $ avoidStruts $
        tiled
        ||| Mirror tiled
        ||| Full
        ||| Grid
  where
    -- default tiling algorithm partitions the screen into two panes
    tiled = Tall 1 (3/100) (1/2)

myManageHook :: Query (Endo WindowSet)
myManageHook =
  composeAll
    [ className =? "Nitrogen" --> doFloat,
      className =? "Pavucontrol" --> doFloat,
      className =? "KeePassXC" --> doFloat,
      className =? "zoom" --> doFloat,
      className =? "Gimp" --> doFloat,
      className =? "Slack" --> doShift "0",
      className =? "qutebrowser" --> doShift "2",
      className =? "firefox" --> doShift "2",
      className =? "Chromium" --> doShift "2"
    ]

myEventHook :: Event -> X All
myEventHook = fullscreenEventHook

myLogHook :: X ()
myLogHook = return ()

myStartupHook :: X ()
myStartupHook = do
  spawnOnce "~/.xmonad/screenlayout.sh"
  spawnOnce "nitrogen --restore &"
  spawnOnce "picom &"

------------------------------------------------------------------------
-- Custom PP
--
-- Determines what is written out to xmobar.
myTitleColor = "#eeeeee" -- color of window title

myCurrentWSColor = "#ebdbb2" -- color of active workspace

myUrgentWSColor = "#cc0000" -- color of workspace with 'urgent' window

myCurrentWSLeft = "[" -- wrap active workspace with these

myCurrentWSRight = "]"

myUrgentWSLeft = "{" -- wrap urgent workspace with these

myUrgentWSRight = "}"

myPP :: PP
myPP =
  xmobarPP
    { -- ppCurrent = xmobarColor "#429942" "" . wrap "<" ">"
      ppTitle = const "",
      ppCurrent =
        xmobarColor myCurrentWSColor ""
          . wrap myCurrentWSLeft myCurrentWSRight,
      ppUrgent =
        xmobarColor myUrgentWSColor ""
          . wrap myUrgentWSLeft myUrgentWSRight
    }

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

main :: IO ()
main = xmonad =<< statusBar "xmobar" myPP toggleStrutsKey (docks defaults)

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults =
  def
    { -- simple stuff
      terminal = myTerminal,
      focusFollowsMouse = myFocusFollowsMouse,
      clickJustFocuses = myClickJustFocuses,
      borderWidth = myBorderWidth,
      modMask = myModMask,
      workspaces = myWorkspaces,
      normalBorderColor = myNormalBorderColor,
      focusedBorderColor = myFocusedBorderColor,
      -- key bindings
      keys = myKeys,
      mouseBindings = myMouseBindings,
      -- hooks, layouts
      layoutHook = myLayout,
      manageHook = myManageHook,
      handleEventHook = myEventHook,
      logHook = myLogHook,
      startupHook = myStartupHook
    }

