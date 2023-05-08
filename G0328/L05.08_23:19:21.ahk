﻿
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢   0
Menu, Tray, Icon, E:\3\IDM v6.38.7.2 中文绿色特别版\IDM\Bin\IDMan.exe,15           ; 脚本图标 
;Menu , tray , tip , !w
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢   1  
#NoEnv                             ; 主要是为了与以后兼容，也可以改善性能
#SingleInstance Force        　         ;当此脚本已经运行时自动替换旧实例再次运行。 
#WinActivateForce                                     ;用强制的方法激活窗口。
#Persistent                      ; 使非热键类的脚本持久运行（即直到用户关闭或遇到 ExitApp）
#SingleInstance                                                                    ; 避免意外的多实例
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢   2
SetBatchLines, -1                                    ; 脚本快速执行,减少 CPU 占用,  使用10ms -1
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢   3
FileGetTime ScriptStartModTime, %A_ScriptFullPath%
SetTimer CheckScriptUpdate, 100, 0x7FFFFFFF ; 100 ms, highest priority最高优先级
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢   4
CheckScriptUpdate() {
    global ScriptStartModTime
    FileGetTime curModTime, %A_ScriptFullPath%
    If (curModTime == ScriptStartModTime)
        return
    SetTimer CheckScriptUpdate, Off
    Loop
    {
        reload
        ;Sleep 300 
        ;MsgBox 0x2, %A_ScriptName%, Reload failed. ; 0x2 = Abort/Retry/Ignore
        ;IfMsgBox Abort
           ; ExitApp
       ; IfMsgBox Ignore
          ;  break
    } ; loops reload on"Retry"
}
;------------------------------------------脚本修改并保存后  自动刷新脚本   
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢   5
SetWorkingDir, %A_ScriptDir%                                      ; 让脚本无条件使用它所在的文件夹作为工作目录  
#Include *i %A_ScriptDir%\1\ImagePut.ahk
#Include *i %A_ScriptDir%\BeautifulToolTip\Lib\BTT.ahk
#Include *i %A_ScriptDir%\BeautifulToolTip\Lib\Gdip_All.ahk
#Include *i %A_ScriptDir%\BeautifulToolTip\Lib\NonNull.ahk
#include, %A_ScriptDir%
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢   6
devices := ["耳机", "扬声器"]                 ; 改变先后，改变默认
logo := 
cur := 0
ChangeDevice(devices[cur+1], logo)
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢   7
;#NoEnv                                             
;#SingleInstance Force
SendMode Input
Array := []
qCount = 0
zCount = 0
DelimitByCell = 1
InterpretAsCode = 1
TrimEnds = 1
RemoveBlanks = 0

*>!F1::                                          ;---------------------------
Clipboard = %Clipboard%
Send ^c
ClipWait, 1
Gosub ClipboardFormat
Return

*>!F3::                                         ;---------------------------
zCount -= 1
qCount := zCount
Gosub WatchToolTip
Return

~*>!F2::                                         ;---------------------------
zCount += 1
qCount := zCount
If (InterpretAsCode = 0)     ; Uses SendRaw.
	SendRaw % Array[zCount]
If (InterpretAsCode = 1)     ; Uses Send function.
	Send(Array[zCount])
Gosub WatchToolTip
Return
*>!F4::                                         ;---------------------------
zCount += 1
qCount := zCount
Gosub WatchToolTip
Return
WatchTooltip:
NextItem := Array[zCount+1]
PreviousItem := Array[zCount]
1Count := zCount
ToolTip, No. %1Count% `r`n粘贴: %NextItem% `r`n前:  %PreviousItem%
SetTimer, RemoveTooltip, -3000
Return
RemoveTooltip:
ToolTip
Return
ClipboardFormat:
If (DelimitByCell = 0)
{
	qCount += 1
	Clipboard := StrReplace(Clipboard,"`r`n","`n")     ; Fixes double-newline issue.
	Array[qCount] := ClipboardTrim(Clipboard)
	If (RemoveBlanks = 1) && Trim(Clipboard = "`n")     ;If Clipboard is only composed of a newline, then it can be ignored.
	{
		qCount -= 1 
	}
}
If (DelimitByCell = 1)
{
	Clipboard := StrReplace(Clipboard,"`r`n","¶")     ; Replaces newlines (vertical cells) with ¶ symbol.
	Clipboard := StrReplace(Clipboard,"`t","¶")     ; Replaces tabs (horizontal cells) with ¶ symbol.
	If (SubStr(Clipboard,0) = "¶")     ; Removes the last ¶ symbol from the string, if it exists, meaning selection was copied from excel.
	{
		Clipboard := Substr(Clipboard, 1, StrLen(Clipboard) - 1)
	}
	Loop, Parse, Clipboard, "¶"
	{
		qCount += 1
		Array[qCount] := ClipboardTrim(A_LoopField)
		If (RemoveBlanks = 1) && (Array[qCount] = "")     ;If Clipboard is blank, then it can be ignored.
		{
			qCount -= 1 
		}
	}
}
Return
ClipboardTrim(StringToTrim)
{
If (TrimEnds = 1)
{
	StringToTrim := Trim(StringToTrim)
}

Return StringToTrim
}
Send(String, Raw:="", RawKeys:="")
{
D:="{",E="}",S:=String D,i=0,T=1,R=(Raw?1:(SubStr(S,1,5)="{RAW}"?1:0)),M="+,!,<!,^",K=RawKeys
While i:=InStr(S,D,V,i+1){
Send,% (R?"{RAW}":"") SubStr(S,T,InStr(S,D,V,i)-T)
B:=SubStr(S,InStr(S,D,V,i)+1,InStr(S,E,V,i)-StrLen(S)-1),A=SubStr(B,1,-1)
If InStr(S,D,V,i+1)
If(B&1=""){
If(A&1!="")
Sleep,% A*1000
else{
L:=(!R?(InStr(S,E,V,i)-StrLen(B)-2>4?4:InStr(S,E,V,i)-StrLen(B)-2):0)
Loop,%L%{
C:=SubStr(SubStr(S,InStr(S,D,V,i)-L,L),A_Index,1)
If C in %M%
{ C:=SubStr(S,InStr(S,D,V,i)-(L+1-A_Index),L+1-A_Index)
break
}else C:=""
}Send,% (K?"{RAW}":"") C "{" B "}"
}}else Sleep,%B%
T:=InStr(S,E,V,i+1)+1
}}
return
; ----------------*>!F1复制 *>!F3 F4切换剪贴板 *>!F2粘贴  重启 清空
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢   8
If Not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%" 
   ExitApp
}
/*
Label_AdminLaunch: ; 管理员启动
	iniread, Launch_Admin, %INI%, 基本设置, 管理员启动, 1
	if (!A_IsAdmin && Launch_Admin=1)
	{
	    try
	    {
	        if A_IsCompiled
	            Run *RunAs "%A_ScriptFullPath%" /restart
	        else
	            Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
	    }catch{
	    	MsgBox, 1,, 以【管理员权限】启动失败！将以普通权限启动，管理员应用窗口将失效！
			IfMsgBox OK
			{
				if A_IsCompiled
	            	Run "%A_ScriptFullPath%" /restart
	       		else
	            	Run "%A_AhkPath%" /restart "%A_ScriptFullPath%"
			}
	    }
	    ExitApp
	}
*/
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢ 9
~appskey & F1::                                                  
    cur := Mod(cur + 1, devices.Length())
    option := logo
    ChangeDevice(devices[cur+1], option)
sleep 500
    return

ChangeDevice(device, option) 
{
loop,1
    SoundBeep, 1000, 10
Text= ⭕       %device%   %option%     ⭕
btt(Text,600,0,,"Style4") 
sleep, 1000
btt()​
       Run, nircmd.exe setdefaultsounddevice %device%       
   }   
 return
