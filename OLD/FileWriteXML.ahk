#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, force

global nameVar


;; Convert code to AHK string
; !F24::
; Single := """"
; Double := """"""
; Clipboard := """" . StrReplace(Clipboard, """", """""") . """"
; MsgBox % Single "`r`n" Double "`r`n" Clipboard
; Return

F24::
InputBox, nameVar, Name of Extension,,,, 100
if ErrorLevel {
	MsgBox, 16, Script cancelled
	Return
}
StringLower, ExtensionVar, nameVar
ExtensionVar := StrReplace(ExtensionVar, A_Space, ".")
xmlLine3 := "<ExtensionManifest ExtensionBundleId=" . """" . "com." . ExtensionVar . """" . " ExtensionBundleVersion=""1.0.0"" Version=""7.0"" xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"">" . "`r`n" 
xmlLine6 := "    <Extension Id=" . """" . "com." . ExtensionVar . ".panel" . """" . " Version=""1.0.0"" />" . "`r`n"
xmlLine23 := "    <Extension Id=" . """" . "com." . ExtensionVar . ".panel" . """" . " />" . "`r`n"
xmlLine38 := "          <Menu>" . nameVar . "</Menu>" . "`r`n" 

fileOpen("manifest.xml", rw)

reWriteXMLFileByLineNumber("3")
reWriteXMLFileByLineNumber("6")
reWriteXMLFileByLineNumber("23")
reWriteXMLFileByLineNumber("38")
File.Close()
Return

reWriteXMLFileByLineNumber(lineNum, file:="manifest.xml") {
	; fileFull := "C:\Users\PortablePawnShop\Documents\GitMaster\Templates\Adobe-Panels\" . file
	fileFull := A_ScriptDir . "\" . file

	file := FileOpen(file,"rw`n")
	if !IsObject(file)
		MsgBox % "Can't open file."

	Loop, % lineNum
	{
		currLine := A_Index
		if (A_Index != lineNum) {
			thisLine := File.ReadLine()
		} else {
			thisLine := xmlLine%lineNum%
			File.WriteLine(thisLine)
			}		
		MsgBox % "line " currLine ": " thisLine
	}
	File.Seek(0,0)
}


	; <?xml version='1.0' encoding='UTF-8'?>
	; <!-- 1) -->
	; <ExtensionManifest ExtensionBundleId="com.show.error" ExtensionBundleVersion="1.0.0" Version="7.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

	; tensionList>
	;     <Extension Id="com.show.error.panel" Version="1.0.0" />

	; "1.0.0" />


; +F24::
; Loop, % xmlLineNums.Length()
; {
; 	lineNumber := xmlLineNums[A_Index]
; 	editXMLArray[lineNumber] := xmlLine%A_Index%
; 	; editXMLArray.push(Line%A_Index%)
; }

; MsgBox % editXMLArray[1] "`r`n" editXMLArray[2]

; LineTest = 3
; MsgBox % editXMLArray[LineTest] "`r`n" "2 :" editXMLArray.5 "`r`n" editXMLArray.23 "`r`n" editXMLArray.38
; Return




	; ﻿<?xml version='1.0' encoding='UTF-8'?>
	; <!-- 1) -->
	; <ExtensionManifest ExtensionBundleId="com.my.test" ExtensionBundleVersion="1.0.0" Version="7.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	;   <ExtensionList>
	;     <!-- 2) -->
	;     <Extension Id="com.my.test.panel" Version="1.0.0" />

; xmlLineNums := ["3", "6", "23", "38"]



^F24::
InputBox, nameVar, Name of Extension,,,, 100
if ErrorLevel {
	MsgBox, 16, Script cancelled
	Return
}
ExtensionVar := nameVar
ExtensionVar := Format("{:L}", StrReplace(ExtensionVar, A_Space, "."))

FileRead, xml, manifest.xml
xml_replaced := RegExReplace(xml, "my\.test", ExtensionVar)

FileDelete, manifest.xml
FileAppend, % xml_replaced, manifest.xml

Return



; loopLine := ["3", "5"]
; cycle = 0

; Loop, 2
; {
; 	++cycle
; 	Loop, % loopLine[1]
; 	{
; 		if (A_Index != loopLine[1])
; 		thisLine := File.ReadLine()
; 		else
; 		thisLine := File.Write(newLineCycle1)
; 		; if ((cycle = 2) && (A_Index != loopLine[2]))
; 		; thisLine := File.ReadLine()
; 		; else
; 		; thisLine := File.Write(newLineCycle2)
; 		MsgBox % "cycle: " cycle "`r`n" "line: " line "`r`n" thisLine
; 	}
; 	File.Seek(0,0)
; }

; close:
; File.Close()
; Return

!Esc::Reload