

=================================================

=================================================

=================================================

=================================================

=================================================

=================================================
Century Schoolbook Pro   英文手写字体
=================================================
$\textcolor{red}{这里输入你要改变颜色的文字}$
$\textcolor{GreenYellow}{GreenYellow} $
$\textcolor{Yellow}{Yellow}$
$\textcolor{Goldenrod}{Goldenrod} $
$\textcolor{Dandelion}{Dandelion}$
$\textcolor{Apricot}{Apricot} $
$\textcolor{Peach}{Peach}$
$\textcolor{Melon}{Melon} $
$\textcolor{YellowOrange}{YellowOrange}$
$\textcolor{Orange}{Orange} $
$\textcolor{BurntOrange}{BurntOrange}$
$\textcolor{Bittersweet}{Bittersweet}$
$\textcolor{RedOrange}{RedOrange} $
$\textcolor{Mahogany}{Mahogany}$
$\textcolor{Maroon}{Maroon} $
$\textcolor{BrickRed}{BrickRed}$
$\textcolor{Red}{Red} $
$\textcolor{OrangeRed}{OrangeRed}$
$\textcolor{RubineRed}{RubineRed}$
$\textcolor{WildStrawberry}{WildStrawberry}$
$\textcolor{Salmon}{Salmon}$
$\textcolor{CarnationPink}{CarnationPink}$
$\textcolor{Magenta}{Magenta} $
$\textcolor{VioletRed}{VioletRed}$
$\textcolor{Rhodamine}{Rhodamine} $
$\textcolor{Mulberry}{Mulberry}$
$\textcolor{RedViolet}{RedViolet} $
$\textcolor{Fuchsia}{Fuchsia}$
$\textcolor{Lavender}{Lavender} $
$\textcolor{Thistle}{Thistle}$
$\textcolor{Orchid}{Orchid} $
$\textcolor{DarkOrchid}{DarkOrchid}$
$\textcolor{Purple}{Purple} $
$\textcolor{Plum}{Plum}$
$\textcolor{Violet}{Violet} $
$\textcolor{RoyalPurple}{RoyalPurple}$
$\textcolor{BlueViolet}{BlueViolet}$
$\textcolor{Periwinkle}{Periwinkle}$
$\textcolor{CadetBlue}{CadetBlue}$
$\textcolor{CornflowerBlue}{CornflowerBlue}$
$\textcolor{MidnightBlue}{MidnightBlue}$
$\textcolor{NavyBlue}{NavyBlue} $
$\textcolor{RoyalBlue}{RoyalBlue}$
$\textcolor{Blue}{Blue} $
$\textcolor{Cerulean}{Cerulean}$
$\textcolor{Cyan}{Cyan} $
$\textcolor{ProcessBlue}{ProcessBlue}$
$\textcolor{SkyBlue}{SkyBlue} $
$\textcolor{Turquoise}{Turquoise}$
$\textcolor{TealBlue}{TealBlue} $
$\textcolor{Aquamarine}{Aquamarine}$
$\textcolor{BlueGreen}{BlueGreen} $
$\textcolor{Emerald}{Emerald}$
$\textcolor{JungleGreen}{JungleGreen}$
$\textcolor{SeaGreen}{SeaGreen} $
$\textcolor{Green}{Green}$
$\textcolor{ForestGreen}{ForestGreen}$
$\textcolor{PineGreen}{PineGreen} $
$\textcolor{LimeGreen}{LimeGreen}$
$\textcolor{YellowGreen}{YellowGreen}$
$\textcolor{SpringGreen}{SpringGreen}$
$\textcolor{OliveGreen}{OliveGreen}$
$\textcolor{RawSienna}{RawSienna} $
$\textcolor{Sepia}{Sepia}$
$\textcolor{Brown}{Brown} $
$\textcolor{Tan}{Tan}$
$\textcolor{Gray}{Gray} $
$\textcolor{Black}{Black}$
==================================================================================================
有序无序列表之间互相转换 ctrl + shift + [      ctrl + shift +]    Typora
=================================================
表格：ctrl+t   Enter回车 增加行
=================================================
插入链接：ctrl + k   按住ctrl 双击即可访问超链接
=================================================
生成目录：[TOC]按回车
=================================================
升级标题 ctrl + =   降级标题 ctrl + - 
=================================================
快速生成标题：ctrl+ 123456
=================================================
用前端代码<center></center>进行居中处理
=================================================
ctrl +shift + k 快速生成代码块
=================================================
ctrl +shift + Q  引用
=================================================
ctrl +shift + `  `` 代码
==================================================================================================
[\u3000|\u0020|\u00A0]   搜索空格
^\s+|\s+$　　　　　　　　首尾空格

^\s*\n　　　　　　　　　 去除空行  Notepad++  Emeditor  Notepad3  其中Notepad3自带　ctrl+alt+b
[\r\n\r\n]+　　　\r　　　去除空行　（需多次替换）Emeditor
=================================================
根据 Numlock的状态, 每个小键盘上的按键可以运行两个不同的热键子程序. 可选的, 可以让小键盘上的按键不论 Numlock 的状态如何都运行相同的子程序. 例如：

NumpadEnd::
Numpad1::
MsgBox, This hotkey is launched regardless of whether Numlock is on.
return
=================================================
#If WinActive("ahk_class Notepad") or WinActive(MyWindowTitle)
#If (WinActive("ahk_class ENSingleNoteView") or WinActive("ahk_class OpusApp"))
Capslock::^b
::/infinity::8
::/pi::p
=================================================
win10系统下，文件夹无法删除
同目录新建zip文件，用7zip打开，返回上级目录，重命名文件，删除。
=================================================
32位系统用 Gdip.ahk
64为系统用 Gdip_All.ahk
=================================================
;自动滚屏相关消息惭愧
  ;~ WM_VSCROLL   = 0x115
  ;~ SB_LINE UP    = 0              上一行
  ;~ SB_LINE DOWN  = 1         下一行
  ;~ SB_PAGEUP    = 2              页上
  ;~ SB_PAGEDOWN  = 3         页下
  ;~ SB_TOP       = 6                顶部
  ;~ SB_BOTTOM    = 7            底部

  ;~ WM_HSCROLL   = 0x114
  ;~ SB_LINELEFT  = 0                  行左
  ;~ SB_LINERIGHT = 1                行右
  ;~ SB_PAGELEFT  = 2
  ;~ SB_PAGERIGHT = 3
  ;~ SB_LEFT      = 6
  ;~ SB_RIGHT     = 7
=================================================
屏蔽特定程序的全局热键，防止快捷键冲突
需求：某程序A注册了全局热键（快捷键），与其他程序B（内部、局部热键）冲突。
需求转换/实现（方式一）：对程序B，AHK（Autohotkey）钩子（物理）注册全局热键，并（逻辑）模拟热键重新发送。
#IfWinActive ahk_exe B.exe
$+^F10::+^F10
#If
可能被A重新竞争/抢占注册。
方式二： $+^F10::ControlSend ,,+^{F10},A ，全部转换为内部/局部热键了。
=====================================================================================
https://zbing-my.sharepoint.com/:i:/g/personal/k55_zbing_onmicrosoft_com/EaLruc_CkwRJh0d8TGgXcScBbjcoj50Bbfl_VLLkXuGk_Q

https://zbing-my.sharepoint.com/:i:/g/personal/k55_zbing_onmicrosoft_com/EaLruc_CkwRJh0d8TGgXcScBbjcoj50Bbfl_VLLkXuGk_Q?download=1

?download=1
=====================================================================================
$^p::
IfWinActive ahk_class Notepad
    return  ; 即不进行操作, 这样让 Control-P 在记事本中失效.
Send ^p
return
=====================================================================================
SoundPlay, D:\ahk1.0\Lib\0\2.wav
SoundBeep, var, 900
=================================================
Run *RunAs cmd ,,max
=================================================
连续执行多个命令，请在命令间使用“&&”分隔： 
Run, %comspec% /c dir /b > C:\list.txt && type C:\list.txt && pause
=================================================
系统属性
C:\Windows\System32\SystemPropertiesComputerName.exe　　计算机名
C:\Windows\System32\SystemPropertiesHardware.exe　　硬件
C:\Windows\System32\SystemPropertiesAdvanced.exe  高级
C:\Windows\System32\SystemPropertiesProtection.exe  系统保护
C:\Windows\System32\SystemPropertiesRemote.exe  远程
=================================================
1.　Run rundll32.exe sysdm.cpl`,EditEnvironmentVariables　　环境变量
2.　Run, control.exe sysdm.cpl`,`,3    　　　　　　　　　　　高级
3.　Runwait, powershell.exe Start-Process "C:\Windows\System32\SystemPropertiesAdvanced.exe" , ,hide 　高级
=================================================
新建文件夹伪装成回收站　　aa.{645FF040-5081-101B-9F08-00AA002F954E}
=================================================
调用 Trim 函数可以把空格和 tab 从每个变量的两端移除。例如：MyArray1 := Trim(MyArray1)。
=================================================
x::Send {text}abc
=================================================
uBlock Origin 插件　油管广告
chrome-extension://cjpalhdlnbpafiamejdnhcphjbkeiagm/dashboard.html#dyna-rules.html
自定义动态规则 将下面内容粘贴到右边，保存即可解决　使用广告拦截器违反...
youtube.com##+js(设置, yt.config_.openPopupConfig.supportedPopups.adBlockMessageViewModel, false)
youtube.com##+js(集, Object.prototype.adBlocksFound, 0)
youtube.com##+js(设置, ytplayer.config.args.raw_player_response.adPlacements, []）
youtube.com##+js(设置, Object.prototype.hasAllowedInstreamAd, true)
=================================================

