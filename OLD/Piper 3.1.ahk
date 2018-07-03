; Piper 3.1
; 18/4/20

#InstallMouseHook
#InstallKeybdHook
#MaxHotkeysPerInterval, 200
; !!! To Do


; Great. Now Git keys are broken for no reason.

; Apparently Auto-Executes of included scripts will be overridden by the first instance of a Return.
; I've no clue why, but to get around it all you need to do is switch it to a gosub and call it from 
; the main Head of the script.


; So KeyMaps is now included in MouseGui. There auto-execute string is completely linear


; ////// Global
	#NoEnv
	#SingleInstance, Force
	
	SendMode Input
	SetWorkingDir %A_ScriptDir%
	Menu, Tray, Icon, %A_WorkingDir%\resources\icons\1.ico,, 1
	
; ////// Var
	global icoCount = 1, icoMax = 14, Set, icoNew
	global CurrHTML := "HTML", CurrJS := "Javascript"
	global icoDirect := A_ScriptDir . "\resources\icons\"
	global screenDirect := A_ScriptDir . "\resources\screens\"
	global Set
	global ScreenState := ""
	global vCurX, vCurY, hWnd, vCtlClassNN
	global _hwnd := "", 
	global _title := ""
	global mouseX, mouseY


; ////// Legacy
	global CurrTitle, DirectNum, Direct, FolderNum, FolderLength, Folder
	global TrailNum, TrailLength, Trail, ScriptNameLength, ScriptName
	global Name, NewName, thisScript
	global AtomFirstTrail, AtomTrailNum, AtomTitle, AtomProject, AtomFile, AtomFileNum, AtomCuts, AtomLCut, AtomRCut, AtomDirectory, AtomDirectory2, DirectNum2
	global shiftcount = 0



; ; ////// Menu 
; 	Menu, Main, Add, Illustrator, LaunchAIMice
; 	Menu, Main, Icon, Illustrator, % icoDirect . "11.ico"


; GitInit
	MenuArray 	:= 	["Dir1", "Dir2", "Dir3", "Change Dir 1", "Change Dir 2", "Change Dir 3"
				   , "GitUser", "Create New Repository", "Automate First Commit"
				   , "Open Working Directory", "Directories", "Flip slashes"
				   , "Reload", "Suspend", "Kill"]
	LabelArray 	:=  ["TrayDir1", "TrayDir2", "TrayDir3", "ChangeDir4", "ChangeDir5", "ChangeDir6"
				   , "gGitUser", "TrayNewRepo", "TrayAutoCommit"
				   , "TrayWorkingDirectory", ":Directories", "ConvertPath"
				   , "TrayReload", "TraySuspend", "TrayExit"]
	Loop, % MenuArray.Length()
		{
		If (A_Index = 4)
			Menu, Directories, Add
		If ((A_Index = 10) || (A_Index = 13))
			Menu, GitInit, Add
			if (A_Index < 7)
				{
					if (A_Index < 4) {
						Menu, Directories, Add, % MenuArray[A_Index], TrayDir%A_Index%
						Menu, Directories, Icon, % MenuArray[A_Index], %A_WorkingDir%\Resources\icons\git\%A_Index%.ico
					} Else {
						Menu, Directories, Add, % MenuArray[A_Index], ChangeDir%A_Index%
						Menu, Directories, Icon, % MenuArray[A_Index], %A_WorkingDir%\Resources\icons\git\%A_Index%.ico
					}
			} else {
				Menu, GitInit, Add, % MenuArray[A_Index], % LabelArray[A_Index]
			    Menu, GitInit, Icon, % MenuArray[A_Index], %A_WorkingDir%\Resources\icons\git\%A_Index%.ico
			}
		}
	; Menu, Main, Add, GitInit, :GitInit


; Context Menu
	contextArray :=	["SDK 2018", "Debug", "API", "Getting Started", "Programmer`'s Guide"		
				   , "Key History", "myTmaster", "Toolblox", "Pied Piper", "01 Scripts"						
				   , "All", "Pen Pal", "Pen Palette", "Sourcerer"								
				   , "AI SDK", "AHK", "CEP", "Adobe", "Visual Studio", "Intro to Scripting", "Javascript Tools"
				   
				   , "Blank 1", "Blank 2", "Blank 3"
				   , "Script 1", "Script 2", "Script 3"								

				   , "Illustrator", "After Effects"									
				   , "Gitinit", "GitMaster", "Sandbox"
				   , "Code", "Favorites", "Scripts", "Pro Spy"
				   , "Minimize All"]


	cLabelArray :=	["menu_SDK_AI_Folder", "menu_SDK_AI_Debug", "menu_SDK_AI_API", "menu_SDK_AI_GettingStarted", "menu_SDK_AI_ProgrammersGuide"
				   , "menu_AHK_KeyHistory", "menu_AHK_myTmaster", "menu_AHK_Toolblox", "menu_AHK_PiedPiper", "menu_AHK_Scripts"
				   , "menu_AI_Launch", "menu_AI_PenPal", "menu_AI_PenPalette", "menu_AI_Sourcerer"
				   , ":SDK", ":AHK", "menu_CEP_Folder", "menu_Adobe", "menu_VisualStudio", "menu_IntroToScripting", "menu_JavaScriptTools"
				   
				   , "Blank1", "Blank2", "Blank3"
				   , "Script1", "Script2", "Script3"
				   
				   , ":Illustrator", "LaunchAE"
				   , ":GitInit", "menu_GitMaster", "menu_Sandbox"
				   , ":Code", ":Favorites", ":Scripts", "menu_ProSpy"
				   , "Minimize"]


