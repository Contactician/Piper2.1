	; #NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
	SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
	SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
	#SingleInstance Force

; SetTitleMatchMode, 2
; #NoTrayIcon



; ////// Sublime Text
SublimeKeys := 				 	{"XButton1" : "{XButton2}"
								,"XButton2" : "{XButton1}"	
								,"^w" : "{CtrlDown}{h}{CtrlUp}"
								,"^+w" : "{CtrlDown}{ShiftDown}{h}{ShiftUp}{CtrlUp}"
								,"$+Enter" : "Return{Enter}"
								,"^+Enter" : "Send, {{}"
								,"^!Enter" : "SendInput, {{}Raw{Right}{Space}{BackSpace}"
								,"#^Enter" : """``r``n""{Space}"
								,"#Tab" : "Tab{Space}{BackSpace}"
								,"#CapsLock" : "CapsLock{Space}{BackSpace}"
								,"#Space" : "Space{Space}{BackSpace}"
								,"#BackSpace" : "BackSpace{Space}{BackSpace}"
								,"#Enter" : "Enter{Space}{BackSpace}"
								,"#RControl" : "Ctrl{Space}{BackSpace}"
								,"#RShift" : "Shift{Space}{BackSpace}"
								,"#RAlt" : "Alt{Space}{BackSpace}"
								,"#!Up" : "Up{Space}{BackSpace}"
								,"#!Down" : "Down{Space}{BackSpace}"
								,"#^Left" : "Break{Enter}"
								,"#^Right" : "Continue{Enter}"
								,"#^Numpad0" : "Loop,{Space}{ShiftDown}{5}{ShiftUp}{Space}"
								,"#^NumpadDot" : "A_Index{Space}{BackSpace}"
								,"#^NumpadEnter" : "for vKey, vValue in{Space}{{}{Enter}"
								,"#^NumpadAdd" : "for vKey2, vValue2 in vValue{Space}{{}{Enter}"
								,"#^NumpadSub" : "vOutput :={Space}{ShiftDown}{'}{ShiftUp}"
								,"#^Up" : "If (){Space}{BackSpace}{Left}"
								,"#^Down" : "Else (){Space}{BackSpace}{Left}"
								,"#!Left" : "{{}{Enter}"
								,"#!Right" : "{{}{Enter}"
								,"^#=" : ":={Space}"
								,"!=" : "+1={Space}"
								,"#!=" : ".={Space}"
								,"^+\" : "MsgBox{Space}{ShiftDown}{5}{ShiftUp}{Space}"
								,"^!\" : "ToolTip{Space}{ShiftDown}{5}{ShiftUp}{Space}"
								,"<!Left" : "{Home}"
								,"<!Right" : "{End}"
								,"<!Up" : "{Up 5}"
								,"<!Down" : "{Down 5}"
								,"^RButton" : "{CtrlDown}{/}{CtrlUp}"
								,"^XButton1" : "{CtrlDown}{]}{CtrlUp}"
								,"^XButton2" : "{CtrlDown}{[}{CtrlUp}"		
								,"<+Space" : "Sleep, 50{Enter}"
								,"<+!Up" : "Up"
								,"<+!Down" : "Down"
								,"F13" : "{Enter}"
								,"F15" : "{PgUp}"
								,"F16" : "{PgDn}"		
								,"<^F13" : "{LControl Up}{Delete Down}"
								,"<^F13 Up" : "{Delete Up}"}
	Hotkey, IfWinActive, ahk_class PX_WINDOW_CLASS
	bindHotkeysFromKeyMap(SublimeKeys)
	Hotkey, If
; ////// Sublime Text



; ; ////// GitBash
; gitKeys :=  					{"^BackSpace" : "clear{Enter}"
; 								,"^v" : "+{Insert}"
; 								,"^j":"cd "
; 								,"^k":"pwd{Enter}"
; 								,"^l":"ls{Enter}"
; 								,"+^l":"ls -a{Enter}"
; 								,"^i":"git "
; 				         	    ,"^b":"echo """" >> .txt{Left 9}"
; 				    	        ,"^n":"touch "
; 				      	        ,"^m":"mkdir "
; 				      	    	,"^Up":"cd ..{Enter}"
; 				      	    	,"^+Up":"cd ../../{Enter}"
; 				      	    	,"^Down":"pwd{Enter}"
; 								,"^+Down":"ls{Enter}"
; 								,"^Right":"touch .html{Left 5}"
; 								,"^+Right":"touch .css{Left 4}"
; 								,"!Right":"touch .txt{Left 4}"
; 								,"^!Right":"echo """" >> .txt{Left 9}"
; 								,"^Numpad1":"git init{Enter}"
; 								,"^NumpadEnd":"git remote add origin "
; 								,"^Numpad2":"git add "
; 								,"^NumpadDown":"git add .{Enter}"
; 								,"^!Numpad2":"git reset HEAD ."
; 								,"^Numpad3":"git commit -m """"{Left}"
; 								,"^NumpadPgdn":"git push -u origin master{Enter}"
; 								,"^NumpadIns":"git --help{Enter}"
; 								,"^Numpad0":"git status{Enter}"
; 								,"^NumpadDot":"ls -a{Enter}"
; 								,"^Numpad4":"git remote add origin "
; 								,"^Numpad5":"git remote -v{Enter}" 
; 								,"^Numpad6":"git push -u origin master{Enter}"
; 								,"^Esc" : ".exit{Enter}"}
; 	Hotkey, IfWinActive, ahk_class mintty
; 	bindHotkeysFromKeyMap(gitKeys)
; 	Hotkey, If
; ; ////// GitBash



