;===============================================================================================
;============================================Presets============================================
;===============================================================================================

#SingleInstance Force
#UseHook On

;global config.ini variables
Global DISABLED
Global LONG_PRESS_TIME
Global LATIN_MODE
Global CYRILLIC_MODE
Global USER_KEY_1
Global USER_KEY_2
Global PAIRED_BRACKETS
Global UNBR_SPACE
Global ROMANIAN_CEDILLA_TO_COMMA
Global DOTLESS_I_SWAP
Global ESC_AS_CAPS
Global NUMPAD
Global EXT := A_IsCompiled ? ".exe" : ".ahk"
Global INI := "config.ini"
IfExist, %INI%
{
    IniRead, DISABLED,                  %INI%, Configuration, Disabled
    IniRead, LONG_PRESS_TIME,           %INI%, Configuration, LongPressTime
    IniRead, LATIN_MODE,                %INI%, Configuration, LatinMode
    IniRead, CYRILLIC_MODE,             %INI%, Configuration, CyrillicMode
    IniRead, USER_KEY_1,                %INI%, Configuration, UserKey1
    IniRead, USER_KEY_2,                %INI%, Configuration, UserKey2
    IniRead, PAIRED_BRACKETS,           %INI%, Configuration, PairedBrackets
    IniRead, UNBR_SPACE,                %INI%, Configuration, UnbrSpace
    IniRead, ROMANIAN_CEDILLA_TO_COMMA, %INI%, Configuration, RomanianCedillaToComma
    IniRead, DOTLESS_I_SWAP,            %INI%, Configuration, DotlessISwap
    IniRead, ESC_AS_CAPS,               %INI%, Configuration, EscAsCaps
    IniRead, NUMPAD,                    %INI%, Configuration, NumPad
    IniRead, menu_path,                 %INI%, Configuration, MenuPath
    IniRead, viatc_file,                %INI%, Configuration, ViatcFile
}
Else
{
    IniWrite, 0,                        %INI%, Configuration, Disabled
    IniWrite, 0.15,                     %INI%, Configuration, LongPressTime
    IniWrite, 0,                        %INI%, Configuration, LatinMode
    IniWrite, 0,                        %INI%, Configuration, CyrillicMode
    IniWrite % "",                      %INI%, Configuration, UserKey1
    IniWrite % "",                      %INI%, Configuration, UserKey2
    IniWrite, 0,                        %INI%, Configuration, PairedBrackets
    IniWrite, 1,                        %INI%, Configuration, UnbrSpace
    IniWrite, 1,                        %INI%, Configuration, RomanianCedillaToComma
    IniWrite, 0,                        %INI%, Configuration, DotlessISwap
    IniWrite, 0,                        %INI%, Configuration, EscAsCaps
    IniWrite, 0,                        %INI%, Configuration, NumPad
    IniWrite, c:\menu\,                 %INI%, Configuration, MenuPath
    IniWrite, c:\ViATc\ViATc.ahk,       %INI%, Configuration, ViatcFile
    FileAppend, `n[AltApps]`n, %INI%
    Run, qphyx%EXT%
}

;set icon
icon := DISABLED ? "disabled.ico" : "qphyx.ico"
IfExist, %icon%
{
    Menu, Tray, Icon, %icon%, , 1
}

;let ViATc override hotkeys (only for TC)
Try
{
    Run, %viatc_file%
}
;let menu override ViATc
Try
{
    Run % menu_path . "menu" . EXT, %menu_path%
}

SetCapsLockState % (ESC_AS_CAPS ? "Off" : "AlwaysOff")


;===============================================================================================
;=====================================Symbol assignments========================================
;===============================================================================================

Global NUM_DICT := {scan_code: ["releasing", "sended", "alt", "alt_long"]
    , SC002: [0, 0, "̃", "̧"]   ; tilde; cedilla
    , SC003: [0, 0, "̊", "̥"]   ; ring above; ring below
    , SC004: [0, 0, "̈", "̤"]   ; diaeresis above; diaeresis below
    , SC005: [0, 0, "̇", "̣"]   ; dot above; dot below
    , SC006: [0, 0, "̆", "̮"]   ; breve above; breve below
    , SC007: [0, 0, "̄", "̱"]   ; macron above; macron below
    , SC008: [0, 0, "̂", "̭"]   ; circumflex above; circumflex below
    , SC009: [0, 0, "̌", "̦"]   ; caron; comma
    , SC00A: [0, 0, "͗", "̳"]   ; right half ring above; double low line
    , SC00B: [0, 0, "̉", "̨"]   ; hook; ogonek
    , SC00C: [0, 0, "̋", "✓"]  ; double acute
    , SC00D: [0, 0, "̛", "✕"]} ; horn

