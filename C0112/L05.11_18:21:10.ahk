 Menu, Tray, Icon, E:\3\IDM v6.38.7.2 中文绿色特别版\IDM\Bin\IDMan.exe,2  
#NoEnv                             ; 不检查空变量是否为环境变量（建议所有新脚本使用）
#WinActivateForce                                     ;用强制的方法激活窗口。
#Persistent                                                              ; 让脚本持久运行（即直到用户关闭或遇到 ExitApp）
#SingleInstance                                                                    ; 避免意外的多实例
#Include D:\ahk1.0\Gdip_All.ahk
;#Include <My Altered GDIP lib> 
;~ #Include <PopUpWindow_V2> 
#SingleInstance, Force
SetBatchLines, -1
Gdip_Startup()
if( !A_IsAdmin )
	Run *RunAs "%A_ScriptFullPath%"

return

;*ESC::ExitApp 

+AppsKey::New DockIt() ;New Instance

class DockIt extends Commands	{
	;Written By: Hellbent
	;Date Started: Apr 20th, 2022
	;Date of Last Edit: Apr 23rd, 2022
	static init := DockIt._SetUp()
	_SetUp(){
		local bd := func( "DockIt._OnExit" ).Bind( this )
		OnExit( bd )
		This.DockedWindowCount := 0
		This.ActiveWindow := ""
		This.MouseTimer := This._MouseHover.Bind( This )
		This.Index := 0
		This.Handles := []
		This.Docks := []
		This.Tabs := []
		This.ChildWindow := []
		OnMessage( 0x0204 , This._ToggleLockState.Bind( This ) )
	}
	_MouseHover(){
		local pos := This.GetMousePos()
		MouseGetPos,,, Win 
		if( !This.ActiveWindow && ( This.Tabs[ Win ].TabWindow.Hwnd = Win || This.Handles[ Win ].MainWindow.Hwnd = Win || This.ChildWindow[ win ].Child.Hwnd = win ) && ( This.Tabs[ Win ].DockedState || This.Handles[ Win ].DockedState || This.ChildWindow[ win ].DockedState ) ){
			if( This.ChildWindow[ win ].Child.Hwnd = win ){
				This.ActiveWindow := This.ChildWindow[ win ].MainWindow.Hwnd
			}else if( This.Tabs[ Win ].TabWindow.Hwnd = Win ){
				if( This.Tabs[ Win ].LockState = 3 )
					return
				Try{
					This.ActiveWindow := This.Tabs[ Win ].MainWindow.Hwnd
					This.Tabs[ Win ].TabWindow.ClearWindow( 1 )
					This.Tabs[ Win ].MainWindow.ShowWindow()
				}
			}else if( This.Handles[ Win ].MainWindow.Hwnd = Win ){
				This.ActiveWindow := This.Handles[ Win ].MainWindow.Hwnd
			}
		}else if( This.ActiveWindow && Win != This.ActiveWindow ){
			if( This.Handles[ This.ActiveWindow ].Child.Hwnd = Win ){
				return
			}
			if( ( This.Tabs[ This.ActiveWindow ].LockState = 2 || This.Handles[ This.ActiveWindow ].LockState = 2 ) ){
				This.ActiveWindow := ""
				return
			}
			if( !This.Tabs[ This.ActiveWindow ].DockedState && !This.Handles[ This.ActiveWindow ].DockedState )
				return
			if( This.Tabs[ This.ActiveWindow ].MainWindow.Hwnd ){
				Try{
					This.Tabs[ This.ActiveWindow ].MainWindow.HideWindow()
					This.Tabs[ This.ActiveWindow ].TabWindow.X := This.Tabs[ This.ActiveWindow ].MainWindow.X
					This.Tabs[ This.ActiveWindow ].TabWindow.Y := This.Tabs[ This.ActiveWindow ].MainWindow.Y
					if( This.Tabs[ This.ActiveWindow ].DockPosition = 3 ){
						This.Tabs[ This.ActiveWindow ].TabWindow.X := A_ScreenWidth - 24
					}
					This.Tabs[ This.ActiveWindow ]._DrawTabWindow()
				}
			}else if(  This.Handles[ This.ActiveWindow ].MainWindow.Hwnd ){
				Try{
					This.Handles[ This.ActiveWindow ].MainWindow.HideWindow()
					This.Handles[ This.ActiveWindow ].TabWindow.X := This.Handles[ This.ActiveWindow ].MainWindow.X
					This.Handles[ This.ActiveWindow ].TabWindow.Y := This.Handles[ This.ActiveWindow ].MainWindow.Y
					if( This.Handles[ This.ActiveWindow ].DockPosition = 3 ){
						This.Handles[ This.ActiveWindow ].TabWindow.X := A_ScreenWidth - 24
					}
					This.Handles[ This.ActiveWindow ]._DrawTabWindow()
				}
			}
			This.ActiveWindow := ""
		}
	}
	_ToggleLockState( p1 , p2 , msg , hwnd ){
		if( !This.Handles[ hwnd ].DockedState && !This.Tabs[ hwnd ].DockedState )
			return
		if( This.Handles[ hwnd ].DockedState ){
			This.ActiveWindow := hwnd
			( ++This.Handles[ hwnd ].LockState > 3 ) ? ( This.Handles[ hwnd ].LockState := 1 )
			This.Handles[ hwnd ]._DrawCenterPanel()
			This.Handles[ hwnd ]._ReSizeMainWindow()
		}else if( This.Tabs[ hwnd ].DockedState ){
			This.ActiveWindow := This.Tabs[ hwnd ].MainWindow.Hwnd
			( ++This.Tabs[ hwnd ].LockState > 3 ) ? ( This.Tabs[ hwnd ].LockState := 1 )
			This.Tabs[ hwnd ]._DrawCenterPanel()
			This.Tabs[ hwnd ]._ReSizeMainWindow()
		}
	}
	__New( color := "22262a" ){
		local bd 
		if( !DockIt.Index ){
			bd := This.MouseTimer
			SetTimer, % bd , 200
		}
		This.FT := 1
		This.DockPosition := 0
		
		This.TabState := 0
		This.MoreState := 0
		This.DockedState := 0
		This.LockState := 1
		
		This.LockColors := []
		This.LockColors[ 1 ] := "0x9900FF00"
		This.LockColors[ 2 ] := "0xaaFFFF00"
		This.LockColors[ 3 ] := "0x99FF0000"
		
		;~ This.Color := "22262a"
		;~ This.Color := "02060a"
		;~ This.Color := "880000"
		This.Color := color
		
		This.Alpha := "99"
		
		This.FontColorTop := "0xcc67D5D6"
		This.FontColorBottom := "0xaa000000"
		
		This.Margin := {}
		This.Margin.X := 4
		This.Margin.Y := 4
		
		This.MinWidth := 185 + 2 * This.Margin.X
		
			;Create the main window
		This._CreateMainWindow()
		
			;Set the child window and the crop area.
		This._GetChild()
		
			;Create the top part of the main window and its controls
		This._CreateHeaderPanel()
	
			;Create the center panel and its controls
		This._CreateCenterPanel()
		
			;Create the inner panel ( the parent of the target window )
		This._CreateInnerPanel()
		
			;Create the options panel and its controls
		This._CreateOptionsPanel()
		
			;Create the small tab window that replaces the main window when in tab form.
		This._CreateTabWindow()
		
			;Resize the main window
		This._ResizeMainWindow()
		
		DockIt.Docks[ ++DockIt.Index ] := This
		DockIt.Handles[ This.MainWindow.Hwnd ] := This
		DockIt.Tabs[ This.TabWindow.Hwnd ] := This
		DockIt.ChildWindow[ This.Child.Hwnd ] := This
		
		This._SetChild()
		This._MoveChild()
		
	}
	_SetChild(){
		try{
			DllCall("SetParent", "uint", This.Child.Hwnd , "uint", This.InnerPanel.Hwnd )
			WinSet, AlwaysOnTop, On, % "ahk_id " This.Child.Hwnd
		}
	}
	_MoveChild(){
		WinMove, % "ahk_id " This.Child.Hwnd ,, % This.Clip.X , % This.Clip.Y ;, % This.Clip.W , % This.Clip.H
		WinSet, Redraw ,, % "ahk_id " This.Child.Hwnd
	}
	_GetChild(){
		This.Child := {}
		This.Child.Positions := {}
		While( !GetKeyState( "ctrl" ) ){
			ToolTip, press "ctrl".
			sleep, 30
		}
		ToolTip, 
		This.Child.Hwnd := This.GetWinHwnd()
		This.Child.Title := This.GetWinTitle( This.Child.Hwnd )
		This.Child.Positions.Start := This.GetWinPos( This.Child.Hwnd )
		While( GetKeyState( "ctrl" ) )
			sleep, 30
		This.Child.Positions.ClipStart := New DrawTarget()
		This.Child.Positions.Offset := {}
		This.Child.Positions.Offset.X := This.Child.Positions.ClipStart.X - This.Child.Positions.Start.X
		This.Child.Positions.Offset.Y := This.Child.Positions.ClipStart.Y - This.Child.Positions.Start.Y
		This.Clip := {}
		This.Clip.W := This.Child.Positions.ClipStart.W
		This.Clip.H := This.Child.Positions.ClipStart.H
		if( This.Clip.W < ( This.MinWidth - 2 * This.Margin.X ) )
			This.Clip.W := This.MinWidth - 2 * This.Margin.X
		This.Clip.X := This.Child.Positions.Offset.X * -1
		This.Clip.Y := This.Child.Positions.Offset.Y * -1
	}
	_ReSizeMainWindow(){
		This.MainWindow.W := This.Clip.W + ( 2 * This.Margin.X )
		if( This.FT && !This.FT := !This.FT ){
			This.MainWindow.X := A_ScreenWidth - This.MainWindow.W - This.Margin.X
			This.MainWindow.Y := 120
		}
		if( This.TabState ){
			This.MainWindow.H := This.HeaderPanel.H 
			This.MainWindow.UpdateSettings( "" , 1 )
			
		}else if( This.MoreState ){
			This.MainWindow.H := This.HeaderPanel.H + This.CenterPanel.H + This.OptionsPanel.H 
			This.MainWindow.UpdateSettings( "" , 1 )
		}else{
			This.MainWindow.H := This.HeaderPanel.H + This.CenterPanel.H 
			This.MainWindow.UpdateSettings( "" , 1 )
		}
		This._DrawMainWindow()
	}
	_ToggleTabState(){
		if( This.DockedState )
			return
		This.TabState := !This.TabState
		This._ReSizeMainWindow()
	}
	_ToggleMoreState( p1 , p2 , state := 0 ){
		This.MoreState := !This.MoreState 
		( state ) ? ( This.MoreState := state - 1 )
		This._DrawCenterPanel()
		This._ReSizeMainWindow()
		
	}
	_MoveDock(){
		local pos , Wpos
		PostMessage, 0xA1, 2,,, % "ahk_id " This.MainWindow.Hwnd
		While( GetKeyState( "LButton" ) )
			Sleep, 30
		Wpos := This.GetWinPos( This.MainWindow.Hwnd )
		This.MainWindow.UpdateSettings( { X: Wpos.X , Y: Wpos.Y , W: Wpos.W , H: Wpos.H } , 1 )
		pos := This.GetMousePos()
		This.DockedState := 0
		if( pos.X < 10 || pos.X > ( A_ScreenWidth - 10 ) || pos.Y < 10 ){
			
			This.TabState := 0
			This.DockedState := 1
			
			SoundBeep
			if( pos.Y < 10 ){
				This.DockPosition := 2
				This.TabWindow.W := 170
				This.TabWindow.H := 24
				This.TabWindow.UpdateSettings( "" , 1 )
			}else if( pos.X < 10 ){
				This.DockPosition := 1
				pos := This.GetMousePos()
				This.MainWindow.X := 0
				This.MainWindow.Y := pos.Y ;- This.MainWindow.H / 2
				( This.MainWindow.Y < 0 ) ? ( This.MainWindow.Y := 0 )
				
				This.TabWindow.W := 24
				This.TabWindow.H := 170
				This.TabWindow.UpdateSettings( "" , 1 )
				This._DrawMainWindow()
			}else if( pos.X > A_ScreenWidth - 20 ){
				This.DockPosition := 3
				This.TabWindow.W := 24
				This.TabWindow.H := 170
				This.TabWindow.UpdateSettings( "" , 1 )
				pos := This.GetMousePos()
				This.MainWindow.X := A_ScreenWidth - This.MainWindow.W 
				This.MainWindow.Y := pos.Y ;- This.MainWindow.H / 2
				( This.MainWindow.Y < 0 ) ? ( This.MainWindow.Y := 0 )
				This._DrawMainWindow()
			}
			DockIt.ActiveWindow := This.MainWindow.Hwnd
			This.LockState := 1
		}else if( This.DockedState ){
			This.DockedState := 0
			DockIt.ActiveWindow := ""
			This.LockState := 1
		}
		This._DrawCenterPanel()
		This._ReSizeMainWindow()
	}
	_CloseWindow(){
		DockIt.ActiveWindow := ""
		try{
			DllCall("SetParent", "uint", This.Child.Hwnd , "uint", 0 )
			WinSet, AlwaysOnTop, Off , % "ahk_id " This.Child.Hwnd
			WinMove, % "ahk_id " This.Child.Hwnd ,, % This.Child.Positions.Start.X , % This.Child.Positions.Start.Y
		}
		This.TabWindow.DeleteWindow()
		This.HeaderPanel.DeleteWindow()
		This.CenterPanel.DeleteWindow()
		This.OptionsPanel.DeleteWindow()
		This.MainWindow.DeleteWindow()
	}
	_OnExit(){
		local count
		if( !DockIt.Index ){
			return
		}
		try{
			Loop, % count := DockIt.Docks.Length(){
				DockIt.Docks[ count-- ]._CloseWindow()
			}
		}
		SoundBeep
	}
}