=================================================

=================================================

=================================================

=================================================

=================================================

==================================================================================================

=================================================

=================================================

=================================================

=================================================

=================================================

==================================================================================================

=================================================

=================================================

=================================================

=================================================

=================================================

==================================================================================================

=================================================

=================================================

=================================================

=================================================

=================================================

==================================================================================================

=================================================

=================================================

=================================================

=================================================

=================================================

==================================================================================================

=================================================

=================================================

=================================================

=================================================

=================================================

=================================================
这种点击方式是相对坐标，是以窗口的左上角为坐标原点开始的。
!k::		;;
click,1000,300
=================================================

::yt::You加１个空格
;-------------------------------------------------------
:oc?:yu::You后无空格
;-------------------------------------------------------
:*:fff::自动完成
;-------------------------------------------------------
:c*:FFf::自动完成区分大小写
;-------------------------------------------------------
 :?:yj::xyz       ;输入cyj回车后变cxyz   z后有空格
;-------------------------------------------------------
 :oc?:yg::xyz无空格     ;输入ygyg回车后变ygxyz  z后无空格
;-------------------------------------------------------
 :?0:yh::xyz    ;单独输入yh回车后变xyz, 输入cyh 回车无效
;-------------------------------------------------------
:*b0:[::]{left 1}    ;  输入一个[，自动完成 ] , 并且光标位于[ ]之间
;-------------------------------------------------------
:*b0:<em>::</em>{left 5}
;热字串产生“<em></em>”并把光标向左移动 5 个位置（这样它就在标签之间了）：
;-------------------------------------------------------
:o:we::xyz        ; 输入we  输出　xyz无空格
;-------------------------------------------------------
::wq::xyz         ; 输入wq  输出　xyz后带空格
;-------------------------------------------------------
:*?B0:zzz::.com    ;输出结果为　zzz.com后无空格
;-------------------------------------------------------
:*?b0:22::
SendInput xx
return            ; 输入22  输出 　22xx2xx2xx2xx
;-------------------------------------------------------
:b0*?:11::
SendInput xx
return            ; 输入11  输出 　11xx1xx1xx1xx
;-------------------------------------------------------
:*b0:day::  
FormatTime, CurrentDateTime,, M/d/yyyy h:mm tt        ; 9/1/2005 3:53 PM 
SendInput %CurrentDateTime%
return
;-------------------------------------------------------
:*:ttt::             ;  "ttt" 替换成当前日期和时间.
FormatTime, CurrentDateTime,, M/d/yyyy h:mm tt  ; 9/1/2005 3:53 PM 
SendInput %CurrentDateTime%
return
;------------------------------------------------------

