;===============================================================================================
;============================================Presets============================================
;===============================================================================================

#SingleInstance Force
#UseHook On

Global EXT := A_IsCompiled ? ".exe" : ".ahk"
Global INI := "config.ini"
;global config.ini variables
Global DISABLED := 0
Global LONG_PRESS_TIME := 0.15
Global LATIN_MODE := 0
Global CYRILLIC_MODE := 0
Global DOTLESS_I_SWAP := 0
Global ROMANIAN_CEDILLA_TO_COMMA := 1
Global PAIRED_BRACKETS := 0
Global UNBR_SPACE := 1
Global ESC_AS_CAPS := 0
Global NUMPAD := 0
Global USER_KEY_1 := ""
Global USER_KEY_2 := ""
IfExist, %INI%
{
    IniRead, DISABLED,                  %INI%, Configuration, Disabled
    IniRead, LONG_PRESS_TIME,           %INI%, Configuration, LongPressTime
    IniRead, LATIN_MODE,                %INI%, Configuration, LatinMode
    IniRead, CYRILLIC_MODE,             %INI%, Configuration, CyrillicMode
    IniRead, DOTLESS_I_SWAP,            %INI%, Configuration, DotlessISwap
    IniRead, ROMANIAN_CEDILLA_TO_COMMA, %INI%, Configuration, RomanianCedillaToComma
    IniRead, PAIRED_BRACKETS,           %INI%, Configuration, PairedBrackets
    IniRead, UNBR_SPACE,                %INI%, Configuration, UnbrSpace
    IniRead, ESC_AS_CAPS,               %INI%, Configuration, EscAsCaps
    IniRead, NUMPAD,                    %INI%, Configuration, NumPad
    IniRead, USER_KEY_1,                %INI%, Configuration, UserKey1
    IniRead, USER_KEY_2,                %INI%, Configuration, UserKey2
    IniRead, menu_path,                 %INI%, Configuration, MenuPath
    IniRead, viatc_file,                %INI%, Configuration, ViatcFile
}
Else
{
    IniWrite, 0,                        %INI%, Configuration, Disabled
    IniWrite, 0.15,                     %INI%, Configuration, LongPressTime
    IniWrite, 0,                        %INI%, Configuration, LatinMode
    IniWrite, 0,                        %INI%, Configuration, CyrillicMode
    IniWrite, 0,                        %INI%, Configuration, DotlessISwap
    IniWrite, 1,                        %INI%, Configuration, RomanianCedillaToComma
    IniWrite, 0,                        %INI%, Configuration, PairedBrackets
    IniWrite, 1,                        %INI%, Configuration, UnbrSpace
    IniWrite, 0,                        %INI%, Configuration, EscAsCaps
    IniWrite, 0,                        %INI%, Configuration, NumPad
    IniWrite, % "",                     %INI%, Configuration, UserKey1
    IniWrite, % "",                     %INI%, Configuration, UserKey2
    IniWrite, c:\menu\,                 %INI%, Configuration, MenuPath
    IniWrite, c:\ViATc\ViATc.ahk,       %INI%, Configuration, ViatcFile
    FileAppend, `n[AltApps]`n, %INI%
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
    Run, % menu_path . "menu" . EXT, %menu_path%
}

SetCapsLockState, % (ESC_AS_CAPS ? "Off" : "AlwaysOff")


;===============================================================================================
;=====================================Symbol assignments========================================
;===============================================================================================

;num row
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

;letter region
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

;language modes read
IniRead, sections, modes.ini
Global LAT_MODE_LIST := []
Global CYR_MODE_LIST := []
For _, section in StrSplit(sections, "`n") {
    IniRead, name, modes.ini, %section%, name
    t := {name: name}
    Loop, 12
    {
        scan_code := "SC00" Format("{:X}", A_Index+1)
        IniRead, values, modes.ini, %section%, %scan_code%
        t[scan_code] := StrSplit(values, ",")
    }
    If (SubStr(section, 1, 5) == "Latin")
    {
        LAT_MODE_LIST.Push(t)
    }
    Else
    {
        CYR_MODE_LIST.Push(t)
    }
}

