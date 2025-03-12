;===============================================================================================
;============================================Presets============================================
;===============================================================================================

#SingleInstance Force
#UseHook True
#Include user_functions.ahk
SendMode "Input"

EXT := A_IsCompiled ? ".exe" : ".ahk"
USER_ASSIGNMENTS := Map()
CONF := Map()

_GetConfig(name, initial:=0)
{
    Try
    {
        Try
            Return Integer(IniRead("config.ini", "Configuration", name))
        Catch
            Return IniRead("config.ini", "Configuration", name)
    }
    Catch
    {
        IniWrite(initial, "config.ini", "Configuration", name)
        Return initial
    }
}

LONG_PRESS_TIME := _GetConfig("LongPressTime", "T0.15")
LAT_LAYOUT := _GetConfig("LatLayout")
CYR_LAYOUT := _GetConfig("CyrLayout")
For name in ["LatinMode", "CyrillicMode", "CombinedView", "DotlessISwap", "RomCedillaToComma", "UnbrSpace", "EscAsCaps"]
    CONF[name] := _GetConfig(name, 1)
For name in ["BlackListSendMode", "Disabled", "ControllingKeys", "NumrowReverse"
    , "BothShiftsAsEsc", "PairedBrackets", "NumPad"]
    CONF[name] := _GetConfig(name)  ; initial 0