SDKnum := 5, AHKnum := SDKnum + 5, Illustratornum := AHKnum + 4, Codenum := Illustratornum + 7, Favoritesnum := Codenum + 3, Scriptsnum := Favoritesnum + 3
main_Major := 28

code_Break1 := Codenum - 4, code_Break2 := code_Break1 + 2, code_Break3 := code_Break2 + 1
main_Break1 := main_Major + 2, main_Break2 := main_Break1 + 3, main_Break3 := main_Break2 + 3


; 37 total

finalCount := 0
	Loop, % contextArray.Length()
		{
	; linebreaks
	++finalCount
		If ((A_Index = code_Break1) || (A_Index = code_Break2) || (A_Index = code_Break3))
			Menu, Code, Add
		If ((A_Index = main_Break1) || (A_Index = main_Break2) || (A_Index = main_Break3))
			Menu, Main, Add
	; submenus
			If (A_Index < main_Major)
				{
					If (A_Index <= SDKnum) {
						Menu, SDK, Add, % contextArray[A_Index], % cLabelArray[A_Index]
						Menu, SDK, Icon, % contextArray[A_Index], %A_WorkingDir%\resources\icons\ContextMenu\%A_Index%.ico
					} Else If (A_Index <= AHKnum){
						Menu, AHK, Add, % contextArray[A_Index], % cLabelArray[A_Index]
						Menu, AHK, Icon, % contextArray[A_Index], %A_WorkingDir%\resources\icons\ContextMenu\%A_Index%.ico
					} Else If (A_Index <= Illustratornum){
						Menu, Illustrator, Add, % contextArray[A_Index], % cLabelArray[A_Index]
						Menu, Illustrator, Icon, % contextArray[A_Index], %A_WorkingDir%\resources\icons\ContextMenu\%A_Index%.ico
					} Else If (A_Index <= Codenum){
						Menu, Code, Add, % contextArray[A_Index], % cLabelArray[A_Index]
						Menu, Code, Icon, % contextArray[A_Index], %A_WorkingDir%\resources\icons\ContextMenu\%A_Index%.ico
					} Else If (A_Index <= Favoritesnum) {
						LastFavorite := A_Index
						Menu, Favorites, Add, % contextArray[A_Index], % cLabelArray[A_Index]
						Menu, Favorites, Icon, % contextArray[A_Index], %A_WorkingDir%\resources\icons\ContextMenu\%A_Index%.ico
					} Else {
						Menu, Scripts, Add, % contextArray[A_Index], % cLabelArray[A_Index]
						Menu, Scripts, Icon, % contextArray[A_Index], %A_WorkingDir%\resources\icons\ContextMenu\%A_Index%.ico
					}
			} Else {
	; main menu
				Menu, Main, Add, % contextArray[A_Index], % cLabelArray[A_Index]
				Menu, Main, Icon, % contextArray[A_Index], %A_WorkingDir%\resources\icons\ContextMenu\%A_Index%.ico
			}
		}


; ////// Head
	SetTimer, currentwindow
	; SetTimer, mouseMain, 20
	
	; #Include Gdip_All2.ahk
	#Include MouseGui.ahk
	; #Include KeyMaps.ahk
	#Include ToggleLib.ahk
	#Include GitLib.ahk
	; Gosub, MouseInit


Bind1:
	MsgBox % "Yes"
Return


^#RButton::
	Gosub, HideGui
	Menu, Main, Show
	Return


^#RButton Up::
	Gosub, HideGui
	Return



; F19::
; Run, *RunAs GDIP_LockBits_DominantColor.ahk, C:\Users\PortablePawnShop\Documents\GitMaster\myTmaster
; Return


; #IfWinActive, ahk_exe atom.exe
; ; RButton::Return
; ; RButton Up::Return
; #If

