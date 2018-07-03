; 18/04/27
; Thanks to swag and jeeswg

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

; https://github.com/mmikeww/AHKv2-Gdip/blob/master/Gdip_All.ahk


pToken := initialize()
DebugModeController := new DebugModes()
mode := DebugModeController.cycle()
; MsgBox, % Format("Current DebugMode set to [{}].`r`nTo change it press 'C'.", mode)

DllCall("QueryPerformanceFrequency", "Int64*", frequency)
Return


Return

F24::
Palette:
vOutput := ""
for index, element in DominantColors {
	If (A_Index > 7)
		Break
	color%A_Index% := element.color
	vOutput .= color%A_Index% ","
	}

vOutput := StrReplace(vOutput, originColor)
vOutput := StrReplace(vOutput, ",,", ",")
vOutput := LTrim(vOutput, ",")
vOutput := RTrim(vOutput, ",")
vColor := StrSplit(vOutput, ",")

; MsgBox % vOutput "`r`n" "omit: " originColor "`r`n" vColor[1] "`r`n" vColor[2] "`r`n" vColor[3] "`r`n" vColor[4] "`r`n" vColor[5] "`r`n" vColor[6]
Return

Scan:
{
	numDominantColors := 10
	dimensions := [vWinX, vWinY, vWinW, vWinH]
	DominantColors := getDominantColorFromRegion(numDominantColors, dimensions)
	; MsgBox, % "origin: " originColor "`r`n" print(DominantColors) 
	; MsgBox % printPalette(DominantColors)
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

	MsgBox, % print(DominantColors)

	elapsed := (counterStop - counterStart) * 1000
	elapsed /= frequency
	MsgBox, % "Executed in " . elapsed . " ms."
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
			ToolTip % "x" vX1 " y" vY1 " w" vW0 " h" vH0
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