menu_path := _GetConfig("MenuPath", "c:\menu\")  ; https://github.com/uqqu/menu
viatc_file := _GetConfig("ViatcFile", "c:\ViATc\ViATc.ahk")  ; https://github.com/magicstep/ViATc-English

Try
    IniRead("config.ini", "AdditionalAssignments")
Catch
    FileAppend("`n[AdditionalAssignments]"
        .
        "`n;['+'_shift_modifier]scan_code:layout_decimal_code_or_'1'_for_any=symbol[s]"
        . "_or_function_'F(<func>(<params>))'"
        . "`n;you can define your own functions on the user_functions.ahk file"
        . "`n;assignments works only for letter region and numrow with tilde"
        . "`n;symbols can be sended by their unicode values as '{U+code}'"
        . "`n;SC002:1=0`n;SC003:1=1`n;SC004:1=2`n;SC005:1=3`n;SC006:1=4"
        . "`n;SC007:1=5`n;SC008:1=6`n;SC009:1=7`n;SC00A:1=8`n;SC00B:1=9"
        . "`nSC00C:1=F(Decr())`nSC00D:1=F(Incr())`nSC029:1=F(LongOnce())"
        . "`n`n[AltApps]`n;scan_code=process_name.exe,program_pathname.exe"
        . "`n`n[BlackList]`n;whatever=process_name.exe`n", "config.ini")

;additional assignments set
For str in StrSplit(IniRead("config.ini", "AdditionalAssignments"), "`n")
{
    ; key:lang=symb[s]
    pair := StrSplit(str, "=")
    values := StrSplit(pair[1], ":")
    Try
        USER_ASSIGNMENTS[values[1]][Integer(values[2])] := pair[2]
    Catch
        USER_ASSIGNMENTS[values[1]] := Map(Integer(values[2]), pair[2])
}

;let ViATc override hotkeys (only for TC)
Try Run(viatc_file)

;let menu override ViATc
Try Run(menu_path . "menu" . EXT, menu_path)

;black-list apps (in which qPhyx switch to disabled state)
For pair in StrSplit(IniRead("config.ini", "BlackList"), "`n")
    GroupAdd("BlackList", "ahk_exe " . StrSplit(pair, "=")[2])

SetCapsLockState(CONF["ControllingKeys"] && !CONF["EscAsCaps"] ? "AlwaysOff" : False)

;read correct spotify process (if exists) for the proper swap between apps
SPOTIFY := 0
_SpotifyDetectProcessId()


;===============================================================================================
;=====================================Symbol assignments========================================
;===============================================================================================

;num row
; scan_code := ["releasing", "sended", "alt", "alt_long",
;               "lat_mode_lower", "lat_mode_upper", "cyr_mode_lower", "cyr_mode_upper"]
SC002 := [0, 0, "̃", "̧", "", "", "", ""]  ; tilde; cedilla
SC003 := [0, 0, "̊", "̥", "", "", "", ""]  ; ring above; ring below
SC004 := [0, 0, "̈", "̤", "", "", "", ""]  ; diaeresis above; diaeresis below
SC005 := [0, 0, "̇", "̣", "", "", "", ""]  ; dot above; dot below
SC006 := [0, 0, "̆", "̮", "", "", "", ""]  ; breve above; breve below
SC007 := [0, 0, "̄", "̱", "", "", "", ""]  ; macron above; macron below
SC008 := [0, 0, "̂", "̭", "", "", "", ""]  ; circumflex above; circumflex below
SC009 := [0, 0, "̌", "̦", "", "", "", ""]  ; caron; comma
SC00A := [0, 0, "͗", "̳", "", "", "", ""]  ; right half ring above; double low line
SC00B := [0, 0, "̉", "̨", "", "", "", ""]  ; hook; ogonek
SC00C := [0, 0, "̋", "✓", "", "", "", ""]  ; double acute
SC00D := [0, 0, "̛", "✕", "", "", "", ""]  ; horn

;letter region
; scan_code := ["releasing", "sended", "long", "alt", "alt_long"]
;;top row
SC010 := [0, 0, "{Text}~", "{Text}°", "{Text}¬"]
SC011 := [0, 0, "{Text}–", "{Text}—", "{Text}²"]
SC012 := [0, 0, "{Text}'", "{Text}’", "{Text}³"]
SC013 := [0, 0, "{Text}\", "{Text}&", "{Text}π"]
SC014 := [0, 0, "{Text}@", "{Text}§", "{Text}∑"]
SC015 := [0, 0, "{Text}<", "{Text}«", "{Text}‰"]
SC016 := [0, 0, "{Text}(", "{SC16A}", ""       ]  ; alt – back
SC017 := [0, 0, "{Text}[", "{SC169}", ""       ]  ; alt - forward
SC018 := [0, 0, "{Text}{", "{Text}“", "{Text}∞"]
SC019 := [0, 0, "{Text}!", "{Text}¡", "{Text}‽"]
SC01A := [0, 0, "{Text}#", "{Text}№", "{Text}※"]
SC01B := [0, 0, "́"       , "̀"       , "{Text}♡"]  ; long – comb. acute; alt – comb. grave
;;home row
SC01E := [0, 0, "{Text}+", "{Text}±", "{Text}½"]
SC01F := [0, 0, "{Text}-", "{Text}−", "{Text}⅓"]
SC020 := [0, 0, "{Text}*", "{Text}×", "{Text}¼"]
SC021 := [0, 0, "{Text}/", "{Text}÷", "{Text}⅔"]
SC022 := [0, 0, "{Text}=", "{Text}≠", "{Text}¾"]
SC023 := [0, 0, "{Text}%", ""       , ""       ]  ; alt - left
SC024 := [0, 0, '{Text}"', ""       , ""       ]  ; alt - down
SC025 := [0, 0, "{Text}.", ""       , ""       ]  ; alt - up
SC026 := [0, 0, "{Text},", ""       , ""       ]  ; alt - right
SC027 := [0, 0, "{Text}:", "{Text}^", "{Text}•"]
SC028 := [0, 0, "{Text};", "{Text}``","{Text}…"]
;;bottom row
SC02C := [0, 0, "{Text}$", "{Text}¢", "{Text}₿"]
SC02D := [0, 0, "{Text}€", "{Text}£", "{Text}₱"]
SC02E := [0, 0, "{Text}₽", "{Text}¥", "{Text}¤"]
SC02F := [0, 0, "{Text}_", "{Text}|", "{Text}©"]
SC030 := [0, 0, "{Text}≈", "{Text}≟", "{Text}®"]
SC031 := [0, 0, "{Text}>", "{Text}»", "{Text}™"]
SC032 := [0, 0, "{Text})", "^{SC02C}",""       ]  ; alt - undo
SC033 := [0, 0, "{Text}]", "^{SC015}",""       ]  ; alt - redo
SC034 := [0, 0, "{Text}}", "{Text}”", "{Text}∵"]
SC035 := [0, 0, "{Text}?", "{Text}¿", "{Text}∴"]

;language modes read
LAT_MODE_LIST := []
CYR_MODE_LIST := []
For section in StrSplit(IniRead("modes.ini"), "`n")
{
    keys := Map("name", IniRead("modes.ini", section, "name"))
    Loop 12
    {
        scan_code := "SC00" Format("{:X}", A_Index+1)
        keys[scan_code] := StrSplit(IniRead("modes.ini", section, scan_code), ",")
    }
    SubStr(section, 1, 3) == "Lat" ? LAT_MODE_LIST.Push(keys) : CYR_MODE_LIST.Push(keys)
}

;set chosen language modes (shift and shift-long layers on the num row)
For i, script in [LAT_MODE_LIST[CONF["LatinMode"]], CYR_MODE_LIST[CONF["CyrillicMode"]]]
{
    Loop 12
    {
        scan_code := "SC00" Format("{:X}", A_Index+1)
        %scan_code%[5+(i-1)*2] := script[scan_code][1+CONF["CombinedView"]*2]
        %scan_code%[6+(i-1)*2] := script[scan_code][2+CONF["CombinedView"]*2]
    }
}

;Turkish and Turkic mode feature: default i = dotted i (iİ); num-row i <sh-long-8> = dotless i (ıI)
;stay calm with third-party bindings. <Sh-i> will be detect as I. Diacr. dot will be added after
If CONF["DotlessISwap"] && (CONF["LatinMode"] == 2 || CONF["LatinMode"] == 11)
    SC009[6] := "I"
Else
    CONF["DotlessISwap"] := 0

;paste comma instead of the cedilla for the chosen romanian mode
;https://en.wikipedia.org/wiki/Romanian_alphabet#Comma-below_(ș_and_ț)_versus_cedilla_(ş_and_ţ)
;this also influences to the cyrillic layout (only with selected Romanian mode)
If CONF["RomCedillaToComma"] && CONF["LatinMode"] == 6
    SC002[4] := "̦"

;autopaste closing brackets
If CONF["PairedBrackets"]
{
    SC015[3] := "<>{Left}"
    SC015[4] := "«»{Left}"
    SC016[3] := "(){Left}"
    SC017[3] := "[]{Left}"
    SC018[3] := "{{}{}}{Left}"
    SC018[4] := "“”{Left}"
    SC024[3] := "`"`"{Left}"
}

;switch between alt apps with <LWin+key>
For str in StrSplit(IniRead("config.ini", "AltApps"), "`n")
{
    pair := StrSplit(str, "=")
    values := StrSplit(pair[2], ",")
    Hotkey("LWin & " . pair[1], Alt.Bind(values[1], values[2]))
}


;===============================================================================================
;================================================Tray menu======================================
;===============================================================================================

LAT_MODES := Menu()
CYR_MODES := Menu()
SUB_SETTINGS := Menu()
SUB_BLSM := Menu()

Try TraySetIcon(CONF["Disabled"] ? "disabled.ico" : "qphyx.ico")
A_IconTip := "qPhyx" . EXT . " – " . (CONF["Disabled"] ? "disabled" : "enabled")

A_TrayMenu.Delete()
A_TrayMenu.Add("qPhyx", CheatsheetToggle)
A_TrayMenu.Disable("qPhyx")
A_TrayMenu.Default := "qPhyx"
A_TrayMenu.ClickCount := 1

For mode in LAT_MODE_LIST
    LAT_MODES.Add(mode["name"], LatModeChange)
For mode in CYR_MODE_LIST
    CYR_MODES.Add(mode["name"], CyrModeChange)

LAT_MODES.Check(LAT_MODE_LIST[CONF["LatinMode"]]["name"])
CYR_MODES.Check(CYR_MODE_LIST[CONF["CyrillicMode"]]["name"])
A_TrayMenu.Add("Change &latin mode", LAT_MODES)
A_TrayMenu.Add("Change &cyrillic mode", CYR_MODES)

_AddOption(text, var, before?)
{
    Try
        SUB_SETTINGS.Insert(before, text, %var . "Toggle"%)
    Catch
        SUB_SETTINGS.Add(text, %var . "Toggle"%)
    If CONF[var]
        SUB_SETTINGS.Check(text)
}

_AddOption("Preferably combined &view for lang mode symbols", "CombinedView")
_AddOption("Toggle controlling &keys remap", "ControllingKeys")
_AddOption("Toggle n&umrow reverse (normal and shift presses for lang.mode; long for numbers)", "NumrowReverse")
_AddOption("Toggle 'b&oth shifts as esc' feature", "BothShiftsAsEsc")

If CONF["LatinMode"] == 2 || CONF["LatinMode"] == 11
    _AddOption("Toggle 'dotless &i' feature", "DotlessISwap")

If CONF["LatinMode"] == 6
    _AddOption("Toggle 'Romanian &cedilla to comma' feature", "RomCedillaToComma")

_AddOption("Toggle '&paired brackets' feature", "PairedBrackets")
_AddOption("Toggle 'no-&break Space' on Sh-Space", "UnbrSpace")
_AddOption("Toggle '&Esc as Caps Lock' feature", "EscAsCaps")
_AddOption("Toggle &NumPad availability", "NumPad")

BLSM_TEXTS := ["Default (SendInput)", "DllCall(keybd_event)", "PostMessage"]
For text in BLSM_TEXTS
    SUB_BLSM.Add(text, BlackListSendModeChange)
SUB_BLSM.Check(BLSM_TEXTS[CONF["BlackListSendMode"] + 1])

SUB_SETTINGS.Add("BlackList &Send Mode", SUB_BLSM)

A_TrayMenu.Add("&Other settings", SUB_SETTINGS)
A_TrayMenu.Add("Long press &delay (now is " . SubStr(LONG_PRESS_TIME, 2) . "s)", LongPressTimeChange)
A_TrayMenu.Add((CONF["Disabled"] ? "En" : "Dis") . "a&ble qPhyx", DisabledToggle)
A_TrayMenu.Add("&Help cheatsheet", CheatsheetToggle)
A_TrayMenu.Add("&Exit", CallExit)


;===============================================================================================
;=============================================GUI cheatsheet====================================
;===============================================================================================

SCAN_CODES := ["SC029","SC002","SC003","SC004","SC005","SC006","SC007","SC008","SC009"
    ,  "SC00A","SC00B","SC00C","SC00D","SC00E","SC00F","SC010","SC011","SC012","SC013","SC014"
    ,  "SC015","SC016","SC017","SC018","SC019","SC01A","SC01B","SC02B","SC03A","SC01E","SC01F"
    ,  "SC020","SC021","SC022","SC023","SC024","SC025","SC026","SC027","SC028","SC01C","SC02A"
    ,  "SC02C","SC02D","SC02E","SC02F","SC030","SC031","SC032","SC033","SC034","SC035","SC136"]

MY_GUI := Gui("-Border -Caption")
close_button := MY_GUI.AddButton("x695 y0 w20 h20 -Tabstop", "✕")
close_button.OnEvent("Click", CheatsheetToggle)
LAT_LAYOUT_BUTTON := MY_GUI.AddButton("x381 y0 w150 h20 -Tabstop", "Latin layout: "
    . (LAT_LAYOUT ? LAT_LAYOUT : "unset"))
CYR_LAYOUT_BUTTON := MY_GUI.AddButton("x531 y0 w150 h20 -Tabstop", "Cyrillic layout: "
    . (CYR_LAYOUT ? CYR_LAYOUT : "unset"))
LAT_LAYOUT_BUTTON.OnEvent("Click", ChangeLatLayout)
CYR_LAYOUT_BUTTON.OnEvent("Click", ChangeCyrLayout)
TABS := MY_GUI.AddTab3("w720 h185 x0 y-1 -Tabstop"
    , ["Base", "Long", "Alt", "Alt long", "Scan codes", "Lang. modes", "Hotkeys"])
BUTTONS := Map()
MY_GUI.SetFont("s11", "Calibri")

_NewButton(i, oi, x:=0, y:=20, w:=50, h:=40)
{
    BUTTONS[SCAN_CODES[i] . oi] := MY_GUI.AddButton("x" . x . " y" . y . " w" . w . " h" . h . " -Tabstop")
}

Loop 5
{
    TABS.UseTab(A_Index)
    _NewButton(1, A_Index)
    outer_ind := A_Index
    Loop 12
        _NewButton(A_Index+1, outer_ind, A_Index*50, , , (outer_ind > 2) ? 40 : 20)

    If outer_ind < 3
    {
        Loop 12
        {
            sc := "SC00" . Format("{:X}", A_Index+1)
            BUTTONS[A_Index . outer_ind] := MY_GUI.AddButton("x" . A_Index*50 . " y40 w50 h20"
                . " -Tabstop", %sc%[5] . " " . %sc%[7])
        }
    }
    _NewButton(14, outer_ind, 650, , 65)
    _NewButton(15, outer_ind, , 60, 65)
    Loop 13
        _NewButton(A_Index+15, outer_ind, A_Index*50+15, 60)
    _NewButton(29, outer_ind, , 100, 80)
    Loop 11
        _NewButton(A_Index+29, outer_ind, A_Index*50+30, 100)
    _NewButton(41, outer_ind, 630, 100, 85)
    _NewButton(42, outer_ind, , 140, 100)
    Loop 10
        _NewButton(A_Index+42, outer_ind, A_Index*50+50, 140)
    _NewButton(53, outer_ind, 600, 140, 115)
}

OnMessage(0x100, GuiKeyPress)
OnMessage(0x104, GuiKeyPress)

_GuiFillValues()

TABS.UseTab(6)
LANG_MODES := MY_GUI.AddListView("r19 w716 h165 x-1 y18 LV3"
        , ["", "№", "Group", "Mode", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "+1", "+2"])
LANG_MODES.OnEvent("DoubleClick", LangDoubleClick)
For i, script in [["Latin", LAT_MODE_LIST], ["Cyrillic", CYR_MODE_LIST]]
{
    For mode_ind, values in script[2]
    {
        chosen := ""
        If mode_ind == CONF["LatinMode"] && i == 1 || mode_ind == CONF["CyrillicMode"] && i == 2
            chosen := "✓"
        symbs := []
        For key, symbol in values
            If key !== "name"
                symbs.Push(symbol[3])
        LANG_MODES.Add(, chosen, mode_ind, script[1], StrReplace(values["name"], "&"), symbs*)
    }
}
LANG_MODES.ModifyCol()  ; adjust width
LANG_MODES.ModifyCol(1, "Desc")
LANG_MODES.ModifyCol(2, "Integer AutoHdr Center")
LANG_MODES.ModifyCol(3, "Desc")
LANG_MODES.ModifyCol(4, 285)
Loop 12
    LANG_MODES.ModifyCol(A_Index+4, "AutoHdr Center")

TABS.UseTab(7)
hotkeys := MY_GUI.AddListView("r19 w716 h165 x-1 y18 LV3", ["Item", "Hotkey"])
hotkeys.Add(, "Toggle this gui", "Alt+F1")
hotkeys.Add(, "GUI tab navigation", "F1-F7")
hotkeys.Add(, "Show tray menu", "LWin+F1")
hotkeys.Add(, "Enable/disable qPhyx functionality", "Shift+Tilde")
hotkeys.Add(, "Restart qPhyx", "Ctrl+Shift+Tilde")
hotkeys.Add(, "Clipboard swap", "Ctrl+Shift+v")
hotkeys.Add(, "Minimize all windows", "LWin+Enter")
hotkeys.Add(, "Restore windows state", "LWin+LongEnter")
hotkeys.Add(, "Non-break space", "Shift+Space")
hotkeys.Add(, "Lowercase lang mode symbol", "Shift+<num>")
hotkeys.Add(, "Uppercase lang mode symbol", "Shift+Long<num>")
hotkeys.Add(, "Begin of line ('home' key)", "Alt+Ctrl+j")
hotkeys.Add(, "End of line ('end' key)", "Alt+Ctrl+k")
hotkeys.Add(, "Move window left/right", "LWin+(h/l)")
hotkeys.Add(, "Move window to the left/right screen", "LWin+Shift+(h/l)")
hotkeys.Add(, "Maximize/minimize window", "LWin(+Shift)+(j/k)")
hotkeys.Add(, "Media play/pause", "Backspace")
hotkeys.Add(, "Volume up", "Shift+Backspace")
hotkeys.Add(, "Volume down", "Alt+Backspace")
hotkeys.Add(, "Next media", "Shift+LongBackspace")
hotkeys.Add(, "Previous media", "Alt+LongBackspace")
hotkeys.Add(, "<Delete>", "Shift+Enter")
hotkeys.Add(, "<Esc>", "LShift+RShift")

hotkeys.ModifyCol()  ; adjust width

Return


;===============================================================================================
;=========================================Main layout functions=================================
;===============================================================================================

SendKbd(scancode, modifiers:="", amodifiers:="", rmodifiers:="")
{
    ; TODO PostMessage with modifiers
    Static mods := Map("+", 0x10, "^", 0x11, "!", 0x12, "#", 0x5B)
    Static key_down := [
        (vk_code) => DllCall("keybd_event", "UInt", vk_code, "UInt", 0, "UInt", 0, "UPtr", 0),
        (vk_code) => PostMessage(0x100, vk_code, 0, , "A")
    ]
    Static key_up := [
        (vk_code) => DllCall("keybd_event", "UInt", vk_code, "UInt", 0, "UInt", 2, "UPtr", 0),
        (vk_code) => PostMessage(0x101, vk_code, 0, , "A")
    ]

    If !CONF["BlackListSendMode"] || !WinActive("ahk_group BlackList")
    {
        Send((modifiers ? modifiers . "{" : "{") . scancode . "}")
        Return
    }

    Loop Parse, modifiers
        key_down[CONF["BlackListSendMode"]].Call(mods[A_LoopField])
    Loop Parse, amodifiers
        key_up[CONF["BlackListSendMode"]].Call(mods[A_LoopField])
    CONF["Disabled"] := !CONF["Disabled"]
    key_down[CONF["BlackListSendMode"]].Call(_GetKeyVK(scancode))
    CONF["Disabled"] := !CONF["Disabled"]
    Loop Parse, amodifiers
        key_down[CONF["BlackListSendMode"]].Call(mods[A_LoopField])
    Loop Parse, rmodifiers
        key_up[CONF["BlackListSendMode"]].Call(mods[A_LoopField])
}

UserDefined(this, upper:=0)
{
    If upper
        this := "+" . this

    If !USER_ASSIGNMENTS.Has(this)
        Return False

    If USER_ASSIGNMENTS[this].Has(1)
    {
        val := USER_ASSIGNMENTS[this][1]
    }
    Else
    {
        lang := _GetCurrentLang()
        If USER_ASSIGNMENTS[this].Has(lang)
            val := USER_ASSIGNMENTS[this][lang]
        Else
            Return False
    }

    If RegExMatch(val, "F\((\w+)\((.*)\)\)", &m)
        If m[2]
            %m[1]%.Call(m[2])
        Else
            %m[1]%.Call()
    Else
        Send(val)
    Return True
}

;num row interaction
DownNum(this, shift:=False, alt:=False)
{
    If TREAT_ONCE_AS_LONG
    {
        %this%[1] := 1
        Global TREAT_ONCE_AS_LONG
        TREAT_ONCE_AS_LONG := False
    }
    Else
    {
        If !shift && !alt && !CONF["NumrowReverse"]
        {
            If !UserDefined(this)
                SendKbd(this)
            Return
        }
        If %this%[1]
            Return
        %this%[1] := 1
        If KeyWait(this, LONG_PRESS_TIME)
            Return
    }

    %this%[2] := 1
    If alt
    {
        Send(%this%[4])
        Return
    }
    Else If CONF["NumrowReverse"]
    {
        If !UserDefined(this, shift)
            SendKbd(this)
        Return
    }
    caps_lock := GetKeyState("CapsLock", "T")
    lang := _GetCurrentLang()
    If lang == LAT_LAYOUT
        Send(%this%[6-caps_lock])
    Else If lang == CYR_LAYOUT
        Send(%this%[8-caps_lock])
}

UpNum(this, shift:=False, alt:=False)
{
    If %this%[1] && !%this%[2]
    {
        If alt
        {
            Send(%this%[3])
        }
        Else If shift || CONF["NumrowReverse"]
        {
            upper := GetKeyState("CapsLock", "T") ^ shift * CONF["NumrowReverse"]
            lang := _GetCurrentLang()
            If lang == LAT_LAYOUT
                Send(%this%[5+upper])
            Else If lang == CYR_LAYOUT
                Send(%this%[7+upper])
        }
    }
    %this%[1] := 0
    %this%[2] := 0
}

;letter rows interaction
Down(this, shift:=False, alt:=False)
{
    If TREAT_ONCE_AS_LONG
    {
        %this%[1] := 1
        Global TREAT_ONCE_AS_LONG
        TREAT_ONCE_AS_LONG := False
    }
    Else
    {
        If WinActive("ahk_group BlackList")
        {
            If alt
                Send(%this%[4])
            Else
                SendKbd(this, (shift ? "+" : ""))
            Return
        }

        If %this%[1]
            Return
        %this%[1] := 1
        If %this%[2] || KeyWait(this, LONG_PRESS_TIME)
            Return
    }

    %this%[2] := 1
    Send(%this%[alt ? 5 : 3])
}

Up(this, shift:=False, alt:=False)
{
    Loop
    {
        If !%this%[1] || %this%[2]
            Break
        If alt
        {
            Send(%this%[4])
            Break
        }
        upper := shift ^ GetKeyState("CapsLock", "T")

        If UserDefined(this, upper)
            Break

        ;dotted/dotless I feature
        If upper && CONF["DotlessISwap"] && GetKeyName(this) == "i" && _GetCurrentLang() == LAT_LAYOUT
        {
            Send(CONF["CombinedView"] ? "İ" : "İ")
            Break
        }

        ;send default
        SendKbd(this, (upper ? "+" : ""))
        Break
    }
    %this%[1] := 0
    %this%[2] := 0
}


;===============================================================================================
;=====================================Additional layout functions===============================
;===============================================================================================

;swap between opened predefined apps
Alt(proc_name, path, *)
{
    proc := (proc_name == "Spotify.exe" && SPOTIFY) ? "ahk_id " . SPOTIFY : "ahk_exe " . proc_name
    Try
    {
        title := WinGetTitle(proc)
        If WinActive(title)
            WinMinimize(title)
        Else
            WinActivate(title)
    }
    Catch
    {
        Run(path)
    }
}

;auxiliary to "#+SC025" restore
LastMinimizedWindow()
{
    For id in WinGetList()
        If WinGetMinMax("ahk_id" . id) == -1
            Return(id)
}


;===============================================================================================
;===============================================Menu functions==================================
;===============================================================================================

DisabledToggle(*)
{
    CONF["Disabled"] := !CONF["Disabled"]
    IniWrite(CONF["Disabled"], "config.ini", "Configuration", "Disabled")
    Try TraySetIcon(CONF["Disabled"] ? "disabled.ico" : "qphyx.ico")
    A_IconTip := "qPhyx" . EXT . " – " . (CONF["Disabled"] ? "disabled" : "enabled")
    w := ["Dis", "En"]
    A_TrayMenu.Rename(w[!CONF["Disabled"]+1] . "a&ble qPhyx", w[CONF["Disabled"]+1] . "a&ble qPhyx")
}

LongPressTimeChange(*)
{
    Global LONG_PRESS_TIME
    user_input := InputBox("New value in seconds (e.g. 0.15)", "Set new long press delay", "w444 h130")
    If user_input.Result !== "OK"
        Return
    If !IsNumber(user_input.Value)
    {
        user_input := MsgBox("Incorrect value", "The input must be a number!", 53)
        If user_input == "Retry"
            LongPressTimeChange()
        Return
    }
    old_value := SubStr(LONG_PRESS_TIME, 2)
    LONG_PRESS_TIME := "T" . user_input.Value
    IniWrite(LONG_PRESS_TIME, "config.ini", "Configuration", "LongPressTime")
    A_TrayMenu.Rename("Long press &delay (now is " . old_value . "s)"
        , "Long press &delay (now is " . user_input.Value . "s)")
}

BlackListSendModeChange(_, item_pos, *)
{
    SUB_BLSM.Uncheck(BLSM_TEXTS[CONF["BlackListSendMode"] + 1])
    CONF["BlackListSendMode"] := item_pos - 1
    IniWrite(CONF["BlackListSendMode"], "config.ini", "Configuration", "BlackListSendMode")
    SUB_BLSM.Check(BLSM_TEXTS[item_pos])
}

LatModeChange(_, item_pos, *)
{
    Loop 12
    {
        scan_code := "SC00" Format("{:X}", A_Index+1)
        %scan_code%[5] := LAT_MODE_LIST[item_pos][scan_code][1+CONF["CombinedView"]*2]
        %scan_code%[6] := LAT_MODE_LIST[item_pos][scan_code][2+CONF["CombinedView"]*2]
    }
    IniWrite(item_pos, "config.ini", "Configuration", "LatinMode")
    LAT_MODES.Uncheck(LAT_MODE_LIST[CONF["LatinMode"]]["name"])
    LAT_MODES.Check(LAT_MODE_LIST[item_pos]["name"])
    Loop 12
    {
        scan_code := "SC00" Format("{:X}", A_Index+1)
        i := A_Index
        Loop 2
        {
            BUTTONS[i . A_Index].Text := LAT_MODE_LIST[item_pos][scan_code][3] . " "
                    . CYR_MODE_LIST[CONF["CyrillicMode"]][scan_code][3]
        }
    }
    LANG_MODES.Modify(CONF["LatinMode"], , "")
    LANG_MODES.Modify(item_pos, , "✓")

    ;switch to non Turkic mode
    If item_pos !== 2 && item_pos !== 11
    {
        CONF["DotlessISwap"] := 0
        Try SUB_SETTINGS.Delete("Toggle 'dotless &i' feature")
    }
    ;to Turkic
    Else
    {
        CONF["DotlessISwap"] := IniRead("config.ini", "Configuration", "DotlessISwap", 1)
        ;…from non Turkic
        If CONF["LatinMode"] !== 2 && CONF["LatinMode"] !== 11
            _AddOption("Toggle 'dotless &i' feature", "DotlessISwap", "Toggle '&paired brackets' feature")
        If CONF["DotlessISwap"]
            SC009[6] := "I"
    }

    ;switch to non Romanian
    If item_pos !== 6
    {
        Try
        {
            SUB_SETTINGS.Delete("Toggle 'romanian &cedilla to comma' feature")
            SC002[4] := "̧"
        }
    }
    ;to Romanian
    Else If CONF["LatinMode"] !== 6
    {
        _AddOption("Toggle 'Romanian &cedilla to comma' feature", "RomCedillaToComma"
            , "Toggle '&paired brackets' feature")
        If CONF["RomCedillaToComma"]
            SC002[4] := "̦"
    }

    CONF["LatinMode"] := item_pos
}

CyrModeChange(_, item_pos, *)
{
    IniWrite(item_pos, "config.ini", "Configuration", "CyrillicMode")
    CYR_MODES.Uncheck(CYR_MODE_LIST[CONF["CyrillicMode"]]["name"])
    CYR_MODES.Check(CYR_MODE_LIST[item_pos]["name"])
    Loop 12
    {
        scan_code := "SC00" Format("{:X}", A_Index+1)
        i := A_Index
        Loop 2
        {
            BUTTONS[i . A_Index].Text := LAT_MODE_LIST[CONF["LatinMode"]][scan_code][3] . " "
                    . CYR_MODE_LIST[item_pos][scan_code][3]
        }
    }
    lat_len := LAT_MODE_LIST.Length
    LANG_MODES.Modify(lat_len + CONF["CyrillicMode"], , "")
    LANG_MODES.Modify(lat_len + item_pos, , "✓")
    CONF["CyrillicMode"] := item_pos
    Loop 12
    {
        scan_code := "SC00" Format("{:X}", A_Index+1)
        %scan_code%[7] := CYR_MODE_LIST[item_pos][scan_code][1+CONF["CombinedView"]*2]
        %scan_code%[8] := CYR_MODE_LIST[item_pos][scan_code][2+CONF["CombinedView"]*2]
    }
}

ChangeLatLayout(*)
{
    Global LAT_LAYOUT
    MsgBox("Switch to your latin layout and press OK")
    lang := _GetCurrentLang()
    IniWrite(lang, "config.ini", "Configuration", "LatLayout")
    LAT_LAYOUT_BUTTON.Text := "Latin layout: " . lang
    LAT_LAYOUT := lang
}

ChangeCyrLayout(*)
{
    Global CYR_LAYOUT
    MsgBox("Switch to your cyrillic layout and press OK")
    lang := _GetCurrentLang()
    IniWrite(lang, "config.ini", "Configuration", "CyrLayout")
    CYR_LAYOUT_BUTTON.Text := "Cyrillic layout: " . lang
    CYR_LAYOUT := lang
}

_ToggleOption(opt, name)
{
    CONF[opt] := !CONF[opt]
    IniWrite(CONF[opt], "config.ini", "Configuration", opt)
    If CONF[opt]
        SUB_SETTINGS.Check(name)
    Else
        SUB_SETTINGS.Uncheck(name)
}

CombinedViewToggle(*)
{
    _ToggleOption("CombinedView", "Preferably combined &view for lang mode symbols")
    LatModeChange("", CONF["LatinMode"])
    CyrModeChange("", CONF["CyrillicMode"])
}

ControllingKeysToggle(*)
{
    _ToggleOption("ControllingKeys", "Toggle controlling &keys remap")
    SetCapsLockState(CONF["ControllingKeys"] && !CONF["EscAsCaps"] ? "AlwaysOff" : False)
    keys := CONF["ControllingKeys"] ? ["Esc", "Media", "Enter", "Backspace"] : ["Tilde", "BS", "Caps Lock", "Enter"]
    Loop 4
    {
        BUTTONS["SC029" . A_Index].Text := keys[1]
        BUTTONS["SC00E" . A_Index].Text := keys[2]
        BUTTONS["SC03A" . A_Index].Text := keys[3]
        BUTTONS["SC01C" . A_Index].Text := keys[4]
    }
}

NumrowReverseToggle(*)
{
    _ToggleOption("NumrowReverse", "Toggle n&umrow reverse (normal and shift presses for lang.mode; long for numbers)")
}

BothShiftsAsEscToggle(*)
{
    _ToggleOption("BothShiftsAsEsc", "Toggle 'b&oth shifts as esc' feature")
}

DotlessISwapToggle(*)
{
    _ToggleOption("DotlessISwap", "Toggle 'dotless &i' feature")
    If CONF["DotlessISwap"]
        SC009[6] := "I"
    Else
        SC009[6] := LAT_MODE_LIST[CONF["LatinMode"]]["SC009"][2+CONF["CombinedView"]*2]
}

RomCedillaToCommaToggle(*)
{
    _ToggleOption("RomCedillaToComma", "Toggle 'romanian &cedilla to comma' feature")
    If CONF["LatinMode"] == 6 && CONF["RomCedillaToComma"]
        SC002[4] := "̦"
    Else
        SC002[4] := "̧"
}

PairedBracketsToggle(*)
{
    _ToggleOption("PairedBrackets", "Toggle '&paired brackets' feature")
    If CONF["PairedBrackets"]
    {
        SC015[3] := "<>{Left}"
        SC016[3] := "(){Left}"
        SC017[3] := "[]{Left}"
        SC018[3] := "{{}{}}{Left}"
        SC024[3] := "`"`"{Left}"
        SC015[4] := "«»{Left}"
        SC018[4] := "“”{Left}"
        BUTTONS["SC0152"].Text := "<>"
        BUTTONS["SC0162"].Text := "()"
        BUTTONS["SC0172"].Text := "[]"
        BUTTONS["SC0182"].Text := "{}"
        BUTTONS["SC0242"].Text := "`"`""
        BUTTONS["SC0153"].Text := "«»"
        BUTTONS["SC0183"].Text := "“”"
    }
    Else
    {
        SC015[3] := "{Text}<"
        SC016[3] := "{Text}("
        SC017[3] := "{Text}["
        SC018[3] := "{Text}{"
        SC024[3] := "{Text}`""
        SC015[4] := "{Text}«"
        SC018[4] := "{Text}“"
        BUTTONS["SC0152"].Text := "<"
        BUTTONS["SC0162"].Text := "("
        BUTTONS["SC0172"].Text := "["
        BUTTONS["SC0182"].Text := "{"
        BUTTONS["SC0242"].Text := "`""
        BUTTONS["SC0153"].Text := "«"
        BUTTONS["SC0183"].Text := "“"
    }
}

UnbrSpaceToggle(*)
{
    _ToggleOption("UnbrSpace", "Toggle 'no-&break Space' on Sh-Space")
}

EscAsCapsToggle(*)
{
    _ToggleOption("EscAsCaps", "Toggle '&Esc as Caps Lock' feature")
    SetCapsLockState(CONF["ControllingKeys"] && !CONF["EscAsCaps"] ? "AlwaysOff" : False)
}

NumPadToggle(*)
{
    _ToggleOption("NumPad", "Toggle &NumPad availability")
}

;===============================================================================================
;================================================Auxiliary======================================
;===============================================================================================

_GetKeyVK(scancode)
{
    Static cached_vk := Map()

    Try
    {
        Return cached_vk[scancode]
    }
    Catch
    {
        cached_vk[scancode] := GetKeyVK(scancode)
        Return cached_vk[scancode]
    }
}

_GetCurrentLang()
{
    Return DllCall("GetKeyboardLayout", "Int", DllCall("GetWindowThreadProcessId", "Int", WinActive("A"), "Int", 0))
}

;detect current spotify process
_SpotifyDetectProcessId()
{
    For id in WinGetList(, , "Program Manager")
    {
        proc := WinGetProcessName("ahk_id" . id)
        title := WinGetTitle("ahk_id" . id)
        If title && proc == "Spotify.exe"
        {
            Global SPOTIFY
            SPOTIFY := id
            Break
        }
    }

    If !SPOTIFY
        SetTimer(_SpotifyDetectProcessId, -66666)
}

_GuiFillValues()
{
    ;read user layout (first tab) and global qphyx keys (second to fourth tabs)
    Loop 53
    {
        BUTTONS[SCAN_CODES[A_Index] . 1].Text := GetKeyName(SCAN_CODES[A_Index])
        Try
        {
            values := %SCAN_CODES[A_Index]%
            BUTTONS[SCAN_CODES[A_Index] . 2].Text := RegExReplace(values[3], "\{.+\}")
            BUTTONS[SCAN_CODES[A_Index] . 3].Text := RegExReplace(values[4], "\{.+\}")
            BUTTONS[SCAN_CODES[A_Index] . 4].Text := RegExReplace(values[5], "\{.+\}")
        }
        BUTTONS[SCAN_CODES[A_Index] . 5].Text := SCAN_CODES[A_Index]
    }

    ;set optional values and fix some broken names
    repl := ["SC029", "SC00E", "SC03A", "SC01C", "SC00F", "SC02A", "SC136"
        , "SC023", "SC024", "SC025", "SC026", "SC016", "SC017", "SC032", "SC033"]
    keys := CONF["ControllingKeys"] ? ["Esc", "Media", "Enter", "Backspace"] : ["Tilde", "BS", "Caps Lock", "Enter"]
    keys.Push("Tab", "LShift", "RShift", "left", "down", "up", "right", "backw", "forw", "undo", "redo")
    Loop 4
    {
        outer_ind := A_Index
        For i, sc in repl
        {
            If outer_ind < 3 && i > 7
                Break
            BUTTONS[sc . outer_ind].Text := keys[i]
        }
    }
    BUTTONS["SC0182"].Text := CONF["PairedBrackets"] ? "{}" : "{"
    BUTTONS["SC0342"].Text := "}"
    BUTTONS["SC0133"].Text := "&"
    BUTTONS["SC01B2"].Text := "ó"
    BUTTONS["SC01B3"].Text := "ò"
    BUTTONS["SC01B4"].Text := "♥"

    ;fill second tab numrow
    Loop 10
        BUTTONS[SCAN_CODES[A_Index+1] . 2].Text := BUTTONS[SCAN_CODES[A_Index+1] . 1].Text

    ;fill diacritics
    For sc in ["SC002", "SC003", "SC004", "SC005", "SC006", "SC007", "SC008", "SC009"
        , "SC00A", "SC00B", "SC00C", "SC00D"]
    {
        BUTTONS[sc . 3].Text := "o" . %sc%[3]
        BUTTONS[sc . 4].Text := "o" . %sc%[4]
    }
    BUTTONS["SC00C4"].Text := SC00C[4]
    BUTTONS["SC00D4"].Text := SC00D[4]

    ;apply user-defined keys
    For key, value in USER_ASSIGNMENTS
        If value.Has(1)
        {
            Try BUTTONS[key . 1].Text := value[1]
        }
        Else
        {
            Try BUTTONS[key . 1].Text := value.Get(LAT_LAYOUT, "") . "|" . value.Get(CYR_LAYOUT, "")
        }
    ;... and fix numrow user-defined keys to incr/decr func, if empty
    For key in [["SC00C", "decr"], ["SC00D", "incr"]]
    {
        If !BUTTONS[key[1] . 1].Text
        {
            BUTTONS[key[1] . 1].Text := key[2]
            BUTTONS[key[1] . 2].Text := key[2]
        }
        Else
        {
            BUTTONS[key[1] . 2].Text := BUTTONS[key[1] . 1].Text
        }
    }
}

GuiKeyPress(wp, *)
{
    key := "SC" . Format("{:03X}", GetKeySC("vk" . Format("{:X}", wp)))
    Loop 5
        Try BUTTONS[key . A_Index].Focus()
}

LangDoubleClick(_, item_pos)
{
    mode_num := LANG_MODES.GetText(item_pos, 2)
    If LANG_MODES.GetText(item_pos, 3) == "Latin"
        LatModeChange(0, mode_num)
    Else
        CyrModeChange(0, mode_num)
}

CheatsheetToggle(*)
{
    If WinExist("ahk_class AutoHotkeyGUI")
        MY_GUI.Hide()
    Else
        MY_GUI.Show("h180 w715")
}

CallExit(*)
{
    ExitApp
}


;===============================================================================================
;===========================================Controlling assignments=============================
;===============================================================================================

;; always enabled
;tilde
^+SC029:: Run("qphyx" . EXT)
 +SC029:: DisabledToggle()

;alt-f1 cheatsheet
 !SC03B:: CheatsheetToggle()
;LWin-f1 menu
<#SC03B:: A_TrayMenu.Show()

;; while the GUI is active
#HotIf CONF["ControllingKeys"] && WinActive("ahk_class AutoHotkeyGUI")
SC029:: MY_GUI.Hide()

#HotIf WinActive("ahk_class AutoHotkeyGUI")
;esc
SC001:: MY_GUI.Hide()
;focus "tab" key
SC00F:: GuiKeyPress(9)
;F1-F7
SC03B:: TABS.Value := 1
SC03C:: TABS.Value := 2
SC03D:: TABS.Value := 3
SC03E:: TABS.Value := 4
SC03F:: TABS.Value := 5
SC040:: TABS.Value := 6
SC041:: TABS.Value := 7

;; main controlling region
#HotIf !CONF["Disabled"] && CONF["ControllingKeys"] && !WinActive("ahk_class AutoHotkeyGUI")
;tilde
 SC029:: SendKbd("SC001")
!SC029:: SendKbd("SC001", "!")
^SC029:: SendKbd("SC001", "^")

;backspace
 SC00E::
{
    SendKbd("SC122")
    KeyWait("SC00E")  ; deny repeating by holding
}
!SC00E::
{
    If KeyWait("SC00E", LONG_PRESS_TIME)
        SendKbd("SC12E", "", "!")
    Else
        SendKbd("SC110", "", "!")
    KeyWait("SC00E")
}
+SC00E::
{
    If KeyWait("SC00E", LONG_PRESS_TIME)
        SendKbd("SC130", "", "+")
    Else
        SendKbd("SC119", "", "+")
    KeyWait("SC00E")
}

;enter
  SC01C:: SendKbd("SC00E")
 +SC01C:: SendKbd("SC153", "", "+")
 ^SC01C:: SendKbd("SC00E", "^")
+^SC01C:: SendKbd("SC153", "^", "+")
 #SC01C::
{
    If !KeyWait("SC01C", LONG_PRESS_TIME)
        WinMinimizeAllUndo
    Else If WinGetTitle("A") !== "Program Manager"
        WinMinimizeAll
    KeyWait("SC01C")
}

;caps lock
 SC03A:: SendKbd("SC01C")
+SC03A:: SendKbd("SC01C", "+")
!SC03A:: SendKbd("SC01C", "!")
^SC03A:: SendKbd("SC01C", "^")

;esc
SC001:: CONF["EscAsCaps"] ? SetCapsLockState(!GetKeyState("CapsLock", "T")) : SendKbd("SC001")

;; both shifts as esc feature
#HotIf !CONF["Disabled"] && CONF["BothShiftsAsEsc"]
SC02A & SC136:: SendKbd("SC001")
SC136 & SC02A:: SendKbd("SC001")
;why?
~*SC136::
{}
~*SC02A::
{}

;; nav region
#HotIf !CONF["Disabled"]
;nav "hjkl"
    ;base nav
  !SC023:: SendKbd("SC04B", "", "!")
  !SC024:: SendKbd("SC050", "", "!")
  !SC025:: SendKbd("SC048", "", "!")
  !SC026:: SendKbd("SC04D", "", "!")
    ;nav with select
 +!SC023:: SendKbd("SC04B", "+", "!")
 +!SC024:: SendKbd("SC050", "+", "!")
 +!SC025:: SendKbd("SC048", "+", "!")
 +!SC026:: SendKbd("SC04D", "+", "!")
    ;ctrl nav (left-right move by words; up-down as home-end)
 ^!SC023:: SendKbd("SC04B", "^", "!")
 ^!SC024:: SendKbd("SC047", "", "^!")
 ^!SC025:: SendKbd("SC04F", "", "^!")
 ^!SC026:: SendKbd("SC04D", "^", "!")
    ;ctrl nav with select
+^!SC023:: SendKbd("SC04B", "+^", "!")
+^!SC024:: SendKbd("SC047", "+", "^!")
+^!SC025:: SendKbd("SC04F", "+", "^!")
+^!SC026:: SendKbd("SC04D", "+^", "!")
    ;move window
  #SC023:: Send( "#{SC04B}")
  #SC024:: Send( "#{SC050}")
  #SC025:: Send( "#{SC048}")
  #SC026:: Send( "#{SC04D}")
 #+SC023:: Send("#+{SC04B}")
 #+SC026:: Send("#+{SC04D}")
 #+SC024::
{
    Try
    {
        WinMinimize("A")
        WinActivate
    }
}
 #+SC025::
{
    Try WinRestore(WinGetTitle("ahk_id" . LastMinimizedWindow()))
}

#HotIf !CONF["Disabled"] && !CONF["ControllingKeys"] && !WinActive("ahk_class AutoHotkeyGUI")
;tilde
SC029::
{
    If !UserDefined("SC029")
        SendKbd("SC029")
}

#HotIf !CONF["Disabled"] && !WinActive("ahk_class AutoHotkeyGUI")
;ctrl-sh-v – clipboard swap (paste and save replaced text as a new clipboard text)
+^SC02F::
{
    saved_value := A_Clipboard
    SendEvent("^{SC02E}")
    Send(saved_value)
}

;backward, forward, undo, redo
!SC016:: SendKbd("SC16A", "", "!")
!SC017:: SendKbd("SC169", "", "!")
!SC032:: SendKbd("SC02C", "^", "!", "^")
!SC033:: SendKbd("SC015", "^", "!", "^")

;unbr space feature
+SC039::
{
    If CONF["UnbrSpace"]
        Send("+{U+00A0}")
    Else
        SendKbd("SC039", "", "+")
}

;===============================================================================================
;============================="Send symbol" key assignments=====================================
;===============================================================================================

;numeric row
SC002:: DownNum("SC002")
SC003:: DownNum("SC003")
SC004:: DownNum("SC004")
SC005:: DownNum("SC005")
SC006:: DownNum("SC006")
SC007:: DownNum("SC007")
SC008:: DownNum("SC008")
SC009:: DownNum("SC009")
SC00A:: DownNum("SC00A")
SC00B:: DownNum("SC00B")
SC00C:: DownNum("SC00C")
SC00D:: DownNum("SC00D")

+SC002:: DownNum("SC002", 1)
+SC003:: DownNum("SC003", 1)
+SC004:: DownNum("SC004", 1)
+SC005:: DownNum("SC005", 1)
+SC006:: DownNum("SC006", 1)
+SC007:: DownNum("SC007", 1)
+SC008:: DownNum("SC008", 1)
+SC009:: DownNum("SC009", 1)
+SC00A:: DownNum("SC00A", 1)
+SC00B:: DownNum("SC00B", 1)
+SC00C:: DownNum("SC00C", 1)
+SC00D:: DownNum("SC00D", 1)

!SC002:: DownNum("SC002", , 1)
!SC003:: DownNum("SC003", , 1)
!SC004:: DownNum("SC004", , 1)
!SC005:: DownNum("SC005", , 1)
!SC006:: DownNum("SC006", , 1)
!SC007:: DownNum("SC007", , 1)
!SC008:: DownNum("SC008", , 1)
!SC009:: DownNum("SC009", , 1)
!SC00A:: DownNum("SC00A", , 1)
!SC00B:: DownNum("SC00B", , 1)
!SC00C:: DownNum("SC00C", , 1)
!SC00D:: DownNum("SC00D", , 1)

SC002 up:: UpNum("SC002")
SC003 up:: UpNum("SC003")
SC004 up:: UpNum("SC004")
SC005 up:: UpNum("SC005")
SC006 up:: UpNum("SC006")
SC007 up:: UpNum("SC007")
SC008 up:: UpNum("SC008")
SC009 up:: UpNum("SC009")
SC00A up:: UpNum("SC00A")
SC00B up:: UpNum("SC00B")
SC00C up:: UpNum("SC00C")
SC00D up:: UpNum("SC00D")

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
+SC010:: Down("SC010", 1)
+SC011:: Down("SC011", 1)
+SC012:: Down("SC012", 1)
+SC013:: Down("SC013", 1)
+SC014:: Down("SC014", 1)
+SC015:: Down("SC015", 1)
+SC016:: Down("SC016", 1)
+SC017:: Down("SC017", 1)
+SC018:: Down("SC018", 1)
+SC019:: Down("SC019", 1)
+SC01A:: Down("SC01A", 1)
+SC01B:: Down("SC01B", 1)
;home letters row
+SC01E:: Down("SC01E", 1)
+SC01F:: Down("SC01F", 1)
+SC020:: Down("SC020", 1)
+SC021:: Down("SC021", 1)
+SC022:: Down("SC022", 1)
+SC023:: Down("SC023", 1)
+SC024:: Down("SC024", 1)
+SC025:: Down("SC025", 1)
+SC026:: Down("SC026", 1)
+SC027:: Down("SC027", 1)
+SC028:: Down("SC028", 1)
;bottom letters row
+SC02C:: Down("SC02C", 1)
+SC02D:: Down("SC02D", 1)
+SC02E:: Down("SC02E", 1)
+SC02F:: Down("SC02F", 1)
+SC030:: Down("SC030", 1)
+SC031:: Down("SC031", 1)
+SC032:: Down("SC032", 1)
+SC033:: Down("SC033", 1)
+SC034:: Down("SC034", 1)
+SC035:: Down("SC035", 1)

;top letters row
!SC010:: Down("SC010", , 1)
!SC011:: Down("SC011", , 1)
!SC012:: Down("SC012", , 1)
!SC013:: Down("SC013", , 1)
!SC014:: Down("SC014", , 1)
!SC015:: Down("SC015", , 1)
!SC018:: Down("SC018", , 1)
!SC019:: Down("SC019", , 1)
!SC01A:: Down("SC01A", , 1)
!SC01B:: Down("SC01B", , 1)
;home letters row
!SC01E:: Down("SC01E", , 1)
!SC01F:: Down("SC01F", , 1)
!SC020:: Down("SC020", , 1)
!SC021:: Down("SC021", , 1)
!SC022:: Down("SC022", , 1)
!SC027:: Down("SC027", , 1)
!SC028:: Down("SC028", , 1)
;bottom letters row
!SC02C:: Down("SC02C", , 1)
!SC02D:: Down("SC02D", , 1)
!SC02E:: Down("SC02E", , 1)
!SC02F:: Down("SC02F", , 1)
!SC030:: Down("SC030", , 1)
!SC031:: Down("SC031", , 1)
!SC034:: Down("SC034", , 1)
!SC035:: Down("SC035", , 1)

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


;===============================================================================================
;===========================================Disabled keys=======================================
;===============================================================================================

#HotIf !CONF["Disabled"] && !CONF["NumPad"] && !WinActive("ahk_group BlackList")
;arrows up/left/right/down
    *SC148::
    *SC14B::
    *SC14D::
    *SC150::
;delete
    *SC153::

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
    {}


;===============================================================================================
;==============================================Other scancodes==================================
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