; ////// Legacy Piper 2.0
	SetNumLockState, AlwaysOn	
	; ^RButton::Return
	#Enter::Return
	^#Enter::Return
	#RShift::Return
	#F16::Return
	; ~LWin::Send {Blind}{vk07}
	; ~LAlt::Send {Blind}{vk07}
	#XButton1::Send, {LWinDown}{Right}{LWinUp}
	#XButton2::Send, {LWinDown}{Left}{LWinUp}
	#F15 Up::Send, {LWinDown}{Up}{LWinUp}{Up Up}
	#F17 Up::Send, {LWinDown}{d}{LWinUp}{d Up}

	LaunchAIMice:
		Run, PenPal.ahk, C:\Users\PortablePawnShop\Documents\Pied Piper\Scribe
		Run, PenPalette.ahk, C:\Users\PortablePawnShop\Documents\Pied Piper\Scribe
	Return 







	; !F24::
	; 	StripSpaces:
	; 		Clipboard := StrReplace(Clipboard, "A_Tab")
	; 		Clipboard := StrReplace(Clipboard, "A_Space")
	; 		Send, +{Insert}
	; 	Return





; /////// Main
	; mouseMain:
	; 	CoordMode, Mouse, Screen
	; 	MouseGetPos, vCurX, vCurY, hWnd, vCtlClassNN
	; 	CoordMode, Pixel, Screen
	; 	PixelGetColor, Camouflage, %vCurX%, %vCurY%, RGB
	; 	mouseX := vCurX-xOffset
	; 	mouseY := vCurY-yOffset
	; 	; Gosub, ShowGui
	; Return


Script1:
Script2:
Script3:
Return

Blank1:
Blank2:
Blank3:
Return

; Favorites:
; Return





; AI / AE 
	menu_AI_Launch:
		runScript("PenPalette", "C:\Users\PortablePawnShop\Documents\Pied Piper\Scribe")
		runScript("PenPal", "C:\Users\PortablePawnShop\Documents\Pied Piper\Scribe")
		runScript("Sourcerer", "C:\Users\PortablePawnShop\Documents\Pied Piper\Scribe")
		Gosub, HideGui
	Return

	menu_AI_PenPalette:
		runScript("PenPalette", "C:\Users\PortablePawnShop\Documents\Pied Piper\Scribe")
		Gosub, HideGui
	Return

	menu_AI_Sourcerer:
		runScript("Sourcerer", "C:\Users\PortablePawnShop\Documents\Pied Piper\Scribe")
		Gosub, HideGui
	Return

	menu_AI_PenPal:
		runScript("PenPal", "C:\Users\PortablePawnShop\Documents\Pied Piper\Scribe")
		Gosub, HideGui
	Return

	LaunchAE:
		runScript("omo 2018", "C:\Users\PortablePawnShop\Documents\Pied Piper\AE")
		runScript("AE_MM 2018", "C:\Users\PortablePawnShop\Documents\Pied Piper\AE")
		Gosub, HideGui
	Return 


; Main
	menu_Adobe:
		exploreFile("Adobe ahk_class CabinetWClass", "C:\Program Files\Adobe")
	Return

	menu_ProSpy:
		runProg("ahk_ex espyxx_amd64.exe", "spyxx_amd64.exe", "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\Tools")
	Return

	menu_GitMaster:
		exploreFile("GitMaster ahk_class CabinetWClass", "C:\Users\PortablePawnShop\Documents\GitMaster")
	Return

	menu_Sandbox:
		exploreFile("Sandbox ahk_class CabinetWClass", "C:\Users\PortablePawnShop\Documents\GitMaster\Sandbox")
	Return


; SDK
	menu_SDK_AI_Folder:
	exploreFile("Adobe Illustrator CC 2018 SDK", "C:\Users\PortablePawnShop\Downloads\CEP\Adobe Illustrator CC 2018 SDK")
	Return

	menu_SDK_AI_Debug:
	exploreFile("Debug", "C:\Users\PortablePawnShop\Downloads\CEP\Adobe Illustrator CC 2018 SDK\samplecode\output\win\Win32\Debug")
	Return

	menu_SDK_AI_API:
	showFile("API ahk_class HH Parent", "index.chm", "C:\Users\PortablePawnShop\Downloads\CEP\Adobe Illustrator CC 2018 SDK\docs\references")
	Return

	menu_SDK_AI_GettingStarted:
	showFile("getting-started-guide.pdf - Adobe Acrobat Reader DC", "getting-started-guide.pdf", "C:\Users\PortablePawnShop\Downloads\CEP\Adobe Illustrator CC 2018 SDK\docs\guides")
	Return
		
	menu_SDK_AI_ProgrammersGuide:
	showFile("programmers-guide.pdf - Adobe Acrobat Reader DC", "programmers-guide.pdf", "C:\Users\PortablePawnShop\Downloads\CEP\Adobe Illustrator CC 2018 SDK\docs\guides")
	Return