Global DICT := {scan_code: ["releasing", "sended", "long", "alt"]
    , SC010: [0, 0, "{Text}~", "{Text}°"]
    , SC011: [0, 0, "{Text}–", "{Text}—"]
    , SC012: [0, 0, "{Text}'", "{Text}’"]
    , SC013: [0, 0, "{Text}\", "{Text}&"]
    , SC014: [0, 0, "{Text}@", "{Text}§"]
    , SC015: [0, 0, "{Text}<", "{Text}«"]
    , SC016: [0, 0, "{Text}(", "{SC16A}"] ; alt – back
    , SC017: [0, 0, "{Text}[", "{SC169}"] ; alt - forward
    , SC018: [0, 0, "{Text}{", "{Text}“"]
    , SC019: [0, 0, "{Text}!", "{Text}¡"]
    , SC01A: [0, 0, "{Text}#", "{Text}№"]
    , SC01B: [0, 0, "́"       , "̀"       ] ; long – diacritic acute; alt – diacritic grave
    , SC01E: [0, 0, "{Text}+", "{Text}±"]
    , SC01F: [0, 0, "{Text}-", "{Text}−"]
    , SC020: [0, 0, "{Text}*", "{Text}×"]
    , SC021: [0, 0, "{Text}/", "{Text}÷"]
    , SC022: [0, 0, "{Text}=", "{Text}≠"]
    , SC023: [0, 0, "{Text}%", ""       ] ; alt - left
    , SC024: [0, 0, "{Text}""",""       ] ; alt - down
    , SC025: [0, 0, "{Text}.", ""       ] ; alt - up
    , SC026: [0, 0, "{Text},", ""       ] ; alt - right
    , SC027: [0, 0, "{Text}:", "{Text}^"]
    , SC028: [0, 0, "{Text};","{Text}``"]
    , SC02C: [0, 0, "{Text}$", "{Text}¥"]
    , SC02D: [0, 0, "{Text}€", "{Text}£"]
    , SC02E: [0, 0, "{Text}₽", "{Text}¤"]
    , SC02F: [0, 0, "{Text}_", "{Text}|"]
    , SC030: [0, 0, "{Text}≈", "{Text}≟"]
    , SC031: [0, 0, "{Text}>", "{Text}»"]
    , SC032: [0, 0, "{Text})", "^{SC02C}"] ; alt - undo
    , SC033: [0, 0, "{Text}]", "^{SC015}"] ; alt - redo
    , SC034: [0, 0, "{Text}}", "{Text}”"]
    , SC035: [0, 0, "{Text}?", "{Text}¿"]}

If PAIRED_BRACKETS
{
    DICT["SC015"][3] := "<>{Left}"
    DICT["SC015"][4] := "«»{Left}"
    DICT["SC016"][3] := "(){Left}"
    DICT["SC017"][3] := "[]{Left}"
    DICT["SC018"][3] := "{{}{}}{Left}"
    DICT["SC018"][4] := "“”{Left}"
    DICT["SC024"][3] := """""{Left}"
}

IniRead, section, modes.ini, Latin %LATIN_MODE%
For ind, pair in StrSplit(section, "`n")
{
    scan_code := SubStr(pair, 1, 5)
    If (scan_code == "name=")
    {
        Continue
    }
    values := StrSplit(SubStr(pair, 7), ",")
    NUM_DICT[scan_code].Push(values[1], values[2])
}
IniRead, section, modes.ini, Cyrillic %CYRILLIC_MODE%
For ind, pair in StrSplit(section, "`n")
{
    scan_code := SubStr(pair, 1, 5)
    If (scan_code == "name=")
    {
        Continue
    }
    values := StrSplit(SubStr(pair, 7), ",")
    NUM_DICT[scan_code].Push(values[1], values[2])
}

;https://www.wikiwand.com/en/Romanian_alphabet#/Comma-below_(ș_and_ț)_versus_cedilla_(ş_and_ţ)
;Default on. If you know what you're doing
;   and you want to type cedilla, you can disable this behavior in config.ini
;This also influences to the cyrillic layout. (Only with selected Romanian mode, ofc)
If (LATIN_MODE == 3 && ROMANIAN_CEDILLA_TO_COMMA)
{
    NUM_DICT["SC002"][4] := "̦"
}

;Turkish, Kazakh latin, Azerbajani latin, ..., mode feature
;Default i = dotted i (iİ); num-row i <sh-long-8> = dotless i (ıI)
;Stay calm with third-party bindings. <Sh-i> will be detect as I. Diacr. dot will be added later
;With this mode you can type I as <sh-i>+<bs> or as <sh-long-8>, how you want it
;This option is not depends on selected latin mode, because you may want to use it with any mode
If DOTLESS_I_SWAP
{
    NUM_DICT["SC009"][6] := "I"
   ;+SC021::I+̇
}

Global SPOTIFY
SpotifyDetectProcessId()


;===============================================================================================
;================================================Tray menu======================================
;===============================================================================================

IniRead, sections, modes.ini
Global LAT_MODE_LIST := []
Global CYR_MODE_LIST := []
For _, section in StrSplit(sections, "`n") {
    IniRead, name, modes.ini, %section%, name
    If (SubStr(section, 1, 5) == "Latin")
    {
        LAT_MODE_LIST.Push(name)
    }
    Else
    {
        CYR_MODE_LIST.Push(name)
    }
}

Menu, Tray, Add, qPhyx, TrayMenu
Menu, Tray, Default, qPhyx
Menu, Tray, Click, 1
Menu, Tray, Disable, qPhyx
Menu, Tray, Tip, % "qPhyx" EXT " – " (DISABLED ? "disabled" : "enabled")
Menu, Tray, NoStandard
For _, wording in LAT_MODE_LIST
{
    Menu, LatModes, Add, %wording%, LatModeChange
}
For _, wording in CYR_MODE_LIST
{
    Menu, CyrModes, Add, %wording%, CyrModeChange
}
    Menu, LatModes, Check, % LAT_MODE_LIST[LATIN_MODE+1]
    Menu, CyrModes, Check, % CYR_MODE_LIST[CYRILLIC_MODE+1]
Menu, Tray, UseErrorLevel
Menu, Tray, Add, Change la&tin mode, :LatModes
Menu, Tray, Add, Change &cyrillic mode, :CyrModes
    Menu, SubSettings, Add, Toggle "&Paired brackets" feature, PairedBracketsToggle
    If PAIRED_BRACKETS
    {
        Menu, SubSettings, Check, Toggle "&Paired brackets" feature
    }
    Menu, SubSettings, Add, Toggle "Dotless &i" feature, DotlessIToggle
    If DOTLESS_I_SWAP
    {
        Menu, SubSettings, Check, Toggle "Dotless &i" feature
    }
    Menu, SubSettings, Add, Toggle "No-&Break Space" on Sh-Space, UnbrSpaceToggle
    If UNBR_SPACE
    {
        Menu, SubSettings, Check, Toggle "No-&Break Space" on Sh-Space
    }
    Menu, SubSettings, Add, Toggle "&Esc as Caps Lock" feature, EscAsCapsToggle
    If ESC_AS_CAPS
    {
        Menu, SubSettings, Check, Toggle "&Esc as Caps Lock" feature
    }
    Menu, SubSettings, Add, Toggle &NumPad availability, NumPadToggle
    If NUMPAD
    {
        Menu, SubSettings, Check, Toggle &NumPad availability
    }
    key1 := (USER_KEY_1 != "") ? USER_KEY_1 : "empty"
    key2 := (USER_KEY_2 != "") ? USER_KEY_2 : "empty"
    Menu, SubSettings, Add, Change &first user-defined key (now is %key1%), ChangeUserKey
    Menu, SubSettings, Add, Change &second user-defined key (now is %key2%), ChangeUserKey
Menu, Tray, Add, &Other settings, :SubSettings
Menu, Tray, Add, &Long press delay (now is %LONG_PRESS_TIME%s), LongPressTimeChange
state := DISABLED ? "En" : "Dis"
Menu, Tray, Add, %state%a&ble qPhyx (sh+tilde to toggle), DisableToggle
Menu, Tray, Add, &Help (cheatsheet), Cheatsheet
Menu, Tray, Add, &Exit, Exit


;===============================================================================================
;=============================================GUI cheatsheet====================================
;===============================================================================================

val := [["A.qwerty","esc","1","2","3","4","5","6","7","8","9","0","incr","decr","media"
        ,"tab","q","w","e","r","t","y","u","i","o","p","","",""
        ,"enter","a","s","d","f","g","h","j","k","l","","","backspace"
        ,"shift","z","x","c","v","b","n","m","","","","shift"]
    ,["Long","esc","1","2","3","4","5","6","7","8","9","0","incr","decr","media"
        ,"tab","~","–","'","\","@","<","(","[","{","!","#","ó","\"
        ,"enter","+","-","*","/","=","%","""",".",",",":",";","backspace"
        ,"shift","$","€","₽","_","≈",">",")","]","}","?","shift"]
    ,["Alt/A.long","esc"
        ,"õ/o̧","o̊/o̥","ö/o̤","ȯ/ọ","ŏ/o̮","ō/o̱","ô/o̭","ǒ/o̦","o͗/o̳","ỏ/ǫ","ő/✓","ơ/✕","media"
        ,"tab","°","—","’","&&","§","«","backw","forw","“","¡","№","ò",""
        ,"enter","±","−","×","÷","≠","left","down","up","right","^","``","collapse all/un"
        ,"shift","¥","£","¤","|","≟","»","undo","redo","”","¿","shift"]]
