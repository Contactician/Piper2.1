	; #NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
	SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
	SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
	#SingleInstance Force

SetTitleMatchMode, 2
SetDefaultMouseSpeed, 3
; #NoTrayIcon

; GenerateKeybinds:
; ////// Sublime Text
SublimeKeys := 				 	{"XButton1" : "{XButton2}"
								,"XButton2" : "{XButton1}"	
								,"^w" : "^{h}"
								,"^+w" : "^+{h}"
								; ,"^#XButton2" : "Gosub, Launch"
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
								,"#^Numpad0" : "Loop,{Space}+{5}{Space}"
								,"#^NumpadDot" : "A_Index{Space}{BackSpace}"
								,"#^NumpadEnter" : "for vKey, vValue in{Space}{{}{Enter}"
								,"#^NumpadAdd" : "for vKey2, vValue2 in vValue{Space}{{}{Enter}"
								,"#^NumpadSub" : "vOutput :={Space}+{'}"
								,"#^Up" : "If (){Space}{BackSpace}{Left}"
								,"#^Down" : "Else (){Space}{BackSpace}{Left}"
								,"#!Left" : "{{}{Enter}"
								,"#!Right" : "{{}{Enter}"
								,"^#=" : ":={Space}"
								,"!=" : "+1={Space}"
								,"#!=" : ".={Space}"
								,"^+\" : "MsgBox{Space}+{5}{Space}"
								,"^!\" : "ToolTip{Space}+{5}{Space}"
								,"<!Left" : "{Home}"
								,"<!Right" : "{End}"
								,"<!Up" : "{Up 5}"
								,"<!Down" : "{Down 5}"
								,"^RButton" : "^{/}"
								,"^;" : "^{/}"
								,"^XButton1" : "^{]}"
								,"^XButton2" : "^{[}"		
								,"<+Space" : "Sleep, 50{Enter}"
								,"<+!Up" : "Up"
								,"<+!Down" : "Down"
								,"F13" : "{Enter}"
								,"F15" : "{PgUp}"
								,"F16" : "{PgDn}"		
								,"<^F13" : "{Delete}"}
	Hotkey, IfWinActive, ahk_class PX_WINDOW_CLASS
	bindHotkeysFromKeyMap(SublimeKeys)
	Hotkey, If
; ////// Sublime Text



; ////// GitBash
gitKeys :=  					{"^BackSpace" : "clear{Enter}"
								,"^v" : "+{Insert}"
								,"^j":"cd "
								,"^k":"pwd{Enter}"
								,"^l":"ls{Enter}"
								,"+^l":"ls -a{Enter}"
								,"^i":"git "
				         	    ,"^b":"echo """" >> .txt{Left 9}"
				    	        ,"^n":"touch "
				      	        ,"^m":"mkdir "
				      	    	,"^Up":"cd ..{Enter}"
				      	    	,"^+Up":"cd ../../{Enter}"
				      	    	,"^Down":"pwd{Enter}"
								,"^+Down":"ls{Enter}"
								,"^Right":"touch .html{Left 5}"
								,"^+Right":"touch .css{Left 4}"
								,"!Right":"touch .js{Left 3}"
								,"^!Right":"echo """" >> .txt{Left 9}"
								,"^Numpad1":"git init{Enter}"
								,"^NumpadEnd":"{Shift Up}git remote add origin "
								,"^Numpad2":"git add "
								,"^NumpadDown":"{Shift Up}git add .{Enter}"
								,"^!Numpad2":"git reset HEAD ."
								,"^Numpad3":"git commit -m """"{Left}"
								,"^NumpadPgdn":"{Shift Up}git push -u origin master{Enter}"
								,"^NumpadIns":"git --help{Enter}"
								,"^Numpad0":"git status{Enter}"
								,"^NumpadDot":"ls -a{Enter}"
								,"^Numpad4":"git remote add origin "
								,"^Numpad5":"git remote -v{Enter}" 
								,"^Numpad6":"git push -u origin master{Enter}"
								,"^Esc" : ".exit{Enter}"}
	Hotkey, IfWinActive, ahk_exe mintty.exe
	bindHotkeysFromKeyMap(gitKeys)
	Hotkey, If
; ////// GitBash


; ////// ExtendScript
ExtendScriptKeys := 		 	{"^#BackSpace" : "^+c"
								,"^+Enter" : "{F5}"
								,"^`'" : """""`;{Left 2}"
								,"^+\" : "alert ();{Left 2}^'"
								, "^Numpad7" : "try+[{Enter}{Enter}+]catch+9err+0+[{Enter}alert+9""Line "" += err.line += ""`\n"" += err.toString+9+0+0`;{Enter}+]{Up}{Home}{Tab}{Up 2}"
								, "^Numpad8" : ".toString().replace(new RegEx("","", ""g""), ""\r"");"
								,"#^Enter" : """`\n""{Space}"
								,"^l" : "log `;{Left}"
								,"^XButton1" : "+{Tab}"
								,"^XButton2" : "{Tab}"	
								,"XButton1" : "^+{Tab}"
								,"XButton2" : "^{Tab}"	
								,"^Rbutton" : "^+{k}"
								,"^/" : "^+{k}"
								,"F24" : "{F5}"}
	Hotkey, IfWinActive, ahk_class Estoolkit35
	bindHotkeysFromKeyMap(ExtendScriptKeys)
	Hotkey, If



