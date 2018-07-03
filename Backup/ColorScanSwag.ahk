#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#NoEnv
#WinActivateForce
#SingleInstance, Force
#MaxThreadsPerHotkey 2
#Warn, ClassOverwrite
SendMode, Input
SetBatchLines, -1
SetTitleMatchMode, 2
SetWorkingDir, %A_ScriptDir%

; https://github.com/mmikeww/AHKv2-Gdip/blob/master/Gdip_All.ahk
#Include, Gdip_All2.ahk

pToken := initialize()

DebugModeController := new DebugModes()
mode := DebugModeController.cycle()
MsgBox, % Format("Current DebugMode set to [{}].`r`nTo change it press 'C'.", mode)

DllCall("QueryPerformanceFrequency", "Int64*", frequency)

x::
{
	DllCall("QueryPerformanceCounter", "Int64*", counterStart)
	DominantColors := getDominantColorScreen(10, mode)
	DllCall("QueryPerformanceCounter", "Int64*", counterStop)

	MsgBox, % print(DominantColors)

	elapsed := (counterStop - counterStart) * 1000
	elapsed /= frequency
	MsgBox, % "Executed in " . elapsed . " ms."
return
}

c::MsgBox, % Format("DebugMode changed to [{}]", mode := DebugModeController.cycle())
z::ExitApp

print(DominantColors) {
	for index, element in DominantColors {
		result .= Format("{}. `t{} `t{}`r`n", index, element.color, element.occurences) ; 1. 0xC0FFEE 385`r`n
	}

	return result
}

/*
	for testing/benchmark purposes
*/
createBitmapBasedOnMode(mode) {
	if (mode = "screen")
		return Gdip_BitmapFromScreen(1) ; main monitor

	if (mode = "debug")
		return Gdip_BitmapFromScreen("300|300|20|20") ; forum thread tests

	; if (mode = "torture")
	; 	return Gdip_CreateBitmapFromFile("noise.png") ; random color noise torture test

	throw Exception("Invalid mode specified!")
}

/*
	returns the specified amount of most dominant colors
*/
getDominantColorScreen(numDominantColors := 1, mode := "screen") {
	pBitmap := createBitmapBasedOnMode(mode)
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
	RGB := StrReplace(RGB, "0xFF", "0x") ; remove Alpha channel, leave only RGB
	return RGB
}

initialize() {
	checkForAdminPrivileges()
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
			, 2 : "DEBUG"}

	cycle() {
		if (++this.currentMode > this.Modes.Length()) {
			this.currentMode := 1
		}

		return this.Modes[this.currentMode]
	}
}