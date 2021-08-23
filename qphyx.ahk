;===============================================================================================
;============================================Presets============================================
;===============================================================================================

#SingleInstance Force
#UseHook On

SetCapsLockState AlwaysOff
SetNumLockState AlwaysOff
SetScrollLockState AlwaysOff

;set icon
icon := "internal\qphyx.ico"
IfExist, %icon%
{
    Menu, Tray, Icon, %icon%, , 1
}

Global EXT
If A_IsCompiled
{
    EXT := ".exe"
}
Else
{
    EXT := ".ahk"
}

;main config.ini variables
Global VIATC_PATH
Global QPHYX_DISABLE
Global QPHYX_LONG_TIME

Global INI := "config.ini"
IfExist, %INI%
{
    IniRead, VIATC_PATH,        %INI%, Configuration, ViatcPath
    IniRead, QPHYX_DISABLE,     %INI%, Configuration, QphyxDisable
    IniRead, QPHYX_LONG_TIME,   %INI%, Configuration, QphyxLongTime
}
Else
{
    IniWrite, 666,                  %INI%, Configuration, MusCheckDelay
    IniWrite, 10,                   %INI%, Configuration, MusPauseDelay
    IniWrite, 33,                   %INI%, Configuration, SleepDelay
    IniWrite, internal\nircmd.exe,  %INI%, Configuration, NircmdPath
    IniWrite, internal\ViATc.lnk,   %INI%, Configuration, ViatcPath
    IniWrite, 0,                    %INI%, Configuration, QphyxDisable
    IniWrite, 0.15,                 %INI%, Configuration, QphyxLongTime
    Run, qphyx%EXT%
}

Global SPOTIFY
SpotifyDetectProcessId()

;let ViATc override hotkeys (only for TC)
Try
{
    Run, %VIATC_PATH%
}
;let menu override ViATc
Try
{
    Run, menu%EXT%
}


Global NUM_DICT := {scan_code: ["releasing", "sended", "shift_long", "alt", "alt_long"]
    , SC002: [0, 0, "⁺", "₁", "₊"]
    , SC003: [0, 0, "⁻", "₂", "₋"]
    , SC004: [0, 0, "ⁿ", "₃", "ₓ"]
    , SC005: [0, 0, "ⁱ", "₄", "ₐ"]
    , SC006: [0, 0, "⁼", "₅", "₌"]
    , SC007: [0, 0, "⁽", "₆", "₍"]
    , SC008: [0, 0, "⁾", "₇", "₎"]
    , SC009: [0, 0, "̂" , "₈", "̃" ] ; shift long – diacritic circumflex; alt_long – diacr. tilde
    , SC00A: [0, 0, "̆" , "₉", "̈" ] ; shift long – diacritic breve; alt_long – diacritic umlaut
    , SC00B: [0, 0, "∕", "₀", "̧" ] ; alt long – diacritic cedilla
    , SC00C: [0, 0, "∞", "↓", "←"]
    , SC00D: [0, 0, "Σ", "↑", "→"]}

