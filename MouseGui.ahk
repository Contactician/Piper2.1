; 3.1 Gui
; 18/4/21

; ////// Global
	; #NoEnv
	; #SingleInstance, Force
	; SetWorkingDir %A_ScriptDir%
	; ; #NoTrayIcon


	#NoEnv
	#WinActivateForce
	#SingleInstance, Force
	#MaxThreadsPerHotkey 2
	#Warn, ClassOverwrite
	
	SendMode, Input
	SetBatchLines, -1
	SetTitleMatchMode, 2
	SetWorkingDir, %A_ScriptDir%
	CoordMode, Mouse, Screen
; Return

	; https://github.com/mmikeww/AHKv2-Gdip/blob/master/Gdip_All.ahk


; MouseInit:
	
	pToken := initialize()
	DebugModeController := new DebugModes()
	mode := DebugModeController.cycle()
	; MsgBox, % Format("Current DebugMode set to [{}].`r`nTo change it press 'C'.", mode)
	DllCall("QueryPerformanceFrequency", "Int64*", frequency)

	; global PrShift
	rem = 8

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
	
	global bg3 := "434343"
	global bg4 := "878787"
	global bgDark := "202020"
	cText := "b7b7b7"

	Select := 0
	

; MouseInit:
; ////// GUI
; BuildGui:
	Gui, -Caption +AlwaysOnTop hwndMouse
	; Gui, 1:Default
	; Gui -DPIScale
	; Gui, Margin, %mMin%, %mMin%
	Gui, 1: Color, 2B2B2C, %bgDark%
	Gui +LastFound
	WinSet, TransColor, 2B2B2C

	Gui, 1:Add, Progress, x0 y0 w13 h6 Background%Bg3% c%G1% vPrShift, 0
	Gui, 1:Add, Progress, x0 y7 w8 h6 Background%Bg3% c%R1% vPrCtrl, 0
	Gui, 1:Add, Progress, x9 y7 w7 h6 Background%Bg3% c%W1% vPrWin, 0
	Gui, 1:Add, Progress, x18 y7 w8 h6 Background%Bg3% c%B1% vPrAlt, 0

	Gui, 1:Add, Progress, x27 y7 w3 h6 Background%Bg3% c%Bg1% vPrScreenOff, 100
	Gui, 1:Add, Progress, x31 y7 w3 h6 Background%Bg3% c%B1% vPrScreenOn, 0

	Gui, 1:Add, Progress, x36 y7 w200 h200 Background%Bg3% c%Bg1% vPrScreenBG, 100
	; Gui, 1:Add, Picture, x36 y10 vPrScreen, %A_ScriptDir%\resources\screens\screen100.png



; If these were numbered, could be rolled through
	Gui, 1:Font, s9 q5, Arial

ProgArray := 	["x45 y16 w182 h18", "x45 y36 w182 h18", "x45 y56 w182 h18"
				, "x45 y79 w82 h18"
				, "x45 y99 w8 h18", "x55 y99 w62 h18", "x119 y99 w8 h18"
				, "x45 y119 w26 h8", "x73 y119 w26 h8", "x101 y119 w26 h8"
				, "x45 y129 w26 h8", "x73 y129 w26 h8", "x101 y129 w26 h8"
				, "x145 y79 w40 h18", "x187 y79 w40 h18"
				, "x145 y99 w40 h18", "x187 y99 w40 h18", "x145 y119 w40 h18", "x187 y119 w40 h18"
				, "x45 y142 w7 h16", "x45 y160 w7 h10", "x45 y172 w7 h10"
				, "x55 y142 w172 h57"]


; ProgArray := 	["x45 y16 w182 h18", "xp-1 yp+19 wp+2 hp+2", "xp-1 yp+19 wp+2 hp+2"
; 				, "xp-1 yp+19 wp-97 hp+2"
; 				, "xp-1 yp+19 wp-74 hp+2", "xp+11 yp wp+52 hp", "x120 yp-1 wp-49 hp+2"
; 				, "x45 y119 w26 h8", "x73 y119 w26 h8", "x101 y119 w26 h8"
; 				, "x45 y129 w26 h8", "x73 y129 w26 h8", "x101 y129 w26 h8"
; 				, "x145 y79 w40 h18", "x187 y79 w40 h18"
; 				, "x145 y99 w40 h18", "x187 y99 w40 h18", "x145 y119 w40 h18", "x187 y119 w40 h18"
; 				, "x45 y142 w7 h16", "x45 y160 w7 h10", "x45 y172 w7 h10"
; 				, "x55 y142 w172 h57"]


