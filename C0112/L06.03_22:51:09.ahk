; https://www.autohotkey.com/board/topic/127255-how-do-i-create-a-hotkey-for-key-sequence-ctrlshiftg-ctrlshiftu/
CapsLock & p::
msg := "
(
    0 for removing while-spaces
    n for removing `n
)"
ToolTip, % msg
input, command, L1 ; L1 to limit the input to 1 keys.
StringLower, command, command
if (command = "0")
{
    ; remove null
    s := Clipboard
    Clipboard := RegExReplace(s, "\s" ,"")
}
; https://www.autohotkey.com/board/topic/23985-removing-line-breaks-in-a-variable/
else if (command = "n"){
    s := Clipboard
    StringReplace, s,s, `r,, All
    StringReplace, s,s, `n,, All
    Clipboard := s 
}else{
    msgbox, no change
    ToolTip,
    Return
}
ToolTip, 剪贴版内容已改变
SetTimer, RemoveToolTip, -1000
Return

RemoveToolTip:
ToolTip
return