class DockItWindows	{
	_CreateMainWindow(){
		This.MainWindow := {}
		This.MainWindow.X := 0
		This.MainWindow.Y := 0
		This.MainWindow.W := 0
		This.MainWindow.H := 0
		This.MainWindow.AutoShow := 1
		This.MainWindow.Options := " +AlwaysOnTop -DPIScale +ToolWindow "
		This.MainWindow := New PopUpWindow( This.MainWindow )
	}
	_CreateHeaderPanel(){
		local k , v , hwnd , bd , cc 
		This.HeaderPanel := {}
		This.HeaderPanel.X := 0
		This.HeaderPanel.Y := 0
		This.HeaderPanel.W := This.Clip.W + ( 2 * This.Margin.X )
		This.HeaderPanel.H := 2 * This.Margin.Y + 18
		This.HeaderPanel.AutoShow := 1
		This.HeaderPanel.Options := " -DPIScale +Parent" This.MainWindow.Hwnd
		This.HeaderPanel := New PopUpWindow( This.HeaderPanel )
		
		This.HeaderPanel.Controls := {}
		
		This.HeaderPanel.Controls.MoveButton := {}
		This.HeaderPanel.Controls.MoveButton.X := This.Margin.X
		This.HeaderPanel.Controls.MoveButton.Y := This.Margin.Y
		This.HeaderPanel.Controls.MoveButton.W := This.HeaderPanel.W - 30 - 20 - 4 * This.Margin.X
		This.HeaderPanel.Controls.MoveButton.H := This.HeaderPanel.H - 2 * This.Margin.Y
		This.HeaderPanel.Controls.MoveButton.Method := "_MoveDock"
		
		This.HeaderPanel.Controls.MinimizeButton := {}
		This.HeaderPanel.Controls.MinimizeButton.X := This.HeaderPanel.W - 2 * This.Margin.X - 30 - 20
		This.HeaderPanel.Controls.MinimizeButton.Y := This.Margin.Y
		This.HeaderPanel.Controls.MinimizeButton.W := 30
		This.HeaderPanel.Controls.MinimizeButton.H := This.HeaderPanel.H - 2 * This.Margin.Y
		This.HeaderPanel.Controls.MinimizeButton.Method := "_ToggleTabState"
		
		This.HeaderPanel.Controls.CloseButton := {}
		This.HeaderPanel.Controls.CloseButton.X := This.HeaderPanel.W - 20 - This.Margin.X
		This.HeaderPanel.Controls.CloseButton.Y := This.Margin.Y
		This.HeaderPanel.Controls.CloseButton.W := 20
		This.HeaderPanel.Controls.CloseButton.H := This.HeaderPanel.H - 2 * This.Margin.Y
		This.HeaderPanel.Controls.CloseButton.Method := "_CloseWindow"
		
		This.HeaderPanel.Text := This.Child.Title
		This.HeaderPanel.Color := "0x" This.Alpha This.Color
		This.HeaderPanel.FontColorTop := This.FontColorTop
		This.HeaderPanel.FontColorBottom := This.FontColorBottom
		
		for k, v in This.HeaderPanel.Controls	{
			cc := This.HeaderPanel.Controls[ k ]
			Gui, % This.HeaderPanel.Hwnd ":Add", Text, % "x" cc.X " y" cc.Y " w" cc.W " h" cc.H " hwndhwnd"
			cc.Hwnd := hwnd
			bd := This[ cc.Method ].Bind( This )
			GuiControl, % This.HeaderPanel.Hwnd ":+G", % hwnd, % bd 
		}
			
		This._DrawHeaderPanel()
	}
	_CreateCenterPanel(){
		This.CenterPanel := {}
		This.CenterPanel.X := 0
		This.CenterPanel.Y := This.HeaderPanel.H
		This.CenterPanel.W := This.Clip.W + 2 * This.Margin.X 
		This.CenterPanel.H := This.Clip.H + 3 * This.Margin.Y + 18
		This.CenterPanel.AutoShow := 1
		This.CenterPanel.Options := " -DPIScale +Parent" This.MainWindow.Hwnd
		This.CenterPanel := New PopUpWindow( This.CenterPanel )
		This.CenterPanel.MoreButton := {}
		This.CenterPanel.MoreButton.X := This.Margin.X
		This.CenterPanel.MoreButton.Y := This.Clip.H + 2 * This.Margin.Y
		This.CenterPanel.MoreButton.W := 60
		This.CenterPanel.MoreButton.H := 18
		This.CenterPanel.MoreButton.Method := "_ToggleMoreState"
		
		cc := This.CenterPanel.MoreButton
		Gui, % This.CenterPanel.Hwnd ":Add", Text, % "x" cc.X " y" cc.Y " w" cc.W " h" cc.H " hwndhwnd"
		cc.Hwnd := hwnd
		bd := This[ cc.Method ].Bind( This )
		GuiControl, % This.CenterPanel.Hwnd ":+G", % hwnd, % bd 
		
		
		This._DrawCenterPanel()
	}
	_CreateInnerPanel(){
		This.InnerPanel := {}
		This.InnerPanel.X := This.Margin.X 
		This.InnerPanel.Y := This.Margin.Y
		This.InnerPanel.W := This.Clip.W
		This.InnerPanel.H := This.Clip.H
		This.InnerPanel.Options := " -Caption -DPIScale +Parent" This.CenterPanel.Hwnd " +E0x02000000 +E0x00080000 "
		Gui, New, % This.InnerPanel.Options " hwndhwnd"
		This.InnerPanel.Hwnd := hwnd
		Gui, Color, % This.Color
		Gui, Show, % "x" This.InnerPanel.X " y" This.InnerPanel.Y " w" This.InnerPanel.W " h" This.InnerPanel.H " NA"
	}
	_CreateOptionsPanel(){
		This.OptionsPanel := {}
		This.OptionsPanel.X := 0
		This.OptionsPanel.Y := This.HeaderPanel.H + This.CenterPanel.H
		This.OptionsPanel.W := 220
		This.OptionsPanel.H := 180
		This.OptionsPanel.AutoShow := 1
		This.OptionsPanel.Options := " -DPIScale +Parent" This.MainWindow.Hwnd
		This.OptionsPanel := New PopUpWindow( This.OptionsPanel )
		
		This.OptionsPanel.ButtonSize := 40
		This.OptionsPanel.YOffset := 15
		This.OptionsPanel.Buttons := {}
		
		This.OptionsPanel.Buttons.UpArrowButton := {}
		This.OptionsPanel.Buttons.UpArrowButton.X := This.Margin.X + This.OptionsPanel.ButtonSize + This.Margin.X
		This.OptionsPanel.Buttons.UpArrowButton.Y := This.Margin.Y + This.OptionsPanel.YOffset
		This.OptionsPanel.Buttons.UpArrowButton.W := This.OptionsPanel.ButtonSize
		This.OptionsPanel.Buttons.UpArrowButton.H := This.OptionsPanel.ButtonSize
		This.OptionsPanel.Buttons.UpArrowButton.Number := 5
		This.OptionsPanel.Buttons.UpArrowButton.Method := "_MoveUp"
		
		This.OptionsPanel.Buttons.DownArrowButton := {}
		This.OptionsPanel.Buttons.DownArrowButton.X := This.Margin.X + This.OptionsPanel.ButtonSize + This.Margin.X
		This.OptionsPanel.Buttons.DownArrowButton.Y := This.Margin.Y + This.OptionsPanel.ButtonSize + This.Margin.Y + This.OptionsPanel.YOffset
		This.OptionsPanel.Buttons.DownArrowButton.W := This.OptionsPanel.ButtonSize
		This.OptionsPanel.Buttons.DownArrowButton.H := This.OptionsPanel.ButtonSize
		This.OptionsPanel.Buttons.DownArrowButton.Number := 6
		This.OptionsPanel.Buttons.DownArrowButton.Method := "_MoveDown"
		
		This.OptionsPanel.Buttons.LeftArrowButton := {}
		This.OptionsPanel.Buttons.LeftArrowButton.X := This.Margin.X
		This.OptionsPanel.Buttons.LeftArrowButton.Y := This.Margin.Y + This.OptionsPanel.ButtonSize / 2 + This.Margin.Y / 2 + This.OptionsPanel.YOffset
		This.OptionsPanel.Buttons.LeftArrowButton.W := This.OptionsPanel.ButtonSize
		This.OptionsPanel.Buttons.LeftArrowButton.H := This.OptionsPanel.ButtonSize
		This.OptionsPanel.Buttons.LeftArrowButton.Number := 3
		This.OptionsPanel.Buttons.LeftArrowButton.Method := "_MoveLeft"
		
		This.OptionsPanel.Buttons.RightArrowButton := {}
		This.OptionsPanel.Buttons.RightArrowButton.X := This.Margin.X + This.OptionsPanel.ButtonSize + This.Margin.X + This.OptionsPanel.ButtonSize + This.Margin.X
		This.OptionsPanel.Buttons.RightArrowButton.Y := This.Margin.Y + This.OptionsPanel.ButtonSize / 2 + This.Margin.Y / 2 + This.OptionsPanel.YOffset
		This.OptionsPanel.Buttons.RightArrowButton.W := This.OptionsPanel.ButtonSize
		This.OptionsPanel.Buttons.RightArrowButton.H := This.OptionsPanel.ButtonSize
		This.OptionsPanel.Buttons.RightArrowButton.Number := 4
		This.OptionsPanel.Buttons.RightArrowButton.Method := "_MoveRight"
		

		
		for k, v in This.OptionsPanel.Buttons	{
			cc := This.OptionsPanel.Buttons[ k ]
			Gui, % This.OptionsPanel.Hwnd ":Add", Text, % "x" cc.X " y" cc.Y " w" cc.W " h" cc.H " hwndhwnd"
			cc.Hwnd := hwnd
			bd := This[ cc.Method ].Bind( This )
			GuiControl, % This.OptionsPanel.Hwnd ":+G", % hwnd, % bd 
		}
			
		
		This._DrawOptionsPanel()
	}
	_CreateTabWindow(){
		This.TabWindow := {}
		This.TabWindow.X := 0
		This.TabWindow.Y := 0
		This.TabWindow.W := 170
		This.TabWindow.H := 24
		This.TabWindow.AutoShow := 1
		This.TabWindow.Options := " +AlwaysOnTop -DPIScale +ToolWindow "
		This.TabWindow := New PopUpWindow( This.TabWindow )
	}
	_MoveUp(){
		if( GetKeyState( "ctrl" ) )
			This.Clip.Y -= 100
		else if( GetKeyState( "shift" ) )
			This.Clip.Y -= 10
		else
			This.Clip.Y -= 1
		This._MoveChild()
	}
	_MoveDown(){
		if( GetKeyState( "ctrl" ) )
			This.Clip.Y += 100
		else if( GetKeyState( "shift" ) )
			This.Clip.Y += 10
		else
			This.Clip.Y += 1
		This._MoveChild()
	}
	_MoveLeft(){
		if( GetKeyState( "ctrl" ) )
			This.Clip.X -= 100
		else if( GetKeyState( "shift" ) )
			This.Clip.X -= 10
		else
			This.Clip.X -= 1
		This._MoveChild()
	}
	_MoveRight(){
		if( GetKeyState( "ctrl" ) )
			This.Clip.X += 100
		else if( GetKeyState( "shift" ) )
			This.Clip.X += 10
		else
			This.Clip.X += 1
		This._MoveChild()
	}
	
}