Gui, Add, Tab3, w720 h185 x-2 y-2, A.qwerty|Long|Alt/A.long|Lang.modes
Gui -Border -Caption
Loop, 3
{
    Gui, Tab, % val[A_Index][1]
    outer_ind := A_Index
    Gui, Font, s11, Calibri
    Gui, Add, Button, % "x0 y20 w50 h40 vSC029" . outer_ind, % val[outer_ind][2]
    GuiControl, Disable, % "SC029" . outer_ind
    Loop, 12
    {
        Gui, Add, Button, % "x" . A_Index*50 . " y20 w50 h40", % val[outer_ind][A_Index+2]
    }
    Gui, Add, Button, x650 y20 w65 h40, % val[outer_ind][15]
    Gui, Add, Button, x0 y60 w65 h40, % val[outer_ind][16]
    Loop, 13
    {
        Gui, Add, Button, % "x" . A_Index*50+15 . " y60 w50 h40", % val[outer_ind][A_Index+16]
    }
    Gui, Add, Button, x0 y100 w80 h40, % val[outer_ind][30]
    Loop, 11
    {
        Gui, Add, Button, % "x" . A_Index*50+30 . " y100 w50 h40", % val[outer_ind][A_Index+30]
    }
    Gui, Add, Button, x630 y100 w85 h40, % val[outer_ind][42]
    Gui, Add, Button, x0 y140 w100 h40, % val[outer_ind][43]
    Loop, 10
    {
        Gui, Add, Button, % "x" . A_Index*50+50 . " y140 w50 h40", % val[outer_ind][A_Index+43]
    }
    Gui, Add, Button, x600 y140 w115 h40, % val[outer_ind][54]
}
Gui, Tab, Lang.modes
Gui, Add, ListView, r19 w715 h165 x0 y18 gLangModes,  |№|Group|Mode|1|2|3|4|5|6|7|8|9|0|+1|+2
For _, script in [["Latin", LAT_MODE_LIST], ["Cyrillic", CYR_MODE_LIST]]
{
    For mode_ind, wording in script[2]
    {
        t := []
        chosen := ""
        IniRead, section, modes.ini, % script[1] " " mode_ind-1
        For ind, pair in StrSplit(section, "`n")
        {
            If (ind == 1)
            {
                Continue
            }
            t.Push(StrReplace(SubStr(pair, 7, 2), ","))
        }
        If (script[1] == "Latin" && mode_ind = LATIN_MODE+1
            || script[1] == "Cyrillic" && mode_ind = CYRILLIC_MODE+1)
        {
            chosen := "✓"
        }
        LV_Add("", chosen, mode_ind, script[1], StrReplace(wording, "&")
            , t[1], t[2], t[3], t[4], t[5], t[6], t[7], t[8], t[9], t[10], t[11], t[12])
    }
}
LV_ModifyCol()
LV_ModifyCol(2, "Integer AutoHdr Center")
LV_ModifyCol(4, 285)
Loop, 12
{
    LV_ModifyCol(A_Index+4, "AutoHdr Center")
}


