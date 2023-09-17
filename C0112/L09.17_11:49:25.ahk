
; ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ    9.16
#Requires AutoHotkey v1.1.36                             ; V1版本
Menu, Tray, Icon, D:\ahk1.0\Lib\0\Symbol purpel.ico                ; 脚本图标 	 
Menu , tray , tip , F62                                            ; 鼠标悬浮提示 
; ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ    1
devices := ["耳机", "扬声器", "手机"]
cur := 0
ChangeDevice(devices[cur+1], logo)
; ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   2
FileGetTime ScriptStartModTime, %A_ScriptFullPath%
SetTimer CheckScriptUpdate, 100, 0x7FFFFFFF ; 100 ms, highest priority最高优先级
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
; ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  保存后  自动刷新脚本  ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ
#NoEnv                                                ; 主要是为了与以后兼容，也可以改善性能
#SingleInstance Force        　              ; 当此脚本已经运行时自动替换旧实例再次运行。 
SendMode,Input
#WinActivateForce                              ; 用强制的方法激活窗口。
#Persistent                                          ; 使非热键类的脚本持久运行（即直到用户关闭或遇到 ExitApp）
#ClipboardTimeout -1                 ;改变当首次访问剪贴板失败后脚本会继续尝试访问剪贴板的持续时间.
               ; -1 表示持续访问剪贴板. 0 表示只访问一次. 没有使用此指令的脚本使用 1000 ms 的超时时间.
; ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ    3
SetWorkingDir, %A_ScriptDir%                ; 让脚本无条件使用它所在的文件夹作为工作目录  
;SetTitleMatchMode 2                              ; 传递消息到匹配部分标题的窗口
;DetectHiddenWindows, On                     ; 传递消息到隐藏窗口
SetTitleMatchMode fast
SetBatchLines, -1                                      ; 脚本快速执行,减少 CPU 占用,  使用10ms -1
Process,priority, , high                              ;脚本进程优先级为高
; ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ    4
#Include *i %A_ScriptDir%\Lib\ImagePut.ahk
#Include *i %A_ScriptDir%\Lib\BTT.ahk
#Include *i %A_ScriptDir%\Lib\Gdip_All.ahk
#Include *i %A_ScriptDir%\Lib\NonNull.ahk
#Include *i %A_ScriptDir%\Lib\TrayIcon.ahk ; *i 和单个空格 忽略读取包含文件时出现的任何问题。
#Include *i %A_ScriptDir%\Lib\StdOutToVar.ahk 
#Include *i %A_ScriptDir%\Lib\SnoMouse.ahk
#Include *i %A_ScriptDir%\Lib\窗口左半.ahk
#Include *i %A_ScriptDir%\Lib\qieH.ahk
; ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ    5
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
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   限制单进程运行   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   
OnClipboardChange:                                 
loop,1
{
	 ;SoundBeep, 4900, 3
	SoundPlay, D:\ahk1.0\Lib\0\0.mp3
btt(Clipboard,,,,"Style8") 
sleep, 70
btt()​
FileAppend, %clipboard% `n, E:\6           ;----------------  剪贴板历史记录保存
return
}
; ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ     复制后通知     ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   
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
;hTTFont2:=hTTFont1:=ToolTipFnt("s19", "
软雅黑", 0x470031, 0xff9898)
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
	btt(Text,300,400,,"Style5")
	sleep, 600
	btt()​

	send, +{space} 
	return
}
; ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  全半角  双击 Ralt  ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   
Appskey::                                           
	t:=-oldt+(oldt:=A_TickCount)
	if (t<100 || t>300)
    	Return
 	else oldt:=0
{
	loop,3
   	 SoundBeep, 3000, 30  
	Text=中英标点
	btt(Text,,,,"Style6")
	sleep, 600
	btt()​
	send, ^.
	Return
}
; ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 中英标点  双击 Appskey  ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   
Rctrl::        ; 双击
Send ^{Space down}{Space up} 
keywait, space
loop,2
    SoundBeep, 4000, 10
return
; ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  切换中英输入法   Rctrl   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   
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
; ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ     音 量  指  示     ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ    
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
	KeyWait, RButton , T0.1
	If ErrorLevel = 0
{
	SendInput {Ctrl Down}c{Ctrl Up}
ClipWait, , 1   ; 等待，一直到剪贴板包含数据。
; 参数 2 将等待不超过2秒的时间. 0 等同于指定 0.5 如果省略, 此命令将无限期等待. 
; 参数 1 会等待剪贴板中出现任何类型的数据. 省略此参数, 此命令会等待剪贴板中出现文本或文件. 
}
return
; 🥦🍄🥦🍄🥦🍄🥦🍄🥦🍄🥦    左键拖选 右键确认 复制    🥦🍄🥦🍄🥦🍄🥦🍄🥦🍄🥦🍄🥦
MButton::                                                  
	KeyWait, MButton, T0.5
	If ErrorLevel = 1
{
	SendInput {Ctrl Down}x{Ctrl Up}
}
	Else
{
	SendInput {Ctrl Down}v{Ctrl Up}
}
return
; 🥦🍄🥦🍄🥦🍄🥦🍄🥦🍄🥦   中键 短按剪切 点击粘贴   🥦🍄🥦🍄🥦🍄🥦🍄🥦🍄🥦🍄🥦
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
; 🥦🍄🥦🍄🥦🍄🥦🍄🥦🍄🥦🍄  art+q 批量复制粘贴 🥦🍄🥦🍄🥦🍄🥦🍄🥦🍄🥦🍄🥦🍄
#Persistent
Copy(clipboardID) {
	global ; All variables are global by default
	local oldClipboard := ClipboardAll ; Save the (real) clipboard
	
	Clipboard := "" ; Erase the clipboard first, or else ClipWait does nothing
	SendInput {Ctrl Down}c{Ctrl Up}
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
	SendInput {Ctrl Down}x{Ctrl Up}
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
;---------------------copy
>!2::Copy(1)
>!3::Copy(2)
>!4::Copy(3)
>!s::Copy(4)
>!d::Copy(5)
>!f::Copy(6)
>!5::Copy(7)
;-------------------paste
>!w::Paste(1)
>!e::Paste(2)
>!r::Paste(3)
>!x::Paste(4)
>!c::Paste(5)
>!v::Paste(6)
>!t::Paste(7)
;--------------------cut
>!g::Cut(2)
>!b::Paste(2)                                 ;-------------->! g 剪切    >! b 粘贴
;------------------
return
;🥦🍄🥦🍄🥦🍄🥦🍄🥦🍄🥦🍄 >! 2345sdf复制  wertxcv 粘贴 🥦🍄🥦🍄🥦🍄🥦🍄🥦🍄🥦
AppsKey & F4::  
Clipboard =
Send, {ctrl down}c{ctrl up}
ClipWait
path = %Clipboard%
Clipboard = %path%
Tooltip, %path%
clipWait,1
Tooltip
Return
; 🥦🍄🥦🍄🥦🍄🥦🍄🥦🍄🥦   复制文件路径   AppsKey & F4   🥦🍄🥦🍄🥦🍄🥦🍄🥦🍄🥦
*>!F1::	
Send, ^c
sleep, 200
	run, nircmd.exe clipboard addfile "E:\5"
	sleep, 20
	run, nircmd.exe exec show "E:\3\EmEditor_22.0.1_64bit_Portable\EmEditor.exe" "E:\5"
	sleep, 200
	Send, `r  
	sleep, 20
	Send, ^s 
	sleep, 300
	send, ^+{F6}
  ; IfWinExist, ahk_class EmEditorMainFrame3
{
	;WinMinimize
}
return
;🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨  >!F1  内容自动保存到  E:\5  🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨   可见模式
*>!F2::	
SendInput {Ctrl Down}c{Ctrl Up}
Run, nircmd.exe clipboard addfile "E:\5"
Run, nircmd cmdwait 100 speak text "已复制" -1 80    
;send, ^w          ; 类型：text, xml, file  速度：-10-+10  音量：0-100
return
;🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨  >!F2    内容自动保存到  E:\5  🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨  隐藏模式
*>!F3::
Run, nircmd.exe clipboard readfile "E:\5"
sleep, 900
SendInput {Ctrl Down}v{Ctrl Up}
Run, nircmd cmdwait 100 speak text "已粘贴" -1 80
return
;🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨  >!F3    将E:\5中的内容  粘贴到文档   🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨
*>!F4::
Run  "D:\ahk1.0\Lib\0 tool\bat\新建5覆盖不提示.vbs"  
Run, nircmd cmdwait 100 speak text "内容已清空" -1 80  
return
F4::F4
return
;🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨  >!F4   清空E:\5 内容  🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨
*>!F5::							
	Clipboard := ""
	Send, ^c
	ClipWait					
	Clipboard := RegExReplace(Clipboard, "\R")	; \R 涵盖所有回车换行符组合
sleep, 1000
send, ^v
	return
;🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨   >!F5  多行转一行   🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨 
*>!F6::							 ; $ 防止下面的发送命令触发热键
	Clipboard := ""
	Send, ^c
	ClipWait					
	Clipboard := RegExReplace(Clipboard, "\R")	; \R 涵盖所有回车换行符组合
	return
;🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨   >!F6  多行转一行至剪贴板   🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨  
Rshift & NumLock::  
Clipboard =
Send, ^c
Run  "D:\ahk1.0\Lib\0 tool\bat\新建htm覆盖不提示.vbs"  
sleep, 900
FileAppend, %clipboard% `n, E:\3\0\语音合成\录音\q.htm 

 	IfWinNotExist ahk_exe AudioRecorder.exe
{
	Run "E:\3\0\语音合成\录音\录音.exe"  , , max       
	WinActivate
}
	Else IfWinNotActive ahk_exe AudioRecorder.exe
{
	WinActivate            
}
sleep, 2000
runwait E:\3\0\语音合成\录音\q.htm
sleep, 3000
send ^+u
sleep, 200
send, ^+{space}
return
; 🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️💠   Rshift NumLock  文字转MP3   💠🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️
appskey & F1:: 
    cur := Mod(cur + 1, devices.Length())
    option := logo
    ChangeDevice(devices[cur+1], option)
sleep 50
    return

;AutoHotkey并不支持切换设备，这时候就要借助NirCmd工具来执行切换设备的指令
ChangeDevice(device, option) 
{
loop,1
    SoundBeep, 1000, 10                          
; 1000 声音的频率, 可以为 表达式. 它应该是介于 37 和 32767 之间的数字. 如果省略, 则频率为 523.
; 10 声音的持续时间, 单位为毫秒. 如果省略, 则持续时间为 150.
Text= ⭕    %device%   %option% ⭕
btt(Text,600,10,,"Style7") 
sleep, 500
btt()​
       Run, nircmd.exe setdefaultsounddevice %device%   
;Run, nircmd cmdwait 100 speak text "hi" -1 80    
   }   
 return
;🤸‍♂️🤸‍♂️🤸‍♂️🤸‍♂️🤸‍♂️🤸‍♂️🤸‍♂️💠  切换音频设备 appskey +F1 💠🤸‍♂️🤸‍♂️🤸‍♂️🤸‍♂️🤸‍♂️🤸‍♂️🤸‍♂️
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
run "D:\ahk1.0\Lib\0 tool\SGScreencapture\screencapture.exe"
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
;✂✂✂✂✂✂✂✂✂✂✂   截图  单ocr 双Snipaste  Appskey & 1  ✂✂✂✂✂✂✂✂✂
Appskey & 2::
  	IfWinExist, ahk_class FastStoneScreenCapturePanel
	WinClose
else
  	Run, E:\3\9 FSCapture97\FSCapture.exe
	sleep, 1100
	send, !2	
return
;✂✂✂✂✂✂✂✂✂✂✂  截图  FSCapture.exe  Appskey & 2  ✂✂✂✂✂✂✂✂✂✂
$+#s:: 
;clipboard =
Send, {PrintScreen}
sleep,6000
ImagePutFile("", "C:\Users\D\Desktop\")
return
;✂✂✂✂✂✂✂✂✂✂✂✂  截图  保存于桌面/剪贴板  +#s  ✂✂✂✂✂✂✂✂✂✂✂ 
Appskey & 3::
Imageshow("a")
ImagePutClipboard(ImagePutFile("A", "C:\Users\D\Desktop\"))
return
;✂✂✂✂✂✂✂✂✂ 截图  当前窗口 剪贴板/贴图/存桌面 Appskey & 3 ✂✂✂✂✂✂✂✂ 
Appskey & 4:: 
file := ImagePutFile(clip, "C:\Users\D\Desktop\" )
return
;✂✂✂✂✂✂✂✂✂ 截图 将剪贴板中的截图 保存于桌面  Appskey & 4 ✂✂✂✂✂✂✂✂
Appskey & 5::
run, nircmd  loop 2 3000 savescreenshot "C:\Users\D\Desktop\~$currtime.HHmm_ss$ ~$loopcount$.png"
return                  ;2为截图数   3000 为间隔3秒
;✂✂✂✂✂✂✂✂✂✂ 截图 全屏 间隔3秒截图２张 Appskey & 5  ✂✂✂✂✂✂✂✂✂✂
Appskey & 6::
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
Run "D:\ahk1.0\Lib\0 tool\窗口隐藏工具\窗口隐藏工具.exe"
Run E:\3\4\Gif123.exe
} 
else if (d1d >= 2)
{    
Run "D:\ahk1.0\Lib\0 tool\窗口隐藏工具\窗口隐藏工具.exe"
Run E:\3\9ZDSoftScnRec\ScnRecPortable.exe
}
d1d = 0  ;每次响应时钟后把计数器清0复位
return
;✂✂✂✂✂✂✂✂✂✂✂ 录屏 单 gif  双 MP4  Appskey & 6  ✂✂✂✂✂✂✂✂✂✂✂
;#SingleInstance Force
;#NoEnv
displayNum := 0
visibleState := true
~F9 & 9::
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

;^WheelDown::
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
;^WheelUp::
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
;^MButton::
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

~WheelDown::
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
~WheelUp::
	increaseSize(){
		id := WinExist("A")
		img := img%id%
		scale%id% += 35
		WinGetPos,,, width, height
		width := width%id% * scale%id% // 100
		height := height%id% * scale%id% // 100
		GuiControl, MoveDraw, %img%, w%width% h%height%
		WinMove,,,,, width, height
		tooltip, % "Size:" scale%id% "%"
		sleep, 100
	              tooltip,
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
~F9 & 0::
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
~F9 & -::
	destroyAllPaste(){
		WinGet, id, List, pasteToScreen
		Loop, %id%
		{
			this_id := id%A_Index%
			SendMessage, 0x203,,,, ahk_id %this_id%
		}
	}
return
~F9 & =::
FileSelectFile, imgFile, 3, D:\3\Camera Roll\1.png
hBitmap := LoadPicture(imgFile)
displayImg(hBitmap)
return
;🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🥅    鼠标滚轮改变贴图大小 双击关闭
;🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🥅    Ctrl+鼠标滚动   改变粘贴的透明度
;🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🥅    Ctrl+中键  重置透明度
;🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🥅    F9+- 关闭所有粘贴
;🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🥅    F9+0 隐藏或显示所有粘贴                  
;🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🥅    F9+= 打开图并设置为贴图
;🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🥅    F9+9 贴图 
;🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🔦🥅   F9+8 剪贴板内容贴在桌面
~F9 & 8::             
ImagePutDesktop(ClipboardAll)    
;ImagePutDesktop("D:\3\Camera Roll\1.png")
return
;✂✂✂✂✂✂✂✂ 剪贴板内容贴在桌面不能动 需重截图覆盖  F9 + 8  ✂✂✂✂✂✂✂✂✂       
~Ins::
	Send, {ctrl down}c{ctrl up}
sleep,1000    
	Run, nircmd execmd "picgo u"
sleep, 2000
	Run, nircmd execmd "D:\ahk1.0\Lib\0 tool\9upit\upgit.exe :clipboard-files"
	, ,hide
return
; 🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩   onegit上传剪贴板中的 文件 Ins
F2 & 2::
Text= ⭕       上传图片中     ⭕ 
btt(Text,600,0,,"Style4") 
	;run, cmd /c D:\ahk1.0\Lib\0 tool\9upit\upgit.exe :clipboard -o clipboard -f markdown
             Run "D:\ahk1.0\Lib\0 tool\9upit\upgit.exe" :clipboard -o clipboard -f markdown
	, ,hide
	Sleep, 5000
btt()​
return
; 🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩  git上传剪贴板中的  图片 F2 & 2
F2 & 6::
Text= ⭕       上传图片中     ⭕ 
btt(Text,600,0,,"Style4") 
	;Run, cmd /c  "picgo u" , , min 
	;Run, D:\ahk1.0\nircmd-x64\nircmd.exe exec show C:\Users\D\.picgo\2.bat , ,hide
	Run, nircmd execmd "picgo u"	
sleep, 9000
btt()​
return
; 🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩🛩     one上传剪贴板中的  图片 F2 & 6
AppsKey & F3:: 
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
;🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁  隐藏任务栏    AppsKey & F3  🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁
capslock:: 
if Wint_presses > 0 ; SetTimer 已经启动, 所以我们记录键击.
{
    Wint_presses += 1
    return
}
; 否则, 这是新开始系列中的首次按下. 把次数设为 1 并启动
; 计时器：
Wint_presses = 1
SetTimer, KeyWint, 1200                                                  ; 在 1200 毫秒内等待更多的键击.   
return                 ; -----------------------------------------设为大于900，则4击时有足够的时间，否则不灵

KeyWint:
SetTimer, KeyWint, off
if Wint_presses = 1 ; 此键按下了1次.
{
   send, !p                              ;----------------------------------1  系统
sleep, 200
send /
sleep, 200
send s
}
 if Wint_presses = 2   ; 此键按下了2次.
{
   send, !p                              ;----------------------------------2  Clash
sleep, 200
send /
sleep, 200
send 9
}

if Wint_presses = 3 ; 此键按下了3次.
{
  send, !p                              ;----------------------------------3 美
sleep, 200
send /
sleep, 200
send 7
}

if Wint_presses = 4 ; 此键按下了4次.
{
  send, !p                              ;----------------------------------4 德
sleep, 200
send /
sleep, 200
send 4
}

if Wint_presses > 4 ; 此键按下了5次.
{
  send, !p                              ;----------------------------------5 直
sleep, 200
send /
sleep, 200
send 0
}
; 不论触发了上面的哪个动作, 都对 count 进行重置
; 为下一个系列的按下做准备:
Wint_presses = 0
return
;🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋  浏览器代理切换 1系统 2Cla 3美 4直 5德  🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋   
~F2:: 
if Wint_presses > 0 ; SetTimer 已经启动, 所以我们记录键击.
{
    Wint_presses += 1
    return
}
; 否则, 这是新开始系列中的首次按下. 把次数设为 1 并启动
; 计时器：
Wint_presses = 1
SetTimer, KeyWint4, 1200                                                  ; 在 1200 毫秒内等待更多的键击.   
return                 ; -----------------------------------------设为大于900，则4击时有足够的时间，否则不灵

KeyWint4:
SetTimer, KeyWint4, off

if Wint_presses = 2 ; 此键按下了2次.
{
Imageshow("D:\ahk1.0\1\1.png")
;ImageShow("https://cdn.jsdelivr.net/gh/zbb7001/4@master/C0112/L06.04_12:19:36.png")
}                                                   ;---------------------------------------------快捷键目录  F2按2下

if Wint_presses = 3 ; 此键按下了3次.
{
WinGetActiveTitle, Title
	Title := StrReplace(Title, "🍁置顶 🍁")        
	ID := WinExist("A")
	WinGet, ExStyle, ExStyle, ahk_id %ID%
	If (ExStyle & 0x8)		
	{
		WinSet,TopMost,,A
		WinSetTitle, , ,🍁 OFF 🍁

 SoundPlay, D:\ahk1.0\Lib\0\2.mp3
;Run, nircmd speak text "已取消置顶" 0 90
	}
	Else		
	{
		WinSet,TopMost,,A
		WinSetTitle, , ,🍁 置顶 🍁

   	 SoundPlay, D:\ahk1.0\Lib\0\1.mp3
;Run, nircmd speak text "当前窗口已置顶" 1 90
	}
}                                                    ; -------------------------------------------窗口置顶  F2按3下  

 if Wint_presses = 4   ; 此键按下了4次.
{
    send, ^c
String2 = %clipboard%
ComObjCreate("SAPI.SpVoice").Speak(String2)		  
}                                                   ; ----------------------------------------朗读选中文本  F2按4下

if Wint_presses > 4 ; 此键按下了5次.
{
run osk
}                                                   ;---------------------------------------------屏幕键盘  F2按5下


; 不论触发了上面的哪个动作, 都对 count 进行重置
; 为下一个系列的按下做准备:
Wint_presses = 0
return
;🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋     F2
~F4:: 
if Wint_presses > 0 ; SetTimer 已经启动, 所以我们记录键击.
{
    Wint_presses += 1
    return
}
; 否则, 这是新开始系列中的首次按下. 把次数设为 1 并启动
; 计时器：
Wint_presses = 1
SetTimer, KeyWint2, 1200                                                  ; 在 1200 毫秒内等待更多的键击.   
return                 ; -----------------------------------------设为大于900，则4击时有足够的时间，否则不灵

KeyWint2:
SetTimer, KeyWint2, off
if Wint_presses = 2 ; 此键按下了1次.
{
run ms-settings:network-proxy         
}                                                    ; -------------------------------------------网络代理  F4按2下 

 if Wint_presses = 3   ; 此键按下了2次.
{
run ncpa.cpl        		
}                                                    ; -------------------------------------------网络连接  F4按3下 

if Wint_presses = 4 ; 此键按下了3次.
{
run gpedit.msc   
}                                                    ; ---------------------------------------------组策略  F4按4下 

if Wint_presses > 4 ; 此键按下了4次.
{
run intl.cpl
}                                                    ; -----------------------------------------区域和语言  F4按5下 

; 不论触发了上面的哪个动作, 都对 count 进行重置
; 为下一个系列的按下做准备:
Wint_presses = 0
return
;🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋   F4
~F5:: 
if Wint_presses > 0 ; SetTimer 已经启动, 所以我们记录键击.
{
    Wint_presses += 1
    return
}
; 否则, 这是新开始系列中的首次按下. 把次数设为 1 并启动
; 计时器：
Wint_presses = 1
SetTimer, KeyWint5, 1200                                                  ; 在 1200 毫秒内等待更多的键击.   
return                 ; -----------------------------------------设为大于900，则4击时有足够的时间，否则不灵

KeyWint5:
SetTimer, KeyWint5, off
if Wint_presses = 2 ; 此键按下了1次.
{
Run control        		                    
}                                                    ; -----------------------------------------------控制面板  F5按2下  

if Wint_presses = 3 ; 此键按下了1次.
{
Run C:\Windows\System32\SystemPropertiesAdvanced.exe              
}                                                    ; ------------------------------------------------环境变量  F5按3下

 if Wint_presses = 4   ; 此键按下了2次.
{
run taskschd.msc  		  
}                                                  ; ------------------------------------------------任务计划  F5按4下

if Wint_presses > 4 ; 此键按下了5次.
{
run main.cpl                  		    
sleep, 600
send, {Space down}{Space up}
sleep, 200
send, {Enter}
}                                                   ; ----------------------------------------------鼠标左右键  F5按5下


; 不论触发了上面的哪个动作, 都对 count 进行重置
; 为下一个系列的按下做准备:
Wint_presses = 0
return
;🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋   F5
~F6:: 
if Wint_presses > 0 ; SetTimer 已经启动, 所以我们记录键击.
{
    Wint_presses += 1
    return
}
; 否则, 这是新开始系列中的首次按下. 把次数设为 1 并启动
; 计时器：
Wint_presses = 1
SetTimer, KeyWint6, 1200                                                  ; 在 1200 毫秒内等待更多的键击.   
return                 				           ; 设为大于900，则4击时有足够的时间，否则不灵

KeyWint6:
SetTimer, KeyWint6, off
if Wint_presses = 2 ; 此键按下了2次.
{
Suspend
  Reload		                    
}                                                       ; -------------------------------------------------刷新脚本  F6按2下  

if Wint_presses = 3 ; 此键按下了3次.
{
   path:=A_IsCompiled ? A_ScriptFullPath:A_AhkPath
SplitPath, path,, dir
Run, "%dir%\AutoHotkey.chm"     
}                                                     ; ---------------------------------------------------帮助文档  F6按3下

 if Wint_presses = 4   ; 此键按下了4次.
{
 if (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey > 900)
    loop,1
    SoundBeep, 1000, 10
Text= ⭕       启   动        ⭕`n  ——————`n⭕  窗口折叠隐藏   ⭕
btt(Text,600,0,,"Style8") 
sleep, 3000
btt()​
    ;Run D:\ahk1.0\DockIt.ahk 	  
}                                                   ; -------------------------------------------------窗口折叠隐藏  F6按4下

if Wint_presses > 4 ; 此键按下了5次.
{
ImagePutFile("C:\Users\D\Desktop\1.jpg", "C:\Users\D\Desktop\2.png")
}                                                   ; -------------------------------------------------转换图片格式  F6按5下
;-----yestoall 覆盖   noerrorui 不显示错误信息 silent 不显示文件复制进度 nosecattr 不复制文件属性

; 不论触发了上面的哪个动作, 都对 count 进行重置
; 为下一个系列的按下做准备:
Wint_presses = 0
return
;🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋   F6

; 🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞  光标  操作  🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞
; 🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞  光标  操作  🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞
AppsKey & w::Send {Up}
AppsKey & s::Send {Down}
AppsKey & a::Send {Left}
AppsKey & d::Send {Right}
;---------------------------------------------------- ----------------------    adws 上 下 左 右
AppsKey & z::Send {home}
;---------------------------------------------------- ----------------------   AppsKey & z 行首 
AppsKey & x::Send {end}
;---------------------------------------------------- ----------------------   AppsKey & x 行尾
AppsKey & y:: Send, ^y
;---------------------------------------------------------------------------  AppsKey & y 重做 
AppsKey & q:: Send, {Bs} 
AppsKey & e:: Send, {delete}
AppsKey & f:: Send, {Enter}  
;--------------------------------------------------- q 退格 e 删除 f 回车 z 左键单击 x 右键单击 

; 🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞  鼠标  操作  🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞
; 🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞  鼠标  操作  🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞
*>^z::  
SendEvent {click}
return
;---------------------------------------------------------------------------------------鼠标单击  >^z   左键

;--------------------------------------------注意设置成>^c  >^v 会和手势的 复制和粘贴 冲突，一定要加个 " ~ "
~>^x::   
 SendEvent {RButton click}{RButton down}  ; 按住左键不放   注意此处为RButton（鼠标左右换了）
 KeyWait, RButton
return
~>^v::    
SendEvent {RButton up}                   ;  松开左键
return
;----------------------------------------------------------------------------->^x 左键按住     >^v 松开左键
~>^c:: 
SendEvent {Blind}{LButton down}          ;注意此处为LButton（鼠标左右换了）
KeyWait RCtrl  
global SendEvent {Blind}{LButton up}
return
;--------------------------------------------------------------   鼠标单击 >^c   右键
; 🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞  长按  开关  🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞
; 🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞  长按  开关  🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞
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
~f11::   ; 长按
KeyWait, f11, T1.2
if (ErrorLevel = 1) 
{
    loop,1
    SoundBeep, 1000, 10
Text= ⭕       启   动        ⭕`n  ——————`n⭕  SnoMouse   ⭕
btt(Text,600,0,,"Style8") 
sleep, 3000
btt()​
    Run D:\ahk1.0\Lib\90.数字声音.ahk
 } 
Return
; -------------------------------------------长按F10启动 数字键盘声音
~f10::   ; 长按
KeyWait, f10, T1.7
if (ErrorLevel = 1) 
{
    loop,1
    SoundBeep, 1000, 10
Text= ⭕       启   动        ⭕`n  ——————`n⭕  数字键盘声音   ⭕
btt(Text,600,0,,"Style8") 
sleep, 3000
btt()​
    Run D:\ahk1.0\Lib\SnoMouse.ahk
 } 
Return
; -------------------------------------------长按F11启动 SnoMouse
; 🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞   页面  操作  🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞
; 🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞   页面  操作  🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞
>^q::                           
ControlGetFocus, control, A
SendMessage, 0x115, 0, , %control%, A              ;WM_VSCROLL = 0x115
return
; 🎗⭐🎗⭐🎗⭐🎗⭐🎗⭐🎗⭐🎗⭐🎗⭐  >^q  向上滚动一行  🎗⭐🎗⭐🎗⭐🎗⭐🎗⭐🎗⭐🎗⭐🎗⭐🎗⭐🎗⭐🎗
>^e::                    
ControlGetFocus, control, A
SendMessage, 0x115, 1, , %control%, A
return
; 🎗⭐🎗⭐🎗⭐🎗⭐🎗⭐🎗⭐🎗⭐🎗⭐  >^e  向下滚动一行  🎗⭐🎗⭐🎗⭐🎗⭐🎗⭐🎗⭐🎗⭐🎗⭐🎗⭐🎗⭐🎗
>^r:: 
SendEvent {pgup}
return
; 💢⭐💢⭐💢⭐💢⭐💢⭐💢⭐💢⭐💢⭐   >^R  pgup   💢⭐💢⭐💢⭐💢⭐💢⭐💢⭐💢⭐💢⭐💢⭐💢
>^t:: 
SendEvent {pgdn}
return
; 💢⭐💢⭐💢⭐💢⭐💢⭐💢⭐💢⭐💢⭐  >^T   pgdn   💢⭐💢⭐💢⭐💢⭐💢⭐💢⭐💢⭐💢⭐💢⭐💢
#Appskey::
ControlGetFocus, control, A
SendMessage, 0x115, 6, , %control%, A
return
; 🔰⭐🔰⭐🔰⭐🔰⭐🔰⭐🔰⭐🔰⭐🔰⭐🔰   #Appskey  Home   🔰⭐🔰⭐🔰⭐🔰⭐🔰⭐🔰⭐🔰⭐🔰⭐🔰⭐🔰⭐🔰
!Appskey::                           ; End
ControlGetFocus, control, A
SendMessage, 0x115, 7, , %control%, A
return
; 🔰⭐🔰⭐🔰⭐🔰⭐🔰⭐🔰⭐🔰⭐🔰⭐🔰   !Appskey  End   🔰⭐🔰⭐🔰⭐🔰⭐🔰⭐🔰⭐🔰⭐🔰⭐🔰⭐🔰⭐🔰⭐🔰
+!d::
Run  "E:\3\alist123\123.vbs - 快捷方式.lnk"  
return
; 🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞 快捷  搜索  🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞
; 🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞 快捷  搜索  🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞
F1 & 1::                                     
  	send, {F2} 
sleep,200
send,{ctrl down}c{ctrl up}
sleep,200
ClipWait
  	Run, "E:\3\Everything-1.4.1.1021.x64\Everything.exe"  -s "%clipboard%"
  	return
 ; 🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁   F1 & 1 用Evething搜索选中的文字
F1 & 4:: 
	Send, {ctrl down}c{ctrl up}
	KeyWait F1
	Run https://www.baidu.com/s?ie=UTF-8&wd=%clipboard% 
	return
 ; 🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁      F1 & 4 用百度搜索选中的文字
F1 & 5::
Send, {ctrl down}c{ctrl up}   
sleep, 400
	KeyWait F1                         
 	 Runwait https://fanyi.baidu.com/?aldtype=23#en/zh/%clipboard%
	return
 ; 🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁    F1 & 5 百度翻译
F1 & 6:: 
	Send, {ctrl down}c{ctrl up}   
sleep, 400
	KeyWait F1                         
 	 Runwait https://transmart.qq.com/zh-CN/index
	sleep, 3000
	Send, {ctrl down}v{ctrl up}                                                               
	return
 ; 🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁    F1 & 6 腾讯翻译
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
 ; 🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁       F1 & 7 用DocFetcher.exe 
F1 & 8::  
Send, {ctrl down}c{ctrl up} 
sleep, 100
Run, E:\3\filelocator_9.0.3389.0_Portable\FileLocatorPro.exe -c  %clipboard% -d "C:\Users\D\Desktop\123" 
sleep, 4500
send, {enter}
return
 ; 🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁       F1 & 8  Filelocatorpro.exe搜索
F1 & 9::  
  	Send, {ctrl down}c{ctrl up}
	KeyWait F1
	Run http://www.google.com.tw/search?hl=zh-TW&q=%Clipboard%
	return
 ; 🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁     F1 & 9 用谷歌搜索选中的文字
F1 & 0::      
	Send, {ctrl down}c{ctrl up}
	send, #!/     
	KeyWait F1
	;sleep,2000                        
  	Run https://www.deepl.com/translator?q=Adds%20shortcuts%20to%20increase%2Fdecrease%20font%20size#en/zh/%clipboard%  
	sleep,16000
	send, #!/  
  	return
 ; 🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁      F1 & 0  DeepL翻译 需全局

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
; 📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥  单击 复制文件名 双击 以剪贴板命名 F2 & 3
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
; 📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥   单 新建文件夹 双 TxT文件 名为剪贴板 F2 & 4
; 🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞 快捷  运行  🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞
; 🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞 快捷  运行  🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞
#WinActivateForce
Rctrl & 1::
    IfWinNotExist ahk_exe chrome.exe
    {
        Run "C:\Users\D\AppData\Local\Google\Chrome\Application\chrome.exe", ,max
        WinActivate
keywait, Rctrl 
    }
    Else IfWinNotActive ahk_exe chrome.exe
    {
       WinActivate   
keywait, Rctrl          
    }
    Else
    {
        WinMinimize   
keywait, Rctrl   
    }
Return
; ❄❄❄❄❄❄❄❄❄❄❄❄  打开 chrome  Rctrl & 1 ❄❄❄❄❄❄❄❄❄❄❄❄❄
Rctrl & 2::
    IfWinNotExist ahk_exe EmEditor.exe
    {
        Run "E:\3\EmEditor_22.0.1_64bit_Portable\EmEditor.exe"  , , max             ;-----------------, , min
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
; ❄❄❄❄❄❄❄❄❄❄❄❄   打开 EmEditor  Rctrl & 2   ❄❄❄❄❄❄❄❄❄❄❄❄
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
; ❄❄❄❄❄❄❄❄❄❄❄❄  打开 资源处理器  Rctrl & 3  ❄❄❄❄❄❄❄❄❄❄❄❄
#WinActivateForce
Rctrl & 4::
    IfWinNotExist ahk_exe brave.exe
    {
        Run "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe", ,max
        WinActivate
keywait, Rctrl 
    }
    Else IfWinNotActive ahk_exe brave.exe
    {
       WinActivate   
keywait, Rctrl          
    }
    Else
    {
        WinMinimize   
keywait, Rctrl   
    }
Return
;  ❄❄❄❄❄❄❄❄❄❄❄❄ 打开 brave  Rctrl & 4  ❄❄❄❄❄❄❄❄❄❄❄❄❄❄
Rctrl & 5::
WeChat:="ahk_class WeChatMainWndForPC"
WeChat_path:="C:\Program Files (x86)\Tencent\WeChat\WeChat.exe"
 
if ProcessExist("WeChat.exe")=0
{
	Run, %WeChat_path%
sleep, 3000
DllCall("SetCursorPos", int, 728, int, 543) 
	click 17
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
 
ProcessExist(exe){		   ;一个自定义函数,根据自定义函数的返回值作为#if成立依据原GetPID
	Process, Exist,% exe
	return ErrorLevel
}
; ❄❄❄❄❄❄❄❄❄❄❄❄❄  打开 微信  Rctrl & 5  ❄❄❄❄❄❄❄❄❄❄❄❄❄
Rctrl & 6::
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
; ❄❄❄❄❄❄❄❄❄❄❄❄ 打开 微信小窗  Rctrl & 6  ❄❄❄❄❄❄❄❄❄❄❄❄❄

; 🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞  其他  功能  🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞
; 🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞  其他  功能  🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞  1
CurrentDesktop := 1
Appskey & F5:: 
	Send, % (CurrentDesktop = 1 ? "^#{Right}" : "^#{Left}")
	CurrentDesktop := (CurrentDesktop = 1 ? 2 : 1)
return
; 🎵🎵🎵🎵🎵🎵🎵🎵🎵🎵🎵   Appskey & F5  在两个窗口切换  🎵🎵🎵🎵🎵🎵🎵🎵🎵🎵🎵
;F3 & 5::                     
    SendInput ^#{Left}                    
Return
;F3 & 6::                                                                    
    SendInput ^#{Right}                  
Return
; 🎵🎵🎵🎵🎵🎵🎵🎵🎵🎵🎵  F3 & 5 上一窗口  6 下一窗口 🎵🎵🎵🎵🎵🎵🎵🎵🎵🎵🎵🎵
Rctrl & 7:: 
Clipboard =
send,{ctrl down}c{ctrl up}
sleep, 1500
Run, properties %Clipboard%
return
;🍀🍀🍀🍀🍀🍀🍀🍀🍀🍀🍀🍀🍀🍀   右键属性  Rctrl &  7   🍀🍀🍀🍀🍀🍀🍀🍀🍀🍀🍀🍀
Rctrl & 8::                     
o=E:\3\EmEditor_22.0.1_64bit_Portable\EmEditor.exe
1=D:\ahk1.0\Ahk1.0.ahk
2=C:\Users\D\.picgo\config.json
3=D:\ahk1.0\Lib\0 tool\9upit\config.toml
Run,%o% "%1%" "%2%" "%3%"  
return
;🍀🍀🍀🍀🍀🍀🍀🍀🍀 打开 EmEditor打开3个config文件 Rctrl & 8 🍀🍀🍀🍀🍀🍀🍀🍀🍀🍀
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
;💲💲💲💲💲💲💲💲💲💲💲💲💲💲💲💲💲💲  F3 & 1   循环 大写   小写  首字母大写  💲💲💲💲💲💲💲💲💲💲💲💲💲💲💲💲💲

;#Persistent
;#SingleInstance force
KillTip()             ;清除toolTip
{        
        tooltip
}
volUp()            ;增加""
{       
        sendInput {Volume_Up}
    SoundGet, master_volume
    master_volume := ceil(master_volume)
    ;ToolTip %master_volume% `%   
    ;SetTimer, killTip, -500
}
 
