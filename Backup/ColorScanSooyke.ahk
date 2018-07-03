#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetBatchLines, -1
#SingleInstance, force

#include *i Gdip_All2.ahk

If !pToken := Gdip_Startup()
{
	MsgBox, 48, gdiplus error!, Gdiplus failed to start. Please ensure you have gdiplus on your system
	ExitApp
}

coordmode pixel
coordMode screen


;==================================================

;based on LetUserSelectRect by Lexikos:
;LetUserSelectRect - select a portion of the screen - Scripts and Functions - AutoHotkey Community
;https://autohotkey.com/board/topic/45921-letuserselectrect-select-a-portion-of-the-screen/

;note: 'CoordMode, Mouse, Screen' must be used in the auto-execute section

;e.g.

#LButton::
MouseGetPos, originX, originY
InputRect(vWinX, vWinY, vWinR, vWinB)
vWinW := vWinR-vWinX, vWinH := vWinB-vWinY
if (vInputRectState = -1)
	return

InputRect(ByRef vX1, ByRef vY1, ByRef vX2, ByRef vY2)
{
	global vInputRectState := 0
	DetectHiddenWindows, On
	Gui, 1: -Caption +ToolWindow +AlwaysOnTop +hWndhGuiSel
	Gui, 1: -DPIScale
	Gui, 1: Color, Red
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
	Gui, 1: Destroy
	MsgBox % "x" vX1 " y" vY1 " w" vW0 " h" vH0
	ToolTip
	Gosub, Scan
	return

	InputRect_Update:
	if !vInputRectState
	{
		MouseGetPos, vX, vY
		(vX < vX0) ? (vX1 := vX, vX2 := vX0) : (vX1 := vX0, vX2 := vX)
		(vY < vY0) ? (vY1 := vY, vY2 := vY0) : (vY1 := vY0, vY2 := vY)
		; Gui, 1:Show, % "NA x" vX1 " y" vY1 " w" (vX2-vX1) " h" (vY2-vY1)
		vW0 := (vX2-vX1), vH0 := (vY2-vY1)
		Gui, 1:Show, % "NA x" vX1 " y" vY1 " w" vW0 " h" vH0
		ToolTip % "x" vX1 " y" vY1 " w" vW0 " h" vH0
		return
	}
	vInputRectState := 1

	InputRect_End:
	if !vInputRectState
		vInputRectState := -1
	Hotkey, *LButton, Off
	SetTimer, InputRect_Update, Off
	Gui, 1: Destroy


	InputRect_Return:
	return
}

; #LButton Up::
; Gosub, Scan
; ToolTip
; Return


; !#LButton::
; 	MouseGetPos, originX, originY
; 	originX := xm, originY := ym
; 	SetTimer, WhileHolding, 20
; Return

; WhileHolding:
; 	MouseGetPos, xm, ym
; 	width := (xm - originX), height := (ym - originY)
; 	ToolTip % "w: " width "`t" "h: " height
; Return

; !#LButton Up::
; 	SetTimer, WhileHolding, Off
; 	ToolTip
; 	Gosub, Scan
; Return

Scan:
t:=a_tickcount
spectrum:=""
res:=""
; w:=h:=20 ; area right of cursor
; xm:=300
; ym:=300
; vX1 " y" vY1 " w" vW0 " h" vH0

screen:=vX1 "|" vY1 "|" vW0 "|" vH0

pBitmap:=Gdip_BitmapFromScreen(screen)

E1 := Gdip_LockBits(pBitmap, 0, 0, vW0, vH0, Stride1, Scan1, BitmapData1)

x := -1
y := -1
xLoc := 0
yLoc := 0
Loop, %vW0%
  {
            Loop, %vH0%
              {
              spectrum .= format("{1:x}",Gdip_GetLockBitPixel(Scan1, xLoc, yLoc, Stride1)) "`n"
                         
              yLoc := yLoc + 1
              }
  xLoc := xLoc + 1
  yLoc :=0
  }
Gdip_UnlockBits(pBitmap1, BitmapData1)

Gdip_SaveBitmapToFile(pBitmap,"test.png")

Gdip_DisposeImage(pBitmap)

Gdip_Shutdown(pToken)
arr:={}
z:=""
m:=""
loop, Parse, spectrum, `n, `r
{
	if ( !Arr.Haskey(A_LoopField) )
		Arr[A_LoopField] := 1
	else
		Arr[A_LoopField] += 1
}	
for key, val in Arr
	z .= val "`t" key "`n"
	
Sort, z,N R

loop,parse,z,`n,`r
{
if A_Index=7
break
m .=A_LoopField "`n"
}

msgbox % a_tickcount-t "ms`n`n`n" m

Return

; exitapp