;;set chosen language modes (shift and shift-long layers on the num row)
For i, script in [LAT_MODE_LIST[LATIN_MODE+1], CYR_MODE_LIST[CYRILLIC_MODE+1]]
{
    Loop, 12
    {
        scan_code := "SC00" Format("{:X}", A_Index+1)
        NUM_DICT[scan_code][5+(i-1)*2] := script[scan_code][1]
        NUM_DICT[scan_code][6+(i-1)*2] := script[scan_code][2]
    }
}

;;Default i = dotted i (iİ); num-row i <sh-long-8> = dotless i (ıI)
;;Turkish, Kazakh latin, Azerbajani latin, ..., mode feature
;;Stay calm with third-party bindings. <Sh-i> will be detect as I. Diacr. dot will be added later
;;With this mode you can type I as <sh-i>+<bs> or as <sh-long-8>, how you want it
;;This option is not depends on selected latin mode, because you may want to use it with any mode
If DOTLESS_I_SWAP
{
    NUM_DICT["SC009"][6] := "I"
   ;+SC021::I+̇
}

;;paste comma instead of the cedilla for the chosen romanian mode
;;https://www.wikiwand.com/en/Romanian_alphabet#/Comma-below_(ș_and_ț)_versus_cedilla_(ş_and_ţ)
;;Default on. If you know what you're doing
;;   and you want to type cedilla, you can disable this behavior in config.ini
;;This also influences to the cyrillic layout. (Only with selected Romanian mode, ofc)
If (LATIN_MODE == 3 && ROMANIAN_CEDILLA_TO_COMMA)
{
    NUM_DICT["SC002"][4] := "̦"
}

;other settings
;;autopaste closing brackets
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

;read correct spotify process (if exists) for the proper swap between apps
Global SPOTIFY
SpotifyDetectProcessId()

;switch between alt apps with LWin+<key>
IniRead, section, %INI%, AltApps
For ind, pair in StrSplit(section, "`n")
{
    scan_code := SubStr(pair, 1, 5)
    values := StrSplit(SubStr(pair, 7), ",")
    option%ind% := Func("Alt").Bind(values[1], values[2])
    Hotkey, LWin & %scan_code%, % option%ind%
}


;===============================================================================================
;================================================Tray menu======================================
;===============================================================================================

Menu, Tray, Add, qPhyx, Cheatsheet
Menu, Tray, Default, qPhyx
Menu, Tray, Click, 1
Menu, Tray, Disable, qPhyx
Menu, Tray, Tip, % "qPhyx" . EXT . " – " . (DISABLED ? "disabled" : "enabled")
Menu, Tray, NoStandard
For _, mode in LAT_MODE_LIST
{
    Menu, LatModes, Add, % mode["name"], LatModeChange
}
For _, mode in CYR_MODE_LIST
{
    Menu, CyrModes, Add, % mode["name"], CyrModeChange
}
    Menu, LatModes, Check, % LAT_MODE_LIST[LATIN_MODE+1]["name"]
    Menu, CyrModes, Check, % CYR_MODE_LIST[CYRILLIC_MODE+1]["name"]
