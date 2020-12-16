; ! = ALT
; ^ = CTRL
; + = SHIFT
; # = WIN

#NoEnv
SendMode Input
SetTitleMatchMode, 2

; Disable windows lock to enable remapping #l
RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Policies\System, DisableLockWorkstation, 1

GroupAdd, Browsers, ahk_exe chrome.exe
GroupAdd, Browsers, ahk_exe firefox.exe
GroupAdd, Editors, ahk_exe Code.exe
GroupAdd, Terminals, ahk_exe WindowsTerminal.exe

global start_dir := "C:\Users\cleme"


; ------
; KEYBOARD MOVEMENTS
; ------

; Move/Select by line
#Left::Send {Home}
#Right::Send {End}
#Up::
  if WinActive("ahk_exe explorer.exe")
    Send !{Up} ; Move up a folder in explorer
  else
    Send ^{Home}
  return
#Down::
  if WinActive("ahk_exe explorer.exe")
    Send {Enter} ; Move down a folder in explorer
  else
    Send ^{End}
  return
#+Left::send +{Home}
#+Right::Send +{End}
#+Up::send ^+{Home}
#+Down::Send ^+{End}

; Move/Select by word
!Left::Send ^{Left}
!Right::Send ^{Right}
!+Left::Send ^+{Left}
!+Right::Send ^+{Right}

; Delete
!BS::Send {LShift Down}{LCtrl Down}{Left}{LShift Up}{LCtrl Up}{Delete}
!+BS::Send {LShift Down}{LCtrl Down}{Right}{LShift Up}{LCtrl Up}{Delete}
#+BS::Send {LShift down}{End}{LShift Up}{Delete}
#BS::
  if WinActive("ahk_exe explorer.exe")
    Send {Delete} ; Put selected file in bin in explorer
  else if WinActive("ahk_group Editors")
    Send {LShift Down}{Home}{BackSpace}{LShift Up}
  else
    Send {LShift Down}{Home}{LShift Up}{Delete}
  return

; Select multiple caret
#^Up::Send ^!{Up}
#^Down::Send ^!{Down}

; Backward/Forward history
#^Left::Send !^{Left}
#^Right::Send ^!{Right}

; Move windows with super+alt+arrows
#!Left::SendEvent {LWin Down}{Left}{LWin Up}
#!Right::SendEvent {LWin Down}{Right}{LWin Up}
#!Up::SendEvent {LWin Down}{Up}{LWin Up}
#!Down::SendEvent {LWin Down}{Down}{LWin Up}


; ------
; WINDOWS KEY TO CONTROL MAPPING
; ------

#a::Send ^a
#b::Send ^b
#c::Send ^c
#+c::Send ^+c
#!c::
  if WinActive("ahk_group Browsers")
    Send ^+c ; Shows inspector mode for dev tools on browsers
  else
    Send ^!c
  return
#d::Send ^d
#!d::
  if WinActive("ahk_group Browsers")
    Send ^+d ; Change docking mode for dev tools on browsers
  else
    Send ^!d
  return
#+d::Send ^+d
#e::Run, %start_dir% ; Allow custom startup folder otherwise impossible
#+e::
  if WinActive("ahk_exe Simplenote.exe")
    Send ^+f ; Show sidebar in simplenote
  else
    Send ^+e
  return
#!e::
  if WinActive("ahk_group Browsers")
    Send ^+e ; Shows network mode for dev tools on browsers
  else
    Send ^!e
  return
#f::Send ^f
#+f::
  if WinActive("ahk_exe Simplenote.exe")
    Send ^+s ; Focus search field in simplenote
  else
    Send ^+f
  return
#!f::Send +!f
#g::Send ^g
#h::Send ^h
#i::
  if WinActive("ahk_exe explorer.exe")
    Send !{Enter} ; Shows info panel in explorer
  else
    Send ^i
  return
#!i::
  if WinActive("ahk_group Browsers")
    Send ^+i ; Shows dev tools on browsers
  else
    Send ^!i
  return
#+i::Send ^+i
#k::Send ^k
#+k::Send ^+k
#!k::
  if WinActive("ahk_group Browsers")
    Send ^+k ; Shows console mode for dev tools on browsers
  else
    Send ^!k
  return
#l::Send ^l
#+l::Send ^+l
#m::WinMinimize, a ; Minimize current app
#+m::Send ^+m
#!m::
  if WinActive("ahk_group Browsers")
    Send ^+m ; Shows mobile dev tools on browsers
  else
    Send ^!m
  return