;----------------------------------------------切换音频设备 appskey & F1
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢ 10
#SingleInstance Off
;MsgBox, 4096,, % A_Now
return
OnlyOne(flag="") {
  static init:=OnlyOne("001")
  DetectHiddenWindows, % (bak:=A_DetectHiddenWindows) ? "On":"On"
  mypid:=DllCall("GetCurrentProcessId")
  flag:="Ahk_OnlyOne_Ahk<<" . flag . ">>"
  Gui, Ahk_OnlyOne_Ahk: Show, Hide, %flag%
  WinGet, list, List, %flag% ahk_class AutoHotkeyGUI
  Loop, % list
  IfWinExist, % "ahk_id " . list%A_Index%
  {
    WinGet, pid, PID
    IfEqual, pid, %mypid%, Continue
    WinClose, ahk_pid %pid% ahk_class AutoHotkey,, 3
    IfWinNotExist,,, Continue
    Process, Close, %pid%
    WinWaitClose
  }
  WinGet, list, List, %flag% ahk_class AutoHotkeyGUI
  IfNotEqual, list, 1, ExitApp
  DetectHiddenWindows, %bak%
}
;------------限制单进程运行 同时启动N个本脚本，只会保留1个进程
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
global MyClipData
global page
*>!q:: 批量复制粘贴工具()  
#IfWinExist, 批量复制粘贴工具 ahk_class AutoHotkeyGUI
$^c::
Clipboard:=""
Send ^c{Ctrl Up}
ClipWait, 3
s:=Clipboard
if (s="")
ToolTip,
else
批量复制粘贴工具(s)
return
1::
nume:=1
Gosub copytt(nume)
return
2::
nume:=2
Gosub copytt(nume)
return
3::
nume:=3
Gosub copytt(nume)
return
4::
nume:=4
Gosub copytt(nume)
return
5::
nume:=5
Gosub copytt(nume)
return
6::
nume:=6
Gosub copytt(nume)
return
7::
nume:=7
Gosub copytt(nume)
return
8::
nume:=8
Gosub copytt(nume)
return
9::
nume:=9
Gosub copytt(nume)
return
copytt(nume):
{
i:=nume
Clipboard:=MyClipData[i:=(page-1)*10+i]
Send ^v
return
}
0::
nume1:=0
Gosub copytt(nume1)
return

copytt(nume1):
{
i:=nume1
Clipboard:=MyClipData[i:=(page-1)*10+10+i]
Send ^v
return
}
#IfWinExist
;-------- 下面是函数 --------
批量复制粘贴工具(s:="", Cmd:="")
{
  static
  if (Cmd="Move")
  {
    if (A_GuiControl="")
      SendMessage, 0xA1, 2
    return
  }
  else if (Cmd="Click")
  {
    i:=SubStr(A_GuiControl, 3)
    if (i>=1 and i<=10)
    {
      s:=MyClipData[i:=(page-1)*10+i]
      if (s="")
        return
      if (!clear)
      {
        ; Gui, MyClip: Hide
        ; Gui, MyClip: Show, NA
        Clipboard:=s
        Send ^v
        Sleep, 200
        return
      }
      MyClipData.RemoveAt(i)
      if (MyClipData.length()<(page-1)*10+1)
        page--
    }
    else if (i=11 and page>1)
      page--
    else if (i=13 and MyClipData.length()>page*10)
      page++
    else if (i=12)
      clear:=!clear
  }
  else if (Cmd="" and s!="")
  {
    MyClipData.InsertAt(1,s), page:=1, clear:=0
  }
  if !IsObject(MyClipData)
  {
    MyClipData:=[], page:=1, clear:=0
    Run:=Func(A_ThisFunc).Bind("","Click")
    Gui, MyClip: Destroy
    Gui, MyClip: +AlwaysOnTop +ToolWindow +E0x08000000
    Gui, MyClip: Margin, 10, 10
    Gui, MyClip: Color, f39bdc8
    Gui, MyClip: Font, s11,c364f6b
    Loop, 13
    {
      i:=A_Index, v:=(i=11 ? "<<" : i=13 ? ">>" : "")
      j:=(i=1 ? "w250 Left" : i=11 ? "xm w75"
        : i=12 ? "x+0 w100" : i=13 ? "x+0 w75" : "y+0 wp Left")
      Gui, MyClip: Add, Button, %j% vbt%i% Hwndid -Wrap, %v%
      GuiControl, MyClip: +g, %id%, % Run
    }
    Gui, MyClip: Show, NA, %A_ThisFunc%
    OnMessage(0x201, Func(A_ThisFunc).Bind("","Move"))
    v:=Func(A_ThisFunc).Bind("","")
    Menu, Tray, Add
    Menu, Tray, Add, %A_ThisFunc%, %v%
    Menu, Tray, Default, %A_ThisFunc%
    Menu, Tray, Click, 1
  }
  Loop, 10
  {    Menu, Tray, Click, 1

    i:=A_Index, v:=MyClipData[(page-1)*10+i]
    v:=(v="" ? v : "[" StrLen(v) "] " SubStr(v,1,50))
    v:=RegExReplace(v, "s+", " ")
    GuiControl, MyClip: , bt%i%, %v%
  }
  GuiControl, MyClip: , bt12, % clear ? "点选条目":"+删除条目+"
  Gui, MyClip: Show, NA
}
return
;-----------------------------------------  >!q 启动剪贴板 1－0粘贴
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
#Persistent
Copy(clipboardID) {
	global ; All variables are global by default
	local oldClipboard := ClipboardAll ; Save the (real) clipboard
	
	Clipboard := "" ; Erase the clipboard first, or else ClipWait does nothing
	Send ^c
	ClipWait, 2, 1 ; Wait 1s until the clipboard contains any kind of data
	if ErrorLevel {
		Clipboard := oldClipboard ; Restore old (real) clipboard
		return
	}
	
	ClipboardData%clipboardID% := Clipboard
	
	Clipboard := oldClipboard ; Restore old (real) clipboard
}

Cut(clipboardID) {
	global ; All variables are global by default
	local oldClipboard := ClipboardAll ; Save the (real) clipboard
	
	Clipboard := "" ; Erase the clipboard first, or else ClipWait does nothing
	Send ^x
	ClipWait, 2, 1 ; Wait 1s until the clipboard contains any kind of data
	if ErrorLevel {
		Clipboard := oldClipboard ; Restore old (real) clipboard
		return
	}
	ClipboardData%clipboardID% := Clipboard
	
	Clipboard := oldClipboard ; Restore old (real) clipboard
}

Paste(clipboardID) {
	global
	local oldClipboard := ClipboardAll ; Save the (real) clipboard

	Clipboard := "" ; Erase the clipboard first, or else ClipWait does nothing
	Clipboard := ClipboardData%clipboardID%
	ClipWait, 2, 1 ; Wait 1s until the clipboard contains any kind of data
	SendRaw, % Clipboard ; Was having an issue with ^v

	Clipboard := oldClipboard ; Restore old (real) clipboard
}

return