; //// Chrome
ChromeKeys := 					{"F13" : "^e"
								,"F14" : "^t"
								,"^F14" : "^+b"
								,"F15" : "^{PgUp}"
								,"F16" : "^{PgDn}"
								,"F18" : "^+i"
								,"^F18" : "^u"
								,"XButton1" : "{XButton1}"
								,"XButton2" : "{XButton2}"}
	Hotkey, IfWinActive, ahk_exe chrome.exe
	bindHotkeysFromKeyMap(ChromeKeys)
	Hotkey, If



; ///// Misc
AdobeMenuKeys := 				{"F13" : "{Enter}"
								,"XButton2" : "{Tab}"
								,"XButton1" : "+{Tab}"}
	Hotkey, IfWinActive, ahk_class #32770
	bindHotkeysFromKeyMap(AdobeMenuKeys)
	Hotkey, If


VStudioKeys :=	 				{"^Rbutton" : "^{/}"
								,"F13" : "{Enter}"}
	Hotkey, IfWinActive, ahk_class #32770
	bindHotkeysFromKeyMap(VisualStudioKeys)
	Hotkey, If
; ///// Misc


PhotoshopKeys := 				{"F13" : "{Enter}"
								,"F14" : "i"
								,"F15" : "p"
								,"F16" : "s"
								,"F17" : "r"
								,"XButton2" : "a"
								,"XButton1" : "v"}
								; ,"MButton" : "+{F7}"
								; ,"^F13" : "{Delete}"
								; ,"^XButton2" : "+{F11}"
								; ,"^XButton1" : "^{F11}"
								; ,"^MButton" : "^g"
								; ,"+F13" : "!{F12}"
								; ,"+F16" : "^7"
								; ,"+F17" : "^8"
								; ,"+XButton2" : "^+{F12}"
								; ,"+XButton1" : "+{F12}"
								; ,"+F18" : "^{F12}"
								; ,"+MButton" : "+m"
								; ,"!F15" : "{F3}"
								; ,"!F16" : "{F5}"
								; ,"!XButton2" : "^+]"
								; ,"!XButton1" : "^+["
								; ,"!MButton" : "^+g"
								; ,"!RButton" : "/"
								; ,"^+XButton2" : "^{F3}"
								; ,"^+XButton1" : "+{F3}"
								; ,"^!F13" : "{F8}"
								; ,"^!F14" : "^{F8}"
								; ,"^!F15" : "{F9}"
								; ,"^!F16" : "^{F9}"
								; ,"^!F17" : "^+{F6}"
								; ,"^!XButton2" : "{F10}"
								; ,"^!XButton1" : "{F11}"
								; ,"^!MButton" : "^j"
								; ,"^!RButton" : "^3"
								; ,"+!F13" : "+{F9}"
								; ,"+!F14" : "!{F2}"
								; ,"+!F15" : "^!y"
								; ,"+!F16" : "^!+s"
								; ,"+!F17" : "{F6}"
								; ,"+!XButton2" : "^{`'}"
								; ,"+!XButton1" : "+^{`'}"
								; ,"+!F18" : "+{F6}"
								; ,"+!MButton" : "{F12}"
								; ,"+!RButton" : "^2"}
	Hotkey, IfWinActive, ahk_class Photoshop
	bindHotkeysFromKeyMap(PhotoshopKeys)
	Hotkey, If