Menu, Tray, UseErrorLevel
Menu, Tray, Add, Change &latin mode, :LatModes
Menu, Tray, Add, Change &cyrillic mode, :CyrModes
    If LATIN_MODE in 1,20,24
    {
        Menu, SubSettings, Add, Toggle "Dotless &i" feature, DotlessIToggle
        If DOTLESS_I_SWAP
        {
            Menu, SubSettings, Check, Toggle "Dotless &i" feature
        }
    }
    If (LATIN_MODE == 3)
    {
        Menu, SubSettings, Add, Toggle "Romanian &cedilla to comma" feature
            , RomanianCedillaToCommaToggle
        If ROMANIAN_CEDILLA_TO_COMMA
        {
            Menu, SubSettings, Check, Toggle "Romanian &cedilla to comma" feature
        }
    }
    Menu, SubSettings, Add, Toggle "&Paired brackets" feature, PairedBracketsToggle
    If PAIRED_BRACKETS
    {
        Menu, SubSettings, Check, Toggle "&Paired brackets" feature
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
    key1 := (USER_KEY_1 == "") ? "empty" : USER_KEY_1
    key2 := (USER_KEY_2 == "") ? "empty" : USER_KEY_2
    Menu, SubSettings, Add, Change &first user-defined key (now is %key1%), ChangeUserKey
    Menu, SubSettings, Add, Change &second user-defined key (now is %key2%), ChangeUserKey
Menu, Tray, Add, &Other settings, :SubSettings
Menu, Tray, Add, Long press &delay (now is %LONG_PRESS_TIME%s), LongPressTimeChange
state := DISABLED ? "En" : "Dis"
Menu, Tray, Add, %state%a&ble qPhyx, DisabledToggle
Menu, Tray, Add, &Help cheatsheet, Cheatsheet
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
        ,"enter","±","−","×","÷","≠","left","down","up","right","^","``",""
        ,"shift","¥","£","¤","|","≟","»","undo","redo","”","¿","shift"]
    ,["VK",192,49,50,51,52,53,54,55,56,57,48,189,187,8
        ,9,81,87,69,82,84,89,85,73,79,80,219,221,220
        ,,65,83,68,70,71,72,74,75,76,186,222,13
        ,16,90,88,67,86,66,78,77,188,190,191,666]]
Gui -Border -Caption -Theme
Gui, Add, Button, x698 y-1 w19 h19 gCheatsheet, ✕
Gui, Add, Tab3, w720 h185 x-2 y-2, A.qwerty|Long|Alt/A.long|Lang.modes|Hotkeys
Gui, Font, s11, Calibri
AddButton(i, oi, x:=0, y:=20, w:=50, h:=40)
{
    Global
    Gui, Add, Button, % "x" . x . " y" . y . " w" . w . " h" . h . " v"
        . Format("{:03.f}", val[4][i]) . oi, % val[oi][i]
}
Loop, 3
{
    Gui, Tab, % val[A_Index][1]
    outer_ind := A_Index
    AddButton(2, outer_ind)
    Loop, 12
    {
        AddButton(A_Index+2, outer_ind, A_Index*50)
    }
    AddButton(15, outer_ind, 650, , 65)
    AddButton(16, outer_ind, , 60, 65)
    Loop, 13
    {
        AddButton(A_Index+16, outer_ind, A_Index*50+15, 60)
    }
    AddButton(30, outer_ind, , 100, 80)
    Loop, 11
    {
        AddButton(A_Index+30, outer_ind, A_Index*50+30, 100)
    }
    AddButton(42, outer_ind, 630, 100, 85)
    AddButton(43, outer_ind, , 140, 100)
    Loop, 10
    {
        AddButton(A_Index+43, outer_ind, A_Index*50+50, 140)
    }
    AddButton(54, outer_ind, 600, 140, 115)
}
Gui, +Theme
OnMessage(0x100, "GuiKeyPress")
OnMessage(0x104, "GuiKeyPress")

Gui, Tab, Lang.modes
Gui, Add, ListView, r19 w716 h165 x-1 y18 LV1 gLangModes vLangModes
    , |№|Group|Mode|1|2|3|4|5|6|7|8|9|0|+1|+2
For _, script in [["Latin", LAT_MODE_LIST], ["Cyrillic", CYR_MODE_LIST]]
{
    For mode_ind, values in script[2]
    {
        chosen := ""
        If (script[1] == "Latin" && mode_ind == LATIN_MODE+1
            || script[1] == "Cyrillic" && mode_ind == CYRILLIC_MODE+1)
        {
            chosen := "✓"
        }
        t := []
        For key, symbol in values
        {
            If (key == "name")
            {
                Continue
            }
            t.Push(symbol[1])
        }
        LV_Add(, chosen, mode_ind, script[1], StrReplace(values["name"], "&"), t*)
    }
}
LV_ModifyCol()
LV_ModifyCol(1, "Desc")
LV_ModifyCol(2, "Integer AutoHdr Center")
LV_ModifyCol(3, "Desc")
LV_ModifyCol(4, 285)
Loop, 12
{
    LV_ModifyCol(A_Index+4, "AutoHdr Center")
}