; //// Chrome
ChromeKeys := 					{"F13" : "Send, ^e"
								,"F14" : "Send, ^t"
								,"^F14" : "Send, ^+b"
								,"F15" : "Send, ^{PgUp}"
								,"F16" : "Send, ^{PgDn}"
								,"F18" : "Send, ^+i"
								,"^F18" : "Send, ^u"
								,"XButton1" : "Send, {XButton1}"
								,"XButton2" : "Send, {XButton2}"}
	Hotkey, IfWinActive, ahk_exe chrome.exe
	bindHotkeysFromKeyMap(ChromeKeys)
	Hotkey, If



; ///// Misc
AdobeMenuKeys := 				{"F13" : "Send, {Enter}"
								,"XButton2" : "Send, {Tab}"
								,"XButton1" : "Send, +{Tab}"}
	Hotkey, IfWinActive, ahk_class #32770
	bindHotkeysFromKeyMap(AdobeMenuKeys)
	Hotkey, If


VStudioKeys :=	 				{"^Rbutton" : "Send, {CtrlDown}{/}{CtrlUp}"
								,"F13" : "Send, {Enter}"}
	Hotkey, IfWinActive, ahk_class #32770
	bindHotkeysFromKeyMap(VisualStudioKeys)
	Hotkey, If
; ///// Misc



; ///// Atom
SetTitleMatchMode, RegEx
HTMLKeys :=				  		{"^XButton1" : "^]"
								,"^XButton2" : "^["
								,"^Numpad7" : "<link href=""./resources/css/style.css"" type=""text/css"" rel=""stylesheet"">"
								,"<!Left" : "{Home}"
								,"<!Right" : "{End}"
								,"^RButton" : "^/"}
	Hotkey, IfWinActive, (?i).*\.html
	bindHotkeysFromKeyMap(HTMLKeys)
	Hotkey, If

CSSKeys := 				 		{"^NumpadDiv" : "border: 2px solid black;{Enter}"
								,"^Numpad8" : "resources\images\"
							    ,"^Numpad9" : "url(""../images/"");{Left 3}"
								,"^RButton" : "^/"}
	Hotkey, IfWinActive, (?i).*\.css
	bindHotkeysFromKeyMap(CSSKeys)
	Hotkey, If

JavaScriptKeys := 			 	{"^l" : "console.log();{Left 2}"
								, "^Numpad7" : """"" : """""
							    ,"^Enter" : "(function() {{Enter}});"
								, "^!Enter" : "`'`/n{Right}{Space}"
								,"^RButton" : "^/"}
	Hotkey, IfWinActive, (?i).*\.js
	bindHotkeysFromKeyMap(JavaScriptKeys)
	Hotkey, If
; ///// Atom





KeySet(msg) {
	SendInput, % msg
}

bindHotkeysFromKeyMap(KeyMap) {
	for keybind, command in KeyMap {
		bf  :=  Func("KeySet").bind(command)
		Hotkey, % keybind, % bf, On
	}
}

nextLayer() {
	static layers := ["HTML", "CSS", "JavaScript"]
	static index

	++index
	if (index > layers.MaxIndex()) {
		index := 1
	}

	return layers[index]
}

; Return




; ////// Legacy