IllustratorKeys := 				{"F13" : "{Enter}"
								,"F14" : "i"
								,"F15" : "p"
								,"F16" : "s"
								,"F17" : "r"
								; , "z" : "/"
								,"XButton2" : "v"
								,"XButton1" : "a"
								,"MButton" : "+{F7}"
								; ,"^F13" : "{Delete}"
								,"^XButton2" : "+{F11}"
								,"^XButton1" : "^{F11}"
								,"^MButton" : "^g"
								,"+F13" : "!{F12}"
								,"+F16" : "^7"
								,"+F17" : "^8"
								,"+XButton2" : "^+{F12}"
								,"+XButton1" : "+{F12}"
								,"+F18" : "^{F12}"
								,"+MButton" : "+m"
								,"!F15" : "{F3}"
								,"!F16" : "{F5}"
								,"!XButton2" : "^+]"
								,"!XButton1" : "^+["
								,"!MButton" : "^+g"
								; ,"!RButton" : "/"
								,"^+XButton2" : "^{F3}"
								,"^+XButton1" : "+{F3}"
								,"^!F13" : "{F8}"
								,"^!F14" : "^{F8}"
								,"^!F15" : "{F9}"
								,"^!F16" : "^{F9}"
								,"^!F17" : "^+{F6}"
								,"^!XButton2" : "{F10}"
								,"^!XButton1" : "{F11}"
								,"^!MButton" : "^j"
								,"^!RButton" : "^3"
								,"+!F13" : "+{F9}"
								,"+!F14" : "!{F2}"
								,"+!F15" : "^!y"
								,"+!F16" : "^!+s"
								,"+!F17" : "{F6}"
								,"+!XButton2" : "^{`'}"
								,"+!XButton1" : "+^{`'}"
								,"+!F18" : "+{F6}"
								,"+!MButton" : "{F12}"
								,"+!RButton" : "^2"}
	Hotkey, IfWinActive, ahk_class illustrator
	bindHotkeysFromKeyMap(IllustratorKeys)
	Hotkey, If


; ////// AE 
AfterEffectsKeys :=				{"F13" : "{Enter}"
								,"F14" : "^e"
								,"F15" : "p"
								,"F16" : "s"
								,"F17" : "r"
								,"XButton2" : "v"
								,"XButton1" : "u"
								,"F18" : "t"
								,"^F13" : "{Delete}"
								,"^F14" : "^t"
								,"^F15" : "g"
								,"^F16" : "q"
								,"^F17" : "^{Up}"
								,"^XButton2" : "{PgDn}"
								,"^XButton1" : "{PgUp}"
								,"^F18" : "^{Down}"
								,"^MButton" : "^d"
								,"+F15" : "k"
								,"+F16" : "j"
								,"+F17" : "["
								,"+F18" : "]"
								,"+MButton" : "{F9}"
								,"!F13" : "+{F3}"
								,"!F14" : "^!k"
							 	,"!F15" : "+!p"
								,"!F16" : "+!s"
								,"!F17" : "+!r"
								,"!F18" : "+!t"
								,"^+F13" : "^!{Home}"
								,"^+F15" : "^p"
								,"^+F16" : "y"
								,"^+F17" : "!]"
								,"^+F18" : "!["
								,"^+MButton" : "^+c"
								,"^!F13" : "^i"
								,"^!F14" : "^!r"
								,"^!F15" : "!{NumpadMult}"
								,"^!F16" : "{Home}"
								,"^!F17" : "^!{Up}"
								,"^!XButton2" : "+{PgDn}"
								,"^!XButton1" : "+{PgUp}"
								,"^!F18" : "^!{Down}"
								,"^!MButton" : "{F4}"
								,"+!F13" : "{F4}"
								,"+!F14" : "^+d"
								,"+!F15" : "b"
								,"+!F16" : "n"
								,"+!XButton2" : "^+!y"
								,"+!XButton1" : "^y"
								,"+!MButton" : "^k"
								,"+!RButton" : "^l"}
	Hotkey, IfWinActive, ahk_class AE_CApplication_15.1
	bindHotkeysFromKeyMap(AfterEffectsKeys)
	Hotkey, If

