; Copyright (c) 2008, Tony Ivanov
; All rights reserved.
;
; Redistribution and use in source and binary forms, with or without
; modification, are permitted provided that the following conditions are met:
;     * Redistributions of source code must retain the above copyright
;       notice, this list of conditions and the following disclaimer.
;     * Redistributions in binary form must reproduce the above copyright
;       notice, this list of conditions and the following disclaimer in the
;       documentation and/or other materials provided with the distribution.
;     * Neither the name of Wuake nor the
;       names of its contributors may be used to endorse or promote products
;       derived from this software without specific prior written permission.
;
; THIS SOFTWARE IS PROVIDED BY Tony Ivanov ``AS IS'' AND ANY
; EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
; WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
; DISCLAIMED. IN NO EVENT SHALL Tony Ivanov BE LIABLE FOR ANY
; DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
; (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
; ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
; (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
; SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.0.0
 Author:         Tony Ivanov (telamohn@gmail.com)

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------
$version = 1.0

; ----- configuration ------
$hotkey = "{APPSKEY}" 
$runCommand = "Console.exe"
$winHandleMatch = "[TITLE:Wuake; CLASS:Console_2_Main;]"



; Script Start - Don't edit anything beyond this point unless you really want to.
#include <GUIConstantsEx.au3>
Run($runCommand,"", @SW_HIDE)
WinWait($winHandleMatch)

Opt("TrayOnEventMode",1)
Opt("TrayAutoPause",0)
Opt("TrayMenuMode",1) 
Opt("GUIOnEventMode", 1)
$about = TrayCreateItem("About")
TrayItemSetOnEvent($about,"PopAbout")
$exit = TrayCreateItem("Exit")
TrayItemSetOnEvent($exit,"ExitEv")
TraySetOnEvent(-7,"toggleVisible")
TraySetClick (8)

$visible = false
$console = WinGetHandle($winHandleMatch)
WinMove($console,"",0,0,@DesktopWidth, @DesktopHeight / 2)
HotKeySet($hotkey,"toggleVisible")




Func toggleVisible()
	If $visible Then		
		;WinMove ( $console, "", 200,0,Default,Default,5) ;Window sliding effect was a bit too slow to be useful...
		WinSetState ( $console,"", @SW_HIDE )		
		$visible = false
	Else
		WinSetState ( $console,"", @SW_SHOW )
		WinSetOnTop ($console,"",1)
		WinActivate($console,"")
		
		;WinMove ( $console, "", 200,100,Default,Default,5)
		$visible = true
	EndIf
	
EndFunc

While 1
	If Not WinExists($winHandleMatch) Then
		Exit
	EndIf
    Sleep(100)
WEnd
Func ExitEv()
	WinClose($console)
	Exit
EndFunc

Func OnAutoItExit()
	WinClose($console)
EndFunc

Func PopAbout()	
	$o = 25
	GUICreate("About", 230, 160) 
 	GUICtrlCreateLabel("Wuake v" & $version,85,10+$o)
	GUICtrlCreateLabel("Author: Tony Ivanov (telamohn@gmail.com)",10,25+$o)
	GUICtrlCreateLabel("http://www.tonyivanov.se",10,40+$o)
	GUICtrlCreateLabel("Console project page: ",10,65+$o)
	GUICtrlCreateLabel("http://sourceforge.net/projects/console/",10,80+$o)
	$okBtn= GUICtrlCreateButton("Ok",85,100+$o,60)
	GUISetState(@SW_SHOW)
	GUICtrlSetOnEvent($okBtn, "closeAbout")
	GUISetOnEvent($GUI_EVENT_CLOSE, "closeAbout")
EndFunc
Func closeAbout()
	GUIDelete()
EndFunc