; AHK
	menu_AHK_KeyHistory:
		KeyHistory
		; runScript("KeyHistory", "C:\Users\PortablePawnShop\Documents\01 Scripts")
	Return 

	menu_AHK_myTmaster:
	exploreFile("myTmaster ahk_class CabinetWClass", "C:\Users\PortablePawnShop\Documents\GitMaster\myTmaster")
	Return

	menu_AHK_Toolblox:
	exploreFile("Toolblox ahk_class CabinetWClass", "C:\Users\PortablePawnShop\Documents\01 Scripts\Toolblox")
	Return

	menu_AHK_PiedPiper:
	exploreFile("Pied Piper ahk_class CabinetWClass", "C:\Users\PortablePawnShop\Documents\Pied Piper")
	Return

	menu_AHK_Scripts:
	exploreFile("01 Scripts ahk_class CabinetWClass", "C:\Users\PortablePawnShop\Documents\01 Scripts")
	Return

	menu_CEP_Folder:
	exploreFile("extensions ahk_class CabinetWClass", "C:\Users\PortablePawnShop\AppData\Roaming\Adobe\CEP\extensions")
	Return

; Code
	menu_VisualStudio:
	runProg("ahk_exe devenv.exe", "devenv.exe", "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE")
	Return

	menu_IntroToScripting:
	showFile("Intro to Scripting.pdf (SECURED) - Adobe Acrobat Reader DC", "Intro to Scripting.pdf", "C:\Users\PortablePawnShop\Documents\Pied Piper")
	Return

	menu_JavaScriptTools:
	showFile("JavaScript Tools Guide CC - Adobe Acrobat Reader DC", "JavaScript Tools Guide CC.pdf", "C:\Program Files (x86)\Adobe\Adobe ExtendScript Toolkit CC\SDK")
	Return





; KillFolders:
; WinClose ahk_group WindEx
; Return


Minimize:
WinMinimizeAll
Return







runProg(WindowTitle, exeName, exePath) {
	If !WinExist(WindowTitle)
	{
		Run, % exeName, % exePath
		Return
	} Else {
		WinActivate, % WindowTitle
		Return
		}
}

runScript(scriptName, scriptPath){
	Run, % scriptName ".ahk", % scriptPath
}

exploreFile(WindowTitle, exePath) {
	If !WinExist(WindowTitle)
	{
		Run, % "explore " exeName, % exePath
		Return
	} Else {
		WinActivate, % WindowTitle
		Return
		}
}


showFile(WindowTitle, exeName, exePath) {
	If !WinExist(WindowTitle)
	{
		Run, % exeName, % exePath
		Return
	} Else {
		WinActivate, % WindowTitle
		Return
		}
}






!Esc::Reload






^#F13::
Gosub, SearchAHKDocs
; SearchAHKDocs()
Return

^#F14::
Gosub, JumpToGit
; JumpToGit()
Return

+#F15::
Gosub, JumpToExtendScript
Return


^#F15::
Gosub, JumpToSublime
; JumpToSublime()
Return

!#F15::
Gosub, JumpToAtom
; JumpToAtom()
Return

;Sublime hotkeys
#IfWinActive, ahk_exe sublime_text.exe
	^#XButton2::Gosub, Launch
	^#XButton1::Gosub, Explorer
#If

#IfWinActive, ahk_class Estoolkit35
*^RButton::Return
#If




; Toolbox()
	^#F17::	
	Gosub, KillAHKs
	LaunchPiper()
	Return

	; Launch
	^#MButton::
	LaunchPiper()
	Run, Piper 3.1.ahk, C:\Users\PortablePawnShop\Documents\GitMaster\myTmaster
	Return


LaunchPiper(){
		Run, Piper 1.31.ahk, C:\Users\PortablePawnShop\Documents\01 Scripts\Toolblox
		; Run, MiniSpy.ahk, C:\Users\PortablePawnShop\Documents\GitMaster\myTmaster
		Run, Gitinit1.2.ahk, C:\Users\PortablePawnShop\Documents\GitMaster\GitinitAHK
		; Run, Piper 3.1.ahk, C:\Users\PortablePawnShop\Documents\GitMaster\myTmaster
		; Run, KeyMaps.ahk, C:\Users\PortablePawnShop\Documents\GitMaster\myTmaster
		; Run, *RunAs GDIP_LockBits_DominantColor.ahk, C:\Users\PortablePawnShop\Documents\GitMaster\myTmaster
}

		; Run, Pieper 2.1.ahk, C:\Users\PortablePawnShop\Documents\01 Scripts\Toolblox
		; Run, Piper 3.1.ahk, C:\Users\PortablePawnShop\Documents\GitMaster\myMaster
		; Run, MiniSpy.ahk, C:\Users\PortablePawnShop\Documents\01 Scripts\Toolblox



	~*LButton::
	~*RButton::
	~*LButton Up::
	~*RButton Up::
		WinGetActiveTitle, ClickTitle
		    if !(ClickTitle = _ClickTitle) {
		        _ClickTitle := ClickTitle
		        gosub foolproof
		    }
	Return

	currentwindow:		
	    hwnd := winexist("a")
	    if !(hwnd = _hwnd) {
	        _hwnd := hwnd
	        gosub foolproof
	    }
	return

	foolproof:
		++WinChange
	    WinGetClass, WinClass, ahk_id %hwnd%
	    WinGetTitle, WinTitle, ahk_id %hwnd%
	    WinGet, WinExe, ProcessName, ahk_id %hwnd%
	    Gosub, IcoCheck
    	screenDirect := "resources\screens\" . Master . "\" . vOutput ".png"
	return


	ToolTipper:
		; tooltip % "window changes: " WinChange "`nwindow: " hwnd "`ntitle: " WinTitle "`nclass: " WinClass "`nexe: " WinExe
	   	; ToolTip % CurrHTML
	    ; ToolTip % Stats "`r`n" vOutput "`r`n" ScreenVar "`r`n" Master "`r`n" screenDirect
	    ; ToolTip % WinClass
	Return