=================================================
Click  ; 在鼠标光标的当前位置点击鼠标左键.
Click 100, 200  ; 在指定坐标处点击鼠标左键.
Click 100, 200, 0  ; 移动而不点击鼠标.
Click 100, 200 right  ; 点击鼠标右键.
Click 2  ; 执行双击.
Click down  ; 按下鼠标左键不放.
Click up right  ; 释放鼠标右键.
=================================================
autohotkey如何调用python的程序
z::	;
run, test.py
return
或者
#o::		;;
run, python test.py
Return 
==================================================
autohotkey静默不显示界面地运行python程序
z::		;;
run, pythonw E:\Documents\Desktop\Program\Python\爬虫\百度\百度OCR\test.pyw
Return 
需要注意两点，1是python程序的后缀名应该改为pyw，2是应该用pythonw而非python解释器来运行程序。
===================================================
Clipboard = my text ;给予剪贴板全新的内容。
Clipboard = ;清空剪贴板。
Clipboard = %clipboard% ;将任何复制的文件、HTML 或者其它带格式的文本转换为纯文本。

Clipboard = %clipboard% zcr023。 ;在剪贴板中追加些文本。
-------------------------------------------------------------------------------------------------------
ClipboardAll 
包含了剪贴板中的所有内容(例如图片和格式). 它常用来保存剪贴板的内容, 以便脚本可以在某个操作中临时使用剪贴板. 当这个操作结束后, 脚本可以恢复剪贴板为原来的内容, 如下所示