>!2::Copy(1)
>!3::Copy(2)
>!4::Copy(3)
>!s::Copy(4)
>!d::Copy(5)
>!f::Copy(6)
;#^!Numpad1::Cut(1)
>!w::Paste(1)
>!e::Paste(2)
>!r::Paste(3)
>!x::Paste(4)
>!c::Paste(5)
>!v::Paste(6)
return
;--------------------------------剪贴板  >! 234sdf复制       werxcv 粘贴
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
OnClipboardChange:                                 
loop,1
{
    SoundBeep, 4900, 3
btt(Clipboard,,,,"Style8") 
sleep, 70
btt()​
FileAppend, %clipboard% `n, E:\6.txt
return
}
 ; -------------------------------------------------------- 复制后通知
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
~LButton & RButton::                                                   
	cos_mousedrag_treshold := 2 ; pixels
MouseGetPos, cos_mousedrag_x, cos_mousedrag_y
	win1 := WinActive("A")
	KeyWait LButton
MouseGetPos, cos_mousedrag_x2, cos_mousedrag_y2
	win2 := WinActive("A")
	WinGetClass cos_class, A
  if(((abs(cos_mousedrag_x2 - cos_mousedrag_x) > cos_mousedrag_treshold
  or abs(cos_mousedrag_y2 - cos_mousedrag_y) > cos_mousedrag_treshold)) and win1 = win2 
  and cos_class != "ConsoleWindowClass")
	KeyWait, RButton                                             ;, T0.1
	If ErrorLevel = 0
{
	Send, {ctrl down}c{ctrl up}
}
return
 ;---------------------------------------------左键拖选 右键确认 复制
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
   
+#d::
send, {F2}^c
Run, "D:\ahk1.0\bat\新建5txt覆盖不提示.vbs"         
sleep,2000

b64Decode(string)
{
    if !(DllCall("crypt32\CryptStringToBinary", "ptr", &string, "uint", 0, "uint", 0x1, "ptr", 0, "uint*", size, "ptr", 0, "ptr", 0))
        throw Exception("CryptStringToBinary failed", -1)
    VarSetCapacity(buf, size, 0)
    if !(DllCall("crypt32\CryptStringToBinary", "ptr", &string, "uint", 0, "uint", 0x1, "ptr", &buf, "uint*", size, "ptr", 0, "ptr", 0))
        throw Exception("CryptStringToBinary failed", -1)
    return StrGet(&buf, size, "UTF-8")
} 
FileAppend, %  b64decode( clipboard ) , E:\5
sleep, 1000
Run, nircmd.exe clipboard readfile "E:\5"
;MsgBox,4 ,F4+d F4+V , ;%  b64decode( clipboard ), 2
return
;----------------------base64解码到剪贴板+#d
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
+#f::
send, {F2}^c
Run, "D:\ahk1.0\bat\新建5txt覆盖不提示.vbs"         
sleep,2000

b64Encode(string)
{
    VarSetCapacity(bin, StrPut(string, "UTF-8")) && len := StrPut(string, &bin, "UTF-8") - 1 
    if !(DllCall("crypt32\CryptBinaryToString", "ptr", &bin, "uint", len, "uint", 0x1, "ptr", 0, "uint*", size))
        throw Exception("CryptBinaryToString failed", -1)
    VarSetCapacity(buf, size << 1, 0)
    if !(DllCall("crypt32\CryptBinaryToString", "ptr", &bin, "uint", len, "uint", 0x1, "ptr", &buf, "uint*", size))
        throw Exception("CryptBinaryToString failed", -1)
    return StrGet(&buf)
} 
FileAppend, %  b64encode( clipboard ) , E:\5 
sleep, 1000
Run, nircmd.exe clipboard readfile "E:\5"
return
;----------------------base64编码到剪贴板+#f
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
MButton::                                                  
	KeyWait, MButton, T0.5
	If ErrorLevel = 1
{
	Send, {ctrl down}x{ctrl up}
}
	Else
{
	Send, {ctrl down}v{ctrl up}
}
return
; --------------------------------------鼠标中键 短按剪切 点击粘贴
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢  
Ralt::                                                         
if (A_PriorHotkey <> "Ralt" or A_TimeSincePriorHotkey > 400)
{
  	  ; 两次按下时间间隔太长, 所以这不是一个两次按下.
  	  KeyWait, Ralt
 	   return
}
{
	loop,3
   	 SoundBeep, 4000, 30    
}
{
/*
;ToolTip, 全半角,,, 1
;hTTFont2:=hTTFont1:=ToolTipFnt("s19", "微软雅黑", 0x470031, 0xff9898)
;sleep, 2000
;ToolTip

ToolTipFont("s24", "微软雅黑")
ToolTipColor("470031", "ff9898")
ToolTip ToolTip with custom font and color
ToolTip,全半角,,, 1
sleep, 600
ToolTip
*/
	Text=全半角
	btt(Text,400,200,,"Style5")
	sleep, 600
	btt()​

	send, +{space} 
	return
}
;----------------------------------------------------全半角  双击 Ralt
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
Appskey::                                               
	t:=-oldt+(oldt:=A_TickCount)
	if (t<100 || t>300)
    	Return
 	else oldt:=0
{
	loop,3
   	 SoundBeep, 3000, 30  
	Text=中英标点
	btt(Text,,,,"Style5")
	sleep, 600
	btt()​
	send, ^.
	Return
}
 ;-------------------------------------------中英标点  双击 Appskey
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
^appskey::
if GetKeyState("CapsLock","T")
loop,2
{
    SoundBeep, 9900, 2

	SetCapsLockState,Off
	ToolTip,CapsLock `n      Off
	SetTimer,RemoveToolTip,600
}
else
loop,2
{
    SoundBeep, 900, 2

	SetCapsLockState,On
	ToolTip,CapsLock `n      On
	SetTimer,RemoveToolTip,600
}
return
;------------------------------------------- ^appskey    CapsLock
#appskey::
if GetKeyState("NumLock","T")
loop,2
{
    SoundBeep, 8900, 2

	SetNumLockState,Off
	ToolTip,NumLock `n      Off
	SetTimer,RemoveToolTip,600
}
else
loop,2
{
    SoundBeep, 800, 2

	SetNumLockState,On
	ToolTip,NumLock `n      On
	SetTimer,RemoveToolTip,600
}
return
;------------------------------------------- #appskey    NumLock
!appskey::
if GetKeyState("ScrollLock","T")
loop,2
{
    SoundBeep, 7900, 2

	SetScrollLockState,Off
	ToolTip,ScrollLock `n      Off
	SetTimer,RemoveToolTip,600
}
else
loop,2
{
    SoundBeep, 700, 2

	SetScrollLockState,On
	ToolTip,ScrollLock `n      On
	SetTimer,RemoveToolTip,600
}
return
;------------------------------------------- !appskey    ScrollLock
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
+appskey::
send, {Tab}
loop,4	
SoundBeep, 12000, 20		
return		
;------------------------------------------- +appskey    Tab
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
$>!5::							 ; $ 防止下面的发送命令触发热键
	Clipboard := ""
	Send, ^c
	ClipWait					
	Clipboard := RegExReplace(Clipboard, "\R")	; \R 涵盖所有回车换行符组合
	return
;-------------------------------复制的分行文字为同一行 >!5
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
$>!6::							 ; $ 防止下面的发送命令触发热键
	Clipboard := ""
	Send, ^c
	ClipWait					
	Clipboard := RegExReplace(Clipboard, "\R")	; \R 涵盖所有回车换行符组合
sleep, 1000
send, ^v
	return
;-------------------------------复制的分行文字 粘贴为同一行 >!6
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
Volume_Up::TuneVolume("+")
Volume_Down::TuneVolume("-")

TuneVolume(UpDown) {
	;"VolumeDivide": Increasing this number will result in smaller volume step, whereas decreasing it will result in larger volume step.
	;It divides the current volume (0 to 100) by this number to decide how large the volume step should be.
	static VolumeDivide := 20, VolumePercent, VolPercentB1, VolPercentB2, VolPercentB3, VolPercentB4, Prefix := ""
	SoundGet, CurrentVolume
	CurrentVolume += 0.1, StepAmount := Ceil(CurrentVolume / VolumeDivide)
	SoundSet, % UpDown StepAmount
	SetTimer, DestroyBvcGui, -880
	SoundGet, CurrentVolume
	IfWinExist, BetterVolumeControl
	{
		;the -Redraw and +Redraw seem to slightly reduce the flickering caused by drawing the black border.
		GuiControl, bvc:-Redraw, VolPercentB1
		GuiControl, bvc:-Redraw, VolPercentB2
		GuiControl, bvc:-Redraw, VolPercentB3
		GuiControl, bvc:-Redraw, VolPercentB4
		GuiControl, bvc:-Redraw, VolumePercent
		GuiControl, bvc:Text, VolPercentB1, % Prefix Round(CurrentVolume, 0)
		GuiControl, bvc:Text, VolPercentB2, % Prefix Round(CurrentVolume, 0)
		GuiControl, bvc:Text, VolPercentB3, % Prefix Round(CurrentVolume, 0)
		GuiControl, bvc:Text, VolPercentB4, % Prefix Round(CurrentVolume, 0)
		GuiControl, bvc:Text, VolumePercent, % Prefix Round(CurrentVolume, 0)
		GuiControl, bvc:+Redraw, VolPercentB1
		GuiControl, bvc:+Redraw, VolPercentB2
		GuiControl, bvc:+Redraw, VolPercentB3
		GuiControl, bvc:+Redraw, VolPercentB4
		GuiControl, bvc:+Redraw, VolumePercent
	}
	Else
	{	Gui, bvc:New, +LastFound +AlwaysOnTop -Border -Caption +ToolWindow +E0x20	;+E0x20 enables you to click thru the window
		Gui, Font, s50
		Gui, Color, c000001
		Gui, Add, Text, x5 y5 c21e6c1 BackgroundTrans vVolumePercent, %Prefix%100	;preoccupy max width
		GuiControl, Text, VolumePercent, % Prefix Round(CurrentVolume, 0)
		WinSet, TransColor, c000001
		Gui, Show, NA x670 y380, BetterVolumeControl
	}
}
DestroyBvcGui() {
	Gui, bvc:Destroy
}
return
;-----------------------------------------------------------  音量指示
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     AppsKey
Appskey & 1::
if (c1c > 0) 
{    
c1c += 1    
return
}
c1c := 1 ;设置计数器，记录按键次数
SetTimer, j, -400 ;设置时钟，在 400 毫秒内等待更多的按键
return
j:
if (c1c = 1)
{    
run D:\ahk1.0\SGScreencapture\screencapture.exe	
} 
else if (c1c >= 2)
{    
Run E:\3\9Snipaste-2.7.3-Beta-x64\Snipaste.exe
sleep,180000
k1 =
(
E:\3\9Snipaste-2.7.3-Beta-x64\Snipaste.exe             ;此处填写多项程序进行关闭
)
	{
RunWait, %ComSpec% /c tasklist >%A_Temp%\tasklist.tmp, , Hide
Loop
	 {
    FileReadLine, line, %A_Temp%\tasklist.tmp, %A_Index%
    if errorlevel
        Break
    IfInString, line, .exe
	 {
        StringSplit,var, line, %A_Space%,
       ; ToolTip 不退出:%var1%
        IfInString, k1, %var1%
	 {
                runwait, %ComSpec% /c taskkill /f /IM %var1%, , Hide
                ;ToolTip, 退出%var1%
                Sleep,1000
	 } ;END IF k1
	 } ;END IF LINE
	 } ;END LOOP
	 }
return
}
c1c = 0  ;每次响应时钟后把计数器清0复位
return
;-------------------------------截图 单ocr 双Snipaste  Appskey & 1
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
Appskey & 2::
  	IfWinExist, ahk_class FastStoneScreenCapturePanel
	WinClose
else
  	Run, E:\3\9 FSCapture97\FSCapture.exe
	sleep, 1100
	send, !2	
return
;----------------------------------------------截图 FSCapture.exe    Appskey & 2
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
Appskey & 6:: 
file := ImagePutFile(clip, "C:\Users\D\Desktop" )
return
; --------------- 截图于剪贴板 选择是否保存于桌面  Appskey & 6
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠
$+#s:: 
clipboard =
Send, {PrintScreen}

sleep,15000
ImagePutFile("", A_Desktop)
return

; ---------------系统截图并保存于桌面及剪贴板 +#s
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
Appskey & 4::Imageshow("a")
; -------------------------------对 当前窗口 截图并贴图 Appskey & 4
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
Appskey & 5::
run, nircmd  loop 2 3000 savescreenshot "C:\Users\D\Desktop\~$currtime.HHmm_ss$ ~$loopcount$.png"
return
;-------------------------------------自动全屏 间隔截图 Appskey & 5                   
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
Appskey & 3:: 
ImagePutClipboard(ImagePutFile("A", A_Desktop))
return
; ---------------对 当前窗口 截图并保存于桌面及剪贴板 Appskey & 3
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
Appskey & 8:: 
ImagePutFile("C:\Users\D\Desktop\1.jpg", "C:\Users\D\Desktop\2.png")
return
; ---------------将桌面1.jpg转换成2.png    Appskey & 8
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
Appskey & 7::
if (d1d > 0) 
{    
d1d += 1    
return
}
d1d := 1 ;设置计数器，记录按键次数
SetTimer, y, -400 ;设置时钟，在 400 毫秒内等待更多的按键
return
y:
if (d1d = 1)
{    
Run E:\3\4\Gif123.exe
} 
else if (d1d >= 2)
{    
Run E:\3\9ZDSoftScnRec\ScnRecPortable.exe
}
d1d = 0  ;每次响应时钟后把计数器清0复位
return
; ---------------------------------------单 gif  双 MP4  Appskey & 7
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
AppsKey & F2::     
                              
Imageshow("D:\ahk1.0\1\1.png")
return
; ----------------------------------显示本地图片 1.png  快捷键目录 appskey & F2
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
appskey & F3::
	WinGetActiveTitle, Title
	Title := StrReplace(Title, "👁‍🗨置顶 👁‍🗨")        
	ID := WinExist("A")
	WinGet, ExStyle, ExStyle, ahk_id %ID%
	If (ExStyle & 0x8)
		
	{
		Winset, Alwaysontop, Off, A
		WinSetTitle, , ,%Title%
	}
	Else
		
	{
		Winset, Alwaysontop, On, A
		WinSetTitle, , ,% Title . "👁‍🗨置顶 👁‍🗨" 
	}
return
 ; ----------------------------------------------------窗口置顶 appskey & F3
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
AppsKey & F4:: 
HideShowTaskbar() 
{
   static SW_HIDE := 0, SW_SHOWNA := 8, SPI_SETWORKAREA := 0x2F
   DetectHiddenWindows, On
   hTB := WinExist("ahk_class Shell_TrayWnd")
   WinGetPos,,,, H
   hBT := WinExist("ahk_class Button ahk_exe Explorer.EXE")  ; for Windows 7
   b := DllCall("IsWindowVisible", "Ptr", hTB)
   for k, v in [hTB, hBT]
      ( v && DllCall("ShowWindow", "Ptr", v, "Int", b ? SW_HIDE : SW_SHOWNA) )
   VarSetCapacity(RECT, 16, 0)
   NumPut(A_ScreenWidth, RECT, 8)
   NumPut(A_ScreenHeight - !b*H, RECT, 12, "UInt")
   DllCall("SystemParametersInfo", "UInt", SPI_SETWORKAREA, "UInt", 0, "Ptr", &RECT, "UInt", 0)
   WinGet, List, List
   Loop % List 
	{
	  WinGet, res, MinMax, % "ahk_id" . List%A_Index%
    	  if (res = 1)
        	 WinMove, % "ahk_id" . List%A_Index%,, 0, 0, A_ScreenWidth, A_ScreenHeight - !b*H
	}
}
return
;-------------------------------------------------隐藏任务栏 AppsKey & F4
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
AppsKey & F5::  
Clipboard =
Send, {ctrl down}c{ctrl up}
ClipWait
path = %Clipboard%
Clipboard = %path%
Tooltip, %path%
clipWait,1
Tooltip
Return
;------------------------------------------------复制文件路径 AppsKey & F5
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     Rctrl	
Rctrl::
Send ^{Space down}{Space up} 
keywait, space
loop,2
    SoundBeep, 4000, 10
{
    ;mainAction("A", CN, EN)
    return
}
;----------------------------------------------------切换中英输入法 Rctrl
/*
Toggle := False
Rctrl::
Send ^{Space} 
	Toggle := !Toggle
	SoundBeep(Toggle ? 5000 : 80, Toggle ? 200 : 100)
/*
Text= % Toggle ? "En" : "CN" 
btt(Text,,,,"Style9") 
sleep, 500
btt()​
*/
    return

	
SoundBeep(A, B) {
	SoundBeep, % A, % B
}
return
*/
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
Rctrl & 1::
    IfWinNotExist ahk_exe chrome.exe
    {
        Run "C:\Users\D\AppData\Local\Google\Chrome\Application\chrome.exe"
        WinActivate
    }
    Else IfWinNotActive ahk_exe chrome.exe
    {
       WinActivate            
    }
    Else
    {
        WinMinimize       
    }
Return
 ;---------------------------------------------打开 chrome  Rctrl & 1
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
Rctrl & 2::
    IfWinNotExist ahk_exe EmEditor.exe
    {
        Run "E:\3\EmEditor_22.0.1_64bit_Portable\EmEditor.exe"  , , max             ;-----------------------------------------, , min
        WinActivate
    }
    Else IfWinNotActive ahk_exe EmEditor.exe 
    {
       WinActivate            
    }
    Else
    {
        WinMinimize       
    }
Return
 ;-------------------------------------------打开 EmEditor  Rctrl & 2
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
Rctrl & 3::
    IfWinNotExist ahk_class CabinetWClass
    {
        Run "C:\Windows\explorer.exe"
        WinActivate
    }
    Else IfWinNotActive ahk_class CabinetWClass
    {
       WinActivate            
    }
    Else
    {
        WinMinimize       
    }
Return
;------------------------------------------打开 资源处理器  Rctrl & 3
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
Rctrl & 4::
WeChat:="ahk_class WeChatMainWndForPC"
WeChat_path:="C:\Program Files (x86)\Tencent\WeChat\WeChat.exe"
 
if ProcessExist("WeChat.exe")=0
{
	Run, %WeChat_path%
sleep, 6000
Send, {Space 8}
keywait, space
}   
else
{
	WinGet,wxhwnd,ID,%WeChat%
	if strlen(wxhwnd)=0
	{
		winshow,%WeChat%
		winactivate,%WeChat%
	}
	else
	{
		winhide,%WeChat%
	}
}
return
 
ProcessExist(exe){			;一个自定义函数,根据自定义函数的返回值作为#if成立依据原GetPID
	Process, Exist,% exe
	return ErrorLevel
}
;-------------------------------------------------打开 微信  Rctrl & 4
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
Rctrl & 5::
WeChat:="ahk_class CefWebViewWnd"
WeChat_path:="C:\Program Files (x86)\Tencent\WeChat\WeChat.exe"
 
if ProcessExist("WeChat.exe")=0
{
	Run, %WeChat_path%
sleep, 2000
Send {Space down}
sleep, 200  
Send {Space up} 
}   
else
{
	WinGet,wxhwnd,ID,%WeChat%
	if strlen(wxhwnd)=0
	{
		winshow,%WeChat%
		winactivate,%WeChat%
	}
	else
	{
		winhide,%WeChat%
	}
}
return
;-------------------------------------------------打开 微信小窗  Rctrl & 5
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
Rctrl & 6::                             
send, ^c
s = %clipboard%
Run, properties %s%
return
; ----------------------------------------------------------------右键属性
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
Rctrl & 7::                     
o=E:\3\EmEditor_22.0.1_64bit_Portable\EmEditor.exe
1=D:\ahk1.0\Ahk1.0.ahk
2=C:\Users\D\.picgo\config.json
3=D:\ahk1.0\9upit\config.toml
Run,%o% "%1%" "%2%" "%3%"  
return
;----------------------运行EmEditor.并打开3个config文件 Rctrl & 7
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
;¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢ 光标
AppsKey & w::Send {Up}
AppsKey & s::Send {Down}
AppsKey & a::Send {Left}
AppsKey & d::Send {Right}
AppsKey & z::Send {home}
AppsKey & x::Send {end}
;---------------------------------------------------- adws 上下左右      zx  home end
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢ 光标
AppsKey & q:: Send, {Bs} 
AppsKey & e:: Send, {delete}
AppsKey & f:: Send, {Enter}  
;----------------------- q 退格 e 删除 f 回车 z 左键单击 x 右键单击
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢ 光标
AppsKey & t:: Send, ^z
AppsKey & y:: Send, ^y
AppsKey & R:: Send, {Tab}
;-----------------------------------------------  r Tab t 撤消 y 重做  
;¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤ 
;*>^w:: MouseMove, 0, -20, 0, R    ;上移鼠标                                  ; * 号可以避免和系统自带的Alt+w冲突，造成上移时关闭文档。
;*>^s:: MouseMove, 0, 20, 0, R      ;下移鼠标
;*>^a:: MouseMove, -20, 0, 0, R    ; 左移鼠标
;*>^d:: MouseMove, 20, 0, 0, R     ; 右移鼠标
;return
;------------------------------------------移动鼠标 q s a d  上下左右   运行后会有点卡顿 替代为 SnoMouse.ahk
;¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤ 鼠标
*>^z::  
SendEvent {click}
return
;------------------------------------------------鼠标单击  >^z   左键
;¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤ 鼠标
;--------------------------------------------注意设置成>^c  >^v 会和手势的 复制和粘贴 冲突，一定要加个 " ~ "
~>^x::   
 SendEvent {RButton click}{RButton down}  ; 按住左键不放   注意此处为RButton（鼠标左右换了）
 KeyWait, RButton
return
~>^v::    
SendEvent {RButton up}                   ;  松开左键
return
;-----------------------------------Rctrl & c 左键按住     v 松开左键
;¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤ 鼠标
~>^c:: 
SendEvent {Blind}{LButton down}          ;注意此处为LButton（鼠标左右换了）
KeyWait RCtrl  
global SendEvent {Blind}{LButton up}
return
;-------------------------------------------------鼠标单击 >^c   右键
;¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤ 鼠标
*>^e:: 
SendEvent {WheelDown}
return
;--------------------------------------------------WheelDown   >^e
*>^q:: 
SendEvent {Wheelup}
return
;------------------------------------------------------Wheelup  >^q
;¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤ 鼠标
*>^r:: 
SendEvent {pgup}
return
;----------------------------------------------------------pgup  >^r
*>^t:: 
SendEvent {pgdn}
return
;----------------------------------------------------------pgdn  >^t
;¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤ 鼠标
*>^b:: 
SendEvent {AppsKey}
return
;------------------------------------------------------AppsKey  >^b
;¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤ 鼠标
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     F5~F8 
;#SingleInstance Force
;#NoEnv
displayNum := 0
visibleState := true
F9 & 9::
	pasteToScreen(){
		if DllCall("IsClipboardFormatAvailable", "UInt", 1)
			displayText(Clipboard)
		If DllCall("IsClipboardFormatAvailable", "UInt", 2){
			if DllCall("OpenClipboard", "uint", 0) {
				hBitmap := DllCall("GetClipboardData", "uint", 2)
				DllCall("CloseClipboard")
			}
			displayImg(hBitmap)
		}
		if DllCall("IsClipboardFormatAvailable", "UInt", 15){
			imgFile := Clipboard
			if(hBitmap := LoadPicture(imgFile))
				displayImg(hBitmap)
		}
	}
displayText(text){
	global
	Gui, New, +hwndpasteText%displayNum% -Caption +AlwaysOnTop +ToolWindow -DPIScale
	local textHnd := pasteText%displayNum%
	Gui, Margin, 10, 10
	Gui, Font, s16
	Gui, Add, Text,, % text
	OnMessage(0x201, "move_Win")
	OnMessage(0x203, "close_Win")
	Gui, Show,, pasteToScreen_text
	transparency%textHnd% := 100
	displayNum++
}

displayImg(hBitmap){
	global
	Gui, New, +hwndpasteImg%displayNum% -Caption +AlwaysOnTop +ToolWindow -DPIScale
	local imgHnd := pasteImg%displayNum%
	Gui, Margin, 0, 0
	Gui, Add, Picture, Hwndimg%imgHnd%, % "HBITMAP:*" hBitmap
	OnMessage(0x201, "move_Win")
	OnMessage(0x203, "close_Win")
	Gui, Show,, pasteToScreen_img
	local img := img%imgHnd%
	ControlGetPos,,, width%imgHnd%, height%imgHnd%,, ahk_id %img%
	scale%imgHnd% := 100
	transparency%imgHnd% := 100
	displayNum++
}

move_Win(){
	PostMessage, 0xA1, 2
}

close_Win(){
	id := WinExist("A")
	transparency%id% := ""
	scale%id% := ""
	width%id% := ""
	height%id% := ""
	Gui, Destroy
}
return
#IfWinActive pasteToScreen

^WheelDown::
	decreaseTransparency(){
		id := WinExist("A")
		transparency%id% -= 20            ; 透明速度
		If (transparency%id% < 10)
			transparency%id% = 10
		transparency := transparency%id% * 255 // 100
		WinSet, Transparent, %transparency%, A
		tooltip, % "Opacity:" transparency%id% "%"
		sleep, 500
tooltip,
	}
return
^WheelUp::
	increaseTransparency(){
		id := WinExist("A")
		transparency%id% += 20
		If (transparency%id% > 100)
			transparency%id% = 100
		transparency := transparency%id% * 255 // 100
		WinSet, Transparent, %transparency%, A
		tooltip, % "Opacity:" transparency%id% "%"
		sleep, 500
tooltip,
	}
return
^MButton::
	resetTransparency(){
		id := WinExist("A")
		transparency%id% = 100
		WinSet, Transparent, 255, A
		tooltip, % "Opacity:" transparency%id% "%"
		sleep, 500
tooltip,
	}
return
#IfWinActive pasteToScreen_img

;~WheelDown::
	decreaseSize(){
		id := WinExist("A")
		img := img%id%
		scale%id% -= 35
		If (scale%id% < 10)
			scale%id% = 10
		WinGetPos,,, width, height
		width := width%id% * scale%id% // 100
		height := height%id% * scale%id% // 100
		GuiControl, MoveDraw, %img%, w%width% h%height%
		WinMove,,,,, width, height
		;tooltip, % "Size:" scale%id% "%"
		;sleep, 100
	              ;tooltip,
	}
return
;~WheelUp::
	increaseSize(){
		id := WinExist("A")
		img := img%id%
		scale%id% += 35
		WinGetPos,,, width, height
		width := width%id% * scale%id% // 100
		height := height%id% * scale%id% // 100
		GuiControl, MoveDraw, %img%, w%width% h%height%
		WinMove,,,,, width, height
		;tooltip, % "Size:" scale%id% "%"
		;sleep, 100
	              ;tooltip,
	}
return
~MButton::
	resetSize(){
		id := WinExist("A")
		img := img%id%
		scale%id% = 100
		width := width%id%
		height := height%id%
		GuiControl, MoveDraw, %img%, w%width% h%height%
		WinMove,,,,, width, height
		tooltip, % "Size:" scale%id% "%"
		sleep, 500
tooltip,
	}

#IfWinActive
return
F9 & 0::
	toggleVisibleState(){
		global visibleState
		if(visibleState){
			WinGet, id, List, pasteToScreen
			Loop, %id%
			{
				this_id := id%A_Index%
				WinHide, ahk_id %this_id%
			}
			visibleState := false
		} else {
			DetectHiddenWindows, On
			WinGet, id, List, pasteToScreen
			Loop, %id%
			{
				this_id := id%A_Index%
				WinShow, ahk_id %this_id%
			}
			DetectHiddenWindows, Off
			visibleState := true
		}
	}
return
F9 & -::
	destroyAllPaste(){
		WinGet, id, List, pasteToScreen
		Loop, %id%
		{
			this_id := id%A_Index%
			SendMessage, 0x203,,,, ahk_id %this_id%
		}
	}
return
F9 & =::
FileSelectFile, imgFile, 3, D:\3\Camera Roll\1.png
hBitmap := LoadPicture(imgFile)
displayImg(hBitmap)
return
;-----------------------------------------------------------F9+9 贴图 
;-----------鼠标滚动改变粘贴的大小 双击关闭
;-----------------------------------Ctrl+鼠标滚动   改变粘贴的透明度
;-----------Ctrl+中键  重置透明度
;-----------F9+- 关闭所有粘贴
;-----------------------------------------F9+0 隐藏或显示所有粘贴
;-----------F9+= 打开的图片 然后作为贴图
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
F9 & 8::                                   
ImagePutDesktop(ClipboardAll)    
;ImagePutDesktop("D:\3\Camera Roll\1.png")
return
; -------------------将剪贴板中内容贴在桌面不能改动 重新截图覆盖 F9 + 8 
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
+F3::
 if (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey > 900)
    loop,1
    SoundBeep, 1000, 10
Text= ⭕       启   动        ⭕`n  ——————`n⭕  朗读选中文本   ⭕
btt(Text,600,0,,"Style8") 
sleep, 3000
btt()​
    Run D:\ahk1.0\1\读.ahk
Return
; -------------------------------------------长按+F3启动 朗读选中文本F2F3F4
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
+F2::
 if (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey > 900)
    loop,1
    SoundBeep, 1000, 10
Text= ⭕       启   动        ⭕`n  ——————`n⭕  窗口折叠隐藏   ⭕
btt(Text,600,0,,"Style8") 
sleep, 3000
btt()​
    Run D:\ahk1.0\DockIt.ahk 
 Return
; -------------------------------------------长按+F2启动 窗口折叠隐藏
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
~f4::   ; 长按
KeyWait, f4, T1.7
if (ErrorLevel = 1) 
{
    loop,1
    SoundBeep, 1000, 10
Text= ⭕       启   动        ⭕`n  ——————`n⭕  数字键盘声音   ⭕
btt(Text,600,0,,"Style7") 
sleep, 3000
btt()​
    Run D:\ahk1.0\1\90.数字声音.ahk  
 } 
Return
; -------------------------------------------长按F4启动 数字键盘声音
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
~f7::   ; 长按
KeyWait, f7, T1.2
if (ErrorLevel = 1) 
{
    loop,1
    SoundBeep, 1000, 10
 	Text=⭕      中  英      ⭕`n  ——————`n⭕  输入法指示  ⭕
btt(Text,600,0,,"Style5") 
sleep, 3000
btt()​
    Run D:\ahk1.0\KBLAutoSwitch-2.4.1\KBLAutoSwitch.ahk
 } 
Return
; ---------------------------------------------长按F7启动 输入法指示
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
~f8::   ; 长按
KeyWait, f8, T1.2
if (ErrorLevel = 1) 
{
    loop,1
    SoundBeep, 1000, 10
 	Text= ⭕      启   动      ⭕`n  ——————`n⭕  cl3  剪贴板   ⭕
btt(Text,600,0,,"Style7") 
sleep, 3000
btt()​
    Run D:\ahk1.0\CL3-1.106\cl3.ahk
 } 
Return
; --------------------------------------------- -长按F8启动 cl3剪贴板
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
~f10::   ; 长按
KeyWait, f10, T1.2
if (ErrorLevel = 1) 
{
    loop,1
    SoundBeep, 1000, 10
Text= ⭕       启   动        ⭕`n  ——————`n⭕  SnoMouse   ⭕
btt(Text,600,0,,"Style8") 
sleep, 3000
btt()​
    Run D:\ahk1.0\SimMouse\SnoMouse.ahk
 } 
Return
; -------------------------------------------长按F10启动 SnoMouse
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
~f11::   ; 长按
KeyWait, f11, T1.2
if (ErrorLevel = 1) 
{
    loop,1
    SoundBeep, 1000, 10
Text= ⭕       启   动        ⭕`n  ——————`n⭕   15分钟报时    ⭕
btt(Text,600,0,,"Style8") 
sleep, 3000
btt()​
    Run D:\ahk1.0\1\15 分钟播放一次声音.ahk
 } 
Return
; -------------------------------------------长按F11启动 15分钟报时
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
~f12::   ; 长按
KeyWait, f12, T1.2
if (ErrorLevel = 1) 
{
   ; loop,1
    ;SoundBeep, 1000, 10
Text= ⭕       启   动        ⭕`n  ——————`n⭕  取色器已开启   ⭕
btt(Text,600,0,,"Style8") 
sleep, 3000
btt()​
    Run D:\ahk1.0\1\取色器.ahk
sleep, 10
Run, nircmd speak text "取色器已开启" -1 80
 } 
Return
; -------------------------------------------长按F12启动 取色器
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
~Ins::   ; 长按
KeyWait, Ins, T1.2
if (ErrorLevel = 1) 
{
  loop,1
    SoundBeep, 5000, 10
sleep, 300		  
Text=🔋       关  闭        🔋`n ————————`n🔋      显示器屏    🔋
btt(Text,600,0,,"Style8") 
sleep, 3000
btt()
SendMessage, 0x112, 0xF170, 2,, Program Manager 
 } 

Return
; ---------------------------------------------------- Ins  关闭显示器 
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     Ralt
<!w::
Reload
Return
; ---------------------------------------------------刷新脚本 <! w
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢ 
<!q::
ExitApp
Return
; ---------------------------------------------------退出脚本 <! q
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
<!r::
DetectHiddenWindows, On
WinGet, list, List, ahk_class AutoHotkey
Loop, %list%
{
  IfEqual, A_ScriptHwnd, % id:=list%A_Index%, Continue
  WinGet, pid, PID, ahk_id %id%
  WinClose, ahk_id %id%,, 1
  IfWinExist, ahk_id %id%
    Process, Close, %pid%
}
/*
Tip("✂ 其他 AHK脚本 ✂`n ————————`n✂       已退出      ✂")
return

Tip(s:="") {
  SetTimer, %A_ThisFunc%, % s="" ? "Off" : -3000

	ToolTipFont("s11", "微软雅黑")
ToolTipColor("113a5d", "ff7a8a")
ToolTip ToolTip with custom font and color

  ToolTip, %s% ,700, 0
}
return
*/
Text=✂ 其他 AHK脚本 ✂`n ————————`n✂       已退出      ✂
btt(Text,600,0,,"Style2") 
sleep, 3000
btt()​
return
; ------------------------------------一键清理其他AHK进程 <!r
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     F1
F1 & 1::                                     
  	send, {F2} 
sleep,200
send,{ctrl down}c{ctrl up}
sleep,200
ClipWait
  	Run, "E:\3\Everything-1.4.1.1021.x64\Everything.exe"  -s "%clipboard%"
  	return
 ; ----------------------------热键F1 & 1 用Evething搜索选中的文字
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
F1 & 4:: 
	Send, {ctrl down}c{ctrl up}
	KeyWait F1
	Run https://www.baidu.com/s?wd=%clipboard% 
	return
; ----------------------------------热键F1 & 4 用百度搜索选中的文字
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
F1 & 5::
Send, {ctrl down}c{ctrl up}   
sleep, 400
	KeyWait F1                         
 	 Runwait https://fanyi.baidu.com/?aldtype=23#en/zh/
	sleep, 3000
	Send, {ctrl down}v{ctrl up}                                                               
	return
 ;---------------------------------------------热键 F1 & 5 用  TTime  翻译  选中的文字
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
F1 & 6:: 
	Send, {ctrl down}c{ctrl up}   
sleep, 400
	KeyWait F1                         
 	 Runwait https://transmart.qq.com/zh-CN/index
	sleep, 3000
	Send, {ctrl down}v{ctrl up}                                                               
	return
; -----------------------------------热键F1 & 6 腾讯翻译 选中的文字
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
F1 & 7::  
Send, {ctrl down}c{ctrl up} 
sleep, 200
    IfWinNotExist ahk_class SWT_Window0
    {
        Run "E:\3\DocFetcher-1.1.25\DocFetcher.exe"
     WinWaitActive, ahk_exe javaw.exe, , 7
	Send, {ctrl down}v{ctrl up}{enter}
sleep, 900
Send, {down}                                   
    }
    Else IfWinNotActive ahk_class SWT_Window0
    {

       WinActivate  
sleep, 200
    Send, {ctrl down}f{ctrl up}    
sleep, 200
	Send, {ctrl down}v{ctrl up}{enter}
sleep, 900
Send, {down}   
    }
    Else
    {
        WinMinimize       
    }
Return
; -------------------------------------热键F1 & 7 用DocFetcher.exe 
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
F1 & 8::  
  	Send, {ctrl down}c{ctrl up}
	KeyWait F1
	Run http://www.google.com.tw/search?hl=zh-TW&q=%Clipboard%
	return
; ---------------------------------热键F1 & 8 用谷歌搜索选中的文字
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
F1 & 9::      
	Send, {ctrl down}c{ctrl up}
	send, #!/     
	KeyWait F1
	;sleep,2000                        
  	Run https://www.deepl.com/translator?q=Adds%20shortcuts%20to%20increase%2Fdecrease%20font%20size#en/zh/%clipboard%  
	sleep,16000
	send, #!/  
  	return
 ; --------------热键F1 & 9 用 DeepL 翻译  选中的文字  （需要全局）
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
F1 & F2::
clipboard :=""
移动到 = D:\B
    send ^c
    clipwait,2
    选中文件 :=clipboard
   if (选中文件)

Loop, parse, clipboard, `n, `r

{
	RegExMatch(A_LoopField,".*\\(.+?\..*)$",文件名)
	RegExMatch(A_LoopField,"(.*\\).+?\..*$",原始路径)
;文件存在检测 :=% 原始路径1 "B\" 文件名1
if (FileExist(文件存在检测2), "D")
                {
                    
                }
else
{
 FileMove, %A_LoopField%, % 移动到
}
}
return
; -------------------------------------选中文件移动至D:\B   F1 & F2
F1::F1
return
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
F2 & 1::
{
Send, {ctrl down}c{ctrl up}
sleep,1000
Run, cmd /c picgo u
, ,hide
Text= ⭕       上传文件中     ⭕
btt(Text,600,0,,"Style4") 
sleep, 2000
btt()​
Run, cmd /c D:\ahk1.0\9upit\upgit.exe :clipboard-files
, ,hide
}
return
;----------------------------------------上传剪贴板中的 文件 F2 & 1
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
F2 & 2::
{
Run, cmd /c picgo u
, ,hide
Text= ⭕       上传图片中     ⭕
btt(Text,600,0,,"Style4") 
sleep, 2000
btt()​
}   
run, cmd /c D:\ahk1.0\9upit\upgit.exe :clipboard -t C0112  -o clipboard -f markdown
, ,hide
return
;---------------------------------------上传剪贴板中的  图片 F2 & 2
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
F2 & 3::
if winc_presses > 0 ; SetTimer 已经启动, 所以我们记录键击.
{
    winc_presses += 1
    return
}
; 否则, 这是新开始系列中的首次按下. 把次数设为 1 并启动
; 计时器：
winc_presses = 1
SetTimer, KeyWinC, 300 ; 在 400 毫秒内等待更多的键击.
return

KeyWinC:
SetTimer, KeyWinC, off
if winc_presses = 1 ; 此键按下了一次.
{
send, {F2} 
sleep,200
send,{ctrl down}c{ctrl up}
ClipWait
send, {enter} 
}
else if winc_presses = 2 ; 此键按下了两次.
{
send, {F2} 
sleep,200
send,{ctrl down}v{ctrl up}{enter} 
}
winc_presses = 0
return
; -------------------------单击 复制文件名 双击 以剪贴板命名 F2 & 3
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
F2 & 4::
if wincc_presses > 0 ; SetTimer 已经启动, 所以我们记录键击.
{
    wincc_presses += 1
    return
}
; 否则, 这是新开始系列中的首次按下. 把次数设为 1 并启动
; 计时器：
wincc_presses = 1
SetTimer, Keywincc, 300 ; 在 400 毫秒内等待更多的键击.
return

Keywincc:
SetTimer, Keywincc, off
if wincc_presses = 1 ; 此键按下了一次.
{
   Click right  
sleep,200
Send, wf 
Clipboard= %Clipboard%
sleep,200
send,{ctrl down}v{ctrl up}
ClipWait
send, {enter} 
}
else if wincc_presses = 2 ; 此键按下了两次.
{
   Click right  
sleep,200
Send, w{up}{enter}
Clipboard= %Clipboard%
sleep,200
send,{ctrl down}v{ctrl up}
ClipWait
send, {enter} 
}
wincc_presses = 0
return
; ----------------------单 新建文件夹 双 TxT文件 名为剪贴板 F2 & 4
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
F2 & 5::
send, {F2}
sleep, 200
send, #v
sleep, 1000
send  {enter}
sleep, 300
send  {click 10,10}
return
; -------------------------框选数个文件 以剪贴板内容重命名 F2 & 5
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
F3 & h::
path:=A_IsCompiled ? A_ScriptFullPath:A_AhkPath
SplitPath, path,, dir
Run, "%dir%\AutoHotkey.chm"
SetTitleMatchMode, 2
WinWait, 中文帮助,, 5
if !ErrorLevel
  WinMove, 0, 0
return
;-----------------------------AHK帮助 F3 & h
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
;F3 & 5::                                   ;------------------------------------------------------------------------------------------------
    SendInput ^#{Left}                    
Return
;F3 & 6::                                                                    
    SendInput ^#{Right}                  
Return
 ;-----------------------------------
 ;----------------------------------F3 & 5 单击上一窗口 6 下一窗口  
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
CurrentDesktop := 1
F3 & 4:: 
	Send, % (CurrentDesktop = 1 ? "^#{Right}" : "^#{Left}")
	CurrentDesktop := (CurrentDesktop = 1 ? 2 : 1)
return

 ;----------------------------------F3 & 4 在两个窗口切换
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
;#Persistent
;#SingleInstance force
KillTip()             ;清除toolTip
{        
        toolTip
}
volUp()            ;增加""
{       
        sendInput {Volume_Up}
    SoundGet, master_volume
    master_volume := ceil(master_volume)
    ToolTip %master_volume% `%   
    SetTimer, killTip, -500
}
 