; ////// Scan Windows
; F24::




; ////// Nav
	IcoCheck:
	AppClasses := 	["PX_WINDOW_CLASS"
					,"mintty"
					,"#32770"
					,"illustrator"
					,"Photoshop"
					,"AE_CApplication_15.1"
					,"Estoolkit35"]
					; ,"audition11"
					

	Extensions :=  	[".html", ".css", ".js"]

		vOutputClass := ""
		vOutputName := ""
		Loop, % AppClasses.Length()
		{
			vOutputClass .= AppClasses[A_Index] . " "
		}
		Loop, % Extensions.Length()
		{
			vOutputName .= Extensions[A_Index] . " "
		}

		If InStr(vOutputClass, WinClass) {
			If (WinClass = "PX_WINDOW_CLASS") {
				icon("AHK")
				; Master := "AHK"
			} Else If (WinClass = "mintty") {
				icon("Git")
			} Else If ((WinClass = "illustrator" || WinClass = "#32770" ) && (WinExe = "Illustrator.exe")) {
				icon("Illustrator")
				; Master := "Illustrator"
			} Else If ((WinClass = "Photoshop" || WinClass = "#32770" ) && (WinExe = "Photoshop.exe")) {
				icon("Photoshop")
			} Else If ((WinClass = "AE_CApplication_15.1"  || WinClass = "#32770" ) && (WinExe = "AfterFX.exe")) {
				icon("AfterEffects")
			} Else If ((WinClass = "audition11" || WinClass = "#32770" ) && (WinExe = "Adobe Audition CC.exe")) {
				icon("Audition")
			} Else If (WinClass = "Estoolkit35") {
				icon("ExtendScript")
			}
		} Else {
			If InStr(WinTitle, ".html") {
				If (CurrHTML = "HTML") {
					icon("HTML")
					; AtomKeys(CurrHTML)
					SubTitle := "HTML"
				}
				Else If (CurrHTML = "Bootstrap") {
					icon("Bootstrap")
				}
			} Else If InStr(WinTitle, ".css") {
				icon("CSS")
				; AtomKeys(CSS)
				SubTitle := "CSS"
			} Else If InStr(WinTitle, ".js") {
				If (CurrJS = "Javascript") {
					icon("Javascript")
					; AtomKeys(Javascript)
					SubTitle := "JavaScript"
				}
				Else If (CurrJS = "JQuery") {
					icon("JQuery")
				}
			} Else {
				icon("Pi")
			}
		}
	Return

	icon(Set){
		If (Set = "Pi") {
			icoNew = 1
		} Else If (Set = "PiNo") {
			icoNew = 2
		} Else If (Set = "AHK") {
			icoNew = 3
		} Else If (Set = "HTML") {
			icoNew = 4
		} Else If (Set = "CSS") {
			icoNew = 5
		} Else If (Set = "Git") {
			icoNew = 6
		} Else If (Set = "JavaScript") {
			icoNew = 7
		} Else If (Set = "JQuery") {
			icoNew = 8
		} Else If (Set = "Bootstrap") {
			icoNew = 9
		} Else If (Set = "ReactJS") {
			icoNew = 10
		} Else If (Set = "Illustrator") {
			icoNew = 11
		} Else If (Set = "AfterEffects") {
			icoNew = 12
		} Else If (Set = "Photoshop") {
			icoNew = 13
		} Else If (Set = "Audition") {
			icoNew = 14
		} Else If (Set = "ExtendScript") {
			icoNew = 15
		}
		Menu, Tray, Icon, % icoDirect . icoNew ".ico",, 1
	}		
	Return
; ////// Nav





; ////// Atom
#IfWinActive ahk_exe atom.exe
	^Numpad0::
	RefreshChrome:
		WinActivate, ahk_exe chrome.exe
		WinWaitActive, ahk_exe chrome.exe
		Sleep, 100
		Send, {CtrlDown}{r}{CtrlUp}
		WinActivate, ahk_exe atom.exe
	Return


!Numpad0::
ScanTitle:
        WinGetTitle, AtomTitle, ahk_exe atom.exe
        ; Clipboard := AtomTitle