; Scripts
; ^#F13::
SearchAHKDocs() {

	IfWinNotExist, ahk_class HH Parent
	{
		Run, C:\Program Files\AutoHotkey\AutoHotkey.exe, Hidden
		WinMove, ahk_class HH Parent,, -1536, 1008, 1202, 1152
		WinActivate, ahk_class HH Parent
		Sleep, 200
		IfWinActive, ahk_class HH Parent
		{
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
}


; GitBash ToggleRun
; ^#F14::
JumpToGit() {
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
}

; Jump to Sublime Editor
	; ^#F15::
JumpToSublime() {
	IfWinActive, ahk_class PX_WINDOW_CLASS
	{
		IfWinExist, ahk_class illustrator
		{
			WinActivate, ahk_class illustrator
			Return
		}
		IfWinExist, ahk_class AE_CApplication_15.0
			{
				WinActivate, ahk_class AE_CApplication_15.0
				Return
			}	
	} Else IfWinActive, ahk_class illustrator
		{
			IfWinExist, ahk_class PX_WINDOW_CLASS
			{
				WinActivate, ahk_class PX_WINDOW_CLASS
				Return
			}
	} Else IfWinActive, ahk_class AE_CApplication_15.0
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
			WinMove, ahk_class PX_WINDOW_CLASS,, (A_ScreenWidth/2), 0, (A_ScreenWidth/2), (A_ScreenHeight - (taskbarH * 2))
		} Else {
			WinActivate, ahk_class PX_WINDOW_CLASS
			IfWinActive, Update Available ahk_class #32770
			{
				Send, {Right}{Enter}
			}
		}
	}
Return
}




; Jump to Atom Editor
; !#F15::
JumpToAtom() {
	IfWinActive, ahk_exe atom.exe
	{
		IfWinExist, ahk_class illustrator
		{
			WinActivate, ahk_class illustrator
			Return
		}
		IfWinExist, ahk_class AE_CApplication_15.0
			{
				WinActivate, ahk_class AE_CApplication_15.0
				Return
			}	
	} Else IfWinActive, ahk_class illustrator
		{
			IfWinExist, ahk_exe atom.exe
			{
				WinActivate, ahk_exe atom.exe
				Return
			}
	} Else IfWinActive, ahk_class AE_CApplication_15.0
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
			Run, C:\Users\PortablePawnShop\Downloads\atom-windows\Atom\atom.exe, Hidden
			WinActivate, ahk_exe atom.exe
			WinMove, ahk_exe atom.exe,, (A_ScreenWidth/2), 0, (A_ScreenWidth/2), (A_ScreenHeight - (taskbarH * 2))
		} Else {
			WinActivate, ahk_exe atom.exe
		}
	}
	Return
}



EditScript(){
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
}




; NodeTest:
;         WinGetTitle, AtomTitle, ahk_exe atom.exe
;         TrimLPoint := InStr(AtomTitle, "—")
;         TrimL := SubStr(AtomTitle, 1, (TrimLPoint - 2))
;         TrimRPoint := InStr(AtomTitle, "—",, TrimLPoint + 1)
;         TrimR := SubStr(AtomTitle, TrimRPoint, (StrLen(AtomTitle) - TrimRPoint) + 1)
;         TrimMid := SubStr(AtomTitle, TrimLPoint, (StrLen(AtomTitle) - StrLen(TrimR) - StrLen(TrimL) - 2))
;         FullLength := StrLen(AtomTitle) - TrimRPoint

;         AtomTitle := TrimL
;         AtomPath := Substr(TrimMid, 3, (StrLen(TrimMid) - 2))

;         JumpToGit()
;         ; If WinActive("ahk_exe mintty.exe") {
;         ; 	Send, cd{space}%AtomPath%	
;         ; }

;         ; SendInput,
; Return

; NodeRun:
; 	MsgBox % "Works"
; 	; Send, cd{space}%AtomPath%
; Return


; Esc::ExitApp, 0
; MButton::
; {
; 	SubTitle := nextLayer()
; 	ToolTip, % SubTitle, % (A_ScreenWidth // 2), % (A_ScreenHeight // 2)
; 	SetTimer, clearTooltip, -1000
; return
; }

; clearTooltip:
; {
; 	ToolTip
; return
; }


; NOTES

; Hotkey, If, (SubTitle == "JavaScript") ;case-sensitive comparison
	; #If, (SubTitle == "HTML")
	; #If, (SubTitle == "CSS")
	; #If, (SubTitle == "JavaScript")
	; #If