volDown()       ;降低音量
{       
        sendInput {Volume_Down}
    SoundGet, master_volume
    master_volume := ceil(master_volume)
    ToolTip %master_volume% `%
    SetTimer, killTip, -500
}
 
volMute()       ;静音切换
{       
    sendInput {Volume_Mute}
 SoundGet, master_volume
    master_volume := ceil(master_volume)
        toolTip %master_volume% `%
        SetTimer,killTip, -500
}
F2 & q::  volMute() 
F2 & w:: volDown()
F2 & e:: volUp()
/*
#If GetKeyState("RButton", "P")
        LButton::volMute()
        WheelDown::volDown()
        WheelUp::volUp()
#If
*/
 ;-----F2 & e 增大 w 减小 q 静音   || 按住右键 再左键静音 再滚轮调节 ||
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
F2::F2
return
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢
;ʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬ      F3
F3 & 1:: 
Clip(Format("{:" GetNextCaseFormat() "}", Clip()), true)
GetNextCaseFormat()
{
   static i := 0, Formats := ["U", "L", "T"]
   return Formats[++i > 3 ? i := 1 : i]
}
;================================== chip.ahk
Clip(Text="", Reselect="")
{
	Static BackUpClip, Stored, LastClip
	If (A_ThisLabel = A_ThisFunc) {
		If (Clipboard == LastClip)
			Clipboard := BackUpClip
		BackUpClip := LastClip := Stored := ""
	} Else {
		If !Stored {
			Stored := True
			BackUpClip := ClipboardAll ; ClipboardAll must be on its own line
		} Else
			SetTimer, %A_ThisFunc%, Off
		LongCopy := A_TickCount, Clipboard := "", LongCopy -= A_TickCount ; LongCopy gauges the amount of time it takes to empty the clipboard which can predict how long the subsequent clipwait will need
		If (Text = "") {
			SendInput, ^c
			ClipWait, LongCopy ? 0.6 : 0.2, True
		} Else {
			Clipboard := LastClip := Text
			ClipWait, 10
			SendInput, ^v
		}
		SetTimer, %A_ThisFunc%, -700
		Sleep 20 ; Short sleep in case Clip() is followed by more keystrokes such as {Enter}
		If (Text = "")
			Return LastClip := Clipboard
		Else If ReSelect and ((ReSelect = True) or (StrLen(Text) < 3000))
			SendInput, % "{Shift Down}{Left " StrLen(StrReplace(Text, "`r")) "}{Shift Up}"
	}
	Return
	Clip:
	Return Clip()
}
return
;------------------------F3 & 1   循环 大写   小写  首字母大写
;¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
Appskey & F6::
HideOrShowDesktopIcons()
return 
HideOrShowDesktopIcons()
{
ControlGet, class, Hwnd,, SysListView321, ahk_class Progman
If class =
ControlGet, class, Hwnd,, SysListView321, ahk_class WorkerW

If DllCall("IsWindowVisible", UInt,class)
WinHide, ahk_id %class%
Else
WinShow, ahk_id %class%
}
Return
;----------------------------------------------隐藏桌面图标 Appskey & F6
;¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤ 
F3::F3
return
;¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
;ʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬ      F4
F4 & 1::
Run C:\Windows\System32\SystemPropertiesAdvanced.exe
sleep,600
send, n
return
; -----------------------------------------------环境变量  F4 & 1
;¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤ 
F4 & 2::
/*n
send #e
sleep,800
send !d
sleep, 200
send,控制面板\所有控制面板项
sleep,200
send, {enter}
*/
Run control
return
; run shell:::{21EC2020-3AEA-1069-A2DD-08002B30309D}
; -----------------------------------------------控制面板  F4 & 2
;¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤ 
;gpedit.msc    组策略    taskschd.msc：任务计划程序   services.msc   服务
;¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤ 
F4 & 3::
run ms-settings:network-proxy
return
; ----------------------------------------------------代理  F4 & 3
;¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤ 
F4 & 4:: 
	IfWinExist, ahk_class MagUIClass
	WinClose
	else
	Run, Magnify.exe
	return