Global DICT := {scan_code: ["releasing", "sended", "long", "alt"]
    , SC010: [0, 0, "~", "°"]
    , SC011: [0, 0, "–", "—"]
    , SC012: [0, 0, "@", "§"]
    , SC013: [0, 0, "\", "&"]
    , SC014: [0, 0, "``","’"]
    , SC015: [0, 0, "<", "«"]
    , SC016: [0, 0, "(", "" ] ; alt – back
    , SC017: [0, 0, "[", "" ] ; alt - forward
    , SC018: [0, 0, "{", "“"]
    , SC019: [0, 0, "!", "¡"]
    , SC01A: [0, 0, "#", "№"]
    , SC01B: [0, 0, "́" , "̀" ] ; long – diacritic acute; alt – diacritic grave
    , SC01E: [0, 0, "+", "±"]
    , SC01F: [0, 0, "-", "−"]
    , SC020: [0, 0, "*", "×"]
    , SC021: [0, 0, "/", "÷"]
    , SC022: [0, 0, "=", "≠"]
    , SC023: [0, 0, """","" ] ; alt - left
    , SC024: [0, 0, "'", "" ] ; alt - down
    , SC025: [0, 0, ".", "" ] ; alt - up
    , SC026: [0, 0, ",", "" ] ; alt - right
    , SC027: [0, 0, ":", "%"]
    , SC028: [0, 0, ";", "^"]
    , SC02C: [0, 0, "$", "¥"]
    , SC02D: [0, 0, "€", "£"]
    , SC02E: [0, 0, "₽", "¤"]
    , SC02F: [0, 0, "_", "|"]
    , SC030: [0, 0, "≈", "≟"]
    , SC031: [0, 0, ">", "»"]
    , SC032: [0, 0, ")", "" ] ; alt - undo
    , SC033: [0, 0, "]", "" ] ; alt - redo
    , SC034: [0, 0, "}", "”"]
    , SC035: [0, 0, "?", "¿"]}


;===============================================================================================
;===========================================Layout functions====================================
;===============================================================================================

;numerical row interaction
DownNum(this, alt:=0)
{
    If !NUM_DICT[this][1]
    {
        NUM_DICT[this][1] := 1
        KeyWait, %this%, T%QPHYX_LONG_TIME%
        If ErrorLevel
        {
            NUM_DICT[this][2] := 1
            If alt
            {
                SendInput % NUM_DICT[this][5]
            }
            Else
            {
                SendInput % NUM_DICT[this][3]
            }
        }
    }
}
UpNum(this, shift:=0, alt:=0)
{
    If (NUM_DICT[this][1] && !NUM_DICT[this][2])
    {
        If alt
        {
            SendInput % NUM_DICT[this][4]
        }
        Else If shift
        {
            SendInput +{%this%}
        }
        Else
        {
            SendInput {%this%}
        }
    }
    NUM_DICT[this][1] := 0
    NUM_DICT[this][2] := 0
}

;letter rows interaction
Down(this)
{
    If !DICT[this][1]
    {
        DICT[this][1] := 1
        KeyWait, %this%, T%QPHYX_LONG_TIME%
        If (ErrorLevel && !DICT[this][2])
        {
            DICT[this][2] := 1
            SendInput % "{Text}" . DICT[this][3]
        }
    }
}
Up(this)
{
    If (DICT[this][1] && !DICT[this][2])
    {
        SendInput {%this%}
    }
    DICT[this][1] := 0
    DICT[this][2] := 0
}

;swap between opened predefined apps
Alt(process_name, path)
{
    ;hardcoded
    If (process_name == "Spotify.exe" && SPOTIFY)
    {
        proc := "ahk_id " . SPOTIFY
    }
    Else
    {
        proc := "ahk_exe " . process_name
    }

    If WinExist(proc)
    {
        WinGetTitle, title, %proc%
        If WinActive(title)
        {
            WinMinimize, %title%
        }
        Else
        {
            WinActivate, %title%
        }
    }
    Else
    {
        Run %path%
    }
}

;auxiliary to "#+SC025" restore
LastMinimizedWindow()
{
    WinGet, windows, List
    Loop, %windows%
    {
        WinGet, win_state, MinMax, % "ahk_id" windows%A_Index%
        If (win_state == -1)
        {
            Return windows%A_Index%
        }
    }
}

;detect current spotify process
SpotifyDetectProcessId()
{
    WinGet, id, list, , , Program Manager
    Loop, %id%
    {
        this_id := id%A_Index%
        WinGet, proc, ProcessName, ahk_id %this_id%
        WinGetTitle, title, ahk_id %this_id%
        If (title && proc == "Spotify.exe")
        {
            SPOTIFY := this_id
            Break
        }
    }
    If !SPOTIFY
    {
        SetTimer, SpotifyDetectProcessId, -66666
    }
}


Pass:
    Return


;===============================================================================================
;===========================================Controlling assignments=============================
;===============================================================================================

;;;same
;SC001:: esc
;SC00F:: tab
;SC01D:: lctrl
;SC02A:: lshift
;SC038:: lalt
;SC03B:: f1
;SC03C:: f2
;SC03D:: f3
;SC03E:: f4
;SC03F:: f5
;SC040:: f6
;SC041:: f7
;SC042:: f8
;SC043:: f9
;SC044:: f10
;SC045:: pause
;SC046:: scroll lock
;SC057:: f11
;SC058:: f12
;SC110:: media prev
;SC119:: media next
;SC11D:: rctrl
;SC120:: volume mute
;SC121:: calculator
;SC122:: media play/pause
;SC124:: media stop
;SC12E:: volume down
;SC130:: volume up
;SC132:: browser (new window or homepage on active browser window active tab)
;SC136:: rshift
;SC137:: print screen
;SC138:: ralt
;SC147:: home
;SC149:: page up
;SC14F:: end
;SC151:: page down
;SC152:: insert
;SC15B:: lwin
;SC15D:: apps key
;SC169:: browser forward
;SC16A:: browser back-
;SC16D:: media player

;;;other (not found)
;SC036:: rshift ??? (136)
;SC054:: (Alt-SysRq) on a 84+ key keyboard
;SC055:: is less common; occurs e.g. as F11 on a Cherry G80-0777 keyboard,
    ;as F12 on a Telerate keyboard, as PF1 on a Focus 9000 keyboard, as FN on an IBM ThinkPad
;SC056:: mostly on non-US keyboards.
    ;It is often an unlabelled key to the left or to the right of the left Alt key


;tilde
+SC029::
    If QPHYX_DISABLE
    {
        IniWrite, 0, %INI%, Configuration, QphyxDisable
    }
    Else
    {
        IniWrite, 1, %INI%, Configuration, QphyxDisable
    }
    Run, qphyx%EXT%
    Return


#If !QPHYX_DISABLE

 SC029:: SendInput  {SC001}
!SC029:: SendInput !{SC001}
^SC029:: SendInput ^{SC001}

;swap between opened predefined apps
LWin & SC010:: Alt("nvim-qt.exe",       "C:\Shortcuts\nvim-qt.exe.lnk")     ;Q
LWin & SC011:: Alt("Notion.exe",        "C:\Shortcuts\Notion.exe.lnk")      ;P
LWin & SC012:: Alt("taskmgr.exe",       "C:\Shortcuts\taskmgr.exe.lnk")     ;H
LWin & SC01E:: Alt("Everything.exe",    "C:\Shortcuts\Everything.exe.lnk")  ;E
LWin & SC01F:: Alt("Spotify.exe",       "C:\Shortcuts\Spotify.exe.lnk")     ;A
LWin & SC02C:: Alt("firefox.exe",       "C:\Shortcuts\firefox.exe.lnk")     ;J
LWin & SC020:: Alt("calc.exe",          "C:\Shortcuts\calc.exe.lnk")        ;O
;LWin& SC02D:: Total Commander (set in VIaTC)                               ;Э
LWin & SC021::                                                              ;I
    If (SubStr(A_OSVersion, 1, 2) == 10)
    {
        Alt("WindowsTerminal.exe", "C:\Shortcuts\wt.exe.lnk")
    }
    Else
    {
        Alt("cmd.exe", "C:\Shortcuts\cmd.exe.lnk")
    }

;;;Return
;numpad mult (*)
    *SC037::
;numpad 789-
    *SC047::
    *SC048::
    *SC049::
    *SC04A::
;numpad 456+
    *SC04B::
    *SC04C::
    *SC04D::
    *SC04E::
;numpad 1230.
    *SC04F::
    *SC050::
    *SC051::
    *SC052::
    *SC053::
;numpad enter
    *SC11C::
;numpad div (/)
    *SC135::
;num lock
    *SC145::
;arrows up/left/right/down
    *SC148::
    *SC14B::
    *SC14D::
    *SC150::
;delete
    *SC153::
        Return

;backspace
 SC00E:: SendInput {SC122}
!SC00E::
    KeyWait, SC00E, T%QPHYX_LONG_TIME%
    If ErrorLevel
    {
        SendInput {SC110}
    }
    Else
    {
        SendInput {SC12E}
    }
    KeyWait, SC00E
    Return
+SC00E::
    KeyWait, SC00E, T%QPHYX_LONG_TIME%
    If ErrorLevel
    {
        SendInput {SC119}
    }
    Else
    {
        SendInput {SC130}
    }
    KeyWait, SC00E
    Return

;enter
  SC01C:: SendInput  {SC00E}
 +SC01C:: SendInput  {SC153}
 ^SC01C:: SendInput ^{SC00E}
+^SC01C:: SendInput ^{SC153}
 #SC01C::
    KeyWait, SC01C, T%QPHYX_LONG_TIME%
    If ErrorLevel
    {
        WinMinimizeAllUndo
    }
    Else
    {
        WinGetTitle, title, A
        If (title != "Program Manager")
        {
            WinMinimizeAll
        }
    }
    KeyWait, SC01C
    Return

;(\|), on a 102-key keyboards controled by menu.ahk

;caps lock
 SC03A:: SendInput  {SC01C}
+SC03A:: SendInput +{SC01C}
!SC03A:: SendInput !{SC01C}
^SC03A:: SendInput ^{SC01C}

;uim, гшьб (wlf] шлфч)
!SC016:: SendInput  {SC16A}
!SC017:: SendInput  {SC169}
!SC032:: SendInput ^{SC02C}
!SC033:: SendInput ^{SC015}

;nav hjkl ролд (mstr мстр)
    ;base nav
  !SC023:: SendInput   {SC14B}
  !SC024:: SendInput   {SC150}
  !SC025:: SendInput   {SC148}
  !SC026:: SendInput   {SC14D}
    ;nav with select
 +!SC023:: SendInput  +{SC14B}
 +!SC024:: SendInput  +{SC150}
 +!SC025:: SendInput  +{SC148}
 +!SC026:: SendInput  +{SC14D}
    ;ctrl nav (left-right move by words; up-down as home-end)
 ^!SC023:: SendInput  ^{SC14B}
 ^!SC024:: SendInput   {SC147}
 ^!SC025:: SendInput   {SC14F}
 ^!SC026:: SendInput  ^{SC14D}
    ;ctrl nav with select
+^!SC023:: SendInput +^{SC14B}
+^!SC024:: SendInput  +{SC147}
+^!SC025:: SendInput  +{SC14F}
+^!SC026:: SendInput +^{SC14D}

    ;move window
  #SC023:: SendInput  #{SC14B}
  #SC024:: SendInput  #{SC150}
  #SC025:: SendInput  #{SC148}
  #SC026:: SendInput  #{SC14D}
 #+SC023:: SendInput #+{SC14B}
 #+SC026:: SendInput #+{SC14D}
 #+SC024::
    WinGetActiveTitle, title
    If title
    {
        WinMinimize, A
        WinActivate
    }
    Return
 #+SC025::
    last_minimized := LastMinimizedWindow()
    WinGetTitle, title, ahk_id %last_minimized%
    WinRestore, %title%
    Return

; ctrl-sh-g (qphyx-view). clipboard swap (paste and save replaced text as a new clipboard text)
+^SC02F::
    saved_value := Clipboard
    Clipboard := ""
    SendInput ^{SC02E}
    ClipWait
    saved_value2 := Clipboard
    Clipboard := ""
    Clipboard := saved_value
    ClipWait
    SendEvent ^{SC02F}
    Clipboard := saved_value2
    Return

;===============================================================================================
;============================="Send symbol" key assignments=====================================
;===============================================================================================

;numeric row
+SC002::
+SC003::
+SC004::
+SC005::
+SC006::
+SC007::
+SC008::
+SC009::
+SC00A::
+SC00B::
+SC00C::
+SC00D::
    DownNum(SubStr(A_ThisHotkey, 2))
    Return

!SC002::
!SC003::
!SC004::
!SC005::
!SC006::
!SC007::
!SC008::
!SC009::
!SC00A::
!SC00B::
!SC00C::
!SC00D::
    DownNum(SubStr(A_ThisHotkey, 2), 1)
    Return

;top letters row
SC010::
SC011::
SC012::
SC013::
SC014::
SC015::
SC016::
SC017::
SC018::
SC019::
SC01A::
SC01B::
;home letters row
SC01E::
SC01F::
SC020::
SC021::
SC022::
SC023::
SC024::
SC025::
SC026::
SC027::
SC028::
;bottom letters row
SC02C::
SC02D::
SC02E::
SC02F::
SC030::
SC031::
SC032::
SC033::
SC034::
SC035::
    Down(A_ThisHotkey)
    Return

;numeric row
+SC002 up::
+SC003 up::
+SC004 up::
+SC005 up::
+SC006 up::
+SC007 up::
+SC008 up::
+SC009 up::
+SC00A up::
+SC00B up::
+SC00C up::
+SC00D up::
    UpNum(SubStr(A_ThisHotkey, 2, 5), 1)
    Return

!SC002 up::
!SC003 up::
!SC004 up::
!SC005 up::
!SC006 up::
!SC007 up::
!SC008 up::
!SC009 up::
!SC00A up::
!SC00B up::
!SC00C up::
!SC00D up::
    UpNum(SubStr(A_ThisHotkey, 2, 5), , 1)
    Return

;top letters row
SC010 up::
SC011 up::
SC012 up::
SC013 up::
SC014 up::
SC015 up::
SC016 up::
SC017 up::
SC018 up::
SC019 up::
SC01A up::
SC01B up::
;home letters row
SC01E up::
SC01F up::
SC020 up::
SC021 up::
SC022 up::
SC023 up::
SC024 up::
SC025 up::
SC026 up::
SC027 up::
SC028 up::
;bottom letters row
SC02C up::
SC02D up::
SC02E up::
SC02F up::
SC030 up::
SC031 up::
SC032 up::
SC033 up::
SC034 up::
SC035 up::
    Up(SubStr(A_ThisHotkey, 1, 5))
    Return

;top letters row
!SC010::
!SC011::
!SC012::
!SC013::
!SC014::
!SC015::
!SC018::
!SC019::
!SC01A::
!SC01B::
;home letters row
!SC01E::
!SC01F::
!SC020::
!SC021::
!SC022::
!SC027::
!SC028::
;bottom letters row
!SC02C::
!SC02D::
!SC02E::
!SC02F::
!SC030::
!SC031::
!SC034::
!SC035::
    SendInput % "{Text}" DICT[SubStr(A_ThisHotkey, 2)][4]
    Return

;space
SC039::
    For k in DICT
    {
        If (DICT[k][1] == 1)
        {
            Up(k)
            DICT[k][2] := 1
        }
    }
    SendInput {Space}
    Return
+SC039::
    For k in DICT
    {
        If (DICT[k][1] == 1)
        {
            Up(k)
            DICT[k][2] := 1
        }
    }
    SendInput +{Space}
    Return