#n::Send ^n
#!n::Send ^!n
#+n::
  if WinActive("ahk_exe firefox.exe")
    Send ^+p ; Create new private window similar to chrome
  else
    Send ^+n
  return
#o::Send ^o
#+o::Send ^+o
#p::Send ^p
#+p::Send ^+p
#!p::Send ^!p
#if not (AltTabMenu) ; We want to be able to quit with #q in alt tab mode
  #q::Send !{F4}     ; Force quit app
#if
#r::Send ^r
#+r::Send ^+r
#s::Send ^s
#+s::Send ^+s
#t::
  if WinActive("ahk_exe Simplenote.exe")
    Send ^+i ; New note in simplenote
  else
    Send ^t
  return
#+t::Send ^+t
#u::Send ^u
#v::Send ^v
#+v::Send ^+v
#w::Send ^w
#!w::Send ^!w
#x::Send ^x
#+x::Send ^+x
#z::Send ^z
#+z::Send ^+z

#0::Send ^0
#+0::Send ^+0
#1::Send ^1
#+1::Send ^+1
#2::Send ^2
#+2::Send ^+2
#3::Send ^3
#+3::Send ^+3
#4::Send ^4
#+4:: Run, C:\WINDOWS\system32\SnippingTool.exe /clip ; Run snippet tool
#5::Send ^5
#+5::Send ^+5

#'::Send ^'
#.::Send ^.
#=::Send ^{=}
#-::Send ^-
#\::Send ^\   ; One password shortcuts
#!\::Send ^!\ ; One password shortcuts
#/::Send ^/
#+/::Send ^+/
#,::Send ^,

#+Enter::Send ^+{Enter}
#Delete::Send ^{Delete}
#Enter::
  if WinActive("ahk_exe explorer.exe")
    Send {F2} ; Rename file in explorer
  else
    Send ^{Enter}
  return

#F1::Send #x ; Shows same menu as right clicking windows logo in task bar
#F2::Send #r ; Shows windows run since we remmaped it
#F3::Send #d ; Shows desktop
#F7::Send {Media_Prev}
#F8::Send {Media_Play_Pause}
#F9::Send {Media_Next}
#F10::Send {Volume_Mute}
#F11::Send {Volume_Down 2}
#F12::Send {Volume_Up 2}
#F13::Send {PrintScreen}


; ------
; ACCENTED CHARACTERS
; ------

!e::Send {Asc 130}
!+e::Send {Asc 138}
!^e::Send {Asc 136}
!a::Send {Asc 133}
!+a::Send {Asc 131}
#SC055::Send {Asc 253}
!u:: Send {Asc 151}
!+u:: Send {Asc 150}
!c:: Send {Asc 135}
!i:: Send {Asc 140}
!+i:: Send {Asc 139}
!o:: Send {Asc 147}


; ------
; APPS
; ------

; Alt tab
;LWin & Tab::AltTab
LWin & Tab::
  AltTabMenu := true
  if GetKeyState("Shift","P")
    SendEvent {Alt Down}{Shift Down}{Tab}
  else
    SendEvent {Alt Down}{Tab}
  return
#if (AltTabMenu)
  ~*#q::Send {Delete}
  ~*LWin Up::
    Send {Shift Up}{Alt Up}
    AltTabMenu := false
    return
#if

; Browsers history remap since alt -> left is move by word
#if WinActive("ahk_group Browsers")
  ^Left::Send !{Left}
  ^Right::Send !{Right}
#if

; Windows Terminal quake like for now
#SC029::
  terminal := WinExist("ahk_exe WindowsTerminal.exe")
  if terminal {
    active := WinActive("ahk_id " terminal)
    if (active)
      WinMinimize, ahk_id %active%
    else
      WinActivate, ahk_id %terminal%
  } else {
    ; see https://www.autohotkey.com/boards/viewtopic.php?t=4392&p=24540
    sleep, 150
    Run, wt.exe
  }
  return

; Lock computer
F19::
  RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Policies\System, DisableLockWorkstation, 0
  DllCall("LockWorkStation")
  Reload
  return

; Show / Hide hidden files
#if WinActive("ahk_exe explorer.exe")
  #+.::
    RegRead, ShowHidden_Status, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden
    if ShowHidden_Status = 2
      RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 1
    else
      RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 2
      Send, {F5}
    return
#if