volDown()       ;降低音量
{       
        sendInput {Volume_Down}
    SoundGet, master_volume
    master_volume := ceil(master_volume)
    ;ToolTip %master_volume% `%
    ;SetTimer, killTip, -500
}
 
volMute()       ;静音切换
{       
    sendInput {Volume_Mute}
 SoundGet, master_volume
    master_volume := ceil(master_volume)
        ;toolTip %master_volume% `%
        ;SetTimer,killTip, -500
}
F4 & 1::  volMute() 
F4 & 2:: volDown()
F4 & 3:: volUp()
/*
#If GetKeyState("RButton", "P")                                    ;  按住右键 再左键静音 再滚轮调
        LButton::volMute()
        WheelDown::volDown()
        WheelUp::volUp()
#If
*/
F2::F2
return
; ♻♻♻♻♻♻♻♻♻♻♻♻   F4 & 3 增大 2 减小 1 静音  ♻♻♻♻♻♻♻♻♻♻♻♻♻
^appskey::
if GetKeyState("CapsLock","T")
loop,2
{
    SoundBeep, 9900, 2

	SetCapsLockState,Off
	ToolTip,CapsLock `n      Off
 SetTimer,killTip, 1000
}
else
loop,2
{
    SoundBeep, 900, 2

	SetCapsLockState,On
	ToolTip,CapsLock `n      On
 SetTimer,killTip, 1000
}
return
; ⛩⛩⛩⛩⛩⛩⛩⛩⛩⛩⛩⛩ ^appskey    CapsLock ⛩⛩⛩⛩⛩⛩⛩⛩⛩⛩⛩⛩⛩⛩
+appskey::
send {Tab}
loop,4	
SoundBeep, 12000, 20		
return		
; ⛩⛩⛩⛩⛩⛩⛩⛩⛩⛩⛩⛩⛩ +appskey   Tab   ⛩⛩⛩⛩⛩⛩⛩⛩⛩⛩⛩⛩⛩⛩⛩ 
appskey & Esc:: 
Send {click}{AppsKey}
return
; ⛩⛩⛩⛩⛩⛩⛩⛩⛩⛩⛩   appskey & Esc  AppsKey    ⛩⛩⛩⛩⛩⛩⛩⛩⛩⛩⛩⛩⛩ 
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
F1::F1
return
; ➰➰➰➰➰➰➰➰➰➰➰   F1 & F2    选中文件移动至D:\B  ➰➰➰➰➰➰➰➰➰➰➰