; All report 0
        TrimLPoint := InStr(AtomTitle, "—")
        TrimL := SubStr(AtomTitle, 1, (TrimLPoint - 2))

        TrimRPoint := InStr(AtomTitle, "—",, TrimLPoint + 1)
        TrimR := SubStr(AtomTitle, TrimRPoint, (StrLen(AtomTitle) - TrimRPoint) + 1)

        TrimMid := SubStr(AtomTitle, TrimLPoint, (StrLen(AtomTitle) - StrLen(TrimR) - StrLen(TrimL) - 2))
        FullLength := StrLen(AtomTitle) - TrimRPoint

        Clipboard := TrimRpos

        MsgBox % TrimLPoint "`r`n" TrimL "`r`n" TrimRPoint "`r`n" TrimR "`r`n" TrimMid "`r`n" FullLength
Return
#If
; ///////




; ///// Gitinit 
; #IfWinActive, ahk_exe mintty.exe





; F21::
; MsgBox % Directory1 "`r`n" Directory2 "`r`n" Directory3
; Return


; F22::Gosub, NewRepo
; ^F22::Gosub, PushRepo

; ; F24::Gosub, GitExplorer
; ^F24::Gosub, ConvertPath

; F23::Gosub, Direct1
; ^F23::Gosub, Direct2
; +F23::Gosub, Direct3

; Esc::WinKill, ahk_exe mintty.exe

; #If

; //////



	; #If (InStr(WinTitle, ".html") != 0)
	#IfWinActive ahk_exe atom.exe
	#MButton::
		If InStr(WinTitle, ".html") {
			++HTMLtoggle
			If (HTMLtoggle > 2)
				HTMLtoggle = 1
			If (HTMLtoggle = 1)
				CurrHTML := "HTML"
			Else If (HTMLtoggle = 2)
				CurrHTML := "Bootstrap"
		} Else If InStr(WinTitle, ".js") {
			++JStoggle
			If (JStoggle > 2)
				JStoggle = 1
			If (JStoggle = 1)
				CurrJS := "JavaScript"
			Else If (JStoggle = 2) {
				CurrJS := "JQuery"
			} Else If (JStoggle = 3) {
				CurrJS := "ReactJS"
			}
		}
		Gosub, IcoCheck
	Return
	#If






; ///// Legacy Piper 2.1
ScanTitle(){
;                                                 TrailNum
; 													    |  := RegExMatch(CurrTitle, ".ahk")
; 														| 
;                                   |F-O-L-D-E-R|       |-----T-R-A-I-L------|
;  ____________ CurrTitle___________|___________|_______|____________________
; |                                                     |                    |
; C:\Users\SomeUserOnReddit\Documents\RedditPost\Sandbox.ahk • - Sublime Text
;												||_____|
; |-----------------D-I-R-E-C-T-----------------|   |
; 												|	|___ ScriptName
;                                               |        ScriptNameLength := ((TrailNum - 1) - (DirectNum + 1)) 
;                                              DirectNum
;                       					        := StringGetPos, DirectNum, CurrTitle, \, R
#IfWinActive, ahk_exe sublime_text.exe
	WinGetTitle, CurrTitle, A
		
	StringGetPos, DirectNum, CurrTitle, \, R
	Direct := SubStr(CurrTitle, 1, DirectNum)

	StringGetPos, FolderNum, Direct, \, R
	FolderLength := (DirectNum - FolderNum)
	Folder := SubStr(Direct, FolderNum + 2, FolderLength - 1)

	TrailNum := CurrTitle ~= ".ahk"   	; same as TrailNum := RegExMatch(CurrTitle, ".ahk")
	TrailLength := (StrLen(CurrTitle) - TrailNum)
	Trail := SubStr(CurrTitle, TrailNum, TrailLength + 1)

	ScriptNameLength := ((TrailNum - 1) - (DirectNum + 1)) 
	ScriptName := SubStr(CurrTitle, DirectNum + 2, ScriptNameLength)
#If
Return
}


Launch:
ScanTitle()
thisScript := ScriptName ".ahk"
	Run, % thisScript, % Direct
Return


Explorer:
ScanTitle()
	If !WinExist(Folder " ahk_class CabinetWClass") {
		Run, explore %Direct%, Hidden
		WinMove, %Folder% ahk_class CabinetWClass,, -10, 0, (A_ScreenWidth/2), A_ScreenHeight
		WinWait, %Folder% ahk_class CabinetWClass,, 2
		If ErrorLevel
		{
			MsgBox Explorer failed
		}
	} Else {
		WinActivate, %Folder% ahk_class CabinetWClass
	}
Return




#IfWinActive, ahk_class illustrator
; Automatic icon to png



F19::
	InputBox, IcoNum, Quicksave Single,,,, 100
		if ErrorLevel {
			MsgBox % "Icon cancelled"
			Return
		}
