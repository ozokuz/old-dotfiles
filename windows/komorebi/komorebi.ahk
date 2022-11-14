#SingleInstance Force
#NoEnv

; Komorebi autohotkey library
#Include %A_ScriptDir%\komorebic.lib.ahk
; Default window rules
#Include %A_ScriptDir%\komorebi.generated.ahk

; Quit komorebi & yasb when quitting autohotkey
OnExit("komorebic_stop")
komorebic_stop()
{
    Run, komorebic.exe stop, , Hide
    Run, taskkill.exe /f /im pythonw.exe, , Hide
    return
}


; Generic Behaviour
; Default to minimizing windows when switching workspaces
WindowHidingBehaviour("minimize")
; Set cross-monitor move behaviour to insert instead of swap
CrossMonitorMoveBehaviour("insert")
; Configure the invisible border dimensions
InvisibleBorders(7, 0, 14, 7)
; Change mouse focus settings
ToggleMouseFollowsFocus()
ToggleFocusFollowsMouse("windows")

; Ensure workspaces are created
EnsureWorkspaces(0, 9)
; Workspace Configuration
RunWait, pwsh.exe "C:\Users\%A_UserName%\komorebi-ws.ps1", , Hide

; Custom Window Rules
; iCUE Rule
IdentifyTrayApplication("exe", "iCUE.exe")
IdentifyBorderOverflowApplication("exe", "iCUE.exe")
FloatRule("class", "CUETrayMenu")

; Authy Rule
FloatRule("exe", "Authy Desktop.exe")

; Hyper-V Rule
FloatRule("exe", "vmconnect.exe")

; Path of Building Community Rule
FloatRule("class", "SimpleGraphic Console Class")

; Steam Rule
FloatRule("exe", "steamwebhelper.exe")

; PuyoVS Rule
FloatRule("exe", "PuyoVS.exe")

; Overwolf Rules
ManageRule("title", "CurseForge")
IdentifyTrayApplication("exe", "Overwolf.exe")
IdentifyBorderOverflowApplication("exe", "Overwolf.exe")

; f.lux Rules
FloatRule("exe", "flux.exe")
IdentifyTrayApplication("exe", "flux.exe")

; LoR Master Tracker Rules
FloatRule("exe", "LoRMasterTracker.exe")
IdentifyTrayApplication("exe", "LoRMasterTracker.exe")
IdentifyBorderOverflowApplication("exe", "LoRMasterTracker.exe")

; Workspace Rules
WorkspaceRule("exe", "WhatsApp.exe", 0, 7)
WorkspaceRule("exe", "Spotify.exe", 0, 8)
WorkspaceRule("exe", "WaveLink.exe", 0, 8)

; Allow komorebi to start managing windows
CompleteConfiguration()

; Start yasb
Run, pythonw "C:\Users\%A_UserName%\AppData\Local\Programs\yasb\src\main.py", , Hide


; Keybinds
; Change the focused window, Alt + Vim direction keys (HJKL)
!h::
Focus("left")
return

!j::
Focus("down")
return

!k::
Focus("up")
return

!l::
Focus("right")
return

; Move the focused window in a given direction, Alt + Shift + Vim direction keys (HJKL)
!+h::
Move("left")
return

!+j::
Move("down")
return

!+k::
Move("up")
return

!+l::
Move("right")
return

; Change between workspaces
!1::
FocusWorkspace(0)
return

!2::
FocusWorkspace(1)
return

!3::
FocusWorkspace(2)
return

!4::
FocusWorkspace(3)
return

!5::
FocusWorkspace(4)
return

!6::
FocusWorkspace(5)
return

!7::
FocusWorkspace(6)
return

!8::
FocusWorkspace(7)
return

!9::
FocusWorkspace(8)
return

; Move a window to a workspace
!+1::
SendToWorkspace(0)
return

!+2::
SendToWorkspace(1)
return

!+3::
SendToWorkspace(2)
return

!+4::
SendToWorkspace(3)
return

!+5::
SendToWorkspace(4)
return

!+6::
SendToWorkspace(5)
return

!+7::
SendToWorkspace(6)
return

!+8::
SendToWorkspace(7)
return

!+9::
SendToWorkspace(8)
return

; Close focused window
!q::
WinClose, A
return

; Open Windows Terminal as normal user
!t::
Run, explorer.exe C:\Users\Ozoku\AppData\Local\Microsoft\WindowsApps\wt.exe
return

; Open Brave
!b::
Run, explorer.exe C:\Users\Ozoku\AppData\Local\BraveSoftware\Brave-Browser\Application\brave.exe
return

; Minimize Window
!w::
WinMinimize, A
return

; Toggle Float
!f::
ToggleFloat()
return