ClipSaved := ClipboardAll   ; 把剪贴板的所有内容保存到您选择的变量中.

Clipboard := ClipSaved   ; 恢复剪贴板为原来的内容. 注意这里使用 Clipboard(不是 ClipboardAll).

ClipSaved := ""   ; 在原来的剪贴板含大量内容时释放内存.

ClipboardAll 中的内容可以保存到文件中(在这种模式中, FileAppend 总是覆盖任何现有的文件):

FileAppend, %ClipboardAll%, C:\Company Logo.clip ; 文件扩展名无关紧要.

要在之后加载这个文件的内容回剪贴板(或变量中), 请参照此例:

FileRead, Clipboard, *c C:\Company Logo.clip ; 注意 *c 必须在文件名的前面.
==================================================
当编辑时光标变宽，这时只需按下insert键即可让光标恢复正常！
当编辑时光标变宽，这时只需按下insert键即可让光标恢复正常！
==================================================
每60秒运行一次，保存格式和所放置的目录同
dim a
set a=CreateObject("Wscript.Shell")
Do
a.run "auto.bat"
Wscript.Sleep 60000
Loop
===================================================
1.打开记事本先在里面输入一个单引号加汉字，不这样做的话有时候脚本保存时选择   ANSI编码GB2312 但是还是会成UTF-8，如果文件路径中有中文，UFT-8格式会无法运行
－－－－－－－－－－－－－－－－－－－－－－－－－
'啊
Dim WshShell
Set WshShell=WScript.CreateObject("WScript.Shell")
WshShell.Run "?D:\绿色程序\Textify_v1.8.2_CN\Textify.exe"　　　　　；－－－－－－－－－－－
WScript.Sleep 500  '休眠500毫秒（半秒）
WshShell.Run "Textify.exe"
WScript.Sleep 50
WshShell.SendKeys "%{F4}"
－－－－－－－－－－－－－－－－－－－－－－－－－－
2.如果路径中带有空格，则需要在路径前后加三个双引号，例：
WshShell.Run """?D:\绿色程序\Textify_v1.8.2_CN - 副本\Textify.exe"""　　　；－－－－－－－－－
3.如果不写路径，vbs　文件要存放在和Textify运行程序在同一个目录中
WshShell.Run "Textify.exe"                                             						
===================================================
4、Exec运行的程序路径中即使含有空格，也可以不加引号（参数如需引号，它的引号不能省略）。Run、start没有这个本领。（常识：vbs中一个引号字符"本身要用两个引号表示，即写成""。也可以用Chr函数得到引号：chr(34)）

复制代码 代码如下:

ws.Exec "C:\Program Files\Internet Explorer\IEXPLORE.EXE"
ws.Exec """C:\Program Files\Internet Explorer\IEXPLORE.EXE"""
ws.Run  """C:\Program Files\Internet Explorer\IEXPLORE.EXE"""




===========================================================
1. ^!q::menu,tray,noicon    ; 隐藏脚本图标
    ^!W::menu,tray,icon       ; 显示脚本图标
===========================================================
2.   run, %ComSpec% /k taskkill /f /IM "Cloudflare WARP.exe"
===========================================================

