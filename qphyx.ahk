;===============================================================================================
;============================================Presets============================================
;===============================================================================================

#SingleInstance force
#UseHook On

SetCapslockState AlwaysOff
SetNumLockState AlwaysOff
SetScrollLockState AlwaysOff

;set icon
icon = qphyx.ico
IfExist, %icon%
{
    Menu, Tray, Icon, %icon%
}

;let ViATc override hotkeys (only for TC)
Try
{
    Run, ViATc.lnk
}
;let menu override ViATc
Try
{
    Run, menu.exe
}

global LONG_TIME
global DISABLE
RegRead, LONG_TIME, HKEY_CURRENT_USER\Environment, QPHYX_LONG_TIME
RegRead, DISABLE, HKEY_CURRENT_USER\Environment, QPHYX_DISABLE
If !LONG_TIME
{
    RegWrite, REG_SZ, HKEY_CURRENT_USER\Environment, QPHYX_DISABLE, 0
    RegWrite, REG_SZ, HKEY_CURRENT_USER\Environment, QPHYX_LONG_TIME, 0.166
    QPHYX_DISABLE := 0
    QPHYX_LONG_TIME := 0.166
}

global SPOTIFY
SpotifyDetectProcessId()


global NUM_DICT := { scan_code: ["releasing", "sended", "long_char", "alt", "alt_long"]
    , SC002: [0, 0, "{⁺}", "{₁}", "{₊}"]
    , SC003: [0, 0, "{⁻}", "{₂}", "{₋}"]
    , SC004: [0, 0, "{ⁿ}", "{₃}", "{ₓ}"]
    , SC005: [0, 0, "{ⁱ}", "{₄}", "{ₐ}"]
    , SC006: [0, 0, "{⁼}", "{₅}", "{₌}"]
    , SC007: [0, 0, "{⁽}", "{₆}", "{₍}"]
    , SC008: [0, 0, "{⁾}", "{₇}", "{₎}"]
    , SC009: [0, 0, "{̂}" , "{₈}", "{̃}" ]
    , SC00A: [0, 0, "{̆}" , "{₉}", "{̈}" ]
    , SC00B: [0, 0, "{∕}", "{₀}", "{̧}" ]
    , SC00C: [0, 0, "{∞}", "{↓}", "{←}"]
    , SC00D: [0, 0, "{Σ}", "{↑}", "{→}"]}

global DICT := { scan_code: ["releasing", "sended", "long_char"]
    , SC010: [0, 0, "{~}"]
    , SC011: [0, 0, "{–}"]
    , SC012: [0, 0, "{@}"]
    , SC013: [0, 0, "{\}"]
    , SC014: [0, 0, "{``}"]
    , SC015: [0, 0, "{<}"]
    , SC016: [0, 0, "{(}"]
    , SC017: [0, 0, "{[}"]
    , SC018: [0, 0, "{{}"]
    , SC019: [0, 0, "{!}"]
    , SC01A: [0, 0, "{#}"]
    , SC01B: [0, 0, "{́}" ]
    , SC01E: [0, 0, "{+}"]
    , SC01F: [0, 0, "{-}"]
    , SC020: [0, 0, "{*}"]
    , SC021: [0, 0, "{/}"]
    , SC022: [0, 0, "{=}"]
    , SC023: [0, 0, "{""}"]
    , SC024: [0, 0, "{'}"]
    , SC025: [0, 0, "{.}"]
    , SC026: [0, 0, "{,}"]
    , SC027: [0, 0, "{:}"]
    , SC028: [0, 0, "{;}"]
    , SC02C: [0, 0, "{$}"]
    , SC02D: [0, 0, "{€}"]
    , SC02E: [0, 0, "{₽}"]
    , SC02F: [0, 0, "{_}"]
    , SC030: [0, 0, "{≈}"]
    , SC031: [0, 0, "{>}"]
    , SC032: [0, 0, "{)}"]
    , SC033: [0, 0, "{]}"]
    , SC034: [0, 0, "{}}"]
    , SC035: [0, 0, "{?}"]}