Gui, Tab, Hotkeys
Gui, Add, ListView, r19 w716 h165 x-1 y18 LV1, Item|Hotkey
LV_Add(, "Toggle this gui", "Alt+F1")
LV_Add(, "Show menu", "LWin+F1")
LV_Add(, "Pause/restore qPhyx", "Shift+Tilde")
LV_Add(, "Restart qPhyx", "Ctrl+Shift+Tilde")
LV_Add(, "Clipboard swap", "Ctrl+Shift+v")
LV_Add(, "Minimize all windows", "LWin+Enter")
LV_Add(, "Restore windows state", "LWin+LongEnter")
LV_Add(, "Non-break space", "Shift+Space")
LV_Add(, "Lowercase lang mode symbol", "Shift+<num>")
LV_Add(, "Uppercase lang mode symbol", "Shift+Long<num>")
LV_Add(, "Media play/pause", "Backspace")
LV_Add(, "Volume up", "Shift+Backspace")
LV_Add(, "Volume down", "Alt+Backspace")
LV_Add(, "Media next", "Shift+LongBackspace")
LV_Add(, "Media previous", "Alt+LongBackspace")
LV_Add(, "<Backspace>", "Enter")
LV_Add(, "<Delete>", "Shift+Enter")
LV_Add(, "<Enter>", "CapsLock")
LV_Add(, "<Esc>", "Tilde")

LV_ModifyCol()