; EditArray :=	["x46 y17 w180 h16", "x46 y37 w180 h16", "x46 y57 w180 h16"
; 				,"x46 y80 w80 h16"
; 				, "x46 y100 w6 h16", "x56 y100 w60 h16", "x120 y100 w6 h16"
; 				, "x46 y120 w24 h6", "x74 y120 w24 h16", "x102 y120 w24 h16"
; 				, "x46 y130 w24 h16", "x74 y130 w24 h16", "x102 y130 w24 h16"
; 				, "x146 y80 w38 h16", "x188 y80 w38 h16"
; 				, "x146 y100 w38 h16", "x188 y100 w38 h16", "x146 y120 w38 h16", "x188 y120 w38 h16"
; 				, "x46 y143 w5 h14", "x46 y161 w5 h8", "x46 y173 w5 h8"
; 				, "x56 y143 w170 h55"]


VarArray := 	["WinTitle", "WinExe", "WinClass"
				,"MousePos"
				, "ColorTileL", "ColorName", "ColorTileR"
				, "Drop1", "Drop2", "Drop3"
				, "Drop4", "Drop5", "Drop6"
				, "EditNum", "EditText"
				, "ControlX", "ControlY", "ControlW", "ControlH"
				, "Clip1", "Clip2", "Clip3"
				, "Clipboard"]



params := ["x", "y", "w", "h"]



 ; 1 2 3
 
 ; 4
 ; 5 6 7

 ; 8 9 10
 ; 11 12 13
 
 ; 14 15 
 ; 16 17 18 19
 ; 20 21 22
 ; 23

; SetTimer, Tooltip, 20


Loop, % ProgArray.Length()
{
	If (A_Index = 24) {
		Gui, Add, Progress, % ProgArray[A_Index] " Background" Bg3 " c" Bg1 " vbg" A_Index, 100
		Gui, Add, Edit, % "xp+1 yp+1 wp-2 hp-2 -Multi -E0x200 -Wrap" " c" cText " vPr" A_Index, % VarArray[A_Index]
	} Else If ((A_Index > 13) && (A_Index < 20)) {
		Gui, Add, Progress, % ProgArray[A_Index] " Background" Bg3 " c" Bg1 " vbg" A_Index, 100
		Gui, Add, Edit, % "xp+1 yp+1 wp-2 hp-2 -Multi -E0x200 -Wrap" " c" cText " vPr" A_Index, % VarArray[A_Index]
	} Else If (A_Index < 5) {
		Gui, Add, Progress, % ProgArray[A_Index] " Background" Bg3 " c" Bg1 " vbg" A_Index, 100
		Gui, Add, Edit, % "xp+1 yp+1 wp-2 hp-2 -Multi -E0x200 -Wrap" " c" cText " vPr" A_Index, % VarArray[A_Index]
	} Else If (A_Index = 6) {
		Gui, Add, Progress, % ProgArray[A_Index] "Center Background" Bg3 " c" Bg1 " vbg" A_Index, 100
		Gui, Add, Edit, % "xp+1 yp+1 wp-2 hp-2 -Multi -E0x200 -Wrap" " c" cText " vPr" A_Index, % VarArray[A_Index]
	} Else {
		Gui, Add, Progress, % ProgArray[A_Index] " Background" Bg3 " c" bgDark " vbg" A_Index, 100
	}
}
	

Loop, % ProgArray.Length() {
	GuiControl, Hide, Pr%A_Index%
	GuiControl, Hide, bg%A_Index%
}

	Gui, 1:Show, Hide
	GuiControl, Hide, PrScreenBg
	GuiControl, Hide, PrScreen
	GuiControl, Hide, PrScreenOn
	GuiControl, Hide, PrScreenOff
	SetTimer, mouseTrack, 20
	SetTimer, ClipCheck
	#Include Gdip_All2.ahk
	#Include KeyMaps.ahk

; Return


; F19::
; vOut := ""
; ; for key, coords in ProgArray {
; ; }	
; Return




ParseCoords:
MsgBox % currEditCoords "`r`n" newEditCoords "`r`n" currProgCoords "`r`n" newProgCoords "`r`n" omit "`r`n" differ
MsgBox % vProgOut1 " to " vEditOut1 "`r`n" vProgOut2 " to " vEditOut2 "`r`n" vProgOut3 " to " vEditOut3
Return



		; If InStr(currProgCoords, "h")
		; {
		; 	newProgCoords := StrReplace(currProgCoords, "h", "")
		; }
		; currLength := StrLen(%currNum%Edit[A_Index])
		; %currNum%Edit[A_Index] := SubStr(%currNum%Edit[A_Index], 2, (currLength - 1))
		; editCoords := %currNum%Edit[A_Index]



		; Loop, 2
		; {
		;  	%A_Index%Edit := StrSplit(EditArray[A_Index], A_Space)
		; }

		; MsgBox % "E: " vEdit "`r`n" "P: " vProg
		; MsgBox % 1Edit[1] "`r`n" 1Edit[2] "`r`n" 1Edit[3] "`r`n" 1Edit[4] "`r`n" "currNum: " currNum "`r`n" "currLength: " currLength "`r`n" currEditCoords