class DockItDraw extends DockItWindows {
	_DrawCenterPanel(){
		local x , y , w , h 
		This.CenterPanel.ClearWindow()
		;move button / banner
		x := This.CenterPanel.MoreButton.X
		y := This.CenterPanel.MoreButton.Y
		w := This.CenterPanel.MoreButton.W
		h := This.CenterPanel.MoreButton.H
		Brush := Gdip_CreateLineBrushFromRect( x , y , w , h , "0x9900aaff" , "0x99222222" , 1 , 1 ) , Gdip_FillRoundedRectangle( This.CenterPanel.G , Brush , x , y , w , h , 3 ) , Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0x99" This.Color ) , Gdip_FillRoundedRectangle( This.CenterPanel.G , Brush , x + 2  , y + 2 , w - 4  , h - 4 , 3 ) , Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.FontColorBottom ) , Gdip_TextToGraphics( This.CenterPanel.G , ( !This.MoreState ) ? ( "More" ) : ( "Less" ) , "s" 12 " Center vCenter NoWrap Bold c" Brush " x" x + 1 " y" y + 1  , "Segoe ui" , w  , h ) , Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.FontColorTop ) , Gdip_TextToGraphics( This.CenterPanel.G , ( !This.MoreState ) ? ( "More" ) : ( "Less" ) , "s" 12 " Center vCenter NoWrap Bold c" Brush " x" x " y" y  , "Segoe ui" , w  , h ) , Gdip_DeleteBrush( Brush )
		;~ ToolTip, % "Tip:`n" 
		if( This.DockedState ){
			;~ ToolTip, % "Tip:`n" 
			x := This.CenterPanel.W - This.Margin.X - 18
			y := This.CenterPanel.MoreButton.Y
			w := This.CenterPanel.MoreButton.H
			h := This.CenterPanel.MoreButton.H
			Brush := Gdip_CreateLineBrushFromRect( x , y , w , h , "0x9900aaff" , "0x99222222" , 1 , 1 ) , Gdip_FillRoundedRectangle( This.CenterPanel.G , Brush , x , y , w , h , 3 ) , Gdip_DeleteBrush( Brush )
			Brush := Gdip_BrushCreateSolid( This.LockColors[ This.LockState ] ) , Gdip_FillRoundedRectangle( This.CenterPanel.G , Brush , x + 2  , y + 2 , w - 4  , h - 4 , 3 ) , Gdip_DeleteBrush( Brush )
		
		}
		
		
		Brush := Gdip_BrushCreateSolid( "0x99" This.Color ) , Gdip_FillRoundedRectangle( This.CenterPanel.G , Brush , This.InnerPanel.X  , This.InnerPanel.Y , This.InnerPanel.W  , This.InnerPanel.H , 3 ) , Gdip_DeleteBrush( Brush )
		
		
		This.CenterPanel.UpdateWindow()
	}
	_DrawMainWindow(){
		This.MainWindow.ClearWindow()
		Brush := Gdip_BrushCreateSolid( "0x" This.Alpha This.Color ) , Gdip_FillRoundedRectangle( This.MainWindow.G , Brush , 0 , 0 , This.MainWindow.W , This.MainWindow.H , 5 ) , Gdip_DeleteBrush( Brush )
		This.MainWindow.UpdateWindow()
	}
	_DrawOptionsPanel(){
		local y , cc
		This.OptionsPanel.ClearWindow()
		
		for k , v in This.OptionsPanel.Buttons	{
			cc := This.OptionsPanel.Buttons[ k ]
			Brush := Gdip_CreateLineBrushFromRect( cc.X , cc.Y , cc.W , cc.H , "0x9900aaff" , "0x99222222" , 1 , 1 ) , Gdip_FillRoundedRectangle( This.OptionsPanel.G , Brush , cc.X , cc.Y , cc.W , cc.H , 5 ) , Gdip_DeleteBrush( Brush )
			Brush := Gdip_BrushCreateSolid( "0x" This.Alpha This.Color ) , Gdip_FillRoundedRectangle( This.OptionsPanel.G , Brush , cc.X + 1 , cc.Y + 1 , cc.W - 2 , cc.H - 2 , 5 ) , Gdip_DeleteBrush( Brush )
			Pen := Gdip_CreatePen( "0x9967D5D6" , 1 ) , Gdip_DrawRectangle( This.OptionsPanel.G , Pen , cc.X + 5 , cc.Y + 5 , cc.W - 10 , cc.H - 12 ) , Gdip_DeletePen( Pen )
			Brush := Gdip_BrushCreateSolid( "0x99000000" ) , Gdip_TextToGraphics( This.OptionsPanel.G , cc.Number , "s" 24 " Center vCenter Bold c" Brush " x" cc.X + 1 " y" cc.Y + 2 , "WebDings" , cc.W , cc.H ) , Gdip_DeleteBrush( Brush )
			Brush := Gdip_BrushCreateSolid( "0x9967D5D6" ) , Gdip_TextToGraphics( This.OptionsPanel.G , cc.Number , "s" 24 " Center vCenter Bold c" Brush " x" cc.X " y" cc.Y + 1 , "WebDings" , cc.W , cc.H ) , Gdip_DeleteBrush( Brush )
		
		}
		
		Brush := Gdip_BrushCreateSolid( "0x99000000" ) , Gdip_TextToGraphics( This.OptionsPanel.G , "+ = 10 ^ = 100 " , "s" 12 "  vCenter Bold c" Brush " x" 141 " y" 36  , "Segoe ui" , 50 , 50 ) , Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xaa67D5D6" ) , Gdip_TextToGraphics( This.OptionsPanel.G , "+ = 10 ^ = 100 " , "s" 12 "  vCenter Bold c" Brush " x" 140 " y" 35  , "Segoe ui" , 50 , 50 ) , Gdip_DeleteBrush( Brush )
		
		;slider 1
		y := 120
		Brush := Gdip_CreateLineBrushFromRect( This.Margin.X , y , 130 , 20 , "0x9900aaff" , "0x99222222" , 1 , 1 ) , Gdip_FillRoundedRectangle( This.OptionsPanel.G , Brush , This.Margin.X , y , 130 , 20 , 5 ) , Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0x99" This.Color ) , Gdip_FillRoundedRectangle( This.OptionsPanel.G , Brush , This.Margin.X + 1 , y + 1 , 128 , 18 , 5 ) , Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0x9967D5D6" ) , Gdip_FillRectangle( This.OptionsPanel.G , Brush , This.Margin.X + 10 , y + 8 , 110 , 4 ) , Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( This.Margin.X + 21 , y + 3 , 14 , 14 , "0xaa67D5D6" , "0x99222222" , 1 , 1 ) , Gdip_FillRoundedRectangle( This.OptionsPanel.G , Brush , This.Margin.X + 21 , y + 3 , 14 , 14 , 3 ) , Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0x99" This.Color ) , Gdip_FillRoundedRectangle( This.OptionsPanel.G , Brush , This.Margin.X + 22 , y + 4 , 12 , 12 , 3 ) , Gdip_DeleteBrush( Brush )
		
