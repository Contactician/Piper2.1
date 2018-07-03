; 3.1 Gui
; 18/4/21

; ////// Global
	#NoEnv
	#SingleInstance, Force
	SetWorkingDir %A_ScriptDir%
	; #NoTrayIcon


	; global PrShift
	global Wid1 = 8
	global Wid2 = 12
	global Wid3 = 24
	global Hei = 6
	global xOffset = 14
	global yOffset = -40
	global R1 := "D44400"
	global R2 := "9F3300"
	global R3 := "6A2200"
	global G1 := "24EE49"
	global G2 := "1BB337"
	global G3 := "127725"
	global B1 := "5064F1"
	global B2 := "3C4BB5"
	global B3 := "283279"
	global W1 := "f7f7f7"
	global W2 := "BDBDBD"
	global W3 := "7E7E7E"
	global bg1 := "2B2B2B"
	global bg2 := "878787"
	global bg3 := "434343"

; ////// GUI
; BuildGui:
	Gui, -Caption +AlwaysOnTop +ToolWindow
	; Gui -DPIScale
	Gui, Margin , 0, 0
	Gui, Color, 2B2B2C, 2B2B2C
	Gui +LastFound
	WinSet, TransColor, 2B2B2C

	Gui, Add, Progress, x0 y0 w13 h6 Background%Bg3% c%G1% vPrShift, 0
	Gui, Add, Progress, x0 y7 w8 h6 Background%Bg3% c%R1% vPrCtrl, 0
	Gui, Add, Progress, x9 y7 w7 h6 Background%Bg3% c%W1% vPrWin, 0
	Gui, Add, Progress, x18 y7 w8 h6 Background%Bg3% c%B1% vPrAlt, 0

	Gui, Add, Progress, x27 y7 w3 h6 Background%Bg3% c%Bg1% vPrScreenOff, 100
	Gui, Add, Progress, x31 y7 w3 h6 Background%Bg3% c%B1% vPrScreenOn, 0

	Gui, Add, Progress, x36 y7 w200 h200 Background%Bg3% c%Bg1% vPrScreenBG, 100
	; Gui, Add, Picture, x36 y10 vPrScreen, %A_ScriptDir%\resources\screens\screen100.png
	
	Gui, Show, Hide
	GuiControl, Hide, PrScreenBg
	GuiControl, Hide, PrScreen
	GuiControl, Hide, PrScreenOn
	GuiControl, Hide, PrScreenOff

	SetTimer, mouseTrack, 20
Return


mouseTrack:
		CoordMode, Mouse, Screen
		MouseGetPos, vCurX, vCurY, hWnd, vCtlClassNN
		mouseX := vCurX-xOffset
		mouseY := vCurY-yOffset
		Gosub, ShowGui
	Return

ShowGui:
Gui, Show, NoActivate x%mouseX% y%mouseY%
Return

; Keycheck
	~*Control::
	    CtrlState := "D"
	    If !InStr(Stats, "^", (Stats.Length() - 1)) {
	    	Stats .= "^"
	    }
	    Gosub, KeyCheck
	Return
	~*Control Up::
	   CtrlState :=  ""
	   Stats := StrReplace(Stats, "^")
	   Gosub, KeyCheck
	Return

	~*Shift::
	   ShiftState := "D"
	   If !InStr(Stats, "+", (Stats.Length() - 1)) {
	   		Stats .= "+"
		}
	   Gosub, KeyCheck
	Return
	~*Shift Up::
	   ShiftState :=  ""
	   Stats := StrReplace(Stats, "+")
	   Gosub, KeyCheck
	Return

	~*Alt::
	   AltState := "D"
	   If !InStr(Stats, "!", (Stats.Length() - 1)) {
		   Stats .= "!"
		}
	   Gosub, KeyCheck
	Return
	~*Alt Up::
	   AltState :=  ""
	   Stats := StrReplace(Stats, "!")
	   Gosub, KeyCheck
	Return

	~*LWin::
	   WinState := "D"
	   If !InStr(Stats, "#", (Stats.Length() - 1)) {
	   		Stats .= "#"
		}
	   Gosub, KeyCheck
	Return
	~*LWin Up::
	   WinState :=  ""
	   Stats := StrReplace(Stats, "#")
	   Gosub, KeyCheck
	Return


#!MButton::Gosub, ScreenToggle