; ///////


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

XMLKeys :=				  		{"^XButton1" : "^]"
								,"^XButton2" : "^["
								,"^Numpad7" : "this is xml"
								,"<!Left" : "{Home}"
								,"<!Right" : "{End}"
								,"^RButton" : "^/"}
	Hotkey, IfWinActive, (?i).*\.xml
	bindHotkeysFromKeyMap(XMLKeys)
	Hotkey, If

CSSKeys := 				 		{"^XButton1" : "^]"
								,"^XButton2" : "^["
								,"^NumpadDiv" : "border: 2px solid black;{Enter}"
								,"^Numpad8" : "resources\images\"
							    ,"^Numpad9" : "url(""../images/"");{Left 3}"
								,"^RButton" : "^/"}
	Hotkey, IfWinActive, (?i).*\.css
	bindHotkeysFromKeyMap(CSSKeys)
	Hotkey, If

JavaScriptKeys := 			 	{"^XButton1" : "^]"
								,"^XButton2" : "^["
								,"^+\" : "alert+{9}"
								,"^l" : "console.log();{Left 2}"
								, "^Numpad7" : """"" : """""
							    ; ,"^Enter" : "(function() {{Enter}});"
								, "^!Enter" : "`'`/n{Right}{Space}"
								,"^RButton" : "^/"}
	Hotkey, IfWinActive, (?i).*\.js
	bindHotkeysFromKeyMap(JavaScriptKeys)
	; Hotkey, ^Numpad0, NodeTest
	Hotkey, If
; ///// Atom





; // Create an array with hotkey on left, send result on right (or label)
ChromeKeys := 					{"F13" : "^e"
								,"F14" : "^t"
								,"^F14" : "^+b"
								,"F15" : "^{PgUp}"
								,"F16" : "^{PgDn}"
								,"F18" : "^+i"
								,"^F18" : "^u"
								,"XButton1" : "{XButton1}"
								,"XButton2" : "{XButton2}"}

	Hotkey, IfWinActive, ahk_exe chrome.exe
	bindHotkeysFromKeyMap(ChromeKeys)
	Hotkey, If


; //  don't change these functions
KeySet(msg) {
	SendInput, % msg
}

