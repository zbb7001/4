RunAsAdmin()
Menu,Tray,Icon,Shell32.dll,42
mfolder = d:\music\xiami\精选集22325898

OnMessage(0x218, "PowerBroadcast") ;脚本接收到0x218:WM_POWERBROADCAST消息时调用“PowerBroadcast”这个自定义函数
PowerBroadcast(wParam) ;将0x218的wParam值作为此函数里的wParam变量
{
If (wParam = 7 OR wParam = 8) ;电源广播消息的wParam值如为7:挂起，8:待机
Reload
}

Loop ;主体循环
{
Sleep,3600000 ;3600秒即1小时
IfWinExist,ahk_class PotPlayer ;判断是否有在前台运行的PotPlayer窗口类
Continue


Add_Minute += 1,Minutes ;当前时间变量加上1分钟，重新赋值为加1分钟
Loop ;倒计时提示
{
Count_down=%Add_Minute%
Count_down -= %A_Now%,Seconds
ToolTip, %Count_down% 秒后开始休息:-)
Sleep,33 ;瞬间进入下次循环，从而产生ToolTip跟指针移动的效果。0~20一般没实际意义。
If A_Now>%Add_Minute%
{
ToolTip ;清空提示
Break ;退出倒计时提示循环
}
}
BlockInput,On ;开启屏蔽输入设备
SendMessage,0x112,0xF170,2,,Program Manager ;关闭显示器。0x112：WM_SYSCOMMAND，0xF170：SC_MONITORPOWER，2：关闭。-1：开启显示器。
Loop %mfolder%\*.*
{
cnt++
List_%cnt% = %A_LoopFileFullPath%
}
Random, Rand, 1, %cnt%
playthis := List_%Rand%
SoundPlay, %playthis%, 1

SendMessage,0x112,0xF170,-1,,Program Manager ;开启显示器
BlockInput,Off
ToolTip,移动鼠标来恢复
MouseGetPos,oldx,oldy ;获得指针的位置并赋值给oldx和oldy变量

MOUSE:
MouseGetPos,x,y
If x=%oldx%
If y=%oldy%
Goto,MOUSE
ToolTip
}

#0::
ToolTip
Reload