#IfWinActive ahk_class TTOTAL_CMD
+Enter::
#IfWinActive ahk_class CabinetWClass
+Enter:: ;open file with Paint/Notepad (open folder in new window)
#IfWinActive ahk_class ExploreWClass
+Enter::
#IfWinActive ahk_class Progman
+Enter::
#IfWinActive ahk_class WorkerW
+Enter::
WinGet, hWnd, ID, A
WinGetClass, vWinClass, % "ahk_id " hWnd
vPath := "", vIsDir := 0

if (vWinClass = "TTOTAL_CMD") 
{
	MsgBox "Tc"
}
if (vWinClass = "CabinetWClass") || (vWinClass = "ExploreWClass")
{
	for oWin in ComObjCreate("Shell.Application").Windows
	{
		if (oWin.HWND = hWnd)
		{
			vIsDir := oWin.Document.FocusedItem.IsFolder
			vPath := oWin.Document.FocusedItem.Path
			break
		}
	}
	oWin := ""
}
else if (vWinClass = "Progman") || (vWinClass = "WorkerW")
{
	VarSetCapacity(hWnd, 4, 0)
	;SWC_DESKTOP := 0x8 ;VT_BYREF := 0x4000 ;VT_I4 := 0x3 ;SWFO_NEEDDISPATCH := 0x1
	oWin := ComObjCreate("Shell.Application").Windows.FindWindowSW(0, "", 8, ComObject(0x4003, &hWnd), 1)
	vIsDir := oWin.Document.FocusedItem.IsFolder
	vPath := oWin.Document.FocusedItem.Path
	oWin := ""
}