ScreenToggle:
If (ScreenState != "D") {
	ScreenState := "D"
	GuiControl, Show, PrScreen
	GuiControl, Show, PrScreenBG
	GuiControl, Show, PrScreenOn
	GuiControl, Hide, PrScreenOff
	GuiControl,, PrScreenOn, 100
	GuiControl, +c%Bg3% +Background%Bg1%, PrScreenOn
} Else {
	ScreenState := ""
	GuiControl, Hide, PrScreen
	GuiControl, Hide, PrScreenBG
	GuiControl, Hide, PrScreenOn
	; GuiControl, Show, PrScreenOff
	; GuiControl, +c%Bg1% +Background%Bg3%, PrScreenOff	
}
Return


;@Screen
ParseKey:
vOutput := ""
KeyComp := ["^", "+", "!", "#"]
Loop, % KeyComp.Length()
	{
		If ((CtrlState != "D") && (ShiftState != "D") && (AltState != "D") && (WinState != "D")) {
			vOutput := "Def"
			Break
		}
		ScreenVar := KeyComp[A_Index]
		If InStr(Stats, ScreenVar) {
			vOutput .= ScreenVar
		} 
	}
Return


KeyCheck:
	If ((CtrlState != "D") && (ShiftState != "D") && (AltState != "D") && (WinState != "D")) {
		; vOutput := "Def"
		Stats := "Def"
		GuiControl, Hide, PrCtrl
		GuiControl, Hide, PrShift
		GuiControl, Hide, PrAlt
		GuiControl, Hide, PrWin
		If (ScreenState != "D") {
			GuiControl, Hide, PrScreenOn
			GuiControl, Hide, PrScreenOff
		}
	} Else {
		Stats := StrReplace(Stats, "Def")
		GuiControl, Show, PrCtrl
		GuiControl, Show, PrShift
		GuiControl, Show, PrAlt
		GuiControl, Show, PrWin
		; GuiControl, Show, PrScreenOff
		If (ScreenState = "D") {
			GuiControl, Show, PrScreenOn
		}
	}
	Gosub, ParseKey
	GuiControl, , PrScreen, %screenDirect%
	If (CtrlState = "D") {
		GuiControl, +c%R1% +Background%R2%, PrCtrl
		GuiControl,, PrCtrl, 100
   	} Else {
   		GuiControl, +c%Bg1% +Background%Bg3%, PrCtrl
   		GuiControl,, PrCtrl, 100
   	}
   	If (ShiftState = "D") {
   		GuiControl, +c%G1% +Background%G2%, PrShift
   		GuiControl,, PrShift, 100
   	} Else {
   		GuiControl, +c%Bg1% +Background%Bg3%, PrShift
   		GuiControl,, PrShift, 100
   	}
   	If (AltState = "D") {
   		GuiControl, +c%B1% +Background%B2%, PrAlt
   		GuiControl,, PrAlt, 100
   	} Else {
   		GuiControl, +c%Bg1% +Background%Bg3%, PrAlt
   		GuiControl,, PrAlt, 100
   	}
   	If (WinState = "D") {
		GuiControl, +c%W1% +Background%W2%, PrWin
   		GuiControl,, PrWin, 100
   	} Else {
   		GuiControl, +c%Bg1% +Background%Bg3%, PrWin
   		GuiControl,, PrWin, 100
   	}
Return
; ////// GUI


; ////// Debug
	; ToolTip:
	; 	ToolTip % OldWin "`r`n" WinClass "`r`n" WinChange "`r`n" WinTitle "`r`n" WinExe
	; Return

	; F24::
	; Strip:
	; 	Omit := ["`:`:", "SendInput, {Raw}", "Send, ", "Return", "return", "Sleep, 50", "Sleep, 20"]
	; 	Loop, % Omit.Length()
	; 	{
	; 		Clipboard := StrReplace(Clipboard, Omit[A_Index])
	; 		; Clipboard := StrReplace(Clipboard, "`r`n`r`n")
	; 	}
	; Return

	; !F24::
	; 	StripSpaces:
	; 		Clipboard := StrReplace(Clipboard, "A_Tab")
	; 		Clipboard := StrReplace(Clipboard, "A_Space")
	; 		Send, +{Insert}
	; 	Return

	; F23::
	; 	Send, {Down}{Left}{,}
	; 	Return

	; #MButton::
		; WinGetClass, WinClass, A
		; Clipboard := WinClass
	; 	Clipboard := WinExe "`r`n" WinClass
	; Return

