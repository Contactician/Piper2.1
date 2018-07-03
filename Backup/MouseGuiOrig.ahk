; 3.1 Gui
; 18/4/21

; ////// Global
	#NoEnv
	#SingleInstance, Force
	SetWorkingDir %A_ScriptDir%
	; #NoTrayIcon


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


	; rem = 1
	; mMax := Round((25*rem))

	; wid1 := Round(((mMax - rem)/3))
	; wid2 := Round((wid1 - rem))
	; wid3 := Round(((wid2*2) - rem))

	; hei := Round(((wid3 - rem)/2))

	; yRow := (hei + rem)
	; xCol1 := (wid2 + rem)
	; xCol2 := (wid1 + wid2 + rem + rem)

	Select := 0
	

; ////// GUI
; BuildGui:
	Gui, -Caption +AlwaysOnTop hwndMouse
	; Gui, 1:Default
	; Gui -DPIScale
	; Gui, Margin, %mMin%, %mMin%
	Gui, 1: Color, 2B2B2C, %bgDark%
	Gui +LastFound
	WinSet, TransColor, 2B2B2C

	; Gui, 1:Add, Progress, x0 y0 w%wid3% h%hei% Background%Bg3% c%G1% vPrShift, 0
	; Gui, 1:Add, Progress, xp y%yRow% w%wid3% h%hei% Background%Bg3% c%R1% vPrCtrl, 0
	; Gui, 1:Add, Progress, x%xCol1% yp w%wid3% h%hei% Background%Bg3% c%W1% vPrWin, 0
	; Gui, 1:Add, Progress, x%xCol2% yp w%wid3% h%hei% Background%Bg3% c%B1% vPrAlt, 0

	; Gui, 1:Add, Progress, x27 y7 w3 h6 Background%Bg3% c%Bg1% vPrScreenOff, 100
	; Gui, 1:Add, Progress, x31 y7 w3 h6 Background%Bg3% c%B1% vPrScreenOn, 0

	; Gui, 1:Add, Progress, x36 y7 w200 h200 Background%Bg3% c%Bg1% vPrScreenBG, 100
	; Gui, 1:Add, Picture, x36 y10 vPrScreen, %A_ScriptDir%\resources\screens\screen100.png


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
				, "x45 y142 w182 h50"]


EditArray :=	["x46 y17 w180 h16", "x46 y37 w180 h16", "x46 y57 w180 h16"
				,"x46 y80 w80 h16"
				, "x46 y100 w6 h16", "x56 y100 w60 h16", "x120 y100 w6 h16"
				, "x46 y120 w24 h6", "x74 y120 w24 h16", "x102 y120 w24 h16"
				, "x46 y130 w24 h16", "x74 y130 w24 h16", "x102 y130 w24 h16"
				, "x146 y80 w38 h16", "x188 y80 w38 h16"
				, "x146 y100 w38 h16", "x188 y100 w38 h16", "x146 y120 w38 h16", "x188 y120 w38 h16"
				, "x46 y143 w180 h48"]


VarArray := 	["WinTitle", "WinExe", "WinClass"
				,"MousePos"
				, "ColorTileL", "ColorName", "ColorTileR"
				, "Drop1", "Drop2", "Drop3"
				, "Drop4", "Drop5", "Drop6"
				, "EditNum", "EditText"
				, "ControlX", "ControlY", "ControlW", "ControlH"
				, "Clip1"]

 ; 1 2 3
 
 ; 4
 ; 5 6 7

 ; 8 9 10
 ; 11 12 13
 
 ; 14 15 
 ; 16 17 18 19
 ; 20

; SetTimer, Tooltip, 20