ClipCheck:
	OnClipboardChange()
Return

OnClipboardChange() {
    GuiControl, , Pr23, % Clipboard
}
Return


; ~^c::
; 	GuiControl, , Pr23, % Clipboard
; Return


!#RButton::
	Clipboard := ""

	colorScan := "Start"
	errCount = 0
	status = 0
	originX := vCurX, originY := vCurY
	Loop, 6 {
		newColor%A_Index% := ""
		GuiControl, % "+c" bgDark, % "bg" (A_Index + 7)

	}
	SetTimer, WhileHolding, 20
	PixelGetColor, originColor, originX, originY, RGB
Return


#IfWinActive, ahk_class illustrator
F22::	
F23::
F24::
	KeyC := (SubStr(A_ThisHotkey, 3, 1) - 1)
	; MsgBox % A_ThisHotkey "`r`n" KeyC
	Loop, 3 {
		If (A_Index != KeyC)
		Continue
		ControlFocus, Edit15, ahk_class illustrator
    	ControlSetText, Edit15, % vColor[A_Index], ahk_class illustrator
    	Send, {Enter}
	return
	}
Return

!F22::	
!F23::
!F24::
	KeyD := (SubStr(A_ThisHotkey, 4, 1) - 1)
	Loop, 3 {
		KeyAlt := (A_Index + 3)
		If (A_Index != KeyD)
		Continue
		ControlFocus, Edit15, ahk_class illustrator
    	ControlSetText, Edit15, % vColor[(A_Index + 3)], ahk_class illustrator
    	Send, {Enter}
	return
	}
Return



; 	ControlFocus, Edit15, ahk_class illustrator
; 	ControlSetText, Edit15, % vColor1, ahk_class illustrator
; 	Send, {Enter}
; Return


; F23::
; 	ControlFocus, Edit15, ahk_class illustrator
; 	ControlSetText, Edit15, % vColor2, ahk_class illustrator
; 	Send, {Enter}
; Return


; F24::
; 	ControlFocus, Edit15, ahk_class illustrator
; 	ControlSetText, Edit15, % vColor3, ahk_class illustrator
; 	Send, {Enter}
; Return

#If


; #LButton Up::
; MsgBox % "Works"
; Sleep, 1000
; MsgBox % vColor[1] "`r`n" vColor[2] "`r`n" vColor[3] "`r`n" vColor[4] "`r`n" vColor[5] "`r`n" vColor[6]

; Return


WhileHolding:
PixelGetColor, newColor, vCurX, vCurY, RGB
If (newColor != originColor) {
	If (colorScan = "Done")
		Return
	++errCount
	If (errCount > 3) {
		errCount = 0
		If ((newColor5 != "") && !InStr(spectrum, newColor)) {
			newColor6 := newColor
			spectrum := ""
			GuiControl, +c%newColor6%, bg13
			colorScan := "Done"
			status = 6
			Clipboard := newColor1 " " newColor2 " " newColor3 " " newColor4 " " newColor5 " " newColor6
			Clipboard := StrReplace(Clipboard, "0x")
		} Else If ((newColor4 != "") && !InStr(spectrum, newColor)) {
			newColor5 := newColor
			spectrum .= " " newColor5
			GuiControl, +c%newColor5%, bg12
			status = 5
		} Else If ((newColor3 != "") && !InStr(spectrum, newColor)) {
			newColor4 := newColor
			spectrum .= " " newColor4
			GuiControl, +c%newColor4%, bg11
			status = 4
		} Else If ((newColor2 != "") && !InStr(spectrum, newColor)) {
			newColor3 := newColor
			spectrum .= " " newColor3
			GuiControl, +c%newColor3%, bg10
			status = 3
		} Else If ((newColor1 != "") && !InStr(spectrum, newColor)) {
			newColor2 := newColor
			spectrum .= " " newColor2
			GuiControl, +c%newColor2%, bg9
			status = 2
		} Else If (((status > 5) || (status = 0)) && !InStr(spectrum, newColor)) {
			newColor1 := newColor
			spectrum := newColor1
			GuiControl, +c%newColor1%, bg8
			status = 1
		} 
		; Else {
		; 	newColor1 := newColor
		; 	spectrum := newColor1
		; 	GuiControl, +c%newColor1%, bg8
		; 	status = 1
		; }
	}
}

; ToolTip % "`r`n"  "`r`n" spectrum 