exitapp
===========================================================
0.完全禁用打开运行对话框的 Win+R 热键:  #r::return
===========================================================
1.保存为 UTF-8 有签名
===========================================================
2.PostMessage, 0x112, 0xF060,,, A           ;运行结束 关闭打开的窗口
===========================================================
#Requires AutoHotkey v2.0+                  ;以何种版本运行
#Requires AutoHotkey v1.1.36
===========================================================
4.Menu, Tray, Icon, E:\3\IDM v6.38.7.2 中文绿色特别版\IDM\Bin\IDMan.exe,15           ; 托盘脚本图标 

5.  Menu , tray , tip , !w                鼠标悬浮提示
===========================================================
6.#NoEnv                             ; 主要是为了与以后兼容，也可以改善性能

7.#SingleInstance Force      ;当此脚本已经运行时自动替换旧实例再次运行。 

8. #WinActivateForce          ;用强制的方法激活窗口。

9.#Persistent     ; 使非热键类的脚本持久运行（即直到用户关闭或遇到 ExitApp）

9. #HotkeyModifierTimeout 0  ;影响热键修饰符^+#! 的行为。设为 0 时 ^+#! 总是不会被推回到按下的状态

9. Process,priority, , high  ;脚本进程优先级为高

10.SetBatchLines, -1         ; 脚本快速执行,减少 CPU 占用,  使用10ms -1

11.FileGetTime ScriptStartModTime, %A_ScriptFullPath%

12.SetTimer CheckScriptUpdate, 100, 0x7FFFFFFF ; 100 ms, highest priority最高优先级

13.SetWorkingDir, %A_ScriptDir%                                      ; 让脚本无条件使用它所在的文件夹作为工作目录  

================================================================
#Include *i %A_ScriptDir%\BeautifulToolTip\Lib\NonNull.ahk

#include %A_scriptDir%\myahk\winhide.ahk
================================================================
#Include, Lib\Gdip_All.ahk

D:\ahk1.0\Lib\Gdip_All.ahk    
D:\ahk1.0\ *.ahk        可用下面直接调用Lib中的库文件
#Include <Gdip_All>
================================================================
16   ; Tray menu
Menu, Tray, NoStandard ; remove all options

Menu, Tray, Add, About, ClickHandler
Menu, Tray, Default, About 

Menu, Tray, Add, Exit, ExitScript ; add exit option
================================================================
17  FileAppend, %clipboard% `n, E:\6.txt

================================================================
18 if (A_PriorHotkey <> "z" or A_TimeSincePriorHotkey > 400){
  	  ; 两次按下时间间隔太长, 所以这不是一个两次按下.
  	  KeyWait, Ralt
 	   return
================================================================
19 Appskey & Space:: send {Space } 
$Space:: send {Space}    ; $ 防止下面的发送命令触发热键
$^Space:: ^Space
 return
;¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤























loop,1
    SoundBeep, 1000, 10
Text= ?       %device%   %option%     ?
btt(Text,600,0,,"Style4") 
sleep, 1000
btt()?
       Run, nircmd.exe setdefaultsounddevice %device%   
Run, nircmd cmdwait 100 speak text "非静音" -1 80    


$F5::
	KeyWait, F5
	If (A_TimeSinceThisHotkey > 900)
		SetTimer, mainp1, -1                                                                 ;修改mainp1234
	;Else
		;SendInput, % GetKeyState("CapsLock", "T") ? "T" : "t"             ;时间不够1秒输入1 修改3个1
Return

mainp1:                                                                                                                 ;修改mainp1234
	run, D:\ahk1.0\北京时间校准器\北京时间校准器.ahk /Auto
loop,1
    SoundBeep, 1000, 10
Text= ?       启   动        ?`n  ——————`n?  校准北京时间   ?
btt(Text,600,0,,"Style8") 
sleep, 1000
btt()?
Return
;------------------------------------------北京时间校准器    长按 1  1秒时间
;???????????????????????????????????????????????????????   11

如果用 /NoGui 参数启动，则不显示界面，同步后就退出。


99 开机自动运行程序的延迟启动
folder = F:\Run

Loop, %folder%\*.lnk
{
runwait %folder%\%A_LoopFileName%
; runwait 命令，等一个程序启动完成之后再循环启动下一个程序，直到循环自动退出。
}

ExitApp
; 自动退出
