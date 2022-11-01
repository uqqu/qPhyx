;===============================================================================================
;============================================Presets============================================
;===============================================================================================

#SingleInstance Force
#UseHook On

Global EXT := A_IsCompiled ? ".exe" : ".ahk"
Global LSHIFT_COUNTER := 0
Global RSHIFT_COUNTER := 0
;global config.ini variables
Global DISABLED := 0
Global LONG_PRESS_TIME := 0.15
Global LATIN_MODE := 1
Global CYRILLIC_MODE := 1
Global COMBINED_VIEW := 1
Global CONTROLLING_KEYS := 0
Global NUMROW_SHIFTING := 0
Global DOUBLE_SHIFT_INVERT := 0
Global BOTH_SHIFTS_AS_ESC := 0
Global DOTLESS_I_SWAP := 1
Global ROMANIAN_CEDILLA_TO_COMMA := 1
Global PAIRED_BRACKETS := 0
Global UNBR_SPACE := 1
Global ESC_AS_CAPS := 0
Global NUMPAD := 0
Global USER_ASSIGNMENTS := {}
IfExist, config.ini
{
    IniRead, DISABLED,                     config.ini, Configuration, Disabled
    IniRead, LONG_PRESS_TIME,              config.ini, Configuration, LongPressTime
    IniRead, LATIN_MODE,                   config.ini, Configuration, LatinMode
    IniRead, CYRILLIC_MODE,                config.ini, Configuration, CyrillicMode
    IniRead, COMBINED_VIEW,                config.ini, Configuration, CombinedView
    IniRead, CONTROLLING_KEYS,             config.ini, Configuration, ControllingKeys
    IniRead, NUMROW_SHIFTING,              config.ini, Configuration, NumrowShifting
    IniRead, DOUBLE_SHIFT_INVERT,          config.ini, Configuration, DoubleShiftInvert
    IniRead, BOTH_SHIFTS_AS_ESC,           config.ini, Configuration, BothShiftsAsEsc
    IniRead, DOTLESS_I_SWAP,               config.ini, Configuration, DotlessISwap
    IniRead, ROMANIAN_CEDILLA_TO_COMMA,    config.ini, Configuration, RomanianCedillaToComma
    IniRead, PAIRED_BRACKETS,              config.ini, Configuration, PairedBrackets
    IniRead, UNBR_SPACE,                   config.ini, Configuration, UnbrSpace
    IniRead, ESC_AS_CAPS,                  config.ini, Configuration, EscAsCaps
    IniRead, NUMPAD,                       config.ini, Configuration, NumPad
    IniRead, menu_path,                    config.ini, Configuration, MenuPath
    IniRead, viatc_file,                   config.ini, Configuration, ViatcFile
}
Else
{
    IniWrite, %DISABLED%,                  config.ini, Configuration, Disabled
    IniWrite, %LONG_PRESS_TIME%,           config.ini, Configuration, LongPressTime
    IniWrite, %LATIN_MODE%,                config.ini, Configuration, LatinMode
    IniWrite, %CYRILLIC_MODE%,             config.ini, Configuration, CyrillicMode
    IniWrite, %COMBINED_VIEW%,             config.ini, Configuration, CombinedView
    IniWrite, %CONTROLLING_KEYS%,          config.ini, Configuration, ControllingKeys
    IniWrite, %NUMROW_SHIFTING%,           config.ini, Configuration, NumrowShifting
    IniWrite, %DOUBLE_SHIFT_INVERT%,       config.ini, Configuration, DoubleShiftInvert
    IniWrite, %BOTH_SHIFTS_AS_ESC%,        config.ini, Configuration, BothShiftsAsEsc
    IniWrite, %DOTLESS_I_SWAP%,            config.ini, Configuration, DotlessISwap
    IniWrite, %ROMANIAN_CEDILLA_TO_COMMA%, config.ini, Configuration, RomanianCedillaToComma
    IniWrite, %PAIRED_BRACKETS%,           config.ini, Configuration, PairedBrackets
    IniWrite, %UNBR_SPACE%,                config.ini, Configuration, UnbrSpace
    IniWrite, %ESC_AS_CAPS%,               config.ini, Configuration, EscAsCaps
    IniWrite, %NUMPAD%,                    config.ini, Configuration, NumPad
    IniWrite, c:\menu\,                    config.ini, Configuration, MenuPath
    IniWrite, c:\ViATc\ViATc.ahk,          config.ini, Configuration, ViatcFile
    FileAppend, `n[AdditionalAssignments]`nSC00C=`nSC00D=`n`n[AltApps]`n`n`n[BlackList]`n
        , config.ini
}

;additional assignments set
IniRead, section, config.ini, AdditionalAssignments
For ind, string in StrSplit(section, "`n")
{
    pair := StrSplit(string, "=")
    values := StrSplit(pair[2], ",")
    USER_ASSIGNMENTS[pair[1]] := values
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

;black-list apps (in which qPhyx switch to disabled state)
IniRead, section, config.ini, BlackList
For ind, pair in StrSplit(section, "`n")
{
    values := StrSplit(pair, "=")
    GroupAdd, BlackList, % "ahk_exe " . values[2]
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
Global DICT := {scan_code: ["releasing", "sended", "long", "alt", "alt_long"]
    , SC010: [0, 0, "{Text}~", "{Text}°", "{Text}¬"]
    , SC011: [0, 0, "{Text}–", "{Text}—", "{Text}²"]
    , SC012: [0, 0, "{Text}'", "{Text}’", "{Text}³"]
    , SC013: [0, 0, "{Text}\", "{Text}&", "{Text}π"]
    , SC014: [0, 0, "{Text}@", "{Text}§", "{Text}∑"]
    , SC015: [0, 0, "{Text}<", "{Text}«", "{Text}‰"]
    , SC016: [0, 0, "{Text}(", "{SC16A}", ""       ] ; alt – back
    , SC017: [0, 0, "{Text}[", "{SC169}", ""       ] ; alt - forward
    , SC018: [0, 0, "{Text}{", "{Text}“", "{Text}∞"]
    , SC019: [0, 0, "{Text}!", "{Text}¡", "{Text}‽"]
    , SC01A: [0, 0, "{Text}#", "{Text}№", "{Text}※"]
    , SC01B: [0, 0, "́"       , "̀"       , "{Text}♡"] ; long – comb. acute; alt – comb. grave
    , SC01E: [0, 0, "{Text}+", "{Text}±", "{Text}½"]
    , SC01F: [0, 0, "{Text}-", "{Text}−", "{Text}⅓"]
    , SC020: [0, 0, "{Text}*", "{Text}×", "{Text}¼"]
    , SC021: [0, 0, "{Text}/", "{Text}÷", "{Text}⅔"]
    , SC022: [0, 0, "{Text}=", "{Text}≠", "{Text}¾"]
    , SC023: [0, 0, "{Text}%", ""       , ""       ] ; alt - left
    , SC024: [0, 0, "{Text}""",""       , ""       ] ; alt - down
    , SC025: [0, 0, "{Text}.", ""       , ""       ] ; alt - up
    , SC026: [0, 0, "{Text},", ""       , ""       ] ; alt - right
    , SC027: [0, 0, "{Text}:", "{Text}^", "{Text}•"]
    , SC028: [0, 0, "{Text};", "{Text}``","{Text}…"]
    , SC02C: [0, 0, "{Text}$", "{Text}¢", "{Text}₿"]
    , SC02D: [0, 0, "{Text}€", "{Text}£", "{Text}₱"]
    , SC02E: [0, 0, "{Text}₽", "{Text}¥", "{Text}¤"]
    , SC02F: [0, 0, "{Text}_", "{Text}|", "{Text}©"]
    , SC030: [0, 0, "{Text}≈", "{Text}≟", "{Text}®"]
    , SC031: [0, 0, "{Text}>", "{Text}»", "{Text}™"]
    , SC032: [0, 0, "{Text})", "^{SC02C}",""       ] ; alt - undo
    , SC033: [0, 0, "{Text}]", "^{SC015}",""       ] ; alt - redo
    , SC034: [0, 0, "{Text}}", "{Text}”", "{Text}∵"]
    , SC035: [0, 0, "{Text}?", "{Text}¿", "{Text}∴"]}

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
    If (SubStr(section, 1, 3) == "Lat")
    {
        LAT_MODE_LIST.Push(t)
    }
    Else
    {
        CYR_MODE_LIST.Push(t)
    }
}

;;set chosen language modes (shift and shift-long layers on the num row)
For i, script in [LAT_MODE_LIST[LATIN_MODE], CYR_MODE_LIST[CYRILLIC_MODE]]
{
    Loop, 12
    {
        scan_code := "SC00" Format("{:X}", A_Index+1)
        NUM_DICT[scan_code][5+(i-1)*2] := script[scan_code][1+COMBINED_VIEW*2]
        NUM_DICT[scan_code][6+(i-1)*2] := script[scan_code][2+COMBINED_VIEW*2]
    }
}

;;Default i = dotted i (iİ); num-row i <sh-long-8> = dotless i (ıI)
;;Turkish, Kazakh latin, Azerbajani latin, ..., mode feature
;;Stay calm with third-party bindings. <Sh-i> will be detect as I. Diacr. dot will be added later
;;With this mode you can type I as <sh-i>+<bs> or as <sh-long-8>, how you want it
;;This option is not depends on selected latin mode, because you may want to use it with any mode
If (DOTLESS_I_SWAP && LATIN_MODE in 2,11)
{
    NUM_DICT["SC009"][6] := "I"
}

;;paste comma instead of the cedilla for the chosen romanian mode
;;https://www.wikiwand.com/en/Romanian_alphabet#/Comma-below_(ș_and_ț)_versus_cedilla_(ş_and_ţ)
;;Default on. If you know what you're doing
;;   and you want to type cedilla, you can disable this behavior in config.ini
;;This also influences to the cyrillic layout. (Only with selected Romanian mode, ofc)
If (ROMANIAN_CEDILLA_TO_COMMA && LATIN_MODE == 6)
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
IniRead, section, config.ini, AltApps
For ind, string in StrSplit(section, "`n")
{
    pair := StrSplit(string, "=")
    values := StrSplit(pair[2], ",")
    option%ind% := Func("Alt").Bind(values[1], values[2])
    Hotkey, % "LWin & " . pair[1], % option%ind%
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
    Menu, LatModes, Check, % LAT_MODE_LIST[LATIN_MODE]["name"]
    Menu, CyrModes, Check, % CYR_MODE_LIST[CYRILLIC_MODE]["name"]
Menu, Tray, UseErrorLevel
Menu, Tray, Add, Change &latin mode, :LatModes
Menu, Tray, Add, Change &cyrillic mode, :CyrModes
    Menu, SubSettings, Add, Preferably combined &view for lang mode symbols, CombinedViewToggle
    If COMBINED_VIEW
    {
        Menu, SubSettings, Check, Preferably combined &view for lang mode symbols
    }
    Menu, SubSettings, Add, Toggle controlling &keys remap, ControllingKeysToggle
    If CONTROLLING_KEYS
    {
        Menu, SubSettings, Check, Toggle controlling &keys remap
    }
    Menu, SubSettings, Add, Toggle n&umrow shifting (1-90 to 01-9), NumrowShiftingToggle
    If NUMROW_SHIFTING
    {
        Menu, SubSettings, Check, Toggle n&umrow shifting (1-90 to 01-9)
    }
    Menu, SubSettings, Add, Toggle "&double shift press to toggle case" feature, DoubleShiftToggle
    If DOUBLE_SHIFT_INVERT
    {
        Menu, SubSettings, Check, Toggle "&double shift press to toggle case" feature
    }
    Menu, SubSettings, Add, Toggle "b&oth shifts as esc" feature, BothShiftsAsEscToggle
    If BOTH_SHIFTS_AS_ESC
    {
        Menu, SubSettings, Check, Toggle "b&oth shifts as esc" feature
    }
    If LATIN_MODE in 2,11
    {
        Menu, SubSettings, Add, Toggle "Dotless &i" feature, DotlessIToggle
        If DOTLESS_I_SWAP
        {
            Menu, SubSettings, Check, Toggle "Dotless &i" feature
        }
    }
    If (LATIN_MODE == 6)
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
    key1 := (USER_ASSIGNMENTS["SC00C"] == "") ? "empty" : USER_ASSIGNMENTS["SC00C"]
    key2 := (USER_ASSIGNMENTS["SC00D"] == "") ? "empty" : USER_ASSIGNMENTS["SC00D"]
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

Global TABS := ["Base", "Long", "Alt", "Alt long", "Scan codes", "Lang. modes", "Hotkeys"]
Global SCAN_CODES := ["SC029","SC002","SC003","SC004","SC005","SC006","SC007","SC008","SC009"
    ,  "SC00A","SC00B","SC00C","SC00D","SC00E","SC00F","SC010","SC011","SC012","SC013","SC014"
    ,  "SC015","SC016","SC017","SC018","SC019","SC01A","SC01B","SC02B","SC03A","SC01E","SC01F"
    ,  "SC020","SC021","SC022","SC023","SC024","SC025","SC026","SC027","SC028","SC01C","SC02A"
    ,  "SC02C","SC02D","SC02E","SC02F","SC030","SC031","SC032","SC033","SC034","SC035","SC136"]
Gui -Border -Caption -Theme
Gui, Add, Button, x698 y-1 w19 h19 gCheatsheet, ✕
Gui, Add, Tab3, w720 h185 x-2 y-2 vGuiTabs, % TABS[1] . "|" . TABS[2] . "|" . TABS[3] . "|"
        . TABS[4] . "|" . TABS[5] . "|" . TABS[6] . "|" . TABS[7]
Gui, Font, s11, Calibri

AddButton(i, oi, x:=0, y:=20, w:=50, h:=40)
{
    Global
    Gui, Add, Button, % "x" . x . " y" . y . " w" . w . " h" . h . " v" . SCAN_CODES[i] . oi
}
Loop, 5
{
    outer_ind := A_Index
    Gui, Tab, % TABS[outer_ind]
    AddButton(1, outer_ind)
    Loop, 12
    {
        AddButton(A_Index+1, outer_ind, A_Index*50, , , (outer_ind > 2) ? 40 : 20)
    }
    If (outer_ind < 3)
    {
        Loop, 12
        {
            Gui, Add, Button, % "x" . A_Index*50 . " y40 w50 h20 vLM" . A_Index . outer_ind
                , % NUM_DICT["SC00" . Format("{:X}", A_Index+1)][5] . " "
                    . NUM_DICT["SC00" . Format("{:X}", A_Index+1)][7]
        }
    }
    AddButton(14, outer_ind, 650, , 65)
    AddButton(15, outer_ind, , 60, 65)
    Loop, 13
    {
        AddButton(A_Index+15, outer_ind, A_Index*50+15, 60)
    }
    AddButton(29, outer_ind, , 100, 80)
    Loop, 11
    {
        AddButton(A_Index+29, outer_ind, A_Index*50+30, 100)
    }
    AddButton(41, outer_ind, 630, 100, 85)
    AddButton(42, outer_ind, , 140, 100)
    Loop, 10
    {
        AddButton(A_Index+42, outer_ind, A_Index*50+50, 140)
    }
    AddButton(53, outer_ind, 600, 140, 115)
}

Gui, +Theme
OnMessage(0x100, "GuiKeyPress")
OnMessage(0x104, "GuiKeyPress")

GuiFillValues()

Gui, Tab, % TABS[6]
Gui, Add, ListView, r19 w716 h165 x-1 y18 LV3 gLangModes vLangModes
    , |№|Group|Mode|1|2|3|4|5|6|7|8|9|0|+1|+2
For _, script in [["Latin", LAT_MODE_LIST], ["Cyrillic", CYR_MODE_LIST]]
{
    For mode_ind, values in script[2]
    {
        chosen := ""
        If (script[1] == "Latin" && mode_ind == LATIN_MODE
            || script[1] == "Cyrillic" && mode_ind == CYRILLIC_MODE)
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
            t.Push(symbol[3])
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

Gui, Tab, % TABS[7]
Gui, Add, ListView, r19 w716 h165 x-1 y18 LV3 vHotkeys, Item|Hotkey
LV_Add(, "Toggle this gui", "Alt+F1")
LV_Add(, "GUI tab navigation", "F1-F7")
LV_Add(, "Show menu", "LWin+F1")
LV_Add(, "Pause/restore qPhyx", "Shift+Tilde")
LV_Add(, "Restart qPhyx", "Ctrl+Shift+Tilde")
LV_Add(, "Clipboard swap", "Ctrl+Shift+v")
LV_Add(, "Invert case for selected text", "Shift-Shift (double press)")
LV_Add(, "Upper case for selected text", "Ctrl+Shift-Shift")
LV_Add(, "Lower case for selected text", "Alt+Shift-Shift")
LV_Add(, "Minimize all windows", "LWin+Enter")
LV_Add(, "Restore windows state", "LWin+LongEnter")
LV_Add(, "Non-break space", "Shift+Space")
LV_Add(, "Lowercase lang mode symbol", "Shift+<num>")
LV_Add(, "Uppercase lang mode symbol", "Shift+Long<num>")
LV_Add(, "Begin of line ('home' key)", "Alt+Ctrl+j")
LV_Add(, "End of line ('end' key)", "Alt+Ctrl+k")
LV_Add(, "Move window left/right", "LWin+(h/l)")
LV_Add(, "Move window to the left/right screen", "LWin+Shift+(h/l)")
LV_Add(, "Maximize/minimize window", "LWin(+Shift)+(j/k)")
LV_Add(, "Media play/pause", "Backspace")
LV_Add(, "Volume up", "Shift+Backspace")
LV_Add(, "Volume down", "Alt+Backspace")
LV_Add(, "Media next", "Shift+LongBackspace")
LV_Add(, "Media previous", "Alt+LongBackspace")
LV_Add(, "<Delete>", "Shift+Enter")
LV_Add(, "<Esc>", "LShift+RShift")

LV_ModifyCol()

Return


;===============================================================================================
;=========================================Main layout functions=================================
;===============================================================================================

;num row interaction
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
    }
    SendInput, {Shift up}
    NUM_DICT[this][1] := 0
    NUM_DICT[this][2] := 0
}

;letter rows interaction
Down(this, alt:=0)
{
    If !DICT[this][1]
    {
        DICT[this][1] := 1
        KeyWait, %this%, T%LONG_PRESS_TIME%
        If (ErrorLevel && !DICT[this][2])
        {
            DICT[this][2] := 1
            If alt
            {
                SendInput, % DICT[this][5]
            }
            Else
            {
                SendInput, % DICT[this][3]
            }
        }
    }
}

Up(this, shift:=0, alt:=0)
{
    If (DICT[this][1] && !DICT[this][2])
    {
        If alt
        {
            SendInput, % DICT[this][4]
        }
        Else
        {
            upper := shift ^ GetKeyState("CapsLock", "T")
            u_this := (upper ? "+" : "") . this
            SetFormat, Integer, H
            lang := % DllCall("GetKeyboardLayout", Int
                , DllCall("GetWindowThreadProcessId", int, WinActive("A"), Int, 0))
            SetFormat, Integer, D
            If (USER_ASSIGNMENTS.haskey(u_this)
                && (!USER_ASSIGNMENTS[u_this][2] || (lang == USER_ASSIGNMENTS[u_this][2])))
            {
                SendInput, % USER_ASSIGNMENTS[u_this][1] . (upper ? "{Shift up}" : "")
                DICT[this][1] := 0
                DICT[this][2] := 0
                Return
            }
            If upper
            {
                SendInput, % "+{" . this . "}{Shift up}"
            }
            Else
            {
                SendInput, % "{" . this . "}"
            }
            ;dotted/dotless I feature
            If (upper && DOTLESS_I_SWAP && (lang == -0xF3EFBF7) && (GetKeyName(this) == "i"))
            {
                If LATIN_MODE in 2,11
                {
                    SendInput, {̇}
                }
            }
        }
    }
    SendInput, {Shift up}
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

;incr/decremenet func works on current selected (marked) number or character
;the function changes the integer part for numbers (including floats)
;    or unicode order for other (only last character), omitting the combining characters
;if there is no selection – it will select next (or last) character without incr/decrementing
IncrDecr(n)
{
    saved_value := Clipboard
    Clipboard := ""
    Send, ^{SC02E}
    Sleep, 30
    If (Clipboard*0 == 0)
    {
        If InStr(Clipboard, ".") {
            Clipboard := Round(Clipboard + 1*n, StrLen(Clipboard) - InStr(Clipboard, "."))
        }
        Else
        {
            Clipboard := Clipboard + 1*n
        }
        SendInput, % Clipboard
        new_value_len := StrLen(Clipboard)
        SendInput, {Left %new_value_len%}
        SendInput, +{Right %new_value_len%}{Shift up}
    }
    Else
    {
        If (StrLen(Clipboard) == 1)
        {
            order := Ord(Clipboard) + 1*n
        }
        Else
        {
            order := Ord(SubStr(Clipboard, 0)) + 1*n
            SendInput, {Right}+{Left}{Shift up}
        }
        jump_dict_1 := {31: 32, 127: 160, 159: 126, 768: 880, 879: 767, 1155: 1162, 1161: 1154
            , 1424: 1488, 1487: 1423, 1552: 1563, 1562: 1551, 1611: 1632, 1631: 1610
            , 1750: 1757, 1756: 1749, 1759: 1774, 1773: 1758, 1840: 1869, 1868: 1839
            , 1958: 1969, 1968: 1957, 2027: 2036, 2035: 2026, 2044: 2046, 2045: 2043
            , 2070: 2096, 2095: 2069, 2137: 2142, 2141: 2136, 2259: 2308, 2307: 2258
            , 2362: 2392, 2391: 2361, 2402: 2404, 2403: 2401, 2433: 2437, 2436: 2432
            , 2492: 2524, 2523: 2491, 2530: 2532, 2531: 2529, 2558: 2565, 2564: 2557
            , 2620: 2649, 2648: 2619, 2672: 2674, 2673: 2671, 2677: 2693, 2692: 2676
            , 2748: 2768: 2767: 2747, 2786: 2790, 2789: 2785, 2810: 2821, 2820: 2809
            , 2875: 2908, 2907: 2874, 2914: 2918, 2917: 2913, 2945: 2947, 2946: 2944
            , 3006: 3046, 3045: 3005, 3072: 3077, 3076: 3071, 3134: 3160, 3159: 3133
            , 3170: 3174, 3173: 3169, 3201: 3204, 3203: 3200, 3260: 3294, 3293: 3259
            , 3298: 3302, 3301: 3297, 3315: 3333, 3332: 3314, 3387: 3407, 3406: 3386
            , 3426: 3430, 3429: 3425, 3456: 3461, 3460: 3455, 3530: 3558, 3557: 3529
            , 3570: 3572, 3571: 3569, 3633: 3647, 3646: 3632, 3654: 3663, 3662: 3653
            , 3760: 3773, 3772: 3759, 3784: 3792, 3791: 3783, 3864: 3866, 3865: 3863
            , 3893: 3898, 3897: 3892, 3902: 3904, 3903: 3901, 3953: 3976, 3975: 3952
            , 3981: 4030, 4029: 3980, 4139: 4159, 4158: 4138, 4182: 4186, 4185: 4181
            , 4190: 4197, 4196: 4189, 4199: 4206, 4205: 4198, 4209: 4213, 4212: 4208
            , 4226: 4240, 4239: 4225, 4250: 4254, 4253: 4249, 4957: 4960, 4959: 4956
            , 5906: 5909, 5908: 5905, 5938: 5941, 5940: 5937, 5970: 5974, 5973: 5969}
        jump_dict_2 := { 6002: 6004, 6003: 6001, 6068: 6100, 6099: 6067, 6155: 6160, 6159: 6154
            , 6277: 6279, 6278: 6276, 6432: 6470, 6469: 6431, 6679: 6686, 6685: 6678
            , 6741: 6784, 6783: 6740, 6832: 6917, 6916: 6831, 6964: 6981, 6980: 6963
            , 7019: 7028, 7027: 7018, 7040: 7043, 7042: 7039, 7073: 7086, 7085: 7072
            , 7142: 7164, 7163: 7141, 7204: 7227, 7226: 7203, 7376: 7401, 7400: 7375
            , 7410: 7418, 7417: 7409, 7616: 7680, 7679: 7615, 8400: 8448, 8447: 8399
            , 11503: 11506, 11505: 11502, 11744: 11776, 11775: 11743, 12330: 12336, 12335: 12329
            , 12441: 12443, 12442: 12440, 42607: 42611, 42610: 42606, 42612: 42624, 42623: 42611
            , 42654: 42656, 42655: 42653, 42736: 42738, 42737: 42735, 43008: 43056, 43055: 43007
            , 43136: 43138, 43137: 43135, 43188: 43250, 43249: 43187, 43302: 43310, 43309: 43301
            , 43335: 43359, 43358: 43334, 43392: 43396, 43395: 43391, 43443: 43457, 43456: 43442
            , 43561: 43600, 43599: 43560, 43643: 43646, 43645: 43632, 43696: 43739, 43738: 43695
            , 43755: 43776, 43775: 43754, 44003: 44016, 44015: 44002, 55295: 63744, 63743: 55294
            , 65024: 65040, 65039: 65023, 65056: 65072, 65071: 65055}
        If order in 173,1809,3415,4038,6109,6313,7405,11647,43263,43493,64286
        {
            order := order + 1*n
        }
        Else If jump_dict_1.haskey(order)
        {
            order := jump_dict_1[order]
        }
        Else If jump_dict_2.haskey(order)
        {
            order := jump_dict_2[order]
        }
        Else If order in 9,11
        {
            order := 0
        }
        Clipboard := Chr(order)
        Send, % "{Text}" . Clipboard
        new_value_len := StrLen(Clipboard)
        SendInput, {Left}
        SendInput, +{Right}{Shift up}
    }
    Clipboard := saved_value
}

ShiftPress()
{
    If (LSHIFT_COUNTER > 1 || RSHIFT_COUNTER > 1)
    {
        BlockInput, On
        saved_value := Clipboard
        Clipboard := ""
        Send, ^{SC02E}
        Sleep, 1
        If (StrLen(Clipboard) > 0)
        {
            If GetKeyState("Ctrl")
            {
                StringUpper, result, Clipboard
            }
            Else If GetKeyState("Alt")
            {
                StringLower, result, Clipboard
            }
            Else
            {
                result := RegExReplace(Clipboard, "([a-zа-яё])|([A-ZА-ЯЁ])", "$U1$L2")
            }
            SendInput, {Raw}%result%
        }
        Sleep, 1
        Clipboard := saved_value
        BlockInput, Off
        LSHIFT_COUNTER := 0
        RSHIFT_COUNTER := 0
        SetTimer, ShiftCounterDrop, Off
    }
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
    Loop, 12
    {
        scan_code := "SC00" Format("{:X}", A_Index+1)
        NUM_DICT[scan_code][5] := LAT_MODE_LIST[item_pos][scan_code][1+COMBINED_VIEW*2]
        NUM_DICT[scan_code][6] := LAT_MODE_LIST[item_pos][scan_code][2+COMBINED_VIEW*2]
    }
    IniWrite, % item_pos, config.ini, Configuration, LatinMode
    Menu, LatModes, Uncheck, % LAT_MODE_LIST[LATIN_MODE]["name"]
    Menu, LatModes, Check, % LAT_MODE_LIST[item_pos]["name"]
    Loop, 12
    {
        scan_code := "SC00" Format("{:X}", A_Index+1)
        i := A_Index
        Loop, 2
        {
            GuiControl, Text, % "LM" . i . A_Index
                , % LAT_MODE_LIST[item_pos][scan_code][3] . " "
                    . CYR_MODE_LIST[CYRILLIC_MODE][scan_code][3]
        }
    }
    Gui, ListView, LangModes
    LV_Modify(LATIN_MODE, , "")
    LV_Modify(item_pos, , "✓")
    If item_pos not in 2,11
    {
        Menu, SubSettings, Delete, Toggle "Dotless &i" feature
    }
    Else If LATIN_MODE not in 2,11
    {
        Menu, SubSettings, Insert, Toggle "&Paired brackets" feature
            , Toggle "Dotless &i" feature, DotlessIToggle
        If DOTLESS_I_SWAP
        {
            Menu, SubSettings, Check, Toggle "Dotless &i" feature
            NUM_DICT["SC009"][6] := "I"
        }
    }
    If (item_pos != 6)
    {
        Menu, SubSettings, Delete, Toggle "Romanian &cedilla to comma" feature
        NUM_DICT["SC002"][4] := "̧"
    }
    Else If (LATIN_MODE != 6)
    {
        Menu, SubSettings, Insert, Toggle "&Paired brackets" feature
            , Toggle "Romanian &cedilla to comma" feature, RomanianCedillaToCommaToggle
        If ROMANIAN_CEDILLA_TO_COMMA
        {
            Menu, SubSettings, Check, Toggle "Romanian &cedilla to comma" feature
            NUM_DICT["SC002"][4] := "̦"
        }
    }
    LATIN_MODE := item_pos
}

CyrModeChange(_, item_pos)
{
    IniWrite, % item_pos, config.ini, Configuration, CyrillicMode
    Menu, CyrModes, Uncheck, % CYR_MODE_LIST[CYRILLIC_MODE]["name"]
    Menu, CyrModes, Check, % CYR_MODE_LIST[item_pos]["name"]
    Loop, 12
    {
        scan_code := "SC00" Format("{:X}", A_Index+1)
        i := A_Index
        Loop, 2
        {
            GuiControl, Text, % "LM" . i . A_Index
                , % LAT_MODE_LIST[LATIN_MODE][scan_code][3] . " "
                    . CYR_MODE_LIST[item_pos][scan_code][3]
        }
    }
    Gui, ListView, LangModes
    LV_Modify(LAT_MODE_LIST.MaxIndex() + CYRILLIC_MODE, , "")
    LV_Modify(LAT_MODE_LIST.MaxIndex() + item_pos, , "✓")
    CYRILLIC_MODE := item_pos
    Loop, 12
    {
        scan_code := "SC00" Format("{:X}", A_Index+1)
        NUM_DICT[scan_code][7] := CYR_MODE_LIST[item_pos][scan_code][1+COMBINED_VIEW*2]
        NUM_DICT[scan_code][8] := CYR_MODE_LIST[item_pos][scan_code][2+COMBINED_VIEW*2]
    }
}

CombinedViewToggle()
{
    COMBINED_VIEW := !COMBINED_VIEW
    IniWrite, %COMBINED_VIEW%, config.ini, Configuration, CombinedView
    Menu, SubSettings, % COMBINED_VIEW ? "Check" : "Uncheck"
        , Preferably combined &view for lang mode symbols
    LatModeChange("", LATIN_MODE)
    CyrModeChange("", CYRILLIC_MODE)
}

ControllingKeysToggle()
{
    CONTROLLING_KEYS := !CONTROLLING_KEYS
    IniWrite, %CONTROLLING_KEYS%, config.ini, Configuration, ControllingKeys
    keys := CONTROLLING_KEYS
        ? ["Esc", "Media", "Enter", "Backspace"] : ["Tilde", "BS", "Caps Lock", "Enter"]
    Loop, 4
    {
        GuiControl, Text, % "SC029" . A_Index, % keys[1]
        GuiControl, Text, % "SC00E" . A_Index, % keys[2]
        GuiControl, Text, % "SC03A" . A_Index, % keys[3]
        GuiControl, Text, % "SC01C" . A_Index, % keys[4]
    }
    Menu, SubSettings, % CONTROLLING_KEYS ? "Check" : "Uncheck", Toggle controlling &keys remap
}

NumrowShiftingToggle()
{
    NUMROW_SHIFTING := !NUMROW_SHIFTING
    IniWrite, %NUMROW_SHIFTING%, config.ini, Configuration, NumrowShifting
    If NUMROW_SHIFTING
    {
        Loop, 10
        {
            GuiControl, Text, % "SC00" . Format("{:X}", A_Index+1) . 1, % A_Index - 1
            GuiControl, Text, % "SC00" . Format("{:X}", A_Index+1) . 2, % A_Index - 1
        }
    }
    Else
    {
        Loop, 10
        {
            GuiControl, Text, % SCAN_CODES[A_Index+1] . 1, % GetKeyName(SCAN_CODES[A_Index+1])
            GuiControl, Text, % SCAN_CODES[A_Index+1] . 2, % GetKeyName(SCAN_CODES[A_Index+1])
        }
    }
    Menu, SubSettings, % NUMROW_SHIFTING ? "Check" : "Uncheck", Toggle n&umrow shifting (1-90 to 01-9)
}

DoubleShiftToggle()
{
    DOUBLE_SHIFT_INVERT := !DOUBLE_SHIFT_INVERT
    IniWrite, %DOUBLE_SHIFT_INVERT%, config.ini, Configuration, DoubleShiftInvert
    Menu, SubSettings, % DOUBLE_SHIFT_INVERT ? "Check" : "Uncheck"
        , Toggle "&double shift press to toggle case" feature
}

BothShiftsAsEscToggle()
{
    BOTH_SHIFTS_AS_ESC := !BOTH_SHIFTS_AS_ESC
    IniWrite, %BOTH_SHIFTS_AS_ESC%, config.ini, Configuration, BothShiftsAsEsc
    Menu, SubSettings, % BOTH_SHIFTS_AS_ESC ? "Check" : "Uncheck"
        , Toggle "b&oth shifts as esc" feature
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
        NUM_DICT["SC009"][6] := LAT_MODE_LIST[LATIN_MODE]["SC009"][2+COMBINED_VIEW*2]
    }
    Menu, SubSettings, % DOTLESS_I_SWAP ? "Check" : "Uncheck", Toggle "Dotless &i" feature
}

RomanianCedillaToCommaToggle()
{
    ROMANIAN_CEDILLA_TO_COMMA := !ROMANIAN_CEDILLA_TO_COMMA
    IniWrite, %ROMANIAN_CEDILLA_TO_COMMA%, config.ini, Configuration, RomanianCedillaToComma
    If (LATIN_MODE == 6 && ROMANIAN_CEDILLA_TO_COMMA)
    {
        NUM_DICT["SC002"][4] := "̦"
    }
    Else
    {
        NUM_DICT["SC002"][4] := "̧"
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
        DICT["SC016"][3] := "(){Left}"
        DICT["SC017"][3] := "[]{Left}"
        DICT["SC018"][3] := "{{}{}}{Left}"
        DICT["SC024"][3] := """""{Left}"
        DICT["SC015"][4] := "«»{Left}"
        DICT["SC018"][4] := "“”{Left}"
        GuiControl, Text, SC0152, <>
        GuiControl, Text, SC0162, ()
        GuiControl, Text, SC0172, []
        GuiControl, Text, SC0182, {}
        GuiControl, Text, SC0242, ""
        GuiControl, Text, SC0153, «»
        GuiControl, Text, SC0183, “”
    }
    Else
    {
        DICT["SC015"][3] := "{Text}<"
        DICT["SC016"][3] := "{Text}("
        DICT["SC017"][3] := "{Text}["
        DICT["SC018"][3] := "{Text}{"
        DICT["SC024"][3] := "{Text}"""
        DICT["SC015"][4] := "{Text}«"
        DICT["SC018"][4] := "{Text}“"
        GuiControl, Text, SC0152, <
        GuiControl, Text, SC0162, (
        GuiControl, Text, SC0172, [
        GuiControl, Text, SC0182, {
        GuiControl, Text, SC0242, "
        GuiControl, Text, SC0153, «
        GuiControl, Text, SC0183, “
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
    InputBox, user_input, Set new value for user-defined key (two left keys from backspace)
        , %message%
        , , 611, 160
    If !ErrorLevel
    {
        key := ((SubStr(item_name, 9, 1) == "f") ? [1, "SC00C", "first"] : [0, "SC00D", "second"])
        IniWrite, %user_input%, config.ini, AdditionalAssignments, % key[2]
        old_value := ((USER_ASSIGNMENTS[key[2]] == "") ? "empty" : USER_ASSIGNMENTS[key[2]])
        new_value := (user_input == "") ? "empty" : user_input
        Menu, SubSettings, Rename
            , % "Change &" . key[3] . " user-defined key (now is " . old_value . ")"
            , % "Change &" . key[3] . " user-defined key (now is " . new_value . ")"
        USER_ASSIGNMENTS[key[2]] := user_input
        GuiControl, Text, % key[2] . 1, % user_input
        If (user_input == "")
        {
            GuiControl, Text, % key[2] . 1, % ((key[2] == "SC00C") ? "decr" : "incr")
            GuiControl, Text, % key[2] . 2, % ((key[2] == "SC00C") ? "decr" : "incr")
        }
        Else
        {
            GuiControl, Text, % key[2] . 2, % user_input
        }
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

GuiFillValues()
{
    ;read user layout (first tab) and global qphyx dict (second to fourth tabs)
    Loop, 53
    {
        values := DICT[SCAN_CODES[A_Index]]
        GuiControl, Text, % SCAN_CODES[A_Index] . 1, % GetKeyName(SCAN_CODES[A_Index])
        GuiControl, Text, % SCAN_CODES[A_Index] . 2, % RegExReplace(values[3], "\{.+\}")
        GuiControl, Text, % SCAN_CODES[A_Index] . 3, % RegExReplace(values[4], "\{.+\}")
        GuiControl, Text, % SCAN_CODES[A_Index] . 4, % RegExReplace(values[5], "\{.+\}")
        GuiControl, Text, % SCAN_CODES[A_Index] . 5, % SCAN_CODES[A_Index]
    }

    ;set optional values and fix some broken names
    repl := ["SC029", "SC00E", "SC03A", "SC01C", "SC00F", "SC02A", "SC136"
        , "SC023", "SC024", "SC025", "SC026", "SC016", "SC017", "SC032", "SC033"]
    keys := CONTROLLING_KEYS
        ? ["Esc", "Media", "Enter", "Backspace"] : ["Tilde", "BS", "Caps Lock", "Enter"]
    keys.Push("Tab", "LShift", "RShift"
        , "left", "down", "up", "right", "backw", "forw", "undo", "redo")
    Loop, 4
    {
        outer_ind := A_Index
        For i, sc in repl
        {
            If ((outer_ind < 3) && (i > 7))
            {
                Break
            }
            GuiControl, Text, % sc . outer_ind, % keys[i]
        }
    }
    GuiControl, Text, SC0182, % PAIRED_BRACKETS ? "{}" : "{"
    GuiControl, Text, SC0342, }
    GuiControl, Text, SC0133, &&
    GuiControl, Text, SC01B2, ó
    GuiControl, Text, SC01B3, ò
    GuiControl, Text, SC01B4, ♥

    ;fill second tab numrow
    Loop, 10
    {
        GuiControlGet, base, , % SCAN_CODES[A_Index+1] . 1
        GuiControl, Text, % SCAN_CODES[A_Index+1] . 2, % base
    }

    ;fill diacritics
    For sc, values in NUM_DICT
    {
        GuiControl, Text, % sc . 3, % "o" . values[3]
        GuiControl, Text, % sc . 4, % "o" . values[4]
    }
    GuiControl, Text, SC00C4, % NUM_DICT["SC00C"][4]
    GuiControl, Text, SC00D4, % NUM_DICT["SC00D"][4]

    If NUMROW_SHIFTING
    {
        Loop, 10
        {
            GuiControl, Text, % "SC00" . Format("{:X}", A_Index+1) . 1, % A_Index - 1
            GuiControl, Text, % "SC00" . Format("{:X}", A_Index+1) . 2, % A_Index - 1
        }
    }

    ;apply user-defined keys
    For key, value in USER_ASSIGNMENTS
    {
        If value != ""
        {
            GuiControl, Text, % key . 1, % value
        }
    }
    ;;... and fix numrow user-defined keys to incr/decr func, if empty
    For _, key in [["C", "decr"], ["D", "incr"]]
    {
        GuiControlGet, user_numkey, , % "SC00" . key[1] . 1
        If (user_numkey == "")
        {
            GuiControl, Text, % "SC00" . key[1] . 1, % key[2]
            GuiControl, Text, % "SC00" . key[1] . 2, % key[2]
        }
        Else
        {
            GuiControl, Text, % "SC00" . key[1] . 2, % user_numkey
        }
    }
}

GuiKeyPress(wp, lp, msg, hwnd)
{
    key := "SC" . Format("{:03X}", GetKeySC("vk" . Format("{:X}", wp)))
    Loop, 5
    {
        GuiControl, Focus, % key . A_Index
    }
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
        Gui, Show, h179 w714
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

ShiftCounterDrop:
    LSHIFT_COUNTER := 0
    RSHIFT_COUNTER := 0
    SetTimer, ShiftCounterDrop, Off
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

#If WinActive("ahk_class AutoHotkeyGUI") && CONTROLLING_KEYS && !DISABLED
SC029:: Gui, Hide

#If WinActive("ahk_class AutoHotkeyGUI")
;esc
SC001:: Gui, Hide
;F1-F7
SC03B:: GuiControl, Choose, GuiTabs, % TABS[1]
SC03C:: GuiControl, Choose, GuiTabs, % TABS[2]
SC03D:: GuiControl, Choose, GuiTabs, % TABS[3]
SC03E:: GuiControl, Choose, GuiTabs, % TABS[4]
SC03F:: GuiControl, Choose, GuiTabs, % TABS[5]
SC040:: GuiControl, Choose, GuiTabs, % TABS[6]
SC041:: GuiControl, Choose, GuiTabs, % TABS[7]

#If !DISABLED && CONTROLLING_KEYS
    && !WinActive("ahk_class AutoHotkeyGUI") && !WinActive("ahk_group BlackList")

;tilde
 SC029:: SendInput,  {SC001}
!SC029:: SendInput, !{SC001}
^SC029:: SendInput, ^{SC001}

;backspace
 SC00E:: SendInput, {SC122}
!SC00E::
    KeyWait, SC00E, T%LONG_PRESS_TIME%
    If ErrorLevel
    {
        SendInput, {SC110}
    }
    Else
    {
        SendInput, {SC12E}
    }
    KeyWait, SC00E
    Return
+SC00E::
    KeyWait, SC00E, T%LONG_PRESS_TIME%
    If ErrorLevel
    {
        SendInput, {SC119}{Shift up}
    }
    Else
    {
        SendInput, {SC130}{Shift up}
    }
    KeyWait, SC00E
    Return

;enter
  SC01C:: SendInput,  {SC00E}
 +SC01C:: SendInput,  {SC153}{Shift up}
 ^SC01C:: SendInput, ^{SC00E}
+^SC01C:: SendInput, ^{SC153}{Shift up}
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
 SC03A:: SendInput,  {SC01C}
+SC03A:: SendInput, +{SC01C}{Shift up}
!SC03A:: SendInput, !{SC01C}
^SC03A:: SendInput, ^{SC01C}

;esc
SC001::
    If (ESC_AS_CAPS && CONTROLLING_KEYS)
    {
        SetCapsLockState, % (t:=!t) ?  "On" :  "Off"
    }
    Else
    {
        SendInput, {%A_ThisHotkey%}
    }
    Return

#If !DISABLED && NUMROW_SHIFTING && !WinActive("ahk_class AutoHotkeyGUI")

SC002:: SendInput, 0
SC003:: SendInput, 1
SC004:: SendInput, 2
SC005:: SendInput, 3
SC006:: SendInput, 4
SC007:: SendInput, 5
SC008:: SendInput, 6
SC009:: SendInput, 7
SC00A:: SendInput, 8
SC00B:: SendInput, 9

#If !DISABLED && !WinActive("ahk_group BlackList") && BOTH_SHIFTS_AS_ESC

SC02A & SC136:: SendInput,  {SC001}

#If !DISABLED && !WinActive("ahk_group BlackList") && DOUBLE_SHIFT_INVERT

;double shift press = invert case; +ctrl = upper case; +alt = lower case
~*SC02A up::
    LSHIFT_COUNTER++
    ShiftPress()
    SetTimer, ShiftCounterDrop, % LONG_PRESS_TIME*2000
    Return
~*SC136 up::
    RSHIFT_COUNTER++
    ShiftPress()
    SetTimer, ShiftCounterDrop, % LONG_PRESS_TIME*2000
    Return

#If !DISABLED && !WinActive("ahk_group BlackList")

;nav "hjkl"
    ;base nav
  !SC023:: SendInput,   {SC14B}
  !SC024:: SendInput,   {SC150}
  !SC025:: SendInput,   {SC148}
  !SC026:: SendInput,   {SC14D}
    ;nav with select
 +!SC023:: SendInput,  +{SC14B}{Shift up}
 +!SC024:: SendInput,  +{SC150}{Shift up}
 +!SC025:: SendInput,  +{SC148}{Shift up}
 +!SC026:: SendInput,  +{SC14D}{Shift up}
    ;ctrl nav (left-right move by words; up-down as home-end)
 ^!SC023:: SendInput,  ^{SC14B}
 ^!SC024:: SendInput,   {SC147}
 ^!SC025:: SendInput,   {SC14F}
 ^!SC026:: SendInput,  ^{SC14D}
    ;ctrl nav with select
+^!SC023:: SendInput, +^{SC14B}{Shift up}
+^!SC024:: SendInput,  +{SC147}{Shift up}
+^!SC025:: SendInput,  +{SC14F}{Shift up}
+^!SC026:: SendInput, +^{SC14D}{Shift up}
    ;move window
  #SC023:: SendInput,  #{SC14B}
  #SC024:: SendInput,  #{SC150}
  #SC025:: SendInput,  #{SC148}
  #SC026:: SendInput,  #{SC14D}
 #+SC023:: SendInput, #+{SC14B}{Shift up}
 #+SC026:: SendInput, #+{SC14D}{Shift up}
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

#If !DISABLED && !WinActive("ahk_class AutoHotkeyGUI") && !WinActive("ahk_group BlackList")

;ctrl-sh-v – clipboard swap (paste and save replaced text as a new clipboard text)
+^SC02F::
    saved_value := Clipboard
    Clipboard := ""
    Send, ^{SC02E}
    Sleep, 1
    saved_value2 := Clipboard
    Clipboard := ""
    Clipboard := saved_value
    Sleep, 1
    Send, ^{SC02F}
    Clipboard := saved_value2
    Return

;two keys left from BS ("-/_", "=/+")
SC00C::
    If USER_ASSIGNMENTS["SC00C"][1]
    {
        If USER_ASSIGNMENTS["SC00C"][2]
        {
            SetFormat, Integer, H
            lang := % DllCall("GetKeyboardLayout", Int
                , DllCall("GetWindowThreadProcessId", int, WinActive("A"), Int, 0))
            SetFormat, Integer, D
            If (USER_ASSIGNMENTS["SC00C"][2] == lang)
            {
                SendInput, % USER_ASSIGNMENTS["SC00C"][1]
                Return
            }
        }
        Else
        {
            SendInput, % USER_ASSIGNMENTS["SC00C"][1]
            Return
        }
    }
    IncrDecr(-1)
    Return

SC00D::
    If USER_ASSIGNMENTS["SC00D"][1]
    {
        If USER_ASSIGNMENTS["SC00D"][2]
        {
            SetFormat, Integer, H
            lang := % DllCall("GetKeyboardLayout", Int
                , DllCall("GetWindowThreadProcessId", int, WinActive("A"), Int, 0))
            SetFormat, Integer, D
            If (USER_ASSIGNMENTS["SC00D"][2] == lang)
            {
                SendInput, % USER_ASSIGNMENTS["SC00D"][1]
                Return
            }
        }
        Else
        {
            SendInput, % USER_ASSIGNMENTS["SC00D"][1]
            Return
        }
    }
    IncrDecr(1)
    Return

;backward, forward, undo, redo
!SC016:: SendInput,  {SC16A}
!SC017:: SendInput,  {SC169}
!SC032:: SendInput, ^{SC02C}
!SC033:: SendInput, ^{SC015}


;===============================================================================================
;============================="Send symbol" key assignments=====================================
;===============================================================================================

;numeric row
+SC002:: DownNum("SC002")
+SC003:: DownNum("SC003")
+SC004:: DownNum("SC004")
+SC005:: DownNum("SC005")
+SC006:: DownNum("SC006")
+SC007:: DownNum("SC007")
+SC008:: DownNum("SC008")
+SC009:: DownNum("SC009")
+SC00A:: DownNum("SC00A")
+SC00B:: DownNum("SC00B")
+SC00C:: DownNum("SC00C")
+SC00D:: DownNum("SC00D")

!SC002:: DownNum("SC002", 1)
!SC003:: DownNum("SC003", 1)
!SC004:: DownNum("SC004", 1)
!SC005:: DownNum("SC005", 1)
!SC006:: DownNum("SC006", 1)
!SC007:: DownNum("SC007", 1)
!SC008:: DownNum("SC008", 1)
!SC009:: DownNum("SC009", 1)
!SC00A:: DownNum("SC00A", 1)
!SC00B:: DownNum("SC00B", 1)
!SC00C:: DownNum("SC00C", 1)
!SC00D:: DownNum("SC00D", 1)

+SC002 up:: UpNum("SC002", 1)
+SC003 up:: UpNum("SC003", 1)
+SC004 up:: UpNum("SC004", 1)
+SC005 up:: UpNum("SC005", 1)
+SC006 up:: UpNum("SC006", 1)
+SC007 up:: UpNum("SC007", 1)
+SC008 up:: UpNum("SC008", 1)
+SC009 up:: UpNum("SC009", 1)
+SC00A up:: UpNum("SC00A", 1)
+SC00B up:: UpNum("SC00B", 1)
+SC00C up:: UpNum("SC00C", 1)
+SC00D up:: UpNum("SC00D", 1)

!SC002 up:: UpNum("SC002", , 1)
!SC003 up:: UpNum("SC003", , 1)
!SC004 up:: UpNum("SC004", , 1)
!SC005 up:: UpNum("SC005", , 1)
!SC006 up:: UpNum("SC006", , 1)
!SC007 up:: UpNum("SC007", , 1)
!SC008 up:: UpNum("SC008", , 1)
!SC009 up:: UpNum("SC009", , 1)
!SC00A up:: UpNum("SC00A", , 1)
!SC00B up:: UpNum("SC00B", , 1)
!SC00C up:: UpNum("SC00C", , 1)
!SC00D up:: UpNum("SC00D", , 1)

;top letters row
SC010:: Down("SC010")
SC011:: Down("SC011")
SC012:: Down("SC012")
SC013:: Down("SC013")
SC014:: Down("SC014")
SC015:: Down("SC015")
SC016:: Down("SC016")
SC017:: Down("SC017")
SC018:: Down("SC018")
SC019:: Down("SC019")
SC01A:: Down("SC01A")
SC01B:: Down("SC01B")
;home letters row
SC01E:: Down("SC01E")
SC01F:: Down("SC01F")
SC020:: Down("SC020")
SC021:: Down("SC021")
SC022:: Down("SC022")
SC023:: Down("SC023")
SC024:: Down("SC024")
SC025:: Down("SC025")
SC026:: Down("SC026")
SC027:: Down("SC027")
SC028:: Down("SC028")
;bottom letters row
SC02C:: Down("SC02C")
SC02D:: Down("SC02D")
SC02E:: Down("SC02E")
SC02F:: Down("SC02F")
SC030:: Down("SC030")
SC031:: Down("SC031")
SC032:: Down("SC032")
SC033:: Down("SC033")
SC034:: Down("SC034")
SC035:: Down("SC035")

;top letters row
+SC010:: Down("SC010")
+SC011:: Down("SC011")
+SC012:: Down("SC012")
+SC013:: Down("SC013")
+SC014:: Down("SC014")
+SC015:: Down("SC015")
+SC016:: Down("SC016")
+SC017:: Down("SC017")
+SC018:: Down("SC018")
+SC019:: Down("SC019")
+SC01A:: Down("SC01A")
+SC01B:: Down("SC01B")
;home letters row
+SC01E:: Down("SC01E")
+SC01F:: Down("SC01F")
+SC020:: Down("SC020")
+SC021:: Down("SC021")
+SC022:: Down("SC022")
+SC023:: Down("SC023")
+SC024:: Down("SC024")
+SC025:: Down("SC025")
+SC026:: Down("SC026")
+SC027:: Down("SC027")
+SC028:: Down("SC028")
;bottom letters row
+SC02C:: Down("SC02C")
+SC02D:: Down("SC02D")
+SC02E:: Down("SC02E")
+SC02F:: Down("SC02F")
+SC030:: Down("SC030")
+SC031:: Down("SC031")
+SC032:: Down("SC032")
+SC033:: Down("SC033")
+SC034:: Down("SC034")
+SC035:: Down("SC035")

;top letters row
!SC010:: Down("SC010", 1)
!SC011:: Down("SC011", 1)
!SC012:: Down("SC012", 1)
!SC013:: Down("SC013", 1)
!SC014:: Down("SC014", 1)
!SC015:: Down("SC015", 1)
!SC018:: Down("SC018", 1)
!SC019:: Down("SC019", 1)
!SC01A:: Down("SC01A", 1)
!SC01B:: Down("SC01B", 1)
;home letters row
!SC01E:: Down("SC01E", 1)
!SC01F:: Down("SC01F", 1)
!SC020:: Down("SC020", 1)
!SC021:: Down("SC021", 1)
!SC022:: Down("SC022", 1)
!SC027:: Down("SC027", 1)
!SC028:: Down("SC028", 1)
;bottom letters row
!SC02C:: Down("SC02C", 1)
!SC02D:: Down("SC02D", 1)
!SC02E:: Down("SC02E", 1)
!SC02F:: Down("SC02F", 1)
!SC030:: Down("SC030", 1)
!SC031:: Down("SC031", 1)
!SC034:: Down("SC034", 1)
!SC035:: Down("SC035", 1)

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
+SC010 up:: Up("SC010", 1)
+SC011 up:: Up("SC011", 1)
+SC012 up:: Up("SC012", 1)
+SC013 up:: Up("SC013", 1)
+SC014 up:: Up("SC014", 1)
+SC015 up:: Up("SC015", 1)
+SC016 up:: Up("SC016", 1)
+SC017 up:: Up("SC017", 1)
+SC018 up:: Up("SC018", 1)
+SC019 up:: Up("SC019", 1)
+SC01A up:: Up("SC01A", 1)
+SC01B up:: Up("SC01B", 1)
;home letters row
+SC01E up:: Up("SC01E", 1)
+SC01F up:: Up("SC01F", 1)
+SC020 up:: Up("SC020", 1)
+SC021 up:: Up("SC021", 1)
+SC022 up:: Up("SC022", 1)
+SC023 up:: Up("SC023", 1)
+SC024 up:: Up("SC024", 1)
+SC025 up:: Up("SC025", 1)
+SC026 up:: Up("SC026", 1)
+SC027 up:: Up("SC027", 1)
+SC028 up:: Up("SC028", 1)
;bottom letters row
+SC02C up:: Up("SC02C", 1)
+SC02D up:: Up("SC02D", 1)
+SC02E up:: Up("SC02E", 1)
+SC02F up:: Up("SC02F", 1)
+SC030 up:: Up("SC030", 1)
+SC031 up:: Up("SC031", 1)
+SC032 up:: Up("SC032", 1)
+SC033 up:: Up("SC033", 1)
+SC034 up:: Up("SC034", 1)
+SC035 up:: Up("SC035", 1)

;top letters row
!SC010 up:: Up("SC010", , 1)
!SC011 up:: Up("SC011", , 1)
!SC012 up:: Up("SC012", , 1)
!SC013 up:: Up("SC013", , 1)
!SC014 up:: Up("SC014", , 1)
!SC015 up:: Up("SC015", , 1)
!SC018 up:: Up("SC018", , 1)
!SC019 up:: Up("SC019", , 1)
!SC01A up:: Up("SC01A", , 1)
!SC01B up:: Up("SC01B", , 1)
;home letters row
!SC01E up:: Up("SC01E", , 1)
!SC01F up:: Up("SC01F", , 1)
!SC020 up:: Up("SC020", , 1)
!SC021 up:: Up("SC021", , 1)
!SC022 up:: Up("SC022", , 1)
!SC027 up:: Up("SC027", , 1)
!SC028 up:: Up("SC028", , 1)
;bottom letters row
!SC02C up:: Up("SC02C", , 1)
!SC02D up:: Up("SC02D", , 1)
!SC02E up:: Up("SC02E", , 1)
!SC02F up:: Up("SC02F", , 1)
!SC030 up:: Up("SC030", , 1)
!SC031 up:: Up("SC031", , 1)
!SC034 up:: Up("SC034", , 1)
!SC035 up:: Up("SC035", , 1)

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
    SendInput, {Space}
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
        SendInput, +{Space}{Shift up}
    }
    Else
    {
        SendInput, {Space}{Shift up}
    }
    Return


;===============================================================================================
;===========================================Disabled keys=======================================
;===============================================================================================

#If !NUMPAD && !DISABLED && !WinActive("ahk_group BlackList")

;arrows up/left/right/down
    *SC148::
    *SC14B::
    *SC14D::
    *SC150::
        Return

;delete
    *SC153::
        Return

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