if (vPath = "")
{
	MsgBox, % "error: file not found"
	return
}
else if !FileExist(vPath)
{
	MsgBox, % "error: file not found:`r`n" vPath
	return
}
else if vIsDir
{
	Run, % Chr(34) vPath Chr(34)
	return
}
FileGetSize, vSizeMB, % vPath, M
if (vSizeMB > 6)
{
	MsgBox, % "error: file too big: " vSizeMB " MB"
	return
}

SplitPath, vPath, vName, vDir, vExt, vNameNoExt, vDrive
FileGetSize, vSizeMB, % vPath, M
if (vExt = "lnk")
	FileGetShortcut, % vPath, vPath
if vExt in ,bat,ahk,reg,vbs,txt,htm,html,mht,cpp,h,m3u,mpcpl,url,clp,ini,cfg,csv,srt,log
	Run, "E:\3\EmEditor_22.0.1_64bit_Portable\EmEditor.exe" "%vPath%"            
else if vExt in bmp,gif,jpe,jpeg,jpg,png
	Run, "E:\3\iview460_x64\i_view64.exe" "%vPath%"
Return
; ➰➰➰➰➰➰➰➰➰➰   +Enter  选中图标 用 EmEditor 打开    ➰➰➰➰➰➰➰➰➰➰
<!L::
run rundll32.exe shell32.dll`,Options_RunDLL 7`
sleep, 1500
send, {tab}{down 10}
sleep, 500
Send ^{Space down}{Space up}
sleep, 200
send, {space down}{space up}
sleep, 200
send, !a
sleep, 200
PostMessage, 0x112, 0xF060,,, A
return
;🎵🎵🎵🎵🎵🎵🎵🎵🎵🎵🎵🎵🎵🎵   Art+L  缩略图  🎵🎵🎵🎵🎵🎵🎵🎵🎵🎵🎵🎵🎵🎵