Gosub, Quicksave
; MsgBox % "Successful"
Return

^F19::
	InputBox, LoopNum, Quicksave Multi,,,, 100
		if ErrorLevel {
			MsgBox % "Icon cancelled"
			Return
		}
	Loop, % LoopNum
	{
	WinActivate, ahk_exe illustrator.exe
	 If WinActive("ahk_class illustrator") {
		IcoNum := A_Index
		Gosub, Quicksave
		Sleep, 100
		WinActivate, ahk_class illustrator
		Sleep, 100
		} Else {
			MsgBox % "Loop failed"
			Break
		}
	Sleep, 200
	WinActivate, ahk_class illustrator
	}
MsgBox % "Finished"
Return


Quicksave:
	; WinActivate, ahk_class illustrator
	; Sleep, 50
	If WinActive("ahk_class illustrator")
	{
	Send, ^!+s
	} Else {
		MsgBox % "False start"
	}
	WinWaitActive, ahk_class #32770,, 2
		if ErrorLevel {
			WinActivate, ahk_class illustrator
			Sleep, 50
			Send, ^{F2}
			; MsgBox % "Save for Web fail"
			; Return
		}
	; WinActivate, ahk_class #32770, Save for Web
	If WinActive("Save for Web ahk_class #32770")
	{
		; Send, %IcoNum%
		; MsgBox % "Success"
		Send, {Enter}
	} Else {
		; WinActivate, ahk_class illustrator
		MsgBox % "Save focus fail"
		Return
	}

	WinWaitActive, Save Optimized As ahk_class #32770,, 2
		if ErrorLevel {
			MsgBox % "Save to Directory fail"
			Return
		}

	If WinActive("Save Optimized As ahk_class #32770")
	{
		Send, %IcoNum%
		Send, {Enter}
	} Else {
		MsgBox % "Save fail"
		Return
	}
Return

#If



#IfWinActive, ahk_exe Photoshop.exe

; Automatic icon to png
F19::
	InputBox, IcoNum, Automate .png to .ico, Enter icon number:,,, 100
		if ErrorLevel {
			MsgBox % "Icon cancelled"
			Return
		}
	WinActivate, ahk_exe Photoshop.exe
	Sleep, 50
	Send, ^o
	WinWaitActive, ahk_class #32770,, 2
		if ErrorLevel {
			MsgBox % "Open failed"
			Return
		}
	WinActivate, ahk_class #32770, Open
	If WinActive("Open ahk_class #32770")
	{
		Send, %IcoNum%
		Sleep, 100
		Send, {Down}
		Sleep, 50
		Send, {Enter}
		Sleep, 200
	}
	WinActivate, ahk_exe Photoshop.exe
	Sleep, 200
	Send, {CtrlDown}{ShiftDown}{s}{CtrlUp}{ShiftUp}
	WinWait, ahk_class #32770,, 2
		if ErrorLevel {
			MsgBox % "Save As failed"
			Return
		}
	WinActivate, ahk_class #32770, Save As
	; If WinActive("Save As ahk_class #32770")
	; {
		Sleep, 200
		Send, {Tab}
		Sleep, 200
		Send, {i}
		Sleep, 50
		Send, {Enter}
		Sleep, 300
		Send, {Enter}
		; MsgBox % "Went Through"
	; }
Return