;===============================================================================================
;=========================================Main layout functions=================================
;===============================================================================================

;numerical row interaction
DownNum(this, alt:=0)
{
    If !NUM_DICT[this][1]
    {
        NUM_DICT[this][1] := 1
        KeyWait, %this%, T%LONG_PRESS_TIME%
        If ErrorLevel
        {
            NUM_DICT[this][2] := 1
            If alt
            {
                SendInput % NUM_DICT[this][4]
            }
            Else
            {
                caps_lock := GetKeyState("CapsLock", "T")
                SetFormat, Integer, H
                lang := % DllCall("GetKeyboardLayout", Int
                    , DllCall("GetWindowThreadProcessId", int, WinActive("A"), Int, 0))
                SetFormat, Integer, D
                If (lang == -0xF3EFBF7)
                {
                    SendInput % NUM_DICT[this][6-caps_lock]
                }
                Else If (lang == -0xF3FFBE7)
                {
                    SendInput % NUM_DICT[this][8-caps_lock]
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
            caps_lock := GetKeyState("CapsLock", "T")
            SetFormat, Integer, H
            lang := % DllCall("GetKeyboardLayout", Int
                , DllCall("GetWindowThreadProcessId", int, WinActive("A"), Int, 0))
            SetFormat, Integer, D
            If (lang == -0xF3EFBF7)
            {
                SendInput % NUM_DICT[this][5+caps_lock]
            }
            Else If (lang == -0xF3FFBE7)
            {
                SendInput % NUM_DICT[this][7+caps_lock]
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
Down(this, shift:=0)
{
    If !DICT[this][1]
    {
        DICT[this][1] := 1 + shift
        KeyWait, %this%, T%LONG_PRESS_TIME%
        If (ErrorLevel && !DICT[this][2])
        {
            DICT[this][2] := 1
            SendInput % DICT[this][3]
        }
    }
}

Up(this, shift:=0)
{
    If (DICT[this][1] && !DICT[this][2])
    {
        If (GetKeyState("CapsLock", "T") && DICT[this][1] == 2) {
            SendInput {%this%}
        }
        Else If (GetKeyState("CapsLock", "T") || DICT[this][1] == 2) {
            SendInput +{%this%}
        }
        Else
        {
            SendInput {%this%}
        }
    }
    DICT[this][1] := 0
    DICT[this][2] := 0
}


;===============================================================================================
;=====================================Additional layout functions===============================
;===============================================================================================

;swap between opened predefined apps
Alt(proc_name, path)
{
    proc := (proc_name == "Spotify.exe" && SPOTIFY) ? "ahk_id " . SPOTIFY : "ahk_exe " . proc_name
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
        Run, %path%
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

;works on current selected number
IncrDecrNumber(n)
{
    BlockInput, On
    saved_value := Clipboard
    Clipboard := ""
    Send ^{SC02E}
    Sleep, 1
    If (Clipboard*0 == 0)
    {
        If InStr(Clipboard, ".") {
            Clipboard := Round(Clipboard + 1 * n, StrLen(Clipboard) - InStr(Clipboard, "."))
        }
        Else
        {
            Clipboard := Clipboard + 1 * n
        }
        SendInput % Clipboard
        new_value_len := StrLen(Clipboard)
        SendInput {Left %new_value_len%}
        Send +{Right %new_value_len%}
    }
    Sleep, 1
    Clipboard := saved_value
    BlockInput, Off
}


;===============================================================================================
;===============================================Menu functions==================================
;===============================================================================================

LatModeChange(_, item_pos)
{
    IniWrite % item_pos-1, config.ini, Configuration, LatinMode
    Menu, LatModes, Uncheck, % LAT_MODE_LIST[LATIN_MODE+1]
    Menu, LatModes, Check, % LAT_MODE_LIST[item_pos]
    LV_Modify(LATIN_MODE+1, , "")
    LV_Modify(item_pos, , "✓")
    LATIN_MODE := item_pos-1
    IniRead, section, modes.ini, Latin %LATIN_MODE%
    For ind, pair in StrSplit(section, "`n")
    {
        scan_code := SubStr(pair, 1, 5)
        If (scan_code == "name=")
        {
            Continue
        }
        values := StrSplit(SubStr(pair, 7), ",")
        NUM_DICT[scan_code][5] := values[1]
        NUM_DICT[scan_code][6] := values[2]
    }
}

CyrModeChange(_, item_pos)
{
    IniWrite % item_pos-1, config.ini, Configuration, CyrillicMode
    Menu, CyrModes, Uncheck, % CYR_MODE_LIST[CYRILLIC_MODE+1]
    Menu, CyrModes, Check, % CYR_MODE_LIST[item_pos]
    LV_Modify(LAT_MODE_LIST.MaxIndex() + CYRILLIC_MODE + 1, , "")
    LV_Modify(LAT_MODE_LIST.MaxIndex() + item_pos, , "✓")
    CYRILLIC_MODE := item_pos - 1
    IniRead, section, modes.ini, Cyrillic %CYRILLIC_MODE%
    For ind, pair in StrSplit(section, "`n")
    {
        scan_code := SubStr(pair, 1, 5)
        If (scan_code == "name=")
        {
            Continue
        }
        values := StrSplit(SubStr(pair, 7), ",")
        NUM_DICT[scan_code][7] := values[1]
        NUM_DICT[scan_code][8] := values[2]
    }
}

PairedBracketsToggle()
{
    IniWrite % !PAIRED_BRACKETS, config.ini, Configuration, PairedBrackets
    Run, qphyx%EXT%
}

DotlessIToggle()
{
    IniWrite % !DOTLESS_I_SWAP, config.ini, Configuration, DotlessISwap
    Run, qphyx%EXT%
}

UnbrSpaceToggle()
{
    IniWrite % !UNBR_SPACE, config.ini, Configuration, UnbrSpace
    Run, qphyx%EXT%
}

EscAsCapsToggle()
{
    IniWrite % !ESC_AS_CAPS, config.ini, Configuration, EscAsCaps
    Run, qphyx%EXT%
}

NumPadToggle()
{
    IniWrite % !NUMPAD, config.ini, Configuration, NumPad
    Run, qphyx%EXT%
}

ChangeUserKey(item_name)
{
    message =
    (
        New value (recommended is currency symbol or code). It can be several symbols.
If empty – works as decrement/increment number (be careful with use it on non-textfields!).
    )
    InputBox, user_input, Set new value for user-defined key (two left keys from old backspace)
        , %message%
        , , 611, 160
    If !ErrorLevel
    {
        key_pos := (SubStr(item_name, 8, 1) == "f") ? 1 : 2
        IniWrite, %user_input%, config.ini, Configuration, UserKey%key_pos%
        Run, qphyx%EXT%
    }
}

LongPressTimeChange()
{
    InputBox, user_input, Set new long press delay
        , New value in seconds (e.g. 0.15), , 444, 130
    If !ErrorLevel
    {
        If (user_input is number)
        {
            old_value = %LONG_PRESS_TIME%
            IniWrite, %user_input%, config.ini, Configuration, LongPressTime
            LONG_PRESS_TIME := user_input
            Menu, Tray, Rename, &Long press delay (now is %old_value%s)
                , &Long press delay (now is %LONG_PRESS_TIME%s)
            Run, qphyx%EXT%
        }
        Else
        {
            MsgBox, 53, Incorrect value, The input must be a number!
            IfMsgBox Retry
            {
                LongPressTimeChange()
            }
        }
    }
}

DisableToggle()
{
    IniWrite % !DISABLED, config.ini, Configuration, Disabled
    Run, qphyx%EXT%
}


;===============================================================================================
;================================================Auxiliary======================================
;===============================================================================================

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
Return

TrayMenu:
    Menu, Tray, Show
    Return

Cheatsheet:
    Gui, Show, h180 w715
    Return

LangModes:
    If (A_GuiEvent == "DoubleClick")
    {
        LV_GetText(mode_num, A_EventInfo, 2)
        LV_GetText(mode_script, A_EventInfo, 3)
        If (mode_script == "Latin")
        {
            LatModeChange(_, mode_num)
        }
        Else
        {
            CyrModeChange(_, mode_num)
        }
    }
    Return

Exit:
    ExitApp

;===============================================================================================
;===========================================Controlling assignments=============================
;===============================================================================================

;tilde
^+SC029::
    Run, qphyx%EXT%
    Return
+SC029::
    DisableToggle()
    Return


#If !DISABLED

 SC029:: SendInput  {SC001}
!SC029:: SendInput !{SC001}
^SC029:: SendInput ^{SC001}

;backspace
 SC00E:: SendInput {SC122}
!SC00E::
    KeyWait, SC00E, T%LONG_PRESS_TIME%
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
    KeyWait, SC00E, T%LONG_PRESS_TIME%
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
    KeyWait, SC01C, T%LONG_PRESS_TIME%
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

;caps lock
 SC03A:: SendInput  {SC01C}
+SC03A:: SendInput +{SC01C}
!SC03A:: SendInput !{SC01C}
^SC03A:: SendInput ^{SC01C}

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

; old num-row "-" (two keys left from old BS)
SC00C::
    If USER_KEY_1
    {
        SendInput %USER_KEY_1%
    }
    Else
    {
        IncrDecrNumber(-1)
    }
    Return

; old num-row "=" (one key left from old BS)
SC00D::
    If USER_KEY_2
    {
        SendInput %USER_KEY_2%
    }
    Else
    {
        IncrDecrNumber(1)
    }
    Return

; esc
SC001::
    If ESC_AS_CAPS
    {
        SetCapsLockState % (t:=!t) ?  "On" :  "Off"
    }
    Else
    {
        SendInput {%A_ThisHotkey%}
    }
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

;top letters row
+SC010::
+SC011::
+SC012::
+SC013::
+SC014::
+SC015::
+SC016::
+SC017::
+SC018::
+SC019::
+SC01A::
+SC01B::
;home letters row
+SC01E::
+SC01F::
+SC020::
; +SC021:: exception (separate control command)
+SC022::
+SC023::
+SC024::
+SC025::
+SC026::
+SC027::
+SC028::
;bottom letters row
+SC02C::
+SC02D::
+SC02E::
+SC02F::
+SC030::
+SC031::
+SC032::
+SC033::
+SC034::
+SC035::
    Down(SubStr(A_ThisHotkey, 2), 1)
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
+SC010 up::
+SC011 up::
+SC012 up::
+SC013 up::
+SC014 up::
+SC015 up::
+SC016 up::
+SC017 up::
+SC018 up::
+SC019 up::
+SC01A up::
+SC01B up::
;home letters row
+SC01E up::
+SC01F up::
+SC020 up::
+SC021 up::
+SC022 up::
+SC023 up::
+SC024 up::
+SC025 up::
+SC026 up::
+SC027 up::
+SC028 up::
;bottom letters row
+SC02C up::
+SC02D up::
+SC02E up::
+SC02F up::
+SC030 up::
+SC031 up::
+SC032 up::
+SC033 up::
+SC034 up::
+SC035 up::
    Up(SubStr(A_ThisHotkey, 2, 5), 1)
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
    SendInput % DICT[SubStr(A_ThisHotkey, 2)][4]
    Return

;home row "sh-i"
+SC021::
    Down(SubStr(A_ThisHotkey, 2), 1)
    If (DOTLESS_I_SWAP && !DICT["SC021"][2])
    {
        SetFormat, Integer, H
        lang := % DllCall("GetKeyboardLayout", Int
            , DllCall("GetWindowThreadProcessId", int, WinActive("A"), Int, 0))
        SetFormat, Integer, D
        If (lang == -0xF3EFBF7)
        {
            SendInput {̇}
        }
    }
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
    If UNBR_SPACE {
        SendInput +{Space}
    }
    Else
    {
        SendInput {Space}
    }
    Return


;===============================================================================================
;===========================================Disabled keys=======================================
;===============================================================================================

;;;Return
;arrows up/left/right/down
    *SC148::
    *SC14B::
    *SC14D::
    *SC150::
        Return

;delete
    *SC153::
        Return

#If !NUMPAD

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
        Return


;===============================================================================================
;==============================================Unused scancodes=================================
;===============================================================================================

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

;SC02B:: (\|), on a 102-key keyboards is a default key for menu.*