Appskey & F6::
ControlGet, q, Hwnd,, SysListView321, ahk_class Progman
If q =
	ControlGet, q, Hwnd,, SysListView321, ahk_class WorkerW
If DllCall("IsWindowVisible", UInt, q)
	WinHide, ahk_id %q%
Else
	WinShow, ahk_id %q%
Return
; 🧊🧊🧊🧊🧊🧊🧊🧊🧊🧊🧊🧊🧊🧊🧊🧊🧊🧊🧊🧊🧊🧊🧊🧊🧊        隐藏桌面图标 Appskey & F6
AppsKey & F7::
if winf_presses > 0 ; SetTimer 已经启动, 所以我们记录键击.
{
    winf_presses += 1
    return
}
; 否则, 这是新开始系列中的首次按下. 把次数设为 1 并启动
; 计时器：
winf_presses = 1
SetTimer, Keywinf, 300 ; 在 400 毫秒内等待更多的键击.
return

Keywinf:
SetTimer, Keywinf, off
if winf_presses = 1 ; 此键按下了一次.
{
   run, nircmd.exe win hide class progman
}
else if winf_presses = 2 ; 此键按下了两次.
{
   run, nircmd.exe win show class progman
}
winf_presses = 0
return
F3::F3
return
; 🧊🧊🧊🧊🧊🧊🧊🧊🧊🧊🧊🧊🧊🧊🧊🧊🧊🧊🧊🧊🧊🧊🧊🧊🧊     单隐 双显桌面  AppsKey & F7
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
; 📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥   shift+中键按下 复原
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
; 📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥       透明度 F3 & 3 透明    2 不透明

