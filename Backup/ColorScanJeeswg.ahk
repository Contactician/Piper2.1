#NoEnv
#SingleInstance, Force
SetWorkingDir %A_ScriptDir%
#Include, Gdip_All.ahk

CoordMode, Mouse, Screen

;based on:
;Gdip: image binary data to hex string for OCR - AutoHotkey Community
;https://autohotkey.com/boards/viewtopic.php?t=35339

;[Gdip functions]
;GDI+ standard library 1.45 by tic - AutoHotkey Community
;https://autohotkey.com/boards/viewtopic.php?f=6&t=6517

q:: ;get frequency count for pixels in a rectangle

Scan:     ; Wanted to make this a label so I can GoSub it
pToken := Gdip_Startup()

; vPosX := 300, vPosY := 300
; vPosW := 300, vPosH := 300

vImgPos := Format("{}|{}|{}|{}", originX, originY, vW0, vH0)      ; here

pBitmap := Gdip_BitmapFromScreen(vImgPos)
pBitmap2 := Gdip_CloneBitmapArea(pBitmap, 0, 0, vW0, vH0, 0x26200A)       ; here
hBitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap2)
VarSetCapacity(DIBSECTION, vSizeDS:=A_PtrSize=8?104:84, 0)
DllCall("gdi32\GetObject", Ptr,hBitmap, Int,vSizeDS, Ptr,&DIBSECTION)
vAddr := NumGet(DIBSECTION, A_PtrSize=8?24:20, "Ptr") ;bmBits
vSize := NumGet(DIBSECTION, A_PtrSize=8?52:44, "UInt") ;biSizeImage
vHex := JEE_StrBinToHex(vAddr, vSize)
Clipboard := vHex
;get pixel count:
MsgBox, % Round(StrLen(vHex) / 8) " " (vW0 * vH0)        ; here

DeleteObject(hBitmap)
Gdip_DisposeImage(pBitmap)
Gdip_DisposeImage(pBitmap2)
Gdip_Shutdown(pToken)

MsgBox, % vHex
vOutput := RegExReplace(vHex, "(.{6})..", "$1,") ;BGR
vOutput := SubStr(vOutput, 1, -1)
MsgBox, % vOutput

oArray := {}
Loop, Parse, vOutput, % ","
	if oArray.HasKey("z" A_LoopField)
		oArray["z" A_LoopField]++
	else
		oArray["z" A_LoopField] := 1
;frequency count for pixel colours (BGR)
vOutput2 := ""
for vKey, vValue in oArray
	vOutput2 .= vValue "`t" SubStr(vKey, 2) "`r`n"
Clipboard := vOutput2
MsgBox, % vOutput2
return

;==================================================

;JEE_BinDataToHex
JEE_StrBinToHex(vAddr, vSize, vCase:="U")
{
	static vIsVistaPlus := (DllCall("kernel32\GetVersion", UInt) & 0xFF) >= 6
	if vIsVistaPlus
	{
		;CRYPT_STRING_NOCRLF := 0x40000000
		;CRYPT_STRING_HEXRAW := 0xC ;to return raw hex (not supported by Windows XP)
		DllCall("crypt32\CryptBinaryToString", Ptr,vAddr, UInt,vSize, UInt,0x4000000C, Ptr,0, UIntP,vChars)
		VarSetCapacity(vHex, vChars*2, 0)
		DllCall("crypt32\CryptBinaryToString", Ptr,vAddr, UInt,vSize, UInt,0x4000000C, Str,vHex, UIntP,vChars)
	}
	else
	{
		;CRYPT_STRING_HEX := 0x4 ;to return space/CRLF-separated text
		DllCall("crypt32\CryptBinaryToString", Ptr,vAddr, UInt,vSize, UInt,0x4, Ptr,0, UIntP,vChars)
		VarSetCapacity(vHex, vChars*2, 0)
		DllCall("crypt32\CryptBinaryToString", Ptr,vAddr, UInt,vSize, UInt,0x4, Str,vHex, UIntP,vChars)
		vHex := StrReplace(vHex, "`r`n")
		vHex := StrReplace(vHex, " ")
	}
	if (vCase = "L")
		return vHex
	else
		return Format("{:U}", vHex)
}

;==================================================

;==================================================

;based on LetUserSelectRect by Lexikos:
;LetUserSelectRect - select a portion of the screen - Scripts and Functions - AutoHotkey Community
;https://autohotkey.com/board/topic/45921-letuserselectrect-select-a-portion-of-the-screen/

;note: 'CoordMode, Mouse, Screen' must be used in the auto-execute section

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
		MsgBox % "x" vX1 " y" vY1 " w" vW0 " h" vH0       ; To verify dimensions are correct
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


;==================================================

