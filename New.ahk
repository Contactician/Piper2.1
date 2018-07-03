#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, force





var := "stop"
Return


	F12::Reload



	numpad7::Send, {space}dqwa


f24::
	WinGet, WinState, MinMax, ahk_exe sublime_text.exe
	MsgBox % Winstate
Return