~F4 & 6::#=
F4 & 7::#-        
F4 & 8::send, #{esc}       
return        
; 📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥     放大镜 F4 & 6  放大   7  缩小  8  关闭
F4 & 0::
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
;🏆🏆🏆🏆🏆🏆🏆🏆🏆🏆🏆🏆🏆🏆🏆🏆🏆🏆🏆🏆🏆🏆🏆🏆🏆🏆🏆🏆🏆     计时器 F4 & 0

+#d::
send, {F2}^c
Run, "D:\ahk1.0\Lib\0 tool\bat\新建5覆盖不提示.vbs"         
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
; 📿📿📿📿📿📿📿📿📿📿📿📿📿📿📿📿📿   base64解码到剪贴板 +#d  📿📿📿📿📿📿📿📿📿📿📿📿📿📿📿📿
+#f::
send, {F2}^c
Run, "D:\ahk1.0\Lib\0 tool\bat\新建5覆盖不提示.vbs"         
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
; 📿📿📿📿📿📿📿📿📿📿📿📿📿📿📿📿📿   base64编码到剪贴板 +#f   📿📿📿📿📿📿📿📿📿📿📿📿📿📿📿
+F12::
run D:\ahk1.0\Lib\se.ahk
Return
; -------------------------------------------------取色器  +F12