;===============================================================================================
;===========================================Layout functions====================================
;===============================================================================================

;numerical row interaction
Down_num(this, alt:=0)
{
    If !NUM_DICT[this][1]
    {
        NUM_DICT[this][1] := 1
        KeyWait, %this%, T%LONG_TIME%
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
Up_num(this, shift:=0, alt:=0)
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
        KeyWait, %this%, T%LONG_TIME%
        If (ErrorLevel && !DICT[this][2])
        {
            DICT[this][2] := 1
            SendInput % DICT[this][3]
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

    If Winexist(proc)
    {
        WinGetTitle, title, %proc%
        If Winactive(title)
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
        WinGet, winState, MinMax, % "ahk_id" windows%A_Index%
        If (winState == -1)
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
    If DISABLE
    {
        RegWrite, REG_SZ, HKEY_CURRENT_USER, Environment, QPHYX_DISABLE, 0
    }
    Else
    {
        RegWrite, REG_SZ, HKEY_CURRENT_USER, Environment, QPHYX_DISABLE, 1
    }
    Run, qphyx.exe
    Return


#If !DISABLE

 SC029:: SendInput  {SC001}
!SC029:: SendInput !{SC001}
^SC029:: SendInput ^{SC001}

;swap between opened predefined apps
LWin & SC010:: Alt("nvim-qt.exe",         "C:\Shortcuts\nvim-qt.exe.lnk")       ;Q
LWin & SC011:: Alt("Notion.exe",          "C:\Shortcuts\Notion.exe.lnk")        ;P
LWin & SC012:: Alt("taskmgr.exe",         "C:\Shortcuts\taskmgr.exe.lnk")       ;H
LWin & SC01E:: Alt("Everything.exe",      "C:\Shortcuts\Everything.exe.lnk")    ;E
LWin & SC01F:: Alt("Spotify.exe",         "C:\Shortcuts\Spotify.exe.lnk")       ;A
LWin & SC020:: Alt("calc.exe",            "C:\Shortcuts\calc.exe.lnk")          ;O
LWin & SC021:: Alt("WindowsTerminal.exe", "C:\Shortcuts\wt.exe.lnk")            ;I
LWin & SC02C:: Alt("firefox.exe",         "C:\Shortcuts\firefox.exe.lnk")       ;J
;LWin& SC02D:: Total Commander (set in VIaTC) ;Э

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
    KeyWait, SC00E, T%LONG_TIME%
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
    KeyWait, SC00E, T%LONG_TIME%
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
    KeyWait, SC01C, T%LONG_TIME%
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
    lastMinimized := LastMinimizedWindow()
    WinGetTitle, title, ahk_id %lastMinimized%
    WinRestore, %title%
    Return

; ctrl-sh-g (qphyx-view). clipboard swap (paste and save replaced text as a new clipboard text)
+^SC02F::
    saved_value := Clipboard
    Sleep, SLEEP_DELAY
    SendInput ^{SC02E}
    Sleep, SLEEP_DELAY
    saved_value2 := Clipboard
    Clipboard := saved_value
    Sleep, SLEEP_DELAY
    SendInput ^{SC02F}
    Sleep, SLEEP_DELAY
    Clipboard := saved_value2
    Return

;===============================================================================================
;============================="Send symbol" key assignments=====================================
;===============================================================================================

;numeric row
+SC002:: Down_num("SC002")
!SC002:: Down_num("SC002", 1)
+SC003:: Down_num("SC003")
!SC003:: Down_num("SC003", 1)
+SC004:: Down_num("SC004")
!SC004:: Down_num("SC004", 1)
+SC005:: Down_num("SC005")
!SC005:: Down_num("SC005", 1)
+SC006:: Down_num("SC006")
!SC006:: Down_num("SC006", 1)
+SC007:: Down_num("SC007")
!SC007:: Down_num("SC007", 1)
+SC008:: Down_num("SC008")
!SC008:: Down_num("SC008", 1)
+SC009:: Down_num("SC009")
!SC009:: Down_num("SC009", 1)
+SC00A:: Down_num("SC00A")
!SC00A:: Down_num("SC00A", 1)
+SC00B:: Down_num("SC00B")
!SC00B:: Down_num("SC00B", 1)
+SC00C:: Down_num("SC00C")
!SC00C:: Down_num("SC00C", 1)
+SC00D:: Down_num("SC00D")
!SC00D:: Down_num("SC00D", 1)
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
+SC002 up:: Up_num("SC002", 1)
!SC002 up:: Up_num("SC002", , 1)
+SC003 up:: Up_num("SC003", 1)
!SC003 up:: Up_num("SC003", , 1)
+SC004 up:: Up_num("SC004", 1)
!SC004 up:: Up_num("SC004", , 1)
+SC005 up:: Up_num("SC005", 1)
!SC005 up:: Up_num("SC005", , 1)
+SC006 up:: Up_num("SC006", 1)
!SC006 up:: Up_num("SC006", , 1)
+SC007 up:: Up_num("SC007", 1)
!SC007 up:: Up_num("SC007", , 1)
+SC008 up:: Up_num("SC008", 1)
!SC008 up:: Up_num("SC008", , 1)
+SC009 up:: Up_num("SC009", 1)
!SC009 up:: Up_num("SC009", , 1)
+SC00A up:: Up_num("SC00A", 1)
!SC00A up:: Up_num("SC00A", , 1)
+SC00B up:: Up_num("SC00B", 1)
!SC00B up:: Up_num("SC00B", , 1)
+SC00C up:: Up_num("SC00C", 1)
!SC00C up:: Up_num("SC00C", , 1)
+SC00D up:: Up_num("SC00D", 1)
!SC00D up:: Up_num("SC00D", , 1)
;top letters row
SC010 up:: Up("SC010")
SC011 up:: Up("SC011")
SC012 up:: Up("SC012")
SC013 up:: Up("SC013")
SC014 up:: Up("SC014")
SC015 up:: Up("SC015")
SC016 up:: Up("SC016")
SC017 up:: Up("SC017")
SC018 up:: Up("SC018")
SC019 up:: Up("SC019")
SC01A up:: Up("SC01A")
SC01B up:: Up("SC01B")
;home letters row
SC01E up:: Up("SC01E")
SC01F up:: Up("SC01F")
SC020 up:: Up("SC020")
SC021 up:: Up("SC021")
SC022 up:: Up("SC022")
SC023 up:: Up("SC023")
SC024 up:: Up("SC024")
SC025 up:: Up("SC025")
SC026 up:: Up("SC026")
SC027 up:: Up("SC027")
SC028 up:: Up("SC028")
;bottom letters row
SC02C up:: Up("SC02C")
SC02D up:: Up("SC02D")
SC02E up:: Up("SC02E")
SC02F up:: Up("SC02F")
SC030 up:: Up("SC030")
SC031 up:: Up("SC031")
SC032 up:: Up("SC032")
SC033 up:: Up("SC033")
SC034 up:: Up("SC034")
SC035 up:: Up("SC035")

;top letters row
!SC010:: SendInput {°}
!SC011:: SendInput {—}
!SC012:: SendInput {§}
!SC013:: SendInput {&}
!SC014:: SendInput {’}
!SC015:: SendInput {«}
!SC018:: SendInput {“}
!SC019:: SendInput {¡}
!SC01A:: SendInput {№}
!SC01B:: SendInput {̀}
;home letters row
!SC01E:: SendInput {±}
!SC01F:: SendInput {−}
!SC020:: SendInput {×}
!SC021:: SendInput {÷}
!SC022:: SendInput {≠}
!SC027:: SendInput {`%}
!SC028:: SendInput {^}
;bottom letters row
!SC02C:: SendInput {¥}
!SC02D:: SendInput {£}
!SC02E:: SendInput {¤}
!SC02F:: SendInput {|}
!SC030:: SendInput {≟}
!SC031:: SendInput {»}
!SC034:: SendInput {”}
!SC035:: SendInput {¿}
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