	#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
	SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
	SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
	#SingleInstance Force


SearchAHKDocs:
; SearchAHKDocs() {
	If !WinExist("ahk_class HH Parent")	{
		Run, C:\Program Files\AutoHotkey\AutoHotkey.exe, Hidden
		WinMove, ahk_class HH Parent,, -1536, 1008, 1202, 1152
		WinActivate, ahk_class HH Parent
		Sleep, 200
		If WinActive("ahk_class HH Parent")	{
			Send, {AltDown}{n}{AltUp}
			ControlFocus, Edit1, ahk_class HH Parent	
		}
	} Else {
		WinActivate, ahk_class HH Parent
		IfWinActive, ahk_class HH Parent
		{
			Send, {AltDown}{n}{AltUp}
			ControlFocus, Edit1, ahk_class HH Parent	
		}
	}	
Return
; }


JumpToExtendScript:
If WinActive("ahk_class AE_CApplication_15.1") {
	If WinExist("ahk_class Estoolkit35") {
		WinActivate, ahk_class Estoolkit35
		Return
		}
} Else If WinActive("ahk_class Estoolkit35") {
	If WinExist("ahk_class AE_CApplication_15.1") {
		WinActivate, ahk_class AE_CApplication_15.1
		Return
	} Else If WinExist("ahk_class illustrator") {
		WinActivate, ahk_class illustrator
		Return
	} Else {
	WinMinimize, ahk_class Estoolkit35
	WinActivate, ahk_id %active_id%
	Return
	}
} Else {
	WinGet, active_id, ID, A
}
If !WinExist("ahk_class Estoolkit35") {
		Run, ExtendScript Toolkit.exe, C:\Program Files (x86)\Adobe\Adobe ExtendScript Toolkit CC, Hidden
	} Else {
		WinActivate, ahk_class Estoolkit35
	}
Return


; GitBash ToggleRun
JumpToGit:
; JumpToGit(){
If WinActive("ahk_exe mintty.exe") {
	WinMinimize, ahk_exe mintty.exe
	WinActivate, ahk_id %active_id%
	Return
} Else {
	WinGet, active_id, ID, A
}
If !WinExist("ahk_exe mintty.exe") {
		Run, git-bash.exe, C:\Program Files\Git\, Hidden
		WinWait, ahk_exe mintty.exe
		WinActivate, ahk_exe mintty.exe
		; WinMove, ahk_exe mintty.exe,, 0, ((A_ScreenHeight/5) * 4), (A_ScreenWidth/2), ((A_ScreenHeight/5) - (taskbarH * 2))
		WinSet, Style, ^0xC00000, ahk_exe mintty.exe
		WinMove, ahk_exe mintty.exe,, 0, 850, 1280, 540
		SendInput, {Raw}cd C:/Users/PortablePawnShop/Documents/GitMaster
		Send, {Enter}
		Sleep, 100
		SendInput, Clear{Enter}
		; MsgBox % "GitBash has been created"
	} Else {
		WinRestore, ahk_exe mintty.exe
		WinActivate, ahk_exe mintty.exe
		; MsgBox % "GitBash already exists"
	}
Return
; }


; Jump to Sublime Editor
JumpToSublime:
	IfWinActive, ahk_class PX_WINDOW_CLASS
	{
		IfWinExist, ahk_class illustrator
		{
			WinActivate, ahk_class illustrator
			Return
		}
		IfWinExist, ahk_class AE_CApplication_15.1
			{
				WinActivate, ahk_class AE_CApplication_15.1
				Return
			}	
	} Else IfWinActive, ahk_class illustrator
		{
			IfWinExist, ahk_class PX_WINDOW_CLASS
			{
				WinActivate, ahk_class PX_WINDOW_CLASS
				Return
			}
	} Else IfWinActive, ahk_class AE_CApplication_15.1
		{
			IfWinExist, ahk_class PX_WINDOW_CLASS
			{
				WinActivate, ahk_class PX_WINDOW_CLASS
				Return
			}
	} Else {
		If !WinExist(ahk_class PX_WINDOW_CLASS) {
			Run, C:\Users\PortablePawnShop\Downloads\Sublime Text v3.3126\sublime_text.exe, Hidden
			WinWait, Update Available ahk_class #32770,, 2
			IfWinActive, Update Available ahk_class #32770
			{
				Send, {Right}{Enter}
			}
			WinActivate, ahk_class PX_WINDOW_CLASS
			; WinMove, ahk_class PX_WINDOW_CLASS,, (A_ScreenWidth/2), 0, (A_ScreenWidth/2), (A_ScreenHeight - (taskbarH * 2))
		} Else {
			WinActivate, ahk_class PX_WINDOW_CLASS
			IfWinActive, Update Available ahk_class #32770
			{
				Send, {Right}{Enter}
			}
		}
	}
Return





; Jump to Atom Editor
JumpToAtom:
; JumpToAtom() {
	IfWinActive, ahk_exe atom.exe
	{
		IfWinExist, ahk_class illustrator
		{
			WinActivate, ahk_class illustrator
			Return
		}
		IfWinExist, ahk_class AE_CApplication_15.1
			{
				WinActivate, ahk_class AE_CApplication_15.1
				Return
			}	
	} Else IfWinActive, ahk_class illustrator
		{
			IfWinExist, ahk_exe atom.exe
			{
				WinActivate, ahk_exe atom.exe
				Return
			}
	} Else IfWinActive, ahk_class AE_CApplication_15.1
		{
			IfWinExist, ahk_exe atom.exe
			{
				WinActivate, ahk_exe atom.exe
				Return
			}
	} Else {
		; If !WinExist(ahk_class Chrome_WidgetWin_1) {
		; If !WinExist(ahk_class Chrome_WidgetWin_1 ahk_exe atom.exe) {
		If !WinExist("ahk_exe atom.exe") {
			Run, C:\Users\PortablePawnShop\AppData\Local\atom\app-1.26.1\atom.exe, Hidden
			WinActivate, ahk_exe atom.exe
			WinMove, ahk_exe atom.exe,, (A_ScreenWidth/2), 0, (A_ScreenWidth/2), (A_ScreenHeight - (taskbarH * 2))
		} Else {
			WinActivate, ahk_exe atom.exe
		}
	}
	Return
; }

EditScript:
; EditScript(){
Run, edit New.ahk, %A_ScriptDir%
	Sleep, 150
	Send, {CtrlDown}{ShiftDown}{s}{CtrlUp}{ShiftUp}
	Sleep, 50
	WinWait, Save As ahk_class #32770,, 2
		If ErrorLevel {
			MsgBox Save screen failed
			Return
		}
	Send, {Left 4}{BackSpace 3}
	Send, {LWinUp}
Return
; }