<!q::
ExitApp
Return
; 📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥    退出脚本 <! q
F4 & 9::
Run, nircmd shellcopy "D:\ahk1.0" "E:\0　　tool\0\" yestoall ;silent 
String = 正在进行备份，需时约40秒
ComObjCreate("SAPI.SpVoice").Speak(String)
return
; 📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥     进行备份  F4 & 9
F3 & 5::                 ;关闭显示器.
Sleep 1000 
SendMessage, 0x112, 0xF170, 2,, Program Manager     ; 使用 -1 代替 2 来打开显示器.
return
F3 & 6::                 ;打开显示器.
Sleep 1000 
SendMessage, 0x112, 0xF170, -1,, Program Manager  
return
;🎟🎟🎟🎟🎟🎟🎟🎟🎟🎟🎟🎟 🎟🎟🎟🎟🎟🎟🎟🎟🎟🎟🎟🎟🎟     打开/关闭 显示器   F3 & 5 6   
;<!j::        ; 1为托盘需双击才能打开，不标为单击  MouseInc.exe 双击启动 v2rayN.exe单击启动
TrayIcon_Button("MouseInc.exe", "L",1)
return
;🎟🎟🎟🎟🎟🎟🎟🎟🎟🎟🎟🎟 🎟🎟🎟🎟🎟🎟🎟🎟🎟🎟🎟🎟🎟    <!j MouseInc .exe
<!g::
TrayIcon_Button("v2rayN.exe", "L")
return
;🎟🎟🎟🎟🎟🎟🎟🎟🎟🎟🎟🎟 🎟🎟🎟🎟🎟🎟🎟🎟🎟🎟🎟🎟🎟    <!g v2rayN.exe

Appskey & F2::AltTab
return
; 📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥 Appskey & F2　Alt+Tab
;F4 & r::
run services.msc
return
; 📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥     服务  F4 & r

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
<!u::
msgbox % StdoutToVar_CreateProcess("ipconfig")
msgbox % StdoutToVar_CreateProcess("ping baidu.com")
return
;🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋🔋      ipconfig　和　 ping www.sina.com.cn <!u






;🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨  >!F4   清空E:\5 内容  🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨🥨
;🎫🎫🎫🎫🎫🎫🎫🎫🎫🎫🎫🎫🎫🎫🎫🎫🎫🎫🎫🎫🎫🎫🎫🎫🎫🎫🎫🎫🎫🎫🎫🎫🎫🎫🎫
#IfWinActive ahk_exe chrome.exe
F1 & 2::                                           ; 打开谷歌翻译，回车激活切换中英	
			
sleep, 20
	CoordMode, Mouse, Screen
	global lastXW
	MouseGetPos, xpos, ypos
	WinGetPos,x,y,w,h
	xw := lastXW
	WinGetTitle, title
	IfInString, title, Chrome
	{
		xw := x + w
		lastXW := xw
	}
	pY := ypos
	if pY<200
		pY := 200
Click, 1420, 148                              ; 此处坐标为左上空白处，在此处点右键
sleep, 20
	Click, Right, xw - 10, pY
	MouseMove, xpos, ypos
	sleep, 10
	Send {T}
	;sleep, 10
	;Send {T}
	;sleep, 10
             send, {enter}
	Click, lastX, ypos 
return
F1::F1
return
; 📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥📥    -谷歌翻译 F1 & 2 中文  英文