Return


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
                SendInput, % NUM_DICT[this][4]
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
                    SendInput, % NUM_DICT[this][6-caps_lock]
                }
                Else If (lang == -0xF3FFBE7)
                {
                    SendInput, % NUM_DICT[this][8-caps_lock]
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
            SendInput, % NUM_DICT[this][3]
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
                SendInput, % NUM_DICT[this][5+caps_lock]
            }
            Else If (lang == -0xF3FFBE7)
            {
                SendInput, % NUM_DICT[this][7+caps_lock]
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
        DICT[this][1] := 1+shift
        KeyWait, %this%, T%LONG_PRESS_TIME%
        If (ErrorLevel && !DICT[this][2])
        {
            DICT[this][2] := 1
            Send, % DICT[this][3]
            ;SendInput, % DICT[this][3] ; ?
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
        WinGet, win_state, MinMax, % "ahk_id" . windows%A_Index%
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
            Clipboard := Round(Clipboard+1*n, StrLen(Clipboard) - InStr(Clipboard, "."))
        }
        Else
        {
            Clipboard := Clipboard+1*n
        }
        SendInput, % Clipboard
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

DisabledToggle()
{
    DISABLED := !DISABLED
    IniWrite, %DISABLED%, config.ini, Configuration, Disabled
    icon := DISABLED ? "disabled.ico" : "qphyx.ico"
    IfExist, %icon%
    {
        Menu, Tray, Icon, %icon%, , 1
    }
    Menu, Tray, Tip, % "qPhyx" . EXT . " – " . (DISABLED ? "disabled" : "enabled")
    w := ["Dis", "En"]
    Menu, Tray, Rename, % w[!DISABLED+1] . "a&ble qPhyx"
        , % w[DISABLED+1] . "a&ble qPhyx"
}

LongPressTimeChange()
{
    InputBox, user_input, Set new long press delay
        , New value in seconds (e.g. 0.15), , 444, 130
    If !ErrorLevel
    {
        If (user_input is number)
        {
            old_value := LONG_PRESS_TIME
            IniWrite, %user_input%, config.ini, Configuration, LongPressTime
            LONG_PRESS_TIME := user_input
            Menu, Tray, Rename, Long press &delay (now is %old_value%s)
                , Long press &delay (now is %LONG_PRESS_TIME%s)
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

LatModeChange(_, item_pos)
{
    IniWrite, % item_pos-1, config.ini, Configuration, LatinMode
    Menu, LatModes, Uncheck, % LAT_MODE_LIST[LATIN_MODE+1]["name"]
    Menu, LatModes, Check, % LAT_MODE_LIST[item_pos]["name"]
    LV_Modify(LATIN_MODE+1, , "")
    LV_Modify(item_pos, , "✓")
    If item_pos not in 2,21,25
    {
        Menu, SubSettings, Delete, Toggle "Dotless &i" feature
    }
    Else If LATIN_MODE not in 1,20,24
    {
        Menu, SubSettings, Insert, Toggle "&Paired brackets" feature
            , Toggle "Dotless &i" feature, DotlessIToggle
        If DOTLESS_I_SWAP
        {
            Menu, SubSettings, Check, Toggle "Dotless &i" feature
        }
    }
    If (item_pos != 4)
    {
        Menu, SubSettings, Delete, Toggle "Romanian &cedilla to comma" feature
    }
    Else If (LATIN_MODE != 3)
    {
        Menu, SubSettings, Insert, Toggle "&Paired brackets" feature
            , Toggle "Romanian &cedilla to comma" feature, RomanianCedillaToCommaToggle
        If ROMANIAN_CEDILLA_TO_COMMA
        {
            Menu, SubSettings, Check, Toggle "Romanian &cedilla to comma" feature
        }
    }
    LATIN_MODE := item_pos-1
    Loop, 12
    {
        scan_code := "SC00" Format("{:X}", A_Index+1)
        NUM_DICT[scan_code][5] := LAT_MODE_LIST[item_pos][scan_code][1]
        NUM_DICT[scan_code][6] := LAT_MODE_LIST[item_pos][scan_code][2]
    }
}

CyrModeChange(_, item_pos)
{
    IniWrite, % item_pos-1, config.ini, Configuration, CyrillicMode
    Menu, CyrModes, Uncheck, % CYR_MODE_LIST[CYRILLIC_MODE+1]["name"]
    Menu, CyrModes, Check, % CYR_MODE_LIST[item_pos]["name"]
    LV_Modify(LAT_MODE_LIST.MaxIndex() + CYRILLIC_MODE+1, , "")
    LV_Modify(LAT_MODE_LIST.MaxIndex() + item_pos, , "✓")
    CYRILLIC_MODE := item_pos-1
    Loop, 12
    {
        scan_code := "SC00" Format("{:X}", A_Index+1)
        NUM_DICT[scan_code][7] := CYR_MODE_LIST[item_pos][scan_code][1]
        NUM_DICT[scan_code][8] := CYR_MODE_LIST[item_pos][scan_code][2]
    }
}

DotlessIToggle()
{
    DOTLESS_I_SWAP := !DOTLESS_I_SWAP
    IniWrite, %DOTLESS_I_SWAP%, config.ini, Configuration, DotlessISwap
    If DOTLESS_I_SWAP
    {
        NUM_DICT["SC009"][6] := "I"
    }
    Else
    {
        NUM_DICT["SC009"][6] := LAT_MODE_LIST[LATIN_MODE]["SC009"][2]
    }
    Menu, SubSettings, % DOTLESS_I_SWAP ? "Check" : "Uncheck", Toggle "Dotless &i" feature
}

RomanianCedillaToCommaToggle()
{
    ROMANIAN_CEDILLA_TO_COMMA := !ROMANIAN_CEDILLA_TO_COMMA
    IniWrite, %ROMANIAN_CEDILLA_TO_COMMA%, config.ini, Configuration, RomanianCedillaToComma
    If (LATIN_MODE == 3 && ROMANIAN_CEDILLA_TO_COMMA)
    {
        NUM_DICT["SC002"][4] := "̦"
    }
    Else
    {
        NUM_DICT["SC002"][4] := "̣"
    }
    Menu, SubSettings, % ROMANIAN_CEDILLA_TO_COMMA ? "Check" : "Uncheck"
        , Toggle "Romanian &cedilla to comma" feature
}

PairedBracketsToggle()
{
    PAIRED_BRACKETS := !PAIRED_BRACKETS
    IniWrite, %PAIRED_BRACKETS%, config.ini, Configuration, PairedBrackets
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
    Else
    {
        DICT["SC015"][3] := "{Text}<"
        DICT["SC015"][4] := "{Text}«"
        DICT["SC016"][3] := "{Text}("
        DICT["SC017"][3] := "{Text}["
        DICT["SC018"][3] := "{Text}{"
        DICT["SC018"][4] := "{Text}“"
        DICT["SC024"][3] := "{Text}"""
    }
    Menu, SubSettings, % PAIRED_BRACKETS ? "Check" : "Uncheck", Toggle "&Paired brackets" feature
}

UnbrSpaceToggle()
{
    UNBR_SPACE := !UNBR_SPACE
    IniWrite, %UNBR_SPACE%, config.ini, Configuration, UnbrSpace
    Menu, SubSettings, % UNBR_SPACE ? "Check" : "Uncheck", Toggle "No-&Break Space" on Sh-Space
}

EscAsCapsToggle()
{
    ESC_AS_CAPS := !ESC_AS_CAPS
    IniWrite, %ESC_AS_CAPS%, config.ini, Configuration, EscAsCaps
    SetCapsLockState, % (ESC_AS_CAPS ? "Off" : "AlwaysOff")
    Menu, SubSettings, % ESC_AS_CAPS ? "Check" : "Uncheck", Toggle "&Esc as Caps Lock" feature
}

NumPadToggle()
{
    NUMPAD := !NUMPAD
    IniWrite, % NUMPAD, config.ini, Configuration, NumPad
    Menu, SubSettings, % NUMPAD ? "Check" : "Uncheck", Toggle &NumPad availability
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
        key_pos := (SubStr(item_name, 9, 1) == "f") ? 1 : 2
        IniWrite, %user_input%, config.ini, Configuration, UserKey%key_pos%
        repr_pos := (key_pos == 1) ? "first" : "second"
        pos_value := (USER_KEY_%key_pos% == "") ? "empty" : USER_KEY_%key_pos%
        input_value := (user_input == "") ? "empty" : user_input
        Menu, SubSettings, Rename
            , % "Change &" . repr_pos . " user-defined key (now is " . pos_value . ")"
            , % "Change &" . repr_pos . " user-defined key (now is " . input_value . ")"
        USER_KEY_%key_pos% := user_input
    }
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
        WinGet, proc, ProcessName, ahk_id . %this_id%
        WinGetTitle, title, ahk_id . %this_id%
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

GuiKeyPress(wp, lp, msg, hwnd)
{
    GuiControl, Focus, % Format("{:03.f}", wp) . "1"
    GuiControl, Focus, % Format("{:03.f}", wp) . "2"
    GuiControl, Focus, % Format("{:03.f}", wp) . "3"
}

TrayMenu:
    Menu, Tray, Show
    Return

Cheatsheet:
    If WinExist("ahk_class AutoHotkeyGUI")
    {
        Gui, Hide
    }
    Else
    {
        Gui, Show, h180 w715
    }
    Return

LangModes:
    If (A_GuiEvent == "DoubleClick")
    {
        Gui, ListView, LangModes
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
    DisabledToggle()
    Return

;alt-f1 cheatsheet
!SC03B:: GoTo, Cheatsheet
;LWin-f1 menu
<#SC03B:: Menu, Tray, Show

#If WinActive("ahk_class AutoHotkeyGUI")
;esc
SC001:: Gui, Hide
SC029:: Gui, Hide

#If !DISABLED && !WinActive("ahk_class AutoHotkeyGUI")

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

;ctrl-sh-g (qphyx-view). clipboard swap (paste and save replaced text as a new clipboard text)
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

;old num-row "-" and "=" (two keys left from old BS)
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

;esc
SC001::
    If ESC_AS_CAPS
    {
        SetCapsLockState, % (t:=!t) ?  "On" :  "Off"
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
    SendInput, % DICT[SubStr(A_ThisHotkey, 2)][4]
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

#If ;fix eof accessibility for properly Hotkey command work (used by alt apps switch) /wtf/

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