		;slider 2
		y := 150
		Brush := Gdip_CreateLineBrushFromRect( This.Margin.X , y , 130 , 20 , "0xCC00aaff" , "0x99222222" , 1 , 1 ) , Gdip_FillRoundedRectangle( This.OptionsPanel.G , Brush , This.Margin.X , y , 130 , 20 , 5 ) , Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0x99" This.Color ) , Gdip_FillRoundedRectangle( This.OptionsPanel.G , Brush , This.Margin.X + 1 , y + 1 , 128 , 18 , 5 ) , Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0x9967D5D6" ) , Gdip_FillRectangle( This.OptionsPanel.G , Brush , This.Margin.X + 10 , y + 8 , 110 , 4 ) , Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( This.Margin.X + 21 , y + 3 , 14 , 14 , "0xaa67D5D6" , "0x99222222" , 1 , 1 ) , Gdip_FillRoundedRectangle( This.OptionsPanel.G , Brush , This.Margin.X + 21 , y + 3 , 14 , 14 , 3 ) , Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0x99" This.Color ) , Gdip_FillRoundedRectangle( This.OptionsPanel.G , Brush , This.Margin.X + 22 , y + 4 , 12 , 12 , 3 ) , Gdip_DeleteBrush( Brush )
		
		Brush := Gdip_BrushCreateSolid( "0x99000000" ) , Gdip_TextToGraphics( This.OptionsPanel.G , "Width" , "s" 12 " vCenter Bold c" Brush " x" This.Margin.X + 140  " y" 116  , "Segoe ui" , 50 , 30 ) , Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xaa67D5D6" ) , Gdip_TextToGraphics( This.OptionsPanel.G , "Width" , "s" 12 " vCenter Bold c" Brush " x" This.Margin.X + 139 " y" 115  , "Segoe ui" , 50 , 30 ) , Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0x99000000" ) , Gdip_TextToGraphics( This.OptionsPanel.G , "Height" , "s" 12 " vCenter Bold c" Brush " x" This.Margin.X + 140 " y" 146  , "Segoe ui" , 50 , 30 ) , Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xaa67D5D6" ) , Gdip_TextToGraphics( This.OptionsPanel.G , "Height" , "s" 12 " vCenter Bold c" Brush " x" This.Margin.X + 139 " y" 145  , "Segoe ui" , 50 , 30 ) , Gdip_DeleteBrush( Brush )
		
		This.OptionsPanel.UpdateWindow()
	}
	_DrawHeaderPanel(){
		local w , x , y , h
		This.HeaderPanel.ClearWindow()
		;************
		;~ Brush := Gdip_BrushCreateSolid( "0x33" This.Color ) , Gdip_FillRoundedRectangle( This.HeaderPanel.G , Brush , 0 , 0 , This.HeaderPanel.W , This.HeaderPanel.H , 5 ) , Gdip_DeleteBrush( Brush )
		;************
		;move button / banner
		x := This.HeaderPanel.Controls.MoveButton.X
		y := This.HeaderPanel.Controls.MoveButton.Y
		w := This.HeaderPanel.Controls.MoveButton.W
		h := This.HeaderPanel.Controls.MoveButton.H
		Brush := Gdip_CreateLineBrushFromRect( x , y , w , h , "0x9900aaff" , "0x99222222" , 1 , 1 ) , Gdip_FillRoundedRectangle( This.HeaderPanel.G , Brush , x , y , w , h , 3 ) , Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0x99" This.Color ) , Gdip_FillRoundedRectangle( This.HeaderPanel.G , Brush , x + 2  , y + 2 , w - 4  , h - 4 , 3 ) , Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.FontColorBottom ) , Gdip_TextToGraphics( This.HeaderPanel.G , This.Child.Title , "s" 12 " Left vCenter NoWrap Bold c" Brush " x" x + 6 " y" y + 3  , "Segoe ui" , w - 10 , h - 4 ) , Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.FontColorTop ) , Gdip_TextToGraphics( This.HeaderPanel.G , This.Child.Title , "s" 12 " Left vCenter NoWrap Bold c" Brush " x" x + 5 " y" y + 2  , "Segoe ui" , w - 10 , h - 4 ) , Gdip_DeleteBrush( Brush )
		;tab button
		x := This.HeaderPanel.Controls.MinimizeButton.X
		y := This.HeaderPanel.Controls.MinimizeButton.Y
		w := This.HeaderPanel.Controls.MinimizeButton.W
		h := This.HeaderPanel.Controls.MinimizeButton.H
		Brush := Gdip_CreateLineBrushFromRect( x , y , w , h , "0x9900aaff" , "0x99222222" , 1 , 1 ) , Gdip_FillRoundedRectangle( This.HeaderPanel.G , Brush , x , y , w , h , 3 ) , Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0x99" This.Color ) , Gdip_FillRoundedRectangle( This.HeaderPanel.G , Brush , x + 2  , y + 2 , w - 4  , h - 4 , 3 ) , Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.FontColorBottom ) , Gdip_TextToGraphics( This.HeaderPanel.G , "+/-" , "s" 12 " Left vCenter NoWrap Bold c" Brush " x" x + 6 " y" y + 3  , "Segoe ui" , w , h - 4 ) , Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.FontColorTop ) , Gdip_TextToGraphics( This.HeaderPanel.G , "+/-" , "s" 12 " Left vCenter NoWrap Bold c" Brush " x" x + 5 " y" y + 2  , "Segoe ui" , w , h - 4 ) , Gdip_DeleteBrush( Brush )
		;close button
		x := This.HeaderPanel.Controls.CloseButton.X
		y := This.HeaderPanel.Controls.CloseButton.Y
		w := This.HeaderPanel.Controls.CloseButton.W
		h := This.HeaderPanel.Controls.CloseButton.H
		Brush := Gdip_CreateLineBrushFromRect( x , y , w , h , "0x9900aaff" , "0x99222222" , 1 , 1 ) , Gdip_FillRoundedRectangle( This.HeaderPanel.G , Brush , x , y , w , h , 3 ) , Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0x99" This.Color ) , Gdip_FillRoundedRectangle( This.HeaderPanel.G , Brush , x + 2  , y + 2 , w - 4  , h - 4 , 3 ) , Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.FontColorBottom ) , Gdip_TextToGraphics( This.HeaderPanel.G , "X" , "s" 10 " Center vCenter NoWrap Bold c" Brush " x" x + 1 " y" y + 3  , "Segoe ui" , w , h - 4 ) , Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.FontColorTop ) , Gdip_TextToGraphics( This.HeaderPanel.G , "X" , "s" 10 " Center vCenter NoWrap Bold c" Brush " x" x  " y" y + 2  , "Segoe ui" , w , h - 4 ) , Gdip_DeleteBrush( Brush )
		This.HeaderPanel.UpdateWindow()
	}
	_DrawTabWindow(){
		This.TabWindow.ClearWindow()
		;~ Brush := Gdip_BrushCreateSolid( "0x99" This.Color ) , Gdip_FillRoundedRectangle( This.TabWindow.G , Brush , 0  , 0 , 200  , 200 , 3 ) , Gdip_DeleteBrush( Brush )
		
		if( This.DockPosition = 1 ){
			
			Brush := Gdip_CreateLineBrushFromRect( 0 , 1 , 24 , 160 , "0x9900aaff" , "0x99222222" , 0 , 1 ) , Gdip_FillRoundedRectangle( This.TabWindow.G , Brush , 1 , 1 , 20 , 160 , 5 ) , Gdip_DeleteBrush( Brush )
			Brush := Gdip_BrushCreateSolid( "0x99" This.Color ) , Gdip_FillRoundedRectangle( This.TabWindow.G , Brush , 3 , 3 , 16 , 156 , 5 ) , Gdip_DeleteBrush( Brush )
			Brush := Gdip_CreateLineBrushFromRect( 6 , 2 , 9 , 24 , "0x9900aaff" , "0x99222222" , 2 , 1 ) , Gdip_FillRoundedRectangle( This.TabWindow.G , Brush , 5 , 5 , 12 , 20 , 3 ) , Gdip_DeleteBrush( Brush )
			Brush := Gdip_BrushCreateSolid( This.LockColors[ This.LockState ] ) , Gdip_FillRoundedRectangle( This.TabWindow.G , Brush , 6 , 6 , 10 , 18 , 3 ) , Gdip_DeleteBrush( Brush )
			Brush := Gdip_BrushCreateSolid( This.FontColorBottom ) , Gdip_TextToGraphics( This.TabWindow.G , This.Child.Title , "s" 12 " Center  Bold c" Brush " x" 7 " y" 31  , "Segoe ui" , 11 , 116 ) , Gdip_DeleteBrush( Brush )
			Brush := Gdip_BrushCreateSolid( This.FontColorTop ) , Gdip_TextToGraphics( This.TabWindow.G , This.Child.Title , "s" 12 " Center  Bold c" Brush " x" 6 " y" 30  , "Segoe ui" , 11 , 116 ) , Gdip_DeleteBrush( Brush )
			
		}else if( This.DockPosition = 2 ){
			Brush := Gdip_CreateLineBrushFromRect( 2 , 2 , 163 , 19 , "0x9900aaff" , "0x99222222" , 1 , 1 ) , Gdip_FillRoundedRectangle( This.TabWindow.G , Brush , 1 , 1 , 166 , 20 , 5 ) , Gdip_DeleteBrush( Brush )
			Brush := Gdip_BrushCreateSolid( "0x99" This.Color ) , Gdip_FillRoundedRectangle( This.TabWindow.G , Brush , 3 , 3 , 162 , 16 , 5 ) , Gdip_DeleteBrush( Brush )
			Brush := Gdip_CreateLineBrushFromRect( 8 , 6 , 12 , 11 , "0x9900aaff" , "0x99222222" , 1 , 1 ) , Gdip_FillRoundedRectangle( This.TabWindow.G , Brush , 5 , 5 , 16 , 12 , 3 ) , Gdip_DeleteBrush( Brush )
			Brush := Gdip_BrushCreateSolid( This.LockColors[ This.LockState ] ) , Gdip_FillRoundedRectangle( This.TabWindow.G , Brush , 6 , 6 , 14 , 10 , 3 ) , Gdip_DeleteBrush( Brush )
			Brush := Gdip_BrushCreateSolid( This.FontColorBottom ) , Gdip_TextToGraphics( This.TabWindow.G , This.Child.Title , "s" 12 " vCenter NoWrap Bold c" Brush " x" 27 " y" 3  , "Segoe ui" , 140 , 20 ) , Gdip_DeleteBrush( Brush )
			Brush := Gdip_BrushCreateSolid( This.FontColorTop ) , Gdip_TextToGraphics( This.TabWindow.G , This.Child.Title , "s" 12 " vCenter NoWrap Bold c" Brush " x" 26 " y" 2  , "Segoe ui" , 140 , 20 ) , Gdip_DeleteBrush( Brush )
		}else if( This.DockPosition = 3 ){
			
			Brush := Gdip_CreateLineBrushFromRect( 0 , 1 , 24 , 160 , "0x9900aaff" , "0x99222222" , 0 , 1 ) , Gdip_FillRoundedRectangle( This.TabWindow.G , Brush , 1 , 1 , 20 , 160 , 5 ) , Gdip_DeleteBrush( Brush )
			Brush := Gdip_BrushCreateSolid( "0x99" This.Color ) , Gdip_FillRoundedRectangle( This.TabWindow.G , Brush , 3 , 3 , 16 , 156 , 5 ) , Gdip_DeleteBrush( Brush )
			Brush := Gdip_CreateLineBrushFromRect( 6 , 2 , 9 , 24 , "0x9900aaff" , "0x99222222" , 2 , 1 ) , Gdip_FillRoundedRectangle( This.TabWindow.G , Brush , 5 , 5 , 12 , 20 , 3 ) , Gdip_DeleteBrush( Brush )
			Brush := Gdip_BrushCreateSolid( This.LockColors[ This.LockState ] ) , Gdip_FillRoundedRectangle( This.TabWindow.G , Brush , 6 , 6 , 10 , 18 , 3 ) , Gdip_DeleteBrush( Brush )
			Brush := Gdip_BrushCreateSolid( This.FontColorBottom ) , Gdip_TextToGraphics( This.TabWindow.G , This.Child.Title , "s" 12 " Center  Bold c" Brush " x" 7 " y" 31  , "Segoe ui" , 11 , 116 ) , Gdip_DeleteBrush( Brush )
			Brush := Gdip_BrushCreateSolid( This.FontColorTop ) , Gdip_TextToGraphics( This.TabWindow.G , This.Child.Title , "s" 12 " Center  Bold c" Brush " x" 6 " y" 30  , "Segoe ui" , 11 , 116 ) , Gdip_DeleteBrush( Brush )
			
			
		}
		
		This.TabWindow.UpdateWindow()
	}
	
	
}

