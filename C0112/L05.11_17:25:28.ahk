   #NoEnv   			
   SendMode Input   		
   SetWorkingDir %A_ScriptDir%	
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
		MoveWindow(0, 50) 
	}
	else if (SizeCycle = 1) {
		MoveWindow(50, 50) 
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

MoveWindow(XP, WP) {
	; Get current Window
	WinGetActiveTitle, WinTitle
	WinGetPos, X, Y, WinWidth, WinHeight, %WinTitle%
	
	; Get Taskbar height
	WinGetPos,,, tbW, tbH, ahk_class Shell_TrayWnd
	
	; Calculate new position and size
	XNew := (A_ScreenWidth * XP / 100)
	WNew := (A_ScreenWidth * WP / 100)
	HNew := (A_ScreenHeight - tbH)
	TopNew := 2
	
	; MsgBox, %XNew% - %WNew% ; DEBUG
	WinRestore, %WinTitle%
	WinMove, %WinTitle%,, %XNew%, %TopNew%, %WNew%, %HNew%
}
;---------------------------------------------------------------------------------------
#NoEnv
#SingleInstance force
#WinActivateForce

SetTitleMatchMode, 2
SetKeyDelay, 0
CoordMode, Mouse, Relative
SetKeyDelay, 0

toggle_middle_button := 1
!x::

    if(mod(toggle_middle_button, 2) == 0) 
{
     MoveCycle(333)

    }
    else {
      MoveCycle(222)

    }
    toggle_middle_button := toggle_middle_button + 1
return
;-----------------------------------------------------------------------------------
!z::
	; Windows key + Left arrow ; Cycle left
	MoveCycle(-1)
return