; ToolTip % "x" vCurX ", y" vCurY "`r`n" "origin: x" originX ", y" originY "`r`n" "x" dragXstart ", y" dragYstart "`r`n" 
; ToolTip % errCount "`r`n" originColor "`r`n" newColor "`r`n" "1:" newColor1 "`r`n" "2:" newColor2 "`r`n" "3:" newColor3 "`r`n" "4:" newColor4 "`r`n" "5:" newColor5 "`r`n" "6:" newColor6 "`r`n" status "`r`n" spectrum
Return

!#RButton Up::
	SetTimer, WhileHolding, Off
	status = 0
	spectrum := ""
	ToolTip
Return


; Button1:
; Return


; !MButton::
; 	++Select
; 	SelectBack := (Select - 1)	
; 	If (Select > ProgArray.Length()) {
; 		Select = 1
; 		SelectBack := ProgArray.Length()
; 	}
; 	GuiControl, +Background%bg4%, bg%Select%
; 	GuiControl, +Background%bg3%, bg%SelectBack%
; 	Gosub, UpdateText
; 	; GuiControl, +Backgroundff0000, Pr1
; Return



; This needs to be looped
UpdateText:
Blank := ""
GuiControl, , Pr1, % WinTitle
GuiControl, , Pr2, % WinExe
GuiControl, , Pr3, % WinClass
GuiControl, , Pr4, % "x" . mouseX . " y" mouseY


; ToolTip % vCtlClassNN

; GuiControl, , Pr15, % vCtlClassNN
; GuiControl, , Pr14, % vCtlClassNN
; GuiControl, , Pr13, % vCtlClassNN

; GuiControl, , Pr14, % EditNum

If InStr(vCtlClassNN, "Edit"){
	EditNum := vCtlClassNN
	GuiControl, , Pr14, % EditNum
	ControlGetText, EditText, % EditNum, WinTitle
	GuiControl, , Pr15, % EditText
} Else {
	GuiControl, , Pr14, % Blank
	GuiControl, , Pr15, % Blank
}



HexColor := SubStr(currColor, 3, 6)
; HexColor := LTrim(currColor, "0x")

GuiControl, +c%currColor%, bg5
GuiControl, +c%currColor%, bg7
GuiControl, , Pr6, % HexColor

; GuiControl, +%newColor1%, bg8 
; GuiControl, +%newColor2%, bg9
; GuiControl, +%newColor3%, bg10

; Loop, 2 {
; 	GuiControl, , % "Pr" A_Index + 13, % Blank
; }

; Loop, 3 {
; 	GuiControl, , % "Pr" A_Index + 19, % Blank
; }
GuiControl, , Pr23, % Clipboard
; GuiControl, , Pr8, % EditNum
Return


mouseTrack:
		CoordMode, Mouse, Screen
		MouseGetPos, vCurX, vCurY, hWnd, vCtlClassNN
		mouseX := vCurX-xOffset
		mouseY := vCurY-yOffset
		CoordMode, Pixel, Screen
		PixelGetColor, currColor, %vCurX%, %vCurY%, RGB
		WinGetTitle, WinTitle, A
		WinGetClass, WinClass, A
		WinGet, WinExe, ProcessName, A

		SetTimer, UpdateText, -10

		If !GetKeyState("LWin") {
			Gosub, ShowGui
			; SetTimer, UpdateText, -10
		}
	Return

HideGui:
Send, {LWin Up}{LAlt Up}{LControl Up}{LShift Up}
Gui, Show, Hide
Return