class Commands	extends DockItDraw {
	GetWinHwnd( option := "A" ){
		return WinActive( option )
	}
	GetWinTitle( hwnd ){
		local out 
		WinGetTitle, out , % "ahk_id " hwnd
		return out
	}
	GetWinPos( hwnd ){
		local x , y , w , h 
		WinGetPos, x , y , w , h , % "ahk_id " hwnd 
		return { X: x , Y: y , W: w , H: h }
	}
	GetMousePos( mode := "Screen" ){
		local x , y 
		CoordMode, Mouse, % mode
		MouseGetPos, x , y 
		return { X: x , Y: y }
	}
}

class DrawTarget extends Commands	{
	__New(){
		local pos := This.GetMousePos()
		This.State := 0
		This.Color := "0xFFFF0000"
		This.X1 := pos.X
		This.X2 := 0
		This.Y1 := pos.Y
		This.Y2 := 0
		This.X := pos.X
		This.Y := pos.Y
		This.W := 0
		This.H := 0
		This.Gui1 := New PopUpWindow( { AutoShow: 1 , X: pos.X - 500 , Y: pos.Y - 500 , W: 1001 , H: 1001 , Options: " +AlwaysOnTop -DPIScale +ToolWindow +E0x20" } ) 
		This._SetStartingPos()
		This._SetEndingPos()
		return { X: This.X , Y: This.Y , W: This.W , H: This.H }
	}
	_SetStartingPos(){
		while( !GetKeyState( "ctrl" ) ){
			ToolTip, Press "ctrl" to set the starting position. `n`nTop left corner.
			pos := This.GetMousePos()
			This.Gui1.UpdateSettings( { X: pos.X - 501 , Y: pos.Y - 501 } )
			This.Draw()
			
			sleep, 30
		}
		This.X1 := pos.X 
		This.Y1 := pos.Y
		This.State := 1
		While( GetKeyState( "ctrl" ) )
			sleep, 30
	}
	_SetEndingPos(){
		while( !GetKeyState( "ctrl" ) ){
			ToolTip, Press "ctrl" to set the starting position. `n`nTop left corner.
			pos := This.GetMousePos()
			This.X2 := pos.X 
			This.Y2 := pos.Y
			
			( This.X1 <= This.X2 ) ? ( This.X := This.X1 , This.W := This.X2 - This.X1 ) : ( This.X := This.X2 , This.W := This.X1 - This.X2 )
			( This.Y1 <= This.Y2 ) ? ( This.Y := This.Y1 , This.H := This.Y2 - This.Y1 ) : ( This.Y := This.Y2 , This.H := This.Y1 - This.Y2 )
			This.Gui1.UpdateSettings( { X: This.X - 1 , Y: This.Y - 1 , W: This.W + 2 , H: This.H + 2 } , 1 )
			This.Draw()
			
			sleep, 30
		}
		ToolTip,
		While( GetKeyState( "ctrl" ) )
			sleep, 30
		This.Gui1.DeleteWindow()
	}
	Draw(){
		This.Gui1.ClearWindow()
		if( !This.State ){
			Pen := Gdip_CreatePen( This.Color , 1 ) , Gdip_DrawLine( This.Gui1.G , Pen , 501 , 0 , 501 , 1001 ) , Gdip_DeletePen( Pen )
			Pen := Gdip_CreatePen( This.Color , 1 ) , Gdip_DrawLine( This.Gui1.G , Pen , 0 , 501 , 1001 , 501 ) , Gdip_DeletePen( Pen )
		}else if( This.State = 1 ){
			Pen := Gdip_CreatePen( This.Color , 1 ) , Gdip_DrawRectangle( This.Gui1.G , Pen , 1 , 1  , This.W , This.H ) , Gdip_DeletePen( Pen )
		}
		This.Gui1.UpdateWindow()
	}
}