F4 & 5::#=
F4 & 6::#-
;-------------------------------放大镜 F4 & 4 打开  5  放大   6  缩小
;¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤ 
F4 & 7::run osk
;--------------------------------------------------屏幕键盘  F4 & 7
;¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
F4 & 8::  
send, #v
sleep, 1000
send, {Tab}
sleep, 200
send, {enter}
sleep, 200
send, {down 2}
sleep, 200
send, {enter}
sleep, 200
send, !{F4}
return
;-------------------------------------------剪贴板 整体清零 F4 & 8
;¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
F4 & 9::
loop,10
{
var := 0
InputBox, time, KevZ:计时器 请输入一个时间__分
time := time*60000
Sleep,%time%
loop,26
{
var += 180
SoundBeep, var, 900
;SoundPlay, %A_WinDir%\Media\Ring10.wav
}
msgbox 时间到！！！! ! ! ! ! ! !
return
}
; ---------------------------------------------------计时器 F4 & 9
;¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤ 
F4 & z::
Run, nircmd speak text "确定注销，请点是" 0 90
Run, nircmd.exe cmdwait 100 qboxcom ".............注  销............." "  注意：保存文件" exitwin logoff
return
;¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
F4 & r::
Run, nircmd speak text "确定重启 请点是" 0 90
Run, nircmd.exe  cmdwait 100 qboxcom ".............重  启............." "  注意：保存文件" exitwin reboot
return
;¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
F4 & o::
Run, nircmd speak text "确定关机 请点是" 0 90
Run, nircmd.exe cmdwait 100 qboxcom ".............关  机............." "  注意：保存文件" exitwin poweroff
return
;¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
F4 & c::
SendInput {Ctrl Down}c{Ctrl Up}
Run, nircmd.exe clipboard addfile "E:\5"
Run, nircmd cmdwait 100 speak text "已复制" -1 80     ; 类型(text xml file)  速度(-10到10)  音量(0到100)
;send, ^w
return
;--------------------------------------------------累加复制内容到E:\5
;¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
F4 & v::
Run, nircmd.exe clipboard readfile "E:\5"
sleep, 900
SendInput {Ctrl Down}v{Ctrl Up}
Run, nircmd cmdwait 100 speak text "已粘贴" -1 80
return
;----------------------------------------将E:\5中累加复制的内容粘贴
;¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
F4 & d::
Run  "D:\ahk1.0\bat\新建5txt覆盖不提示.vbs"  
Run, nircmd cmdwait 100 speak text "内容已清空" -1 80  
return
;----------------------------------------------------------删除 E:\5
;¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
F4 & T::
Run, nircmd shellcopy "D:\ahk1.0" "E:\0　　tool\0\" yestoall ;silent 
Run, nircmd cmdwait 100 speak text "正在进行备份，需时约40秒" -1 80
return
;  yestoall 覆盖   noerrorui 不显示错误信息 silent 不显示文件复制进度 nosecattr 不复制文件属性
;-----------------------------------将 D:\ahk1.0 文件夹备份到  E:\0　　tool\0\
;¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
F4::F4
return
;ʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬʬ      shift
~Shift & Wheelup::
; 透明度调整，增加。
WinGet, Transparent, Transparent,A
If (Transparent="")
    Transparent=255
    Transparent_New:=Transparent+15    ;透明度增加速度。
    If (Transparent_New > 254)
                    Transparent_New =255
    WinSet,Transparent,%Transparent_New%,A

    tooltip now: ▲%Transparent_New%`nmae: __%Transparent%  ;查看当前透明度（操作之后的）。
    ;sleep 1500
    SetTimer, RemoveToolTip_transparent_Lwin__2016.09.20, 1500  ;设置统一的这个格式，label在最后。
return

~Shift & WheelDown::
;透明度调整，减少。
WinGet, Transparent, Transparent,A
If (Transparent="")
    Transparent=255
    Transparent_New:=Transparent-15  ;透明度减少速度。
    ;msgbox,Transparent_New=%Transparent_New%
            If (Transparent_New < 30)    ;最小透明度限制。
                    Transparent_New = 30
    WinSet,Transparent,%Transparent_New%,A
    tooltip now: ▲%Transparent_New%`nmae: __%Transparent%  ;查看当前透明度（操作之后的）。
    ;sleep 1500
    SetTimer, RemoveToolTip_transparent_Lwin__2016.09.20, 1500  ;设置统一的这个格式，label在最后。
