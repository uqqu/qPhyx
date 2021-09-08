;===============================================================================================
;============================================Presets============================================
;===============================================================================================

#SingleInstance Force
#UseHook On

SetCapsLockState AlwaysOff

;set icon
icon := "qphyx.ico"
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

;global config.ini variables
Global DOTLESS_I_SWAP
Global QPHYX_DISABLE
Global QPHYX_LONG_TIME

Global INI := "config.ini"
IfExist, %INI%
{
    IniRead, latin_mode,                %INI%, Configuration, LatinMode
    IniRead, cyrillic_mode,             %INI%, Configuration, CyrillicMode
    IniRead, menu_path,                 %INI%, Configuration, MenuPath
    IniRead, viatc_file,                %INI%, Configuration, ViatcFile
    IniRead, romanian_cedilla_to_comma, %INI%, Configuration, RomanianCedillaToComma
    IniRead, DOTLESS_I_SWAP,            %INI%, Configuration, DotlessISwap
    IniRead, QPHYX_DISABLE,             %INI%, Configuration, QphyxDisable
    IniRead, QPHYX_LONG_TIME,           %INI%, Configuration, QphyxLongTime
}
Else
{
    IniWrite, 0,                        %INI%, Configuration, LatinMode
    IniWrite, 0,                        %INI%, Configuration, CyrillicMode
    IniWrite, c:\menu\,                 %INI%, Configuration, MenuPath
    IniWrite, c:\ViATc\ViATc.ahk,       %INI%, Configuration, ViatcFile
    IniWrite, 1                         %INI%, Configuration, RomanianCedillaToComma
    IniWrite, 0                         %INI%, Configuration, DotlessISwap
    IniWrite, 0,                        %INI%, Configuration, QphyxDisable
    IniWrite, 0.15,                     %INI%, Configuration, QphyxLongTime
    Run, qphyx%EXT%
}

Global SPOTIFY
SpotifyDetectProcessId()

;let ViATc override hotkeys (only for TC)
Try
{
    Run, %viatc_file%
}
;let menu override ViATc
Try
{
    Run, %menu_path%menu%EXT%, %menu_path%
}


Global NUM_DICT := {scan_code: ["releasing", "sended", "alt", "alt_long"]
    , SC002: [0, 0, "̃", "̧"]   ; alt – õ ; alt_long – o̧
    , SC003: [0, 0, "̊", "̥"]   ; alt – o̊ ; alt_long – o̥
    , SC004: [0, 0, "̈", "̤"]   ; alt – ö ; alt_long – o̤
    , SC005: [0, 0, "̇", "̣"]   ; alt – ȯ ; alt_long – ọ
    , SC006: [0, 0, "̆", "̮"]   ; alt – ŏ ; alt_long – o̮
    , SC007: [0, 0, "̄", "̱"]   ; alt – ō ; alt_long – o̱
    , SC008: [0, 0, "̂", "̭"]   ; alt – ô ; alt_long – o̭
    , SC009: [0, 0, "̌", "̦"]   ; alt – ǒ ; alt_long – o̦
    , SC00A: [0, 0, "͗", "̳"]   ; alt – o͗ ; alt_long – o̳
    , SC00B: [0, 0, "̉", "̨"]   ; alt – ỏ ; alt_long – ǫ
    , SC00C: [0, 0, "̋", "✓"]  ; alt – ő
    , SC00D: [0, 0, "̛", "✕"]} ; alt – ơ

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
    
IniRead, section, modes.ini, Latin %LATIN_MODE%
For ind, pair in StrSplit(section, "`n")
{
    scan_code := SubStr(pair, 1, 5)
    values := StrSplit(SubStr(pair, 7), ",")
    NUM_DICT[scan_code].Push(values[1], values[2])
}

IniRead, section, modes.ini, Cyrillic %CYRILLIC_MODE%
For ind, pair in StrSplit(section, "`n")
{
    scan_code := SubStr(pair, 1, 5)
    values := StrSplit(SubStr(pair, 7), ",")
    NUM_DICT[scan_code].Push(values[1], values[2])
}

;https://www.wikiwand.com/en/Romanian_alphabet#/Comma-below_(ș_and_ț)_versus_cedilla_(ş_and_ţ)
;Default on. If you know what you're doing 
;   and you want to type cedilla, you can disable this behavior in config.ini
;This also influences to the cyrillic layout. (Only with selected Romanian mode, ofc)
If (latin_mode == 3 && romanian_cedilla_to_comma)
{
    NUM_DICT["SC002"][4] := "̦"
}

;Turkish, Kazakh latin, Azerbajani latin, ..., mode
;Default i = dotted i (iİ); num-row i <sh-long-8> = dotless i (ıI)
;Stay calm with third-party bindings. <Sh-i> will be detect as I. Diacr. dot will be added later
;With this mode you can type I as <sh-i>+<bs> or as <sh-long-8>, how you want it
If DOTLESS_I_SWAP
{
    NUM_DICT["SC009"][6] := "I"
   ;+SC021::I+̇
}


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
                SendInput % NUM_DICT[this][4]
            }
            Else
            {
                SetFormat, Integer, H
                lang := % DllCall("GetKeyboardLayout", Int
                    , DllCall("GetWindowThreadProcessId", int, WinActive("A"), Int, 0))
                SetFormat, Integer, D
                If (lang == -0xF3EFBF7)
                {
                    SendInput % NUM_DICT[this][6]
                }
                Else If (lang == -0xF3FFBE7)
                {
                    SendInput % NUM_DICT[this][8]
                }
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
            SendInput % NUM_DICT[this][3]
        }
        Else If shift
        {
            SetFormat, Integer, H
            lang := % DllCall("GetKeyboardLayout", Int
                , DllCall("GetWindowThreadProcessId", int, WinActive("A"), Int, 0))
            SetFormat, Integer, D
            If (lang == -0xF3EFBF7)
            {
                SendInput % NUM_DICT[this][5]
            }
            Else If (lang == -0xF3FFBE7)
            {
                SendInput % NUM_DICT[this][7]
            }
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

;swap between opened predefined apps
IniRead, section, %INI%, AltApps
For ind, pair in StrSplit(section, "`n")
{
    scan_code := SubStr(pair, 1, 5)
    values := StrSplit(SubStr(pair, 7), ",")
    option%ind% := Func("Alt").Bind(values[1], values[2])
    Hotkey, LWin & %scan_code%, % option%ind%
}


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
;SC16A:: browser back
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

;uim, гшьб (wdf] шдфч)
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


If DOTLESS_I_SWAP
{
    +~SC021::
        SetFormat, Integer, H
        lang := % DllCall("GetKeyboardLayout", Int
            , DllCall("GetWindowThreadProcessId", int, WinActive("A"), Int, 0))
        SetFormat, Integer, D
        If (lang == -0xF3EFBF7)
        {
            SendInput ̇
        }
        Return
}