bindHotkeysFromKeyMap(KeyMap) {
	for keybind, command in KeyMap {
		bf  :=  Func("KeySet").bind(command)
		; bf  :=  command   ; for labels/functions rather than input
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
; //



	; SetTimer, SpaceCheck

	; SpaceCheck:
	; ToolTip, % Key "`r`n" count
	; Key := "Space"
	; If (A_TimeSincePriorHotkey > 600) {
	; 	;Keywait, % Key ; This fires continuously without ever having pressed Space	
	; 	Keywait, % Key, D ; This doesn't count the first instance of Space, is unreliable and produces doubles
	; 	++count
	; }
	; Return 


; :X:let::Send, %varConstruct%{Left 4}

; This below will have:

; so it doesn't interfere with normal typing

; :X:let::autoType(Space)
; #If

	; typePrefix := "let "
	; typeSuffix := " = `;"

	; :X:let::autoType(Space)

	; autoType(Key){
	; 	Send, %typePrefix%
	; 	KeyWait, % Key
	; 	Send, %typeSuffix%{Left}
	; 	MsgBox % "This doesn't work"
	; }


SetTitleMatchMode, RegEx
#If WinActive("(?i).*\.js")

:B0:let::
	KeyWait, Space
	KeyWait, Space, D
	KeyWait, Space
	Send, ={Space}`;{Left}
return

:B0:var::
	KeyWait, Space
	KeyWait, Space, D
	KeyWait, Space
	Send, ={Space}`;{Left}
return

:B0:constf::
	Send {bs 2}{space}
	KeyWait, Space
	KeyWait, Space, D
	KeyWait, Space
	Send, ={Space}+9+0{Left}
	KeyWait, Space, D
	KeyWait, Space
	Send, {bs}{Right} => +[+]{Left}
return

; :B0:class::
; 	Send {bs 2}{space}
; 	KeyWait, Space
; 	KeyWait, Space, D
; 	KeyWait, Space
; 	Send, extends{space}React.Component{Space}+[{Enter}render+9+[{Enter}
; return


; ::func::
	
; Return


::getid::
	Send, document.getElementById(){Left}'
Return

:B0:clickon::
	Clipboard := ""
	; priorClipboard := Clipboard
	; Clipboard := "Reset"
	Send {bs}{space}
	Send, id
	KeyWait, Space
	KeyWait, Space, D
	KeyWait, Space
	Send, name
	KeyWait, Space
	KeyWait, Space, D
	KeyWait, Space
	Send, {bs}^+{Left}
	Sleep, 50
	Send, ^x
	Sleep, 50
	ClipWait, 1, 1
	cKey := Clipboard
	; MsgBox % cKey
	Send, {bs}^+{Left}
	Sleep, 50
	Send, ^x
	Sleep, 50
	ClipWait, 1, 1
	cIndex := Clipboard
	Send, {bs}^+{Left}{bs}
	StringUpper, cIndex, cIndex, T
	Send % "document.getElementBy" cIndex "(""" cKey """).addEventListener(""click"", , false);"
	Send, ^{Left 3}
Return


; :B0:getkey::
; 	Clipboard := ""
; 	; priorClipboard := Clipboard
; 	; Clipboard := "Reset"
; 	Send {bs}{space}
; 	Send, up
; 	KeyWait, Space
; 	KeyWait, Space, D
; 	KeyWait, Space
; 	Send, key
; 	KeyWait, Space
; 	KeyWait, Space, D
; 	KeyWait, Space
; 	Send, {bs}^+{Left}
; 	Sleep, 50
; 	Send, ^x
; 	Sleep, 50
; 	ClipWait, 1, 1
; 	cKey := Clipboard
; 	; MsgBox % cKey
; 	Send, {bs}^+{Left}
; 	Sleep, 50
; 	Send, ^x
; 	Sleep, 50
; 	ClipWait, 1, 1
; 	cIndex := Clipboard
; 	Send, {bs}^+{Left}{bs}
; 	Send % "document.addEventListener('key" cIndex "'), " cKey ", false);"
; 	Send, ^{Left 3}
; Return


#If
; 



; #If  WinActive("(?i).*\.Codecademy")





; f24::
; 	Clipboard := StrReplace(Clipboard, "&#092;", "/")
; Return


; SetTitleMatchMode, 2
; #If WinActive("Codecademy")
#If WinActive("(?i).*\.jsx") || WinActive("(?i).*\Codecademy")
::render::
	Send, ReactDOM.render();{Left 2}
Return

::getid::
	Send, document.getElementById(){Left}'
Return

::getclass::
	Send, document.getElementsByClassName(){Left}'
Return

::getreact::
	Send, import React from 'react';{Enter}import ReactDOM from 'react-dom';{Enter}
Return

::class=::
	Send, className="
	Return

::<img>::
	Send, <img />
Return

::<br>::
	Send, <br />
Return

::<input>::
	Send, <input />
Return

::div::	
	Send, <div></div>{Left 6}
Return

::h1::	
	Send, <h1></h1>{Left 5}
Return

; ::div::	
; 	Send, <div></div>{Left 6}
; Return

; ::/div::
; 	Send, </div>
; Return


:B0:classj::
	Send {bs 2}{space}
	KeyWait, Space
	KeyWait, Space, D
	KeyWait, Space
	Send, extends{space}React.Component{Space}+[{Enter}render+9{Right}{Space}+[{Enter}return{Space}+9{Right};{Left 2}{Enter 2}{Up}{Tab}
return

:B0:constj::
	Send {bs 2}{space}
	KeyWait, Space
	KeyWait, Space, D
	KeyWait, Space
	Send, ={Space}+9+0{Left}{Enter}{Down}{End}{;}{Up}{Tab}
return


; F24::
; MsgBox % "Works"
; Return


; :B0:var::
; 	KeyWait, Space
; 	KeyWait, Space, D
; 	KeyWait, Space
; 	Send, ={Space}`;{Left}
; return

; :B0:constf::
; 	Send {bs 2}{space}
; 	KeyWait, Space
; 	KeyWait, Space, D
; 	KeyWait, Space
; 	Send, ={Space}+9+0{Left}
; 	KeyWait, Space, D
; 	KeyWait, Space
; 	Send, {bs}{Right} => +[+]{Left}
; return


#If

; SetTitleMatchMode, 2
; Return


; Return




; Return

; NodeTest:
;         WinGetTitle, AtomTitle, ahk_exe atom.exe
;         ; Clipboard := AtomTitle

;         TrimLPoint := InStr(AtomTitle, "—")
;         TrimL := SubStr(AtomTitle, 1, (TrimLPoint - 2))

;         TrimRPoint := InStr(AtomTitle, "—",, TrimLPoint + 1)
;         TrimR := SubStr(AtomTitle, TrimRPoint, (StrLen(AtomTitle) - TrimRPoint) + 1)

;         TrimMid := SubStr(AtomTitle, TrimLPoint, (StrLen(AtomTitle) - StrLen(TrimR) - StrLen(TrimL) - 2))
;         FullLength := StrLen(AtomTitle) - TrimRPoint

;         Clipboard := TrimRpos

;         MsgBox % TrimLPoint "`r`n" TrimL "`r`n" TrimRPoint "`r`n" TrimR "`r`n" TrimMid "`r`n" FullLength
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



; ////// Legacy






#IfWinActive, ahk_class illustrator
^F14:: sendTool("t", "LControl")
^F15:: sendTool("m", "LControl")
^F16:: sendTool("l", "LControl")
^F17:: sendTool("5", "LControl")
^F18:: sendTool("o", "LControl")
!F13:: sendTool("+w", "LAlt")
+F14:: sendTool("k", "LShift")
+F15:: sendTool("w", "LShift")
; !RButton Up:: sendTool("/", "LAlt")
^+F14:: sendTool("8", "LShift")

z::
Send, /
Return

sendTool(keyTo, keyFrom) {
	KeyWait %keyFrom%
	Send, %keyTo%  
}


	<!F14::
		GuiControl, Show, mF14
		KeyWait, LAlt
		MouseGetPos, prevX, prevY
		WinActivate, ahk_class %mainProg%
		; Click, 1386, 716, 0
		Sleep, 50
		Sleep, 50
		Send, {i}
		Sleep, 50
		Send, {Enter}
		WinWaitActive, Eyedropper Options ahk_class #32770
		Sleep, 50
		WinActivate, Eyedropper Options ahk_class #32770
		Sleep, 100
		Click, 79, 172, 0
		Sleep, 50
		Click, 79, 172 Left, Down
		Sleep, 50
		Click, 79, 172 Left, Up
		Sleep, 50
		Click, 415, 176, 0
		Sleep, 50
		Click, 415, 176 Left, Down
		Sleep, 50
		Click, 415, 176 Left, Up
		Sleep, 50
		Send, {Enter}
		Sleep, 50
		WinActivate, ahk_class %mainProg%
		Sleep, 50
		Click, %prevX%, %prevY%, 0
		Sleep, 50
	Return

#If

; #IfWinActive, ahk_exe chrome.exe


; #If


; !F24::
; StripSends:
; 	Clipboard := ""
; 	Sleep, 50
; 	Send, ^x
; 	Sleep, 50
; 	ClipWait, 1
; 	If (Clipboard != "")
; 	{
; 		censorWhite := ["A_Tab", "A_Space"]
; 		censorBlack := ["`:`: Send,"]
; 		; newString := StrReplace(Clipboard, "`:`: Send,", ",")
; 		newString := StrReplace(Clipboard, censorBlack[1], " `:")
; 		Sleep, 50
; 		Clipboard := newString
; 		Sleep, 50
; 		ClipWait, 1
; 		; newString := StrReplace(newString, censorWhite[1])
; 		; newerString := StrReplace(newerString, censorWhite[2])
; 		; newSplit := StrSplit(newString, ",")
; 		; MsgBox % Clipboard "`r`n" newString
; 		Send, +{Insert}
; 	} Else {
; 		MsgBox % "Clipboard is blank"
; 	}
	
; Return



; Split := StrSplit(Clipboard, ",")
; MsgBox % Split[1] " " Split[2]
; Clipboard := StrReplace(Clipboard, censor[A_Index])

	; StripSpaces:
	; 	Clipboard := StrReplace(Clipboard, "A_Tab")
	; 	Clipboard := StrReplace(Clipboard, "A_Space")
	; 	Send, +{Insert}
	; Return



; Esc::ExitApp





