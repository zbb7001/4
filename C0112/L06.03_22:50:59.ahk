#t::  ; Control+Alt+Z 热键.
IfWinExist, ahk_class EmEditorMainFrame3
{
    WinActivate  ; 自动使用上面找到的窗口.
   ; WinMaximize  ; 同上
    Send, ^v {Enter}
sleep, 200
WinMinimize
    return
}