;#############################################################################          DockIt          

class PopUpWindow	{
;PopUpWindow v2.2
;Date Written: Oct 28th, 2021
;Last Edit: Feb 7th, 2022 :Changed the trigger method.
;Written By: Hellbent aka CivReborn
;SpcThanks: teadrinker , malcev 
	static Index := 0 , Windows := [] , Handles := [] , EditHwnd , HelperHwnd
	__New( obj := "" ){
		This._SetDefaults()
		This.UpdateSettings( obj )
		This._CreateWindow()
		This._CreateWindowGraphics()
		if( This.AutoShow )
			This.ShowWindow( This.Title )
	}
	_SetDefaults(){
		This.X := 10
		This.Y := 10
		This.W := 10
		This.H := 10
		This.Smoothing := 2
		This.Options := " -DPIScale +AlwaysOnTop "
		This.AutoShow := 0
		This.GdipStartUp := 0
		This.Title := ""
		
		This.Controls := []
		This.Handles := []
		This.Index := 0 
	}
	AddTrigger( obj ){
		local k , v , cc , bd
		
		This.Controls[ ++This.Index ] := { 	X:		10
										,	Y:		10
										,	W:		10
										,	H:		10	}
		for k, v in obj
			This.Controls[ This.Index ][ k ] := obj[ k ] 
		cc := This.Controls[ This.Index ]
		Gui, % This.Hwnd ":Add", Text, % "x" cc.X " y" cc.Y " w" cc.W " h" cc.H " hwndhwnd"
		This.Handles[ hwnd ] := This.Index
		This.Controls[ This.Index ].Hwnd := hwnd
		
		if( IsObject( cc.Label ) ){
			bd := cc.Label
			GuiControl, % This.Hwnd ":+G" , % hwnd , % bd
		}else{
			bd := This._TriggerCall.Bind( This )
			GuiControl, % This.Hwnd ":+G" , % hwnd , % bd
		}
		return hwnd
		
	}
	_TriggerCall(){
		MouseGetPos,,,, ctrl, 2
		Try
			;~ SetTimer, % This.Controls[ This.Handles[ ctrl ] ].Label, -0
			gosub, % This.Controls[ This.Handles[ ctrl ] ].Label
		
				
	}
	DrawTriggers( color := "0xFFFF0000" , AutoUpdate := 0 ){
		local brush , cc 
		Brush := Gdip_BrushCreateSolid( color ) 
		Gdip_SetSmoothingMode( This.G , 3 )
		loop, % This.Controls.Length()	{
			cc := This.Controls[ A_Index ]
			Gdip_FillRectangle( This.G , Brush , cc.x , cc.y , cc.w , cc.h )
		
		}
		Gdip_DeleteBrush( Brush )
		Gdip_SetSmoothingMode( This.G , This.Smoothing )
		if( AutoUpdate )
			This.UpdateWindow()
	}
	UpdateSettings( obj := "" , UpdateGraphics := 0 ){
		local k , v
		if( IsObject( obj ) )
			for k, v in obj
				This[ k ] := obj[ k ]
		( This.X = "Center" ) ? ( This.X := ( A_ScreenWidth - This.W ) / 2 ) 	
		( This.Y = "Center" ) ? ( This.Y := ( A_ScreenHeight - This.H ) / 2 ) 	
		if( UpdateGraphics ){
			This._DestroyWindowsGraphics()
			This._CreateWindowGraphics()
		}
	}
	_CreateWindow(){
		local hwnd
		Gui , New, % " +LastFound +E0x80000 hwndhwnd -Caption  " This.Options
		PopUpWindow.Index++
		This.Index := PopUpWindow.Index
		PopUpWindow.Windows[ PopUpWindow.Index ] := This
		This.Hwnd := hwnd
		PopUpWindow.Handles[ hwnd ] := PopUpWindow.Index
		if( This.GdipStartUp && !PopUpWindow.pToken )
			PopUpWindow.pToken := GDIP_STARTUP()
	}
	_DestroyWindowsGraphics(){
		Gdip_DeleteGraphics( This.G )
		SelectObject( This.hdc , This.obm )
		DeleteObject( This.hbm )
		DeleteDC( This.hdc )
	}
	_CreateWindowGraphics(){
		This.hbm := CreateDIBSection( This.W , This.H )
		This.hdc := CreateCompatibleDC()
		This.obm := SelectObject( This.hdc , This.hbm )
		This.G := Gdip_GraphicsFromHDC( This.hdc )
		Gdip_SetSmoothingMode( This.G , This.Smoothing )
	}
	ShowWindow( Title := "" ){
		Gui , % This.Hwnd ":Show", % "x" This.X " y" This.Y " w" This.W " h" This.H " NA", % Title
	}
	HideWindow(){
		Gui , % This.Hwnd ":Hide",
	}
	UpdateWindow( alpha := 255 ){
		UpdateLayeredWindow( This.hwnd , This.hdc , This.X , This.Y , This.W , This.H , alpha )
	}
	ClearWindow( AutoUpdate := 0 ){
		Gdip_GraphicsClear( This.G )
		if( Autoupdate )
			This.UpdateWindow()
	}
	DrawBitmap( pBitmap , obj , dispose := 1 , AutoUpdate := 0 ){
		Gdip_DrawImage( This.G , pBitmap , obj.X , obj.Y , obj.W , obj.H )
		if( dispose )
			Gdip_DisposeImage( pBitmap )
		if( Autoupdate )
			This.UpdateWindow()
	}
	PaintBackground( color := "0xFF000000" , AutoUpdate := 0 ){
		if( isObject( color ) ){
			Brush := Gdip_BrushCreateSolid( ( color.HasKey( "Color" ) ) ? ( color.Color ) : ( "0xFF000000" ) ) 
			if( color.Haskey( "Round" ) )
				Gdip_FillRoundedRectangle( This.G , Brush , color.X , color.Y , color.W , color.H , color.Round )
			else
				Gdip_FillRectangle( This.G , Brush , color.X , color.Y , color.W , color.H ) 
		}else{
			Brush := Gdip_BrushCreateSolid( color ) 
			Gdip_FillRectangle( This.G , Brush , -1 , -1 , This.W + 2 , This.H + 2 ) 
		}
		Gdip_DeleteBrush( Brush )
		if( AutoUpdate )
			This.UpdateWindow()
	}
	DeleteWindow( GDIPShutdown := 0 ){
		Gui, % This.Hwnd ":Destroy"
		SelectObject( This.hdc , This.obm )
		DeleteObject( This.hbm )
		DeleteDC( This.hdc )
		Gdip_DeleteGraphics( This.G )
		hwnd := This.Hwnd
		for k, v in PopUpWindow.Windows[ Hwnd ]
			This[k] := ""
		PopUpWindow.Windows[ Hwnd ] := ""
		if( GDIPShutdown ){
			Gdip_Shutdown( PopUpWindow.pToken )
			PopUpWindow.pToken := ""
		}
	}
	_OnClose( wParam ){
		if( wParam = 0xF060 ){	;SC_CLOSE ;[ clicking on the gui close button ]
			Try{
				Gui, % PopUpWindow.HelperHwnd ":Destroy"
				SoundBeep, 555
			}
		}
	}
	CreateCachedBitmap( pBitmap , Dispose := 0 ){
		local pCachedBitmap
		if( This.CachedBitmap )
			This.DisposeCachedbitmap()
		DllCall( "gdiplus\GdipCreateCachedBitmap" , "Ptr" , pBitmap , "Ptr" , this.G , "PtrP" , pCachedBitmap )
		This.CachedBitmap := pCachedBitmap
		if( Dispose )
			Gdip_DisposeImage( pBitmap )
	}
	DrawCachedBitmap( AutoUpdate := 0 ){
		DllCall( "gdiplus\GdipDrawCachedBitmap" , "Ptr" , this.G , "Ptr" , This.CachedBitmap , "Int" , 0 , "Int" , 0 )
		if( AutoUpdate )
			This.UpdateWindow()
	}
	DisposeCachedbitmap(){
		DllCall( "gdiplus\GdipDeleteCachedBitmap" , "Ptr" , This.CachedBitmap )
	}
	Helper(){
		local hwnd , MethodList := ["__New","UpdateSettings","ShowWindow","HideWindow","UpdateWindow","ClearWindow","DrawBitmap","PaintBackground","DeleteWindow" , "AddTrigger" , "DrawTriggers", "CreateCachedBitmap" , "DrawCachedBitmap" , "DisposeCachedbitmap" ]
		Gui, New, +AlwaysOnTop +ToolWindow +HwndHwnd
		PopUpWindow.HelperHwnd := hwnd
		Gui, Add, Edit, xm ym w250 r1 Center hwndhwnd, Gui1
		PopUpWindow.EditHwnd := hwnd
		loop, % MethodList.Length()	
			Gui, Add, Button, xm y+1 w250 r1 gPopUpWindow._HelperClip, % MethodList[ A_Index ]
		Gui, Show,,
		OnMessage( 0x112 , This._OnClose.Bind( hwnd ) )
	}
	_HelperClip(){
		local ClipList 
		
		GuiControlGet, out, % PopUpWindow.HelperHwnd ":", % PopUpWindow.EditHwnd	
		
		ClipList := 		{ 	__New: 					" := New PopUpWindow( { AutoShow: 1 , X: 0 , Y: 0 , W: A_ScreenWidth , H: A_ScreenHeight , Options: "" -DPIScale +AlwaysOnTop "" } )"
							,	UpdateSettings:			".UpdateSettings( { X: """" , Y: """" , W: """" , H: """" } , UpdateGraphics := 0 )"
							,	ShowWindow:				".ShowWindow( Title := """" )"
							,	HideWindow:				".HideWindow()"
							,	UpdateWindow:			".UpdateWindow()"
							,	ClearWindow:			".ClearWindow( AutoUpdate := 0 )"
							,	DrawBitmap:				".DrawBitmap( pBitmap := """" , { X: 0 , Y: 0 , W: " Out ".W , H: " Out ".H } , dispose := 1 , AutoUpdate := 0 )"
							,	PaintBackground:		".PaintBackground( color := ""0xFF000000"" , AutoUpdate := 0 )  "  ";{ Color: ""0xFF000000"" , X: 2 , Y: 2 , W: " Out ".W - 4 , H: " Out ".H - 4 , Round: 10 }"
							,	DeleteWindow:			".DeleteWindow( GDIPShutdown := 0 )"
							,	AddTrigger:				".AddTrigger( { X: """" , Y: """" , W: """" , H: """" , Value: """" , Label: """" } )"	
							,	DrawTriggers:			".DrawTriggers( color := ""0xFFFF0000"" , AutoUpdate := 0 )"	
							,	CreateCachedBitmap:		".CreateCachedBitmap( pBitmap , Dispose := 0 )"	
							,	DrawCachedBitmap: 		".DrawCachedBitmap( AutoUpdate := 0 )"	
							,	DisposeCachedbitmap:	".DisposeCachedbitmap()"	}
							
		clipboard := Out ClipList[ A_GuiControl ]
		
	}
}
;-------------------------------------------------------------------------+appskey &  ctrl  选择左上角位置后再点 ctrl  然后拉出选框  再点ctrl