Loop, % EditArray.Length()
{
	If (A_Index > 13) {
			Gui, 1:Add, Progress, % ProgArray[A_Index] " Background" Bg3 " c" Bg1 " vbg" A_Index, 100
			Gui, 1:Add, Edit, % "xp+1 yp+1 wp+2 hp+2 -Multi -E0x200 -Wrap" " c" cText " vPr" A_Index, % VarArray[A_Index]
			; Gui, 1:Add, Edit, % EditArray[A_Index] " -Multi -E0x200 -Wrap" " c" cText " vPr" A_Index, % VarArray[A_Index]
	} Else If (A_Index < 5) {
		Gui, 1:Add, Progress, % ProgArray[A_Index] " Background" Bg3 " c" Bg1 " vbg" A_Index, 100
		Gui, 1:Add, Edit, % EditArray[A_Index] " -Multi -E0x200 -Wrap" " c" cText " vPr" A_Index, % VarArray[A_Index]
	} Else If (A_Index = 6) {
		Gui, 1:Add, Progress, % ProgArray[A_Index] "Center Background" Bg3 " c" Bg1 " vbg" A_Index, 100
		Gui, 1:Add, Edit, % EditArray[A_Index] " -Multi -E0x200 -Wrap" " c" cText " vPr" A_Index, % VarArray[A_Index]
	} Else {
		Gui, 1:Add, Progress, % ProgArray[A_Index] " Background" Bg3 " c" bgDark " vbg" A_Index, 100
		; Gui, 1:Add, ListView,  % EditArray[A_Index] " Background" Bg3 "-Hdr +ReadOnly -E0x200" " vPr" A_Index " +Icon cWhite AltSubmit gButton1"
		; Gui, 1:Add, Text, % EditArray[A_Index] "BackgroundTrans" Center " c" cText " vPr" A_Index, % VarArray[A_Index]
		; Gui, 1:Add, Edit, % EditArray[A_Index] " -Multi -E0x200 -Wrap" " c" cText " vPr" A_Index, % VarArray[A_Index]
	}
}
	

	; Gui, 1:Add, Progress, ProgArray[A_Index] Background%Bg3% c%Bg1% vbg%A_Index%, 100
	; Gui, 1:Add, Edit, EditArray[A_Index] -Multi -E0x200 -Wrap c%cText% vPr%A_Index%, Window Title


Loop, % EditArray.Length() {
	GuiControl, Hide, Pr%A_Index%
	GuiControl, Hide, bg%A_Index%
}

	Gui, 1:Show, Hide
	GuiControl, Hide, PrScreenBg
	GuiControl, Hide, PrScreen
	GuiControl, Hide, PrScreenOn
	GuiControl, Hide, PrScreenOff
	SetTimer, mouseTrack, 20

#Include GDIP_LockBits_DominantColor.ahk

Return


!#RButton::
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


#LButton Up::
; MsgBox % "Works"
Sleep, 1000
MsgBox % vColor[1] "`r`n" vColor[2] "`r`n" vColor[3] "`r`n" vColor[4] "`r`n" vColor[5] "`r`n" vColor[6]

Return


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


Button1:
Return


!MButton::
	++Select
	SelectBack := (Select - 1)	
	If (Select > EditArray.Length()) {
		Select = 1
		SelectBack := EditArray.Length()
	}
	GuiControl, +Background%bg4%, bg%Select%
	GuiControl, +Background%bg3%, bg%SelectBack%
	Gosub, UpdateText
	; GuiControl, +Backgroundff0000, Pr1
Return



; This needs to be looped
UpdateText:
Blank := ""
GuiControl, , Pr1, % WinTitle
GuiControl, , Pr2, % WinExe
GuiControl, , Pr3, % WinClass
GuiControl, , Pr4, % "x" . mouseX . " y" mouseY
; If InStr(vCtlClassNN, "Edit"){
; 	EditNum := vCtlClassNN
; } Else {

; }



HexColor := SubStr(currColor, 3, 6)
; HexColor := LTrim(currColor, "0x")

GuiControl, +c%currColor%, bg5
GuiControl, +c%currColor%, bg7
GuiControl, , Pr6, % HexColor

; GuiControl, +%newColor1%, bg8 
; GuiControl, +%newColor2%, bg9
; GuiControl, +%newColor3%, bg10

GuiControl, , Pr20, % Clipboard
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
Gui, 1:Show, Hide
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
	Loop, % EditArray.Length() {
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
	Loop, % EditArray.Length() {
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