; Automatic icon to png
^F19::
	InputBox, LoopNum, Enter Loop Number,,,, 100
			if ErrorLevel {
				MsgBox % "Loop cancelled"
				Return
			}

	Loop, % LoopNum
	{
		WinActivate, ahk_exe Photoshop.exe
		Sleep, 100
		Send, {CtrlDown}{o}{CtrlUp}
		WinWaitActive, ahk_class #32770,, 2
			if ErrorLevel {
				MsgBox % "Open failed"
				Return
			}
		WinActivate, ahk_class #32770, Open
		If WinActive("Open ahk_class #32770")
		{
			Send, %A_Index%
			Sleep, 100
			Send, {Down}
			Sleep, 50
			Send, {Enter}
			Sleep, 200
		}
		WinActivate, ahk_exe Photoshop.exe
		Sleep, 200
		Send, {CtrlDown}{ShiftDown}{s}{CtrlUp}{ShiftUp}
		WinWait, ahk_class #32770,, 2
			if ErrorLevel {
				MsgBox % "Save As failed"
				Return
			}
		WinActivate, ahk_class #32770, Save As
		; If WinActive("Save As ahk_class #32770")
		; {
			Sleep, 200
			Send, {Tab}
			Sleep, 200
			Send, {i}
			Sleep, 50
			Send, {Enter}
			Sleep, 300
			Send, {Enter}
		Sleep, 300
		WinActivate, ahk_exe Photoshop.exe
	}
	MsgBox % "Successful"
Return
#If




	; @wolf_II
	; https://autohotkey.com/boards/viewtopic.php?p=102103#p102103
	;Script("Full\Path\to\Script.ahk", "Edit")
	Script(Script, Action) { ; use tray icon actions of a running AHK script
	    static a := { Open: 65300, Help:    65301, Spy:   65302, Reload: 65303
	                , Edit: 65304, Suspend: 65305, Pause: 65306, Exit:   65307 }
	    DetectHiddenWindows, On
	    PostMessage, 0x111, % a[Action],,, %Script% - AutoHotkey
	}

	; @Lexikos
	; https://autohotkey.com/board/topic/69611-conditional-singleinstance-force/?p=441099
	KillAHKs:
	DetectHiddenWindows On ; List all running instances of this script:
	WinGet instances, List, ahk_class AutoHotkey
	if (instances > 1) { ; There are 2 or more instances of this script.
	    this_pid := DllCall("GetCurrentProcessId"),  closed := 0
	    Loop % instances { ; For each instance,
	        WinGet pid, PID, % "ahk_id " instances%A_Index%
	        if (pid != this_pid) { ; If it's not THIS instance,
	            WinClose % "ahk_id " instances%A_Index% ; close it.
	            closed += 1
	        }
	    }
	}
	Return







MoveFilesAndFolders(SourcePattern, DestinationFolder, DoOverwrite = false)
; Moves all files and folders matching SourcePattern into the folder named DestinationFolder and
; returns the number of files/folders that could not be moved. This function requires [v1.0.38+]
; because it uses FileMoveDir's mode 2.
{
    if DoOverwrite = 1
        DoOverwrite = 2  ; See FileMoveDir for description of mode 2 vs. 1.
    ; First move all the files (but not the folders):
    FileMove, %SourcePattern%, %DestinationFolder%, %DoOverwrite%
    ErrorCount := ErrorLevel
    ; Now move all the folders:
    Loop, %SourcePattern%, 2  ; 2 means "retrieve folders only".
    {
        FileMoveDir, %A_LoopFileFullPath%, %DestinationFolder%\%A_LoopFileName%, %DoOverwrite%
        ErrorCount += ErrorLevel
        if ErrorLevel  ; Report each problem folder by name.
            MsgBox Could not move %A_LoopFileFullPath% into %DestinationFolder%.
    }
    return ErrorCount
}




; ; Defunct, kind of works.
; Recorder:
; Omit := ["LControl", "LShift", "LWin", "LAlt"]
; If (vOutput = "Def") {
; 	logLast .= logFull
; 	logFull := ""
; }

; If (A_TimeIdle > 200)
; 	log := "Idle"
; Else
; 	log := "Active"

; If InStr(A_ThisHotkey, "~*") && !InStr(A_ThisHotkey, "Button") {
; 	logOut := "L" . SubStr(A_ThisHotkey, 3, (StrLen(A_ThisHotkey) - 2))
; } Else {
; 	logOut := SubStr(A_ThisHotkey, 3, (StrLen(A_ThisHotkey) - 2))
; }
; Loop, % Omit.Length()
; 		{
; 			StripMods := StrReplace(A_PriorKey, Omit[A_Index])
; 		}

; If (A_PriorKey != logOut) {
; 	If (vOutput != "Def") {		
; 		logFull := vOutput . StripMods
; 	}
; }

; ; ToolTip % count "`r`n" shiftcount "`r`n" A_TimeIdle "`r`n" A_TimeSincePriorHotkey "`r`n" A_PriorKey "`r`n" A_PriorHotkey "`r`n" A_ThisHotkey "`r`n" log "`r`n" logOut
; ToolTip % stats "`r`n" vOutput "`r`n" A_PriorKey "`r`n" logOut "`r`n" log "`r`n" logOut "`r`n" logFull "`r`n" logLast
; Return



	; F24::
	; SetTitleMatchMode, RegEx             ; Change all WinTitle commands to accept regular expressions

	; vOutput := ""
	; WinGet instances, List, ahk_class OneNote   ; this is a guess on class
	; if (instances > 1) { 				; There is more than one instance
	;     this_pid := DllCall("GetCurrentProcessId")
	;     Loop % instances { 				; For each instance,
	;         WinGet pid, PID, % "ahk_id " instances%A_Index%
	;         vOutput .= 

	;         if (pid != this_pid) { ; If it's not THIS instance,
	;             WinClose % "ahk_id " instances%A_Index% ; close it.
	;             closed += 1
	;         }
	;     }
	; }


; 	IfWinActive, (?i).*\- OneNote$ {     ; Is a window whose title ends in "- OneNote" active?



; 		}   

; 		MsgBox % "Yes"               ; If so, do this

; 	Else 
; 		MsgBox % "No"                ; If not, do this
; 	Return

; F24::
; SetTitleMatchMode, RegEx
; IfWinActive, (?i).*\- OneNote$
; 	MsgBox % "Yes"
; Else 
; 	MsgBox % "No"
; Return