ShowGui:
Gui, 1:Show, NoActivate x%mouseX% y%mouseY%
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
	Loop, % ProgArray.Length() {
		GuiControl, Show, Pr%A_Index%
		GuiControl, Show, bg%A_Index%
	}
	GuiControl, Show, PrScreen
	GuiControl, Show, PrScreenBG
	GuiControl, Show, PrScreenOn
	GuiControl, Hide, PrScreenOff
	GuiControl,, PrScreenOn, 100
	GuiControl, +c%Bg3% +Background%Bg1%, PrScreenOn
} Else {
	ScreenState := ""
	Loop, % ProgArray.Length() {
		GuiControl, Hide, Pr%A_Index%
		GuiControl, Hide, bg%A_Index%
	}
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

	; Gui, 1:Mouse: Add, Progress, x45 y16 w182 h18 Background%Bg3% c%Bg1% vbg1, 100
	; Gui, 1:Mouse: Add, Edit, x46 y17 w180 h16 -Multi -E0x200 -Wrap c%cText% vPr1, Window Title
	; Gui, 1:Mouse: Add, Progress, x45 y36 w182 h18 Background%Bg3% c%Bg1% vbg2, 100
	; Gui, 1:Mouse: Add, Edit, x46 y37 w180 h16 -Multi -E0x200 -Wrap c%cText% vPr2, ahk_exe
	; Gui, 1:Mouse: Add, Progress, x45 y56 w182 h18 Background%Bg3% c%Bg1% vbg3, 100
	; Gui, 1:Mouse: Add, Edit, x46 y57 w180 h16 -Multi -E0x200 -Wrap c%cText% vPr3, ahk_class


	; Gui, 1:Mouse: Add, Progress, x45 y79 w82 h18 Background%Bg3% c%Bg1% vbg4, 100
	; Gui, 1:Mouse: Add, Edit, x46 y80 w80 h16 -Multi -E0x200 -Wrap c%cText% vPr4, x1291 y423

	; Gui, 1:Mouse: Add, Progress, x45 y100 w82 h18 Background%Bg3% c%R1% vbg5, 100
	; Gui, 1:Mouse: Add, Progress, x45 y120 w38 h18 Background%Bg3% c%G1% vbg6, 100
	; Gui, 1:Mouse: Add, Progress, x88 y120 w38 h18 Background%Bg3% c%B1% vbg7, 100


	; Gui, 1:Mouse: Add, Progress, x145 y79 w82 h18 Background%Bg3% c%Bg1% vbg8, 100
	; Gui, 1:Mouse: Add, Edit, x146 y80 w80 h16 -Multi -E0x200 -Wrap c%cText% vPr8, Edit15
	; Gui, 1:Mouse: Add, Progress, x145 y99 w40 h18 Background%Bg3% c%Bg1% vbg9, 100
	; Gui, 1:Mouse: Add, Edit, x146 y100 w38 h16 -Multi -E0x200 -Wrap c%cText% vPr9, x2010
	; Gui, 1:Mouse: Add, Progress, x187 y99 w40 h18 Background%Bg3% c%Bg1% vbg10, 100
	; Gui, 1:Mouse: Add, Edit, x188 y100 w38 h16 -Multi -E0x200 -Wrap c%cText% vPr10, y408	
	; Gui, 1:Mouse: Add, Progress, x145 y119 w40 h18 Background%Bg3% c%Bg1% vbg11, 100
	; Gui, 1:Mouse: Add, Edit, x146 y120 w38 h16 -Multi -E0x200 -Wrap c%cText% vPr11, w47
	; Gui, 1:Mouse: Add, Progress, x187 y119 w40 h18 Background%Bg3% c%Bg1% vbg12, 100
	; Gui, 1:Mouse: Add, Edit, x188 y120 w38 h16 -Multi -E0x200 -Wrap c%cText% vPr12, h83	

	; Gui, 1:Mouse: Add, Progress, x45 y142 w182 h18 Background%Bg3% c%Bg1% vbg13, 100
	; Gui, 1:Mouse: Add, Edit, x46 y143 w180 h16 -Multi -E0x200 -Wrap c%cText% vPr13, Clipboard Data	






; @ColorScan

	; 18/04/27
; Thanks to swag and jeeswg

; F24::
Palette:
vOutput := ""
for index, element in DominantColors {
	If (A_Index > 10)
		Break
	occur%A_Index% := element.occurences
	If (A_Index > 1)
		Prev := (A_Index - 1)
	If (element.occurences < (occur%Prev% / 8))
		Break
	color%A_Index% := element.color
	vOutput .= color%A_Index% ","
	; occur%A_Index% "`r`n"
	}

vInput := vOutput

vOutput := StrReplace(vOutput, originColor)
vOutput := StrReplace(vOutput, ",,", ",")
vOutput := LTrim(vOutput, ",")
vOutput := RTrim(vOutput, ",")
vColor := StrSplit(vOutput, ",")

; MsgBox % vInput

; MsgBox % vOutput "`r`n" "omit: " originColor "`r`n" vColor[1] "`r`n" vColor[2] "`r`n" vColor[3] "`r`n" vColor[4] "`r`n" vColor[5] "`r`n" vColor[6]

Loop, 6
{
	Nums := (A_Index + 7)
	GuiControl, % "+c" vColor[A_Index], % "bg" Nums
}

; GuiControl, +c%newColor6%, bg13
Return

Scan:
{
	numDominantColors := 10
	dimensions := [vWinX, vWinY, vWinW, vWinH]
	DominantColors := getDominantColorFromRegion(numDominantColors, dimensions)
	; MsgBox, % "origin: " originColor "`r`n" print(DominantColors) 
	; MsgBox % printPalette(DominantColors)
	Gosub, Palette
return
}

#LButton::
{
	MouseGetPos, originX, originY
	global originColor
	PixelGetColor, originColor, originX, originY
	originColor := SubStr(originColor, 3, 6)
	InputRect(vWinX, vWinY, vWinR, vWinB)
	vWinW := vWinR-vWinX, vWinH := vWinB-vWinY

	if (vInputRectState = -1) {
		return
	}
return
}

F21::
{
	DllCall("QueryPerformanceCounter", "Int64*", counterStart)
	DominantColors := getDominantColorFromScreen(10)
	DllCall("QueryPerformanceCounter", "Int64*", counterStop)

	; MsgBox, % print(DominantColors)

	elapsed := (counterStop - counterStart) * 1000
	elapsed /= frequency
	; MsgBox, % "Executed in " . elapsed . " ms."
return
}

; c::MsgBox, % Format("DebugMode changed to [{}]", mode := DebugModeController.cycle())
; z::ExitApp

print(DominantColors) {
	; for index, element in DominantColors {
	; 	result .= Format("{}.{}.{}`r`n", index, element.color, element.occurences) ; 1. 0xC0FFEE 385`r`n
	; }

	for index, element in DominantColors {
		; If (element.color = originColor)
			; DominantColors.Delete(%A_Index%)
		; 	Return
		; Else 
			result .= Format("{}`r`n", element.color) ; 1. 0xC0FFEE 385`r`n
	}

	; result := StrReplace(result, originColor, "omit")

	return result
}


; F24::
; Palette := StrSplit(result, ".", "`r`n")
; 	Loop % Palette.MaxIndex()
; {
;     this_color := Palette[A_Index]
;     MsgBox, Color number %A_Index% is %this_color%.
; }
	
; Return


; printPalette(DominantColors) {
; 	for index, element in DominantColors {
; 		result .= Format("{}`r`n", element.color) ; 0xC0FFEE
; 	}
; }


printError(e) {
	options := 16
	title := "Error!"
	text := Format("Error: `t{}`nFunc: `t{}`nLine: `t{}", e.Message, e.What, e.Line)
	MsgBox, % options, % title, % text
}


/*
	for testing/benchmark purposes
*/
createBitmapBasedOnMode(mode) {
	if (IsObject(mode) && mode.Length() == 4)
		return Gdip_BitmapFromScreen(Format("{}|{}|{}|{}", mode*)) ; format => "x|y|w|h"

	if (mode = "screen")
		return Gdip_BitmapFromScreen(1) ; main monitor

	if (mode = "debug")
		return Gdip_BitmapFromScreen("300|300|20|20") ; forum thread tests

	if (mode = "torture")
		return Gdip_CreateBitmapFromFile("noise.png") ; random color noise torture test

	throw Exception("Invalid mode specified!")
}

/*
	returns the specified amount of most dominant colors
*/
getDominantColor(numDominantColors := 1, mode := "screen") {
	try
		pBitmap := createBitmapBasedOnMode(mode)
	catch e {
		printError(e)
		return 0
	}

	bitmapWidth := Gdip_GetImageWidth(pBitmap)
	bitmapHeight := Gdip_GetImageHeight(pBitmap)

	Gdip_LockBits(pBitmap, 0, 0, bitmapWidth, bitmapHeight, Stride, Scan0, BitmapData)

	ColorOccurences := getLockBitColorOccurences(bitmapWidth, bitmapHeight, Stride, Scan0)
	SortedColors := sortColorArray(ColorOccurences)
	DominantColors := pickDominantColorsFromSortedArray(SortedColors, numDominantColors)

	Gdip_UnlockBits(pBitmap, BitmapData)
	Gdip_DisposeImage(pBitmap)

	return DominantColors
}

/*
	when passed an array of coordinates [x, y, w, h]
	returns a data structure containing the specified N most dominant colors,
	from the region enclosed by the specified coordinates
*/
getDominantColorFromRegion(numDominantColors, region) {
	return getDominantColor(numDominantColors, region)
}

/*
	returns a data structure containing the specified N most dominant colors,
	from the main monitor
*/
getDominantColorFromScreen(numDominantColors) {
	return getDominantColor(numDominantColors, "screen")
}

/*
	retrieves the hex RGB of every pixel in the selected region sequentially
	computes the number of occurences of each pixel
	returns a data structure of the type:
	{
		"0xC0FFEE" : 385,
		"0x0DEAD0" : 22,
		"0x0BEEF0" : 1
	}
*/
getLockBitColorOccurences(width, height, stride, scan) {
	ColorOccurences := {}

	Loop, % width {
		x := A_Index - 1
		Loop, % height {
			y := A_Index - 1

			pixelColor := ARGBtoRGB(Gdip_GetLockBitPixel(scan, x, y, stride))

			if (ColorOccurences.HasKey(pixelColor . "")) {
				ColorOccurences[pixelColor . ""]++
			}
			else {
				ColorOccurences[pixelColor . ""] := 1
			}
		}
	}

	return ColorOccurences
}

/*
	sorts the passed array ascending in a way such that
	the key reflects the total number of times a given color has occured and
	the value contains an array of color, to allow for the case where
	multiple distinct colors have occured the same number of times
	return a data structure of the following type:
	{
		1 :
		{
			1 : "0x0BEEF0"
		},
		22 :
		{
			1 : "0x0DEAD0",
			2 : "0x1DEAD1"
		},
		385 :
		{
			1 : "0xC0FFEE"
		}
	}
*/
sortColorArray(Colors) {
	SortedColors := {}

	for pixelColor, numOccurences in Colors {
		if (SortedColors.HasKey(numOccurences)) {
			SortedColors[numOccurences].push(pixelColor)
		}
		else {
			SortedColors[numOccurences] := [pixelColor]
		}
	}

	return SortedColors
}

/*
	computes the numDominantColors most dominant colors
	if multiple colors have the same number of occurences,
	they are picked in the order that they appear in the data structure.
	returns example data structure for numDominantColors = 4:
	{
		1 : {"color" : "0xC0FFEE", "occurences" : 385 },
		2 : {"color" : "0x0DEAD0", "occurences" : 22 },
		3 : {"color" : "0x1DEAD1", "occurences" : 22 },
		4 : {"color" : "0x0BEEF0", "occurences" : 1 }
	}
*/
pickDominantColorsFromSortedArray(SortedColors, numDominantColors) {
	DominantColors := {}
	colorRank := 1

	Loop, % numDominantColors {
		if (colorRank > numDominantColors) {
			break
		}

		occurences := SortedColors.MaxIndex()
		lastElement := SortedColors.Pop()

		for index, color in lastElement {
			if (colorRank > numDominantColors) {
				break
			}

			DominantColors[colorRank] := {"occurences" : occurences, "color" : color}
			colorRank++
		}
	}

	return DominantColors
}

; ARBG to RGB conversion function
ARGBtoRGB(ARGB) {
	RGB := Format("0x{:X}", ARGB) ; prepend '0x' infront and convert to hex
	RGB := StrReplace(RGB, "0xFF", "") ; remove Alpha channel, leave only RGB
	return RGB
}

initialize() {
	; checkForAdminPrivileges()
	pToken := initializeGdip()
	OnExit(Func("cleanUp").Bind(pToken))
	return
}

checkForAdminPrivileges() {
	if !(A_IsAdmin) {
		MsgBox, % "Run with administrative rights."
			. "`r`n" . "The script will now exit."
		ExitApp
	}
}

initializeGdip() {
	if !(pToken := Gdip_Startup()) {
		MsgBox, % "Failed to load GDI+."
			. "`r`n" . "The script will now exit."
		ExitApp
	}
	return pToken
}

cleanUp(pToken) {
	Gdip_Shutdown(pToken)
	ExitApp
}

class DebugModes {
	static currentMode := 0
	Modes := {1 : "SCREEN"
			, 2 : "DEBUG"
			, 3 : "TORTURE"}

	cycle() {
		if (++this.currentMode > this.Modes.Length()) {
			this.currentMode := 1
		}

		return this.Modes[this.currentMode]
	}
}

InputRect(ByRef vX1, ByRef vY1, ByRef vX2, ByRef vY2) {
	global vInputRectState := 0
	DetectHiddenWindows, On
	Gui, 2: -Caption +Owner +AlwaysOnTop +ToolWindow +hWndhGuiSel
	Gui, 2: -DPIScale
	Gui, 2: Color, Red
	WinSet, Transparent, 128, % "ahk_id " hGuiSel
	Hotkey, *LButton, InputRect_End, On
	; Hotkey, *RButton, InputRect_End, On
	Hotkey, Esc, InputRect_End, On
	KeyWait, LButton, D
	MouseGetPos, vX0, vY0
	SetTimer, InputRect_Update, 10
	KeyWait, LButton
	Hotkey, *LButton, Off
	Hotkey, Esc, InputRect_End, Off
	SetTimer, InputRect_Update, Off
	Gui, 2: Destroy
		; MsgBox % "x" vX1 " y" vY1 " w" vW0 " h" vH0       ; To verify dimensions are correct
		ToolTip
	Loop, 4 {
			GuiControl, +Background%bg3%, % "bg" A_Index + 15
		}
			GuiControl, , Pr16, % "x " vX1
			GuiControl, , Pr17, % "y " vY1
			GuiControl, , Pr18, % "w " vW0
			GuiControl, , Pr19, % "h " vH0
		Gosub, Scan
	return

	InputRect_Update:
	if !vInputRectState
	{
		MouseGetPos, vX, vY
		(vX < vX0) ? (vX1 := vX, vX2 := vX0) : (vX1 := vX0, vX2 := vX)
		(vY < vY0) ? (vY1 := vY, vY2 := vY0) : (vY1 := vY0, vY2 := vY)
		; Gui, 2:Show, % "NA x" vX1 " y" vY1 " w" (vX2-vX1) " h" (vY2-vY1)
			vW0 := (vX2-vX1), vH0 := (vY2-vY1)
			Gui, 2:Show, % "NA x" vX1 " y" vY1 " w" vW0 " h" vH0


			Loop, 4 {
				GuiControl, +Background%bg4%, % "bg" A_Index + 15
			}

			GuiControl, , Pr16, % "x " vX1
			GuiControl, , Pr17, % "y " vY1
			GuiControl, , Pr18, % "w " vW0
			GuiControl, , Pr19, % "h " vH0

			; ToolTip % "x" vX1 " y" vY1 " w" vW0 " h" vH0
		return
	}
	vInputRectState := 1

	InputRect_End:
	if !vInputRectState
		vInputRectState := -1
	Hotkey, *LButton, Off
	SetTimer, InputRect_Update, Off
	Gui, 2: Destroy


	InputRect_Return:
	return
}








Return





;@Coords
; Loop, % ProgArray.Length()
; {	
; 	currNum := A_Index
; 	%A_Index%Prog := StrSplit(ProgArray[A_Index], A_Space)
; 	%A_Index%Edit := StrSplit(EditArray[A_Index], A_Space)

; 	Loop, 4 {		
; 		lastNum := currNum - 1
; 		lastEditCoords := %lastNum%Edit[A_Index]
; 		currProgCoords := %currNum%Prog[A_Index]
; 		Loop, 4
; 		{
; 			omit := params[A_Index]
; 			If InStr(currProgCoords, omit)
; 			{
; 				newProgCoords := StrReplace(currProgCoords, omit, "")
; 				lastEditCoords := StrReplace(lastEditCoords, omit, "")
; 			}
; 		}
; 		differ := newProgCoords - lastEditCoords
; 		If (differ < 0){
; 			progFin := params[A_Index] "p" differ
; 		} Else {
; 			progFin := params[A_Index] "p+" differ
; 		}
; 		vProgOut%currNum% .= progFin . " "
; 	}
; 	vProgOut%currNum% := RTrim(vProgOut%currNum%, A_Space)
; 	If (currNum = 1)
; 	{
; 		vProgOut1 := "x45 y16 w182 h18"
; 	}


; 	Loop, 4 {
; 		currProgCoords := %currNum%Prog[A_Index]
; 		currEditCoords := %currNum%Edit[A_Index]
; 		Loop, 4
; 		{
; 			omit := params[A_Index]
; 			If InStr(currProgCoords, omit)
; 			{
; 				newProgCoords := StrReplace(currProgCoords, omit, "")
; 				newEditCoords := StrReplace(currEditCoords, omit, "")
; 			}
; 		}
; 		differ := newEditCoords - newProgCoords
; 		If (differ < 0){
; 			editFin := params[A_Index] "p" differ
; 		} Else {
; 			editFin := params[A_Index] "p+" differ
; 		}
; 		vEditOut%currNum% .= editFin . " "
; 	}
; 	vEditOut%currNum% := RTrim(vEditOut%currNum%, A_Space)	
; }


; Loop, % ProgArray.Length()
; {
; 	If (A_Index = 24) {
; 		Gui, Add, Progress, % vProgOut[A_Index] " Background" Bg3 " c" Bg1 " vbg" A_Index, 100
; 		Gui, Add, Edit, % vEditOut[A_Index] " -Multi -E0x200 -Wrap" " c" cText " vPr" A_Index, % VarArray[A_Index]
; 	} Else If ((A_Index > 13) && (A_Index < 20)) {
; 		Gui, Add, Progress, % vProgOut[A_Index] " Background" Bg3 " c" Bg1 " vbg" A_Index, 100
; 		Gui, Add, Edit, % vEditOut[A_Index] " -Multi -E0x200 -Wrap" " c" cText " vPr" A_Index, % VarArray[A_Index]
; 	} Else If (A_Index < 5) {
; 		Gui, Add, Progress, % vProgOut[A_Index] " Background" Bg3 " c" Bg1 " vbg" A_Index, 100
; 		Gui, Add, Edit, % vEditOut[A_Index] " -Multi -E0x200 -Wrap" " c" cText " vPr" A_Index, % VarArray[A_Index]
; 	} Else If (A_Index = 6) {
; 		Gui, Add, Progress, % vProgOut[A_Index] "Center Background" Bg3 " c" Bg1 " vbg" A_Index, 100
; 		Gui, Add, Edit, % vEditOut[A_Index] " -Multi -E0x200 -Wrap" " c" cText " vPr" A_Index, % VarArray[A_Index]
; 	} Else {
; 		Gui, Add, Progress, % vProgOut[A_Index] " Background" Bg3 " c" bgDark " vbg" A_Index, 100
; 	}
; }