return
;设置shift &Mbutton直接恢复透明度到255。

shift & Mbutton:: 
WinGet, Transparent, Transparent,A
WinSet,Transparent,255,A 
tooltip ▲Restored ;查看当前透明度（操作之后的）。
;sleep 1500
SetTimer, RemoveToolTip_transparent_Lwin__2016.09.20, 1500  ;设置统一的这个格式，label在最后。
return

removetooltip_transparent_Lwin__2016.09.20:     ;LABEL
tooltip
SetTimer, RemoveToolTip_transparent_Lwin__2016.09.20, Off
return
;---------------shift+滚轮down +10透明度
;--------------------------------shift+滚轮up -10透明度
;-----------------------------------------------shift+中键按下 复原
;----------------------------------------------------------------------------------------------------
F3 & 2::                                         ;窗口透明化减弱
    WinGet, ow, id, A
    WinTransplus(ow)
    return
 
F3 & 3::                                         ;窗口透明化增加
    WinGet, ow, id, A
    WinTransMinus(ow)
    return
WinTransplus(w){
 
    WinGet, transparent, Transparent, ahk_id %w%
    if transparent < 255
        transparent := transparent+10
    else
		a = 1
    if transparent
        WinSet, Transparent, %transparent%, ahk_id %w%
    else
        WinSet, Transparent, off, ahk_id %w%
    return
}
WinTransMinus(w){
 
    WinGet, transparent, Transparent, ahk_id %w%
    if transparent > 10
        transparent := transparent-10
    WinSet, Transparent, %transparent%, ahk_id %w%
    return
}
;------------------------------------------------透明度 F3 & 3 透明    2 不透明
;¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤ 
;#NoEnv   			
  ; SendMode Input   		
  ; SetWorkingDir %A_ScriptDir%	
	MoveCycle(Add) 
{
	static StepsInCycle = 2                        ;--------------------------------------在2种状态间切换
	static SizeCycle = 0
	SizeCycle := Mod(SizeCycle + Add, StepsInCycle)
	if (SizeCycle < 0) 
	{
		SizeCycle := SizeCycle + StepsInCycle
	}
	if (Add = 111) {
		SizeCycle = 1
	}
	else if (Add = 222) {
		SizeCycle = 2
	}
	else if (Add = 333) {
		SizeCycle = 3
	}

	if (SizeCycle = 0) {
		MoveWindow(0, 100) 
	}
	else if (SizeCycle = 1) {
		MoveWindow(15, 70) 
	}
	else if (SizeCycle = 2) {
		MoveWindow(0, 100)
	}
	else if (SizeCycle = 3) {
		MoveWindow(15, 70) 
	
	}
	else if (SizeCycle = 4) {
		MoveWindow(10, 80) 
	}
else if (SizeCycle = 5) {
		MoveWindow(0, 80) 
	}
}

MoveWindow(XP, WP) 
{
	; Get current Window
	WinGetActiveTitle, WinTitle
	WinGetPos, X, Y, WinWidth, WinHeight, %WinTitle%
	
	; Get Taskbar height
	WinGetPos,,, tbW, tbH, ahk_class Shell_TrayWnd
	
	; Calculate new position and size
	XNew := (A_ScreenWidth * XP / 100)
	WNew := (A_ScreenWidth * WP / 100)
	HNew := (A_ScreenHeight - tbH  / 1.3)
	TopNew := 1
	
	; MsgBox, %XNew% - %WNew% ; DEBUG
	WinRestore, %WinTitle%
	WinMove, %WinTitle%,, %XNew%, %TopNew%, %WNew%, %HNew%
}

	!x::
	MoveCycle(-1)
	return
;----------------------------------当前窗口最大化，居中70% 切换 !x
;¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤  

