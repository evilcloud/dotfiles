import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        } `additionalKeys`
        [ ((mod4Mask, xK_h), sendMessage Shrink) -- Shrink the master area
        , ((mod4Mask, xK_l), sendMessage Expand) -- Expand the master area
        , ((mod4Mask, xK_j), windows W.focusDown) -- Move focus to the next window
        , ((mod4Mask, xK_k), windows W.focusUp) -- Move focus to the previous window
        , ((mod4Mask, xK_Return), spawn "kitty") -- Launch terminal
        , ((mod4Mask, xK_b), spawn "qutebrowser") -- Launch web browser
        , ((mod4Mask, xK_Tab), sendMessage NextLayout) -- Toggle between layouts
        , ((mod4Mask, xK_w), kill) -- Kill focused window
        , ((mod4Mask .|. shiftMask, xK_q), io (exitWith ExitSuccess)) -- Quit xmonad
        , ((mod4Mask, xK_r), spawn "dmenu_run") -- Launch dmenu
        ]