;绿色 = 窗口折叠到标题栏，当您将鼠标移开时 - 再次展开，如果您将鼠标移到标题栏上
;黄色 = 窗口保持展开状态
;红色 = 窗口折叠到标题栏，当您将鼠标移开时 - 但它被锁定，并且只有在您右键单击标题栏时才会再次展开（状态变为绿色）。


#Persistent
SetTimer, Alert1, 500
WindowList:=[]
return
 
Alert1:
	Value := WindowList.Pop()
	if (Value=WinExist("A"))
	{
		WindowList.push(WinExist("A"))
	}
	else
	{
		if (value!="")
			WindowList.push(Value)
		WindowList.push(WinExist("A"))
	}
return



F10:: 
if Winv_presses > 0 ; SetTimer 已经启动, 所以我们记录键击.
{
    Winv_presses += 1
    return
}
; 否则, 这是新开始系列中的首次按下. 把次数设为 1 并启动
; 计时器：
Winv_presses = 1
SetTimer, KeyWinv, 400 ; 在 400 毫秒内等待更多的键击.
return

KeyWinv:
SetTimer, KeyWinv, off
if Winv_presses = 1 ; 此键按下了一次.
{
    
  
}
else if Winv_presses = 2 ; 此键按下了两次.
{ 
    loop,1
    SoundBeep, 9000, 10
Tooltip, 🔌        OFF         🔌`n ————————`n🔌      窗口隐藏    🔌  , 600, 0
   SetTimer, RemoveToolTip, 2000
   return
RemoveToolTip:
SetTimer, RemoveToolTip, Off
ToolTip
    exitapp
}

; 不论触发了上面的哪个动作, 都对 count 进行重置
; 为下一个系列的按下做准备:
Winv_presses = 0
return
;------------------------------------------启动 窗口折叠隐藏  全屏无效，但可拉到最大
;⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇠⇢⇢