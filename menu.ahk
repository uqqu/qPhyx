;===============================================================================================
;============================================Presets============================================
;===============================================================================================

#SingleInstance Force
#UseHook On

;set icon
icon := "internal\menu.ico"
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
Global MUS_CHECK_DELAY
Global MUS_PAUSE_DELAY
Global NIRCMD_PATH
Global SLEEP_DELAY
;qphyx-layout functionality
Global QPHYX_DISABLE
Global QPHYX_LONG_TIME

Global INI := "config.ini"
IfExist, %INI%
{
    IniRead, MUS_CHECK_DELAY,   %INI%, Configuration, MusCheckDelay
    IniRead, MUS_PAUSE_DELAY,   %INI%, Configuration, MusPauseDelay
    IniRead, SLEEP_DELAY,       %INI%, Configuration, SleepDelay
    IniRead, NIRCMD_PATH,       %INI%, Configuration, NircmdPath
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
    Run, menu%EXT%
}

;api keys
Global CURRENCY_KEY
Global WEATHER_KEY
RegRead, CURRENCY_KEY, HKEY_CURRENT_USER\Environment, GETGEOAPI
RegRead, WEATHER_KEY, HKEY_CURRENT_USER\Environment, OPENWEATHERMAP

Global CITY
RegRead, CITY, HKEY_CURRENT_USER\Environment, CITY

;on the fly advertisement controlling variables
Global MUTE := 0
Global SPOTIFY := 0
SpotifyDetectProcessId() ; fill SPOTIFY value

;music control label (auto pause music on long afk; auto mute volume when advertisement)
SetTimer, Idle, %MUS_CHECK_DELAY%


;===============================================================================================
;============================================Paste menu=========================================
;===============================================================================================

Menu, Paste, Add, Paste menu, Pass
Menu, Paste, ToggleEnable, Paste menu
Menu, Paste, Icon, Paste menu, %A_AhkPath%, -207

;"predefined values paste" submenu
IniRead, section, %INI%, SavedValue
For ind, pair in StrSplit(section, "`n")
{
    values := StrSplit(pair, "=")
    option%ind% := Func("SendValue").Bind(values[2])
    Menu, Values, Add, % values[1], % option%ind%
}
Menu, Values, Add
Menu, Values, Add, Add new value, AddSavedValue
Menu, Values, Add, Delete existing value, DeleteSavedValue

Menu, Paste, Add, Saved &values, :Values

;"clipboard as input; paste as output" submenu
    normalize_clip   := Func("@Clip").Bind("Normalize")
    capitaliz_clip   := Func("@Clip").Bind("Capitalized")
    lowercase_clip   := Func("@Clip").Bind("Lowercase")
    uppercase_clip   := Func("@Clip").Bind("Uppercase")
    inverted_clip    := Func("@Clip").Bind("Inverted")
    sentence_clip    := Func("@Clip").Bind("Sentence")
    en_ru_q_clip     := Func("@Clip").Bind(Func("LayoutSwitch").Bind("qphyx_en_ru"))
    ru_en_q_clip     := Func("@Clip").Bind(Func("LayoutSwitch").Bind("qphyx_ru_en"))
    en_ru_l_clip     := Func("@Clip").Bind(Func("LayoutSwitch").Bind("qwerty_en_ru"))
    ru_en_l_clip     := Func("@Clip").Bind(Func("LayoutSwitch").Bind("qwerty_ru_en"))
    en_ru_t_clip     := Func("@Clip").Bind(Func("LayoutSwitch").Bind("translit_en_ru"))
    ru_en_t_clip     := Func("@Clip").Bind(Func("LayoutSwitch").Bind("translit_ru_en"))
    calc_expr_clip   := Func("@Clip").Bind("Execute")
    format_time_clip := Func("@Clip").Bind("DatetimeFormat")
    Menu, Clip, Add, Nor&malize,   % normalize_clip
    Menu, Clip, Add, &Sentence,    % sentence_clip
    Menu, Clip, Add, &Capitalized, % capitaliz_clip
    Menu, Clip, Add, &Lowercase,   % lowercase_clip
    Menu, Clip, Add, &Uppercase,   % uppercase_clip
    Menu, Clip, Add, &Inverted,    % inverted_clip
    Menu, Clip, Add
    Menu, Clip, Add, En-Ru q&phyx switch,    % en_ru_q_clip
    Menu, Clip, Add, Ru-En &qphyx switch,    % ru_en_q_clip
    Menu, Clip, Add, &En-Ru qwerty switch,   % en_ru_l_clip
    Menu, Clip, Add, &Ru-En qwerty switch,   % ru_en_l_clip
    Menu, Clip, Add, E&n-Ru transliteration, % en_ru_t_clip
    Menu, Clip, Add, Ru-En transliterati&on, % ru_en_t_clip
    Menu, Clip, Add
    Menu, Clip, Add, C&alculate the expression, % calc_expr_clip
    Menu, Clip, Add, &Format Time (e.g. "dd/MM" to "26/03"), % format_time_clip
    ;currency converter submenu
        usd_rub_c_c  := Func("@Clip").Bind(Func("ExchRates").Bind("USD", "RUB", 0))
        rub_usd_c_c  := Func("@Clip").Bind(Func("ExchRates").Bind("RUB", "USD", 0))
        uah_usd_c_c  := Func("@Clip").Bind(Func("ExchRates").Bind("UAH", "USD", 0))
        usd_uah_c_c  := Func("@Clip").Bind(Func("ExchRates").Bind("USD", "UAH", 0))
        rub_uah_c_c  := Func("@Clip").Bind(Func("ExchRates").Bind("RUB", "UAH", 0))
        uah_rub_c_c  := Func("@Clip").Bind(Func("ExchRates").Bind("UAH", "RUB", 0))
        usd_eur_c_c  := Func("@Clip").Bind(Func("ExchRates").Bind("USD", "EUR", 0))
        eur_usd_c_c  := Func("@Clip").Bind(Func("ExchRates").Bind("EUR", "USD", 0))
        unk_to_usd_c := Func("@Clip").Bind(Func("UnknownCurrency").Bind("USD"))
        unk_to_rub_c := Func("@Clip").Bind(Func("UnknownCurrency").Bind("RUB"))
        Menu, ConvC, Add, &USD–RUB, % usd_rub_c_c
        Menu, ConvC, Add, &RUB–USD, % rub_usd_c_c
        Menu, ConvC, Add
        Menu, ConvC, Add, U&SD–UAH, % usd_uah_c_c
        Menu, ConvC, Add, UA&H–USD, % uah_usd_c_c
        Menu, ConvC, Add
        Menu, ConvC, Add, U&AH–RUB, % uah_rub_c_c
        Menu, ConvC, Add, RU&B–UAH, % rub_uah_c_c
        Menu, ConvC, Add
        Menu, ConvC, Add, US&D–EUR, % usd_eur_c_c
        Menu, ConvC, Add, &EUR–USD, % eur_usd_c_c
        Menu, ConvC, Add
        Menu, ConvC, Add, ... &to USD, % unk_to_usd_c
        Menu, ConvC, Add, ... t&o RUB, % unk_to_rub_c
    Menu, Clip, Add, Currenc&y converter, :ConvC
Menu, Paste, Add, &Clipboard text transform, :Clip

;"selected text as input; paste as output" submenu
    normalize_sel   := Func("@Sel").Bind("Normalize")
    capitaliz_sel   := Func("@Sel").Bind("Capitalized")
    lowercase_sel   := Func("@Sel").Bind("Lowercase")
    uppercase_sel   := Func("@Sel").Bind("Uppercase")
    inverted_sel    := Func("@Sel").Bind("Inverted")
    sentence_sel    := Func("@Sel").Bind("Sentence")
    en_ru_q_sel     := Func("@Sel").Bind(Func("LayoutSwitch").Bind("qphyx_en_ru"))
    ru_en_q_sel     := Func("@Sel").Bind(Func("LayoutSwitch").Bind("qphyx_ru_en"))
    en_ru_l_sel     := Func("@Sel").Bind(Func("LayoutSwitch").Bind("qwerty_en_ru"))
    ru_en_l_sel     := Func("@Sel").Bind(Func("LayoutSwitch").Bind("qwerty_ru_en"))
    en_ru_t_sel     := Func("@Sel").Bind(Func("LayoutSwitch").Bind("translit_en_ru"))
    ru_en_t_sel     := Func("@Sel").Bind(Func("LayoutSwitch").Bind("translit_ru_en"))
    calc_expr_sel   := Func("@Sel").Bind("Execute")
    format_time_sel := Func("@Sel").Bind("DatetimeFormat")
    Menu, Sel, Add, Nor&malize,   % normalize_sel
    Menu, Sel, Add, &Sentence,    % sentence_sel
    Menu, Sel, Add, &Capitalized, % capitaliz_sel
    Menu, Sel, Add, &Lowercase,   % lowercase_sel
    Menu, Sel, Add, &Uppercase,   % uppercase_sel
    Menu, Sel, Add, &Inverted,    % inverted_sel
    Menu, Sel, Add
    Menu, Sel, Add, En-Ru &qphyx switch,    % en_ru_q_sel
    Menu, Sel, Add, Ru-En q&phyx switch,    % ru_en_q_sel
    Menu, Sel, Add, &En-Ru qwerty switch,   % en_ru_l_sel
    Menu, Sel, Add, &Ru-En qwerty switch,   % ru_en_l_sel
    Menu, Sel, Add, E&n-Ru transliteration, % en_ru_t_sel
    Menu, Sel, Add, Ru-En transliterati&on, % ru_en_t_sel
    Menu, Sel, Add
    Menu, Sel, Add, C&alculate the expression, % calc_expr_sel
    Menu, Sel, Add, &Format Time (e.g. "dd/MM" to "26/03"), % format_time_sel
    ;currency converter submenu
        usd_rub_c_s  := Func("@Sel").Bind(Func("ExchRates").Bind("USD", "RUB", 0))
        rub_usd_c_s  := Func("@Sel").Bind(Func("ExchRates").Bind("RUB", "USD", 0))
        uah_usd_c_s  := Func("@Sel").Bind(Func("ExchRates").Bind("UAH", "USD", 0))
        usd_uah_c_s  := Func("@Sel").Bind(Func("ExchRates").Bind("USD", "UAH", 0))
        rub_uah_c_s  := Func("@Sel").Bind(Func("ExchRates").Bind("RUB", "UAH", 0))
        uah_rub_c_s  := Func("@Sel").Bind(Func("ExchRates").Bind("UAH", "RUB", 0))
        usd_eur_c_s  := Func("@Sel").Bind(Func("ExchRates").Bind("USD", "EUR", 0))
        eur_usd_c_s  := Func("@Sel").Bind(Func("ExchRates").Bind("EUR", "USD", 0))
        unk_to_usd_s := Func("@Sel").Bind(Func("UnknownCurrency").Bind("USD"))
        unk_to_rub_s := Func("@Sel").Bind(Func("UnknownCurrency").Bind("RUB"))
        Menu, ConvS, Add, &USD–RUB, % usd_rub_c_s
        Menu, ConvS, Add, &RUB–USD, % rub_usd_c_s
        Menu, ConvS, Add
        Menu, ConvS, Add, U&SD–UAH, % usd_uah_c_s
        Menu, ConvS, Add, UA&H–USD, % uah_usd_c_s
        Menu, ConvS, Add
        Menu, ConvS, Add, U&AH–RUB, % uah_rub_c_s
        Menu, ConvS, Add, RU&B–UAH, % rub_uah_c_s
        Menu, ConvS, Add
        Menu, ConvS, Add, US&D–EUR, % usd_eur_c_s
        Menu, ConvS, Add, &EUR–USD, % eur_usd_c_s
        Menu, ConvS, Add
        Menu, ConvS, Add, ... &to USD, % unk_to_usd_s
        Menu, ConvS, Add, ... t&o RUB, % unk_to_rub_s
    Menu, Sel, Add, Currenc&y converter, :ConvS
Menu, Paste, Add, &Selected text transform, :Sel

;"input_box as input; paste as output" submenu
    normalize_inp   := Func("@Inp").Bind("Normalize")
    capitaliz_inp   := Func("@Inp").Bind("Capitalized")
    lowercase_inp   := Func("@Inp").Bind("Lowercase")
    uppercase_inp   := Func("@Inp").Bind("Uppercase")
    inverted_inp    := Func("@Inp").Bind("Inverted")
    sentence_inp    := Func("@Inp").Bind("Sentence")
    en_ru_q_inp     := Func("@Inp").Bind(Func("LayoutSwitch").Bind("qphyx_en_ru"))
    ru_en_q_inp     := Func("@Inp").Bind(Func("LayoutSwitch").Bind("qphyx_ru_en"))
    en_ru_l_inp     := Func("@Inp").Bind(Func("LayoutSwitch").Bind("qwerty_en_ru"))
    ru_en_l_inp     := Func("@Inp").Bind(Func("LayoutSwitch").Bind("qwerty_ru_en"))
    en_ru_t_inp     := Func("@Inp").Bind(Func("LayoutSwitch").Bind("translit_en_ru"))
    ru_en_t_inp     := Func("@Inp").Bind(Func("LayoutSwitch").Bind("translit_ru_en"))
    calc_expr_inp   := Func("@Inp").Bind("Execute")
    format_time_inp := Func("@Inp").Bind("DatetimeFormat")
    Menu, Inp, Add, Nor&malize,   % normalize_inp
    Menu, Inp, Add, &Sentence,    % sentence_inp
    Menu, Inp, Add, &Capitalized, % capitaliz_inp
    Menu, Inp, Add, &Lowercase,   % lowercase_inp
    Menu, Inp, Add, &Uppercase,   % uppercase_inp
    Menu, Inp, Add, &Inverted,    % inverted_inp
    Menu, Inp, Add
    Menu, Inp, Add, En-Ru &qphyx switch,    % en_ru_q_inp
    Menu, Inp, Add, Ru-En q&phyx switch,    % ru_en_q_inp
    Menu, Inp, Add, &En-Ru qwerty switch,   % en_ru_l_inp
    Menu, Inp, Add, &Ru-En qwerty switch,   % ru_en_l_inp
    Menu, Inp, Add, E&n-Ru transliteration, % en_ru_t_inp
    Menu, Inp, Add, Ru-En transliterati&on, % ru_en_t_inp
    Menu, Inp, Add
    Menu, Inp, Add, C&alculate the expression, % calc_expr_inp
    Menu, Inp, Add, &Format Time (e.g. "dd/MM" to "26/03"), % format_time_inp
    ;currency converter submenu
        usd_rub_c_i  := Func("@Inp").Bind(Func("ExchRates").Bind("USD", "RUB", 0))
        rub_usd_c_i  := Func("@Inp").Bind(Func("ExchRates").Bind("RUB", "USD", 0))
        uah_usd_c_i  := Func("@Inp").Bind(Func("ExchRates").Bind("UAH", "USD", 0))
        usd_uah_c_i  := Func("@Inp").Bind(Func("ExchRates").Bind("USD", "UAH", 0))
        rub_uah_c_i  := Func("@Inp").Bind(Func("ExchRates").Bind("RUB", "UAH", 0))
        uah_rub_c_i  := Func("@Inp").Bind(Func("ExchRates").Bind("UAH", "RUB", 0))
        usd_eur_c_i  := Func("@Inp").Bind(Func("ExchRates").Bind("USD", "EUR", 0))
        eur_usd_c_i  := Func("@Inp").Bind(Func("ExchRates").Bind("EUR", "USD", 0))
        unk_to_usd_i := Func("@Inp").Bind(Func("UnknownCurrency").Bind("USD"))
        unk_to_rub_i := Func("@Inp").Bind(Func("UnknownCurrency").Bind("RUB"))
        Menu, ConvI, Add, &USD–RUB, % usd_rub_c_i
        Menu, ConvI, Add, &RUB–USD, % rub_usd_c_i
        Menu, ConvI, Add
        Menu, ConvI, Add, U&SD–UAH, % usd_uah_c_i
        Menu, ConvI, Add, UA&H–USD, % uah_usd_c_i
        Menu, ConvI, Add
        Menu, ConvI, Add, U&AH–RUB, % uah_rub_c_i
        Menu, ConvI, Add, RU&B–UAH, % rub_uah_c_i
        Menu, ConvI, Add
        Menu, ConvI, Add, US&D–EUR, % usd_eur_c_i
        Menu, ConvI, Add, &EUR–USD, % eur_usd_c_i
        Menu, ConvI, Add
        Menu, ConvI, Add, ... &to USD, % unk_to_usd_i
        Menu, ConvI, Add, ... t&o RUB, % unk_to_rub_i
    Menu, Inp, Add, Currenc&y converter, :ConvI
Menu, Paste, Add, &Input text to transform, :Inp
Menu, Paste, Add

;emoji submenu
    Menu, Emoji, Add, ¯\_(ツ)_/¯ &Shrug, Shrug
    Menu, Emoji, Add, ( ͡° ͜ʖ ͡°) &Lenny, Lenny
    Menu, Emoji, Add, ಠoಠ &Dude, Dude
    Menu, Emoji, Add, ლ(・﹏・ლ) &Why, Why
    Menu, Emoji, Add, (ง'̀-'́)ง &Fight, Fight
    Menu, Emoji, Add, ༼ つ ◕_◕ ༽つ &Take My Energy, TakeMyEnergy
    Menu, Emoji, Add, (╯°□°)╯︵ ┻━┻ &Rage, Rage
    Menu, Emoji, Add, ┬─┬ノ( º _ ºノ) &Putting Table Back, PuttingTableBack
    Menu, Emoji, Add, (；一_一) &Ashamed, Ashamed
    Menu, Emoji, Add, （＾～＾） &Meh, Meh
    Menu, Emoji, Add, ʕ •ᴥ•ʔ &Koala, Koala
    Menu, Emoji, Add, (◐‿◑) &Crazy, Crazy
    Menu, Emoji, Add, (っ⌒‿⌒)っ &Hug, Hug
    Menu, Emoji, Add, (☉__☉”) &Yikes, Yikes
    Menu, Emoji, Add, (ﾉﾟ0ﾟ)ﾉ~ w&Ow, wOw
    Menu, Emoji, Add, ༼ ༎ຶ ෴ ༎ຶ༽ &Upset, Upset
Menu, Paste, Add, &Emoji, :Emoji

;time submenu
    time_pst     := Func("@Clip").Bind(Func("Datetime").Bind("hh:mm:ss tt"))
    date_pst     := Func("@Clip").Bind(Func("Datetime").Bind("MMMM dd"))
    datetime_pst := Func("@Clip").Bind(Func("Datetime").Bind("dddd, MMMM dd yyyy hh:mm:ss tt"))
    new_time_pst := Func("@Clip").Bind("DecimalTime")
    new_date_pst := Func("@Clip").Bind("HexalDate")
    new_datetime := Func("@Clip").Bind("NewDatetime")
    Menu, DatetimeP, Add, &Time, % time_pst
    Menu, DatetimeP, Add, &Date, % date_pst
    Menu, DatetimeP, Add, DateTi&me, % datetime_pst
    Menu, DatetimeP, Add, De&cimal time, % new_time_pst
    Menu, DatetimeP, Add, &Hexal date,   % new_date_pst
    Menu, DatetimeP, Add, &New datetime, % new_datetime
Menu, Paste, Add, &Datetime, :DatetimeP

;exchange rates submenu
    usd_rub_r_p := Func("@Clip").Bind(Func("ExchRates").Bind("USD", "RUB"))
    rub_usd_r_p := Func("@Clip").Bind(Func("ExchRates").Bind("RUB", "USD"))
    uah_usd_r_p := Func("@Clip").Bind(Func("ExchRates").Bind("UAH", "USD"))
    usd_uah_r_p := Func("@Clip").Bind(Func("ExchRates").Bind("USD", "UAH"))
    rub_uah_r_p := Func("@Clip").Bind(Func("ExchRates").Bind("RUB", "UAH"))
    uah_rub_r_p := Func("@Clip").Bind(Func("ExchRates").Bind("UAH", "RUB"))
    usd_eur_r_p := Func("@Clip").Bind(Func("ExchRates").Bind("USD", "EUR"))
    eur_usd_r_p := Func("@Clip").Bind(Func("ExchRates").Bind("EUR", "USD"))
    Menu, RatesP, Add, &USD–RUB, % usd_rub_r_p
    Menu, RatesP, Add, &RUB–USD, % rub_usd_r_p
    Menu, RatesP, Add
    Menu, RatesP, Add, U&SD–UAH, % usd_uah_r_p
    Menu, RatesP, Add, UA&H–USD, % uah_usd_r_p
    Menu, RatesP, Add
    Menu, RatesP, Add, U&AH–RUB, % uah_rub_r_p
    Menu, RatesP, Add, RU&B–UAH, % rub_uah_r_p
    Menu, RatesP, Add
    Menu, RatesP, Add, US&D–EUR, % usd_eur_r_p
    Menu, RatesP, Add, &EUR–USD, % eur_usd_r_p
Menu, Paste, Add, E&xchange rate, :RatesP

weather_pst := Func("@Clip").Bind(Func("Weather").Bind(CITY))
Menu, Paste, Add, Current &weather, % weather_pst


;===============================================================================================
;============================================Message menu=======================================
;===============================================================================================

Menu, Func, Add, Message menu, Pass
Menu, Func, ToggleEnable, Message menu
Menu, Func, Icon, Message menu, %A_AhkPath%, -207

compare_msg := Func("Compare")
Menu, Func, Add, C&ompare selected with clipboard, % compare_msg
Menu, Func, Add

;"clipboard text as input; message box as output" submenu
    normalize_c_msg   := Func("@ClipMsg").Bind("Normalize")
    capitaliz_c_msg   := Func("@ClipMsg").Bind("Capitalized")
    lowercase_c_msg   := Func("@ClipMsg").Bind("Lowercase")
    uppercase_c_msg   := Func("@ClipMsg").Bind("Uppercase")
    inverted_c_msg    := Func("@ClipMsg").Bind("Inverted")
    sentence_c_msg    := Func("@ClipMsg").Bind("Sentence")
    en_ru_q_c_msg     := Func("@ClipMsg").Bind(Func("LayoutSwitch").Bind("qphyx_en_ru"))
    ru_en_q_c_msg     := Func("@ClipMsg").Bind(Func("LayoutSwitch").Bind("qphyx_ru_en"))
    en_ru_l_c_msg     := Func("@ClipMsg").Bind(Func("LayoutSwitch").Bind("qwerty_en_ru"))
    ru_en_l_c_msg     := Func("@ClipMsg").Bind(Func("LayoutSwitch").Bind("qwerty_ru_en"))
    en_ru_t_c_msg     := Func("@ClipMsg").Bind(Func("LayoutSwitch").Bind("translit_en_ru"))
    ru_en_t_c_msg     := Func("@ClipMsg").Bind(Func("LayoutSwitch").Bind("translit_ru_en"))
    calc_expr_c_msg   := Func("@ClipMsg").Bind("Execute")
    format_time_c_msg := Func("@ClipMsg").Bind("DatetimeFormat")
    Menu, ClipMsg, Add, Nor&malize,   % normalize_c_msg
    Menu, ClipMsg, Add, &Sentence,    % sentence_c_msg
    Menu, ClipMsg, Add, &Capitalized, % capitaliz_c_msg
    Menu, ClipMsg, Add, &Lowercase,   % lowercase_c_msg
    Menu, ClipMsg, Add, &Uppercase,   % uppercase_c_msg
    Menu, ClipMsg, Add, &Inverted,    % inverted_c_msg
    Menu, ClipMsg, Add
    Menu, ClipMsg, Add, En-Ru &qphyx switch,    % en_ru_q_c_msg
    Menu, ClipMsg, Add, Ru-En q&phyx switch,    % ru_en_q_c_msg
    Menu, ClipMsg, Add, &En-Ru qwerty switch,   % en_ru_l_c_msg
    Menu, ClipMsg, Add, &Ru-En qwerty switch,   % ru_en_l_c_msg
    Menu, ClipMsg, Add, E&n-Ru transliteration, % en_ru_t_c_msg
    Menu, ClipMsg, Add, Ru-En transliterati&on, % ru_en_t_c_msg
    Menu, ClipMsg, Add
    Menu, ClipMsg, Add, C&alculate the expression, % calc_expr_c_msg
    Menu, ClipMsg, Add, &Format Time (e.g. "dd/MM" to "26/03"), % format_time_c_msg
    ;currency converter submenu
        usd_rub_c_m_c  := Func("@ClipMsg").Bind(Func("ExchRates").Bind("USD", "RUB", 0))
        rub_usd_c_m_c  := Func("@ClipMsg").Bind(Func("ExchRates").Bind("RUB", "USD", 0))
        uah_usd_c_m_c  := Func("@ClipMsg").Bind(Func("ExchRates").Bind("UAH", "USD", 0))
        usd_uah_c_m_c  := Func("@ClipMsg").Bind(Func("ExchRates").Bind("USD", "UAH", 0))
        rub_uah_c_m_c  := Func("@ClipMsg").Bind(Func("ExchRates").Bind("RUB", "UAH", 0))
        uah_rub_c_m_c  := Func("@ClipMsg").Bind(Func("ExchRates").Bind("UAH", "RUB", 0))
        usd_eur_c_m_c  := Func("@ClipMsg").Bind(Func("ExchRates").Bind("USD", "EUR", 0))
        eur_usd_c_m_c  := Func("@ClipMsg").Bind(Func("ExchRates").Bind("EUR", "USD", 0))
        unk_to_usd_m_c := Func("@ClipMsg").Bind(Func("UnknownCurrency").Bind("USD"))
        unk_to_rub_m_c := Func("@ClipMsg").Bind(Func("UnknownCurrency").Bind("RUB"))
        Menu, ConvMC, Add, &USD–RUB, % usd_rub_c_m_c
        Menu, ConvMC, Add, &RUB–USD, % rub_usd_c_m_c
        Menu, ConvMC, Add
        Menu, ConvMC, Add, U&SD–UAH, % usd_uah_c_m_c
        Menu, ConvMC, Add, UA&H–USD, % uah_usd_c_m_c
        Menu, ConvMC, Add
        Menu, ConvMC, Add, U&AH–RUB, % uah_rub_c_m_c
        Menu, ConvMC, Add, RU&B–UAH, % rub_uah_c_m_c
        Menu, ConvMC, Add
        Menu, ConvMC, Add, US&D–EUR, % usd_eur_c_m_c
        Menu, ConvMC, Add, &EUR–USD, % eur_usd_c_m_c
        Menu, ConvMC, Add
        Menu, ConvMC, Add, ... &to USD, % unk_to_usd_m_c
        Menu, ConvMC, Add, ... t&o RUB, % unk_to_rub_m_c
    Menu, ClipMsg, Add, Currenc&y converter, :ConvMC
Menu, Func, Add, &Clipboard text transform, :ClipMsg

;"selected text as input; message box as output" submenu
    normalize_s_msg   := Func("@SelMsg").Bind("Normalize")
    capitaliz_s_msg   := Func("@SelMsg").Bind("Capitalized")
    lowercase_s_msg   := Func("@SelMsg").Bind("Lowercase")
    uppercase_s_msg   := Func("@SelMsg").Bind("Uppercase")
    inverted_s_msg    := Func("@SelMsg").Bind("Inverted")
    sentence_s_msg    := Func("@SelMsg").Bind("Sentence")
    en_ru_q_s_msg     := Func("@SelMsg").Bind(Func("LayoutSwitch").Bind("qphyx_en_ru"))
    ru_en_q_s_msg     := Func("@SelMsg").Bind(Func("LayoutSwitch").Bind("qphyx_ru_en"))
    en_ru_l_s_msg     := Func("@SelMsg").Bind(Func("LayoutSwitch").Bind("qwerty_en_ru"))
    ru_en_l_s_msg     := Func("@SelMsg").Bind(Func("LayoutSwitch").Bind("qwerty_ru_en"))
    en_ru_t_s_msg     := Func("@SelMsg").Bind(Func("LayoutSwitch").Bind("translit_en_ru"))
    ru_en_t_s_msg     := Func("@SelMsg").Bind(Func("LayoutSwitch").Bind("translit_ru_en"))
    calc_expr_s_msg   := Func("@SelMsg").Bind("Execute")
    format_time_s_msg := Func("@SelMsg").Bind("DatetimeFormat")
    Menu, SelMsg, Add, Nor&malize,   % normalize_s_msg
    Menu, SelMsg, Add, &Sentence,    % sentence_s_msg
    Menu, SelMsg, Add, &Capitalized, % capitaliz_s_msg
    Menu, SelMsg, Add, &Lowercase,   % lowercase_s_msg
    Menu, SelMsg, Add, &Uppercase,   % uppercase_s_msg
    Menu, SelMsg, Add, &Inverted,    % inverted_s_msg
    Menu, SelMsg, Add
    Menu, SelMsg, Add, En-Ru &qphyx switch,    % en_ru_q_s_msg
    Menu, SelMsg, Add, Ru-En q&phyx switch,    % ru_en_q_s_msg
    Menu, SelMsg, Add, &En-Ru qwerty switch,   % en_ru_l_s_msg
    Menu, SelMsg, Add, &Ru-En qwerty switch,   % ru_en_l_s_msg
    Menu, SelMsg, Add, E&n-Ru transliteration, % en_ru_t_s_msg
    Menu, SelMsg, Add, Ru-En transliterati&on, % ru_en_t_s_msg
    Menu, SelMsg, Add
    Menu, SelMsg, Add, C&alculate the expression, % calc_expr_s_msg
    Menu, SelMsg, Add, &Format Time (e.g. "dd/MM" to "26/03"), % format_time_s_msg
    ;currency converter submenu
        usd_rub_c_m_s  := Func("@SelMsg").Bind(Func("ExchRates").Bind("USD", "RUB", 0))
        rub_usd_c_m_s  := Func("@SelMsg").Bind(Func("ExchRates").Bind("RUB", "USD", 0))
        uah_usd_c_m_s  := Func("@SelMsg").Bind(Func("ExchRates").Bind("UAH", "USD", 0))
        usd_uah_c_m_s  := Func("@SelMsg").Bind(Func("ExchRates").Bind("USD", "UAH", 0))
        rub_uah_c_m_s  := Func("@SelMsg").Bind(Func("ExchRates").Bind("RUB", "UAH", 0))
        uah_rub_c_m_s  := Func("@SelMsg").Bind(Func("ExchRates").Bind("UAH", "RUB", 0))
        usd_eur_c_m_s  := Func("@SelMsg").Bind(Func("ExchRates").Bind("USD", "EUR", 0))
        eur_usd_c_m_s  := Func("@SelMsg").Bind(Func("ExchRates").Bind("EUR", "USD", 0))
        unk_to_usd_m_s := Func("@SelMsg").Bind(Func("UnknownCurrency").Bind("USD"))
        unk_to_rub_m_s := Func("@SelMsg").Bind(Func("UnknownCurrency").Bind("RUB"))
        Menu, ConvMS, Add, &USD–RUB, % usd_rub_c_m_s
        Menu, ConvMS, Add, &RUB–USD, % rub_usd_c_m_s
        Menu, ConvMS, Add
        Menu, ConvMS, Add, U&SD–UAH, % usd_uah_c_m_s
        Menu, ConvMS, Add, UA&H–USD, % uah_usd_c_m_s
        Menu, ConvMS, Add
        Menu, ConvMS, Add, U&AH–RUB, % uah_rub_c_m_s
        Menu, ConvMS, Add, RU&B–UAH, % rub_uah_c_m_s
        Menu, ConvMS, Add
        Menu, ConvMS, Add, US&D–EUR, % usd_eur_c_m_s
        Menu, ConvMS, Add, &EUR–USD, % eur_usd_c_m_s
        Menu, ConvMS, Add
        Menu, ConvMS, Add, ... &to USD, % unk_to_usd_m_s
        Menu, ConvMS, Add, ... t&o RUB, % unk_to_rub_m_s
    Menu, SelMsg, Add, Currenc&y converter, :ConvMS
Menu, Func, Add, &Selected text transform, :SelMsg

;"input box as input; message box as output" submenu
    normalize_i_msg   := Func("@InpMsg").Bind("Normalize")
    capitaliz_i_msg   := Func("@InpMsg").Bind("Capitalized")
    lowercase_i_msg   := Func("@InpMsg").Bind("Lowercase")
    uppercase_i_msg   := Func("@InpMsg").Bind("Uppercase")
    inverted_i_msg    := Func("@InpMsg").Bind("Inverted")
    sentence_i_msg    := Func("@InpMsg").Bind("Sentence")
    en_ru_q_i_msg     := Func("@InpMsg").Bind(Func("LayoutSwitch").Bind("qphyx_en_ru"))
    ru_en_q_i_msg     := Func("@InpMsg").Bind(Func("LayoutSwitch").Bind("qphyx_ru_en"))
    en_ru_l_i_msg     := Func("@InpMsg").Bind(Func("LayoutSwitch").Bind("qwerty_en_ru"))
    ru_en_l_i_msg     := Func("@InpMsg").Bind(Func("LayoutSwitch").Bind("qwerty_ru_en"))
    en_ru_t_i_msg     := Func("@InpMsg").Bind(Func("LayoutSwitch").Bind("translit_en_ru"))
    ru_en_t_i_msg     := Func("@InpMsg").Bind(Func("LayoutSwitch").Bind("translit_ru_en"))
    calc_expr_i_msg   := Func("@InpMsg").Bind("Execute")
    format_time_i_msg := Func("@InpMsg").Bind("DatetimeFormat")
    Menu, InpMsg, Add, Nor&malize,   % normalize_i_msg
    Menu, InpMsg, Add, &Sentence,    % sentence_i_msg
    Menu, InpMsg, Add, &Capitalized, % capitaliz_i_msg
    Menu, InpMsg, Add, &Lowercase,   % lowercase_i_msg
    Menu, InpMsg, Add, &Uppercase,   % uppercase_i_msg
    Menu, InpMsg, Add, &Inverted,    % inverted_i_msg
    Menu, InpMsg, Add
    Menu, InpMsg, Add, En-Ru &qphyx switch,    % en_ru_q_i_msg
    Menu, InpMsg, Add, Ru-En q&phyx switch,    % ru_en_q_i_msg
    Menu, InpMsg, Add, &En-Ru qwerty switch,   % en_ru_l_i_msg
    Menu, InpMsg, Add, &Ru-En qwerty switch,   % ru_en_l_i_msg
    Menu, InpMsg, Add, E&n-Ru transliteration, % en_ru_t_i_msg
    Menu, InpMsg, Add, Ru-En transliterati&on, % ru_en_t_i_msg
    Menu, InpMsg, Add
    Menu, InpMsg, Add, C&alculate the expression, % calc_expr_i_msg
    Menu, InpMsg, Add, &Format Time (e.g. "dd/MM" to "26/03"), % format_time_i_msg
    ;currency converter submenu
        usd_rub_c_m_i  := Func("@InpMsg").Bind(Func("ExchRates").Bind("USD", "RUB", 0))
        rub_usd_c_m_i  := Func("@InpMsg").Bind(Func("ExchRates").Bind("RUB", "USD", 0))
        uah_usd_c_m_i  := Func("@InpMsg").Bind(Func("ExchRates").Bind("UAH", "USD", 0))
        usd_uah_c_m_i  := Func("@InpMsg").Bind(Func("ExchRates").Bind("USD", "UAH", 0))
        rub_uah_c_m_i  := Func("@InpMsg").Bind(Func("ExchRates").Bind("RUB", "UAH", 0))
        uah_rub_c_m_i  := Func("@InpMsg").Bind(Func("ExchRates").Bind("UAH", "RUB", 0))
        usd_eur_c_m_i  := Func("@InpMsg").Bind(Func("ExchRates").Bind("USD", "EUR", 0))
        eur_usd_c_m_i  := Func("@InpMsg").Bind(Func("ExchRates").Bind("EUR", "USD", 0))
        unk_to_usd_m_i := Func("@InpMsg").Bind(Func("UnknownCurrency").Bind("USD"))
        unk_to_rub_m_i := Func("@InpMsg").Bind(Func("UnknownCurrency").Bind("RUB"))
        Menu, ConvMI, Add, &USD–RUB, % usd_rub_c_m_i
        Menu, ConvMI, Add, &RUB–USD, % rub_usd_c_m_i
        Menu, ConvMI, Add
        Menu, ConvMI, Add, U&SD–UAH, % usd_uah_c_m_i
        Menu, ConvMI, Add, UA&H–USD, % uah_usd_c_m_i
        Menu, ConvMI, Add
        Menu, ConvMI, Add, U&AH–RUB, % uah_rub_c_m_i
        Menu, ConvMI, Add, RU&B–UAH, % rub_uah_c_m_i
        Menu, ConvMI, Add
        Menu, ConvMI, Add, US&D–EUR, % usd_eur_c_m_i
        Menu, ConvMI, Add, &EUR–USD, % eur_usd_c_m_i
        Menu, ConvMI, Add
        Menu, ConvMI, Add, ... &to USD, % unk_to_usd_m_i
        Menu, ConvMI, Add, ... t&o RUB, % unk_to_rub_m_i
    Menu, InpMsg, Add, Currenc&y converter, :ConvMI
Menu, Func, Add, &Input text to transform, :InpMsg
Menu, Func, Add

;time submenu
    time_msg     := Func("@ClipMsg").Bind(Func("Datetime").Bind("hh:mm:ss tt"))
    date_msg     := Func("@ClipMsg").Bind(Func("Datetime").Bind("MMMM dd"))
    dt_msg       := Func("@ClipMsg").Bind(Func("Datetime").Bind("dddd, MMMM dd yyyy hh:mm:ss tt"))
    new_time_msg := Func("@ClipMsg").Bind("DecimalTime")
    new_date_msg := Func("@ClipMsg").Bind("HexalDate")
    new_dt_msg   := Func("@ClipMsg").Bind("NewDatetime")
    Menu, DatetimeM, Add, &Time, % time_msg
    Menu, DatetimeM, Add, &Date, % date_msg
    Menu, DatetimeM, Add, DateTi&me, % dt_msg
    Menu, DatetimeM, Add, De&cimal time, % new_time_msg
    Menu, DatetimeM, Add, &Hexal date,   % new_date_msg
    Menu, DatetimeM, Add, &New datetime, % new_dt_msg
Menu, Func, Add, &Datetime, :DatetimeM

;exchange rates submenu
    usd_rub_r_m := Func("@ClipMsg").Bind(Func("ExchRates").Bind("USD", "RUB"))
    rub_usd_r_m := Func("@ClipMsg").Bind(Func("ExchRates").Bind("RUB", "USD"))
    uah_usd_r_m := Func("@ClipMsg").Bind(Func("ExchRates").Bind("UAH", "USD"))
    usd_uah_r_m := Func("@ClipMsg").Bind(Func("ExchRates").Bind("USD", "UAH"))
    rub_uah_r_m := Func("@ClipMsg").Bind(Func("ExchRates").Bind("RUB", "UAH"))
    uah_rub_r_m := Func("@ClipMsg").Bind(Func("ExchRates").Bind("UAH", "RUB"))
    usd_eur_r_m := Func("@ClipMsg").Bind(Func("ExchRates").Bind("USD", "EUR"))
    eur_usd_r_m := Func("@ClipMsg").Bind(Func("ExchRates").Bind("EUR", "USD"))
    Menu, RatesM, Add, &USD–RUB, % usd_rub_r_m
    Menu, RatesM, Add, &RUB–USD, % rub_usd_r_m
    Menu, RatesM, Add
    Menu, RatesM, Add, U&SD–UAH, % usd_uah_r_m
    Menu, RatesM, Add, UA&H–USD, % uah_usd_r_m
    Menu, RatesM, Add
    Menu, RatesM, Add, U&AH–RUB, % uah_rub_r_m
    Menu, RatesM, Add, RU&B–UAH, % rub_uah_r_m
    Menu, RatesM, Add
    Menu, RatesM, Add, US&D–EUR, % usd_eur_r_m
    Menu, RatesM, Add, &EUR–USD, % eur_usd_r_m
Menu, Func, Add, E&xchange rate, :RatesM

weather_msg := Func("@ClipMsg").Bind(Func("Weather").Bind(CITY))
Menu, Func, Add, Current &weather, % weather_msg

;reminder
Menu, Func, Add, &Reminder, Reminder

Menu, Func, Add
Menu, Func, Add
Menu, Func, Add, Settings, Pass
Menu, Func, ToggleEnable, Settings
Menu, Func, Icon, Settings, %A_AhkPath%, -206

If QPHYX_LONG_TIME
{
    ;global QPHYX_DISABLE bool
    Menu, Func, Add, Disa&ble (sh+tilde to toggle), QphyxDisable
    ;global QPHYX_LONG_TIME int
    Menu, Func, Add, &Long press delay (now is %QPHYX_LONG_TIME%s), QphyxLongPress
}
;global MUS_PAUSE_DELAY int
Menu, Func, Add, &Auto-stop music on AFK delay (now is %MUS_PAUSE_DELAY%m), MusTimer


;===============================================================================================
;===========================================Tools functions=====================================
;===============================================================================================

;decorators
@Clip(func, params*)
{
    msgbox % params
    result := %func%(params)
    SendInput %result%
}
@Sel(func, params*)
{
    saved_value := Clipboard
    Sleep, SLEEP_DELAY
    SendInput ^{SC02E}
    Sleep, SLEEP_DELAY
    result := %func%(params)
    SendInput %result%
    Clipboard := saved_value
}
@Inp(func, params*)
{
    InputBox, user_input, %func%, Input for %func% function, , 300, 150
    If !ErrorLevel
    {
        saved_value := Clipboard
        Sleep, SLEEP_DELAY
        Clipboard := user_input
        Sleep, SLEEP_DELAY
        result := %func%(params)
        SendInput %result%
        Clipboard := saved_value
    }
}
@ClipMsg(func, params*)
{
    result := %func%(params)
    MsgBox, 260, %func%, %result% `nSave result to clipboard?
    IfMsgBox Yes
    {
        Clipboard := result
    }
}
@SelMsg(func, params*)
{
    saved_value := Clipboard
    Sleep, SLEEP_DELAY
    SendInput ^{SC02E}
    Sleep, SLEEP_DELAY
    Clipboard := Trim(Clipboard)
    Sleep, SLEEP_DELAY
    result := %func%(params)
    MsgBox, 260, %func%, %result% `nSave result to clipboard?
    IfMsgBox Yes
    {
        Clipboard := result
    }
    Else
    {
        Clipboard := saved_value
    }
}
@InpMsg(func, params*)
{
    InputBox, user_input, %func%, Input for %func% function, , 300, 150
    If !ErrorLevel
    {
        saved_value := Clipboard
        Sleep, SLEEP_DELAY
        Clipboard := user_input
        Sleep, SLEEP_DELAY
        result := %func%(params)
        MsgBox, 260, %func%, %result% `nSave result to clipboard?
        IfMsgBox Yes
        {
            Clipboard := result
        }
        Else
        {
            Clipboard := saved_value
        }
    }
}

SendValue(value)
{
    SendInput %value%
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

;compare selected with clipboard value
Compare()
{
    saved_value := Clipboard
    Sleep, SLEEP_DELAY
    SendInput ^{SC02E}
    Sleep, SLEEP_DELAY
    If (Clipboard == saved_value)
    {
        result := "Identical"
    }
    Else
    {
        result := "Not identical"
    }
    Sleep, SLEEP_DELAY
    Clipboard := saved_value
    Msgbox, , Message, %result%
}

;calculate expression
Execute() ; https://www.autohotkey.com/boards/viewtopic.php?p=221460#p221460
{
    expr := Clipboard
    expr := StrReplace(RegExReplace(expr, "\s") , ",", ".")
    expr := RegExReplace(StrReplace(expr, "**", "^")
            , "(\w+(\.*\d+)?)\^(\w+(\.*\d+)?)", "pow($1,$3)")
    expr := RegExReplace(expr, "=+", "==")
    expr := RegExReplace(expr, "\b(E|LN2|LN10|LOG2E|LOG10E|PI|SQRT1_2|SQRT2)\b", "Math.$1")
    expr := RegExReplace(expr, "\b(abs|acos|asin|atan|atan2|ceil|cos|exp"
            . "|floor|log|max|min|pow|random|round|sin|sqrt|tan)\b\(", "Math.$1(")

    (o := ComObjCreate("HTMLfile")).write("<body><script>document"
            . ".body.innerText=eval('" . expr . "');</script>")
    o := StrReplace(StrReplace(StrReplace(InStr(o:=o.body.innerText, "body") ? "" : o
            , "false", 0), "true", 1), "undefined", "")
    Return o ;InStr(o, "e") ? Format("{:f}", o) : o
}

Weather(q_city)
{
    If !WEATHER_KEY
    {
        Return "Not found api key in environment variables (search 'OPENWEATHERMAP')"
    }
    web_request := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    web_request.Open("GET", "https://api.openweathermap.org/data/2.5/weather?q=" q_city
        . "&appid=" WEATHER_KEY "&units=metric")
    web_request.Send()
    stat := RegExReplace(web_request.ResponseText, ".+""main"":""(\w+)"".+", "$u1")
    StringUpper stat, stat, T
    temp := RegExReplace(web_request.ResponseText, ".+""temp"":(-?\d+.\d+).+", "$u1")
    feel := RegExReplace(web_request.ResponseText, ".+""feels_like"":(-?\d+.\d+).+", "$u1")
    wind := RegExReplace(web_request.ResponseText, ".+""speed"":(\d+.\d+).+", "$u1")
    Return stat "`n" temp "° (" feel "°)`n" wind "m/s"
}

ExchRates(base, symbol, amount:=1)
{
    If !CURRENCY_KEY
    {
        Return "Not found api key in environment variables (search 'GETGEOAPI')"
    }
    If !amount
    {
        amount := RegExReplace(RegExReplace(Clipboard, "[^\d+\.,]"), ",", ".")
    }
    web_request := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    web_request.Open("GET", "https://api.getgeoapi.com/api/v2/currency/convert?api_key="
        . CURRENCY_KEY "&from=" base "&to=" symbol "&amount=" amount "&format=json")
    web_request.Send()
    Return Round(RegExReplace(web_request.ResponseText
        , ".+""rate_for_amount"":""(\d+\.\d+)"".+", "$u1"), 2)
}

UnknownCurrency(base)
{
    If !CURRENCY_KEY
    {
        Return "Not found api key in environment variables (search 'GETGEOAPI')"
    }
    currencies1 := [[["XCD","EC$","$EC","carib"],"East Caribbean dollar"]
        ,[["COP","COL$","$COL","colom"],"Colombian peso"]
        ,[["CAD","CA$","$CA","can"],"Canadian dollar"]
        ,[["NIO","C$","$C","doba","nicar"],"Nicaraguan córdoba"]
        ,[["AUD","A$","$A","austral"],"Australian dollar"]
        ,[["BMD","BD$","$BD","berm"],"Bermudian dollar"]
        ,[["BND","Br$","$Br","brun"],"Brunei dollar"]
        ,[["BSD","B$","$B","baham"],"Bahamian dollar"]
        ,[["GYD","G$","$G","GY$","guyan"],"Guyanese dollar"]
        ,[["JMD","J$","$J","jam"],"Jamaican dollar"]
        ,[["LRD","L$","LD$","$L","liber"],"Liberian dollar"]
        ,[["CUP","$MN","MN$","cub"],"Cuban peso"]
        ,[["TWD","NT$","$NT","圓","taiw"],"New Taiwan dollar"]
        ,[["NAD","N$","$N","nami","namb"],"Namibian dollar"]
        ,[["WST","SAT","WS$","$WS","samo","tal","tāl"],"Samoan tālā"]
        ,[["SBD","SI$","$SI","solom"],"Solomon Islands dollar"]
        ,[["SRD","Sr$","$Sr","sur"],"Surinamese dollar"]
        ,[["SGD","S$","$S","SG","sing"],"Singaporean dollar"]
        ,[["DOP","RD$","$RD","dom"],"Dominican peso"]
        ,[["UYU","U$","$U","urug"],"Uruguayan peso"]
        ,[["BRL","R$","$R","rea","bra"],"Brazilian real"]
        ,[["TOP","T$","$T","PT","paʻanga","paanga"],"Tongan paʻanga"]
        ,[["USD","Dol","$","states"],"United States dollar"]
        ,[["THB","฿","baht","thai"],"Thai baht"]
        ,[["PAB","B/.","balboa","panam"],"Panamanian balboa"]
        ,[["VES","Bs.","var","venez"],"Venezuelan bolívar"]
        ,[["GHS","GH₵","cedi","ghana"],"Ghana cedi"]
        ,[["BTN","Nu.","ngultrum","bhutan"],"Bhutanese ngultrum"]
        ,[["CRC","₡","colón","colon","costa"," rica","-rica"],"Costa Rican colón"]
        ,[["MKD","ден","den","mace"],"Macedonian denar"]
        ,[["IQD","د.ع","I.Q.D.","iraq"],"Iraqi dinar"]
        ,[["KWD","د.ك","K.D.","kuw"],"Kuwaiti dinar"]
        ,[["RSD","дин","din","serb"],"Serbian dinar"]
        ,[["AED","د.إ","uae","arab","emir"],"United Arab Emirates dirham"]]
    currencies2 := [[["BBD","Bds","barb"],"Barbadian dollar"]
        ,[["ARS","arg"],"Argentine peso"]
        ,[["CLP","chil"],"Chilean peso"]
        ,[["MXN","Mex"],"Mexican peso"]
        ,[["VND","₫","đ","dồng","dong","viet"],"Vietnamese đồng"]
        ,[["AMD","֏","դր","dram","arm"],"Armenian dram"]
        ,[["CVE","Esc","cape","verd"],"Cape Verdean escudo"]
        ,[["EUR","€"],"Euro"]
        ,[["BIF","FBu","bur"],"Burundian franc"]
        ,[["XAF","FCFA"],"Central African CFA franc"]
        ,[["XOF","CFA"],"West African CFA franc"]
        ,[["DJF","Fdj","dji"],"Djiboutian franc"]
        ,[["CHF","fr.","swis"],"Swiss franc"]
        ,[["PYG","₲","guar","parag"],"Paraguayan guaraní"]
        ,[["UAH","₴","грн","hrn","грив","hry","ukr","укр"],"Ukrainian hryvnia"]
        ,[["LAK","₭","kip","lao"],"Lao kip"]
        ,[["CZK","Kč","korun","cze"],"Czech koruna"]
        ,[["DKK","danis"],"Danish krone"]
        ,[["NOK","norw"],"Norwegian krone"]
        ,[["SEK","swe"],"Swedish krona"]
        ,[["ISK","ice"],"Icelandic króna"]
        ,[["FOK","far"],"Faroese króna"]
        ,[["PGK","kin","pap","png"],"Papua New Guinean kina"]
        ,[["MWK","malaw"],"Malawian kwacha"]
        ,[["GEL","₾","ლ","lari","geor"],"Georgian lari"]
        ,[["ALL","lek","alba"],"Albanian lek"]
        ,[["RON","rom"],"Romanian leu"]
        ,[["MDL","mol"],"Moldovan leu"]
        ,[["HNL","lempir","hond"],"Honduran lempira"]
        ,[["BGN","лв","lev","bul"],"Bulgarian lev"]
        ,[["SZL","lil","swaz"],"Swazi lilangeni"]
        ,[["LSL","loti","leso"],"Lesotho loti"]
        ,[["AZN","₼","manat","azer"],"Azerbaijani manat"]
        ,[["ERN","Nkf","ናቕፋ","ناكفا","nakf","erit"],"Eritrean nakfa"]
        ,[["NGN","₦","nair","nig"],"Nigerian naira"]
        ,[["MOP","patac","maca"],"Macanese pataca"]
        ,[["SSP","SS£"],"South Sudanese pound"]
        ,[["SDG","£SD","ج.س"],"Sudanese pound"]
        ,[["IRR","﷼","iran"],"Iranian rial"]
        ,[["OMR","ر.ع.","R.O."],"Omani rial"]
        ,[["SAR","﷼","ر.س","sau"],"Saudi riyal"]]
    currencies3 := [[["YER","ر.ي","﷼","yem"],"Yemeni rial"]
        ,[["KHR","៛","cam"],"Cambodian riel"]
        ,[["INR","₨","₹","indi"],"Indian rupee"]
        ,[["MUR","mauritian"],"Mauritian rupee"]
        ,[["NPR","nep"],"Nepalese rupee"]
        ,[["PKR","pak"],"Pakistani rupee"]
        ,[["LKR","ரூ","රු","sri","lank"],"Sri Lankan rupee"]
        ,[["ILS","₪","NIS","she","isr"],"Israeli new shekel"]
        ,[["TZS","TSh","tanz"],"Tanzanian shilling"]
        ,[["SOS","Sh.So","ShSo","somal"],"Somali shilling"]
        ,[["UGX","USh","uga"],"Ugandan shilling"]
        ,[["XDR","SDR"],"Special drawing rights"]
        ,[["KZT","₸","тен","teŋ","ten","kaz"],"Kazakhstani tenge"]
        ,[["PEN","S/","sol","per"],"Peruvian sol"]
        ,[["MNT","tug","tög","₮","төг","ᠲᠥᠭᠥᠷᠢᠭ","туг","mon"],"Mongolian tögrög"]
        ,[["KRW","원","₩","won","south kor","s.kor"],"South Korean won (may be North)"]
        ,[["KPW","north kor","n.kor"],"North Korean won"]
        ,[["CNY","CN","圆","ren","RMB","yuan","Ұ","chin"],"Chinese Renminbi"]
        ,[["JPY","¥","yen","円","jap"],"Japanese yen"]
        ,[["AOA","Kz","kwanza","ango"],"Angolan kwanza"]
        ,[["BDT","৳","Tk","টাকা","bang","tak"],"Bangladeshi taka"]
        ,[["AWG","ANG","ƒ","Afl","NAf","flor","arub"],"Aruban florin"]
        ,[["STN","Db","dobr","sao","tome","princ"],"São Tomé and Príncipe dobra"]
        ,[["BYN","Br","bela","бел","б.р"],"Belarusian ruble"]
        ,[["KGS","сом","som","С̲","кир","kyr","kir"],"Kyrgyzstani som"]
        ,[["RUB","₽","р","rouble","rus"],"Russian rоuble"]
        ,[["AFN","؋","Af"],"Afghan afghani"]
        ,[["DZD","دج","DA","alg"],"Algerian dinar"]
        ,[["BHD","BD",".د.ب","bahr"],"Bahraini dinar"]
        ,[["TND","د.ت","DT","tunis"],"Tunisian dinar"]
        ,[["MAD","د.م.","DH","moroc"],"Moroccan dirham"]
        ,[["HUF","Ft","forint","hun"],"Hungarian forint"]
        ,[["KMF","CF","como"],"Comorian franc"]
        ,[["CDF","FC","cong"],"Congolese franc"]]
    currencies4 := [[["GNF","FG","GFr"],"Guinean franc"]
        ,[["HRK","kn","kun","cro"],"Croatian kuna"]
        ,[["TRY","₺","TL","lir","tur"],"Turkish lira"]
        ,[["BAM","KM","КМ","bos","her","b&h"],"Bosnia and Herzegovina convertible mark"]
        ,[["MZN","MT","met","moz"],"Mozambican metical"]
        ,[["ZMW","ZK","zam"],"Zambian kwacha"]
        ,[["MRU","UM","ouguiya","mauritanian"],"Mauritanian ouguiya"]
        ,[["EGP","E£","L.E.","ج.م","£E","egyp","egip"],"Egyptian pound"]
        ,[["SYP","£S","LS","syr","sir"],"Syrian pound"]
        ,[["QAR","QR","ر.ق","qat","kat"],"Qatari riyal"]
        ,[["MVR","Rf","ރ","mald","ruf"],"Maldivian rufiyaa"]
        ,[["MYR","RM","ring","malay","malas"],"Malaysian ringgit"]
        ,[["SCR","SR","sey"],"Seychellois rupee"]
        ,[["IDR","Rp","indo"],"Indonesian rupiah"]
        ,[["VUV","VT","van","vat"],"Vanuatu vatu"]
        ,[["PLN","zł","zl","pol"],"Polish złoty"]
        ,[["NZD","NZ","zeal"],"New Zealand dollar"]
        ,[["BZD","BZ","belize"],"Belizean dollar"]
        ,[["KYD","CI","cay"],"Cayman Islands dollar"]
        ,[["FJD","FJ","fij"],"Fiji dollar"]
        ,[["HKD","HK","hong"],"Hong Kong dollar"]
        ,[["TTD","TT","trin","tob","t&t"],"Trinidad and Tobago dollar"]
        ,[["TVD","TV","tuval"],"Tuvaluan dollar"]
        ,[["PHP","₱","P.","ph"],"Philippine peso"]
        ,[["JOD","JD","jo"],"Jordanian dinar"]
        ,[["LYD","LD","ل.د","liby","liv"],"Libyan dinar"]
        ,[["RWG","FRw","R₣","rwa","rua"],"Rwandan franc"]
        ,[["SLL","Le","sie"],"Sierra Leonean leone"]]
    currencies5 := [[["LBP","ل.ل.","LL"],"Lebanese pound"]
        ,[["GBP","£","FKP","GIP","GGP","JEP","IMP","SHP","pou","ster"],"Pound (sterling)"]
        ,[["BWP","P","bot"],"Botswana pula"]
        ,[["MGA","Ari","malag"],"Malagasy ariary"]
        ,[["ZAR","R"],"South African rand"]
        ,[["GMD","D","gamb"],"Gambian dalasi"]
        ,[["GTQ","Q","guat"],"Guatemalan quetzal"]
        ,[["MMK","Ks","kyat","mya"],"Myanmar kyat"]
        ,[["KES","K"],"Kenyan shilling"]
        ,[["HTG","G","hai"],"Haitian gourde"]]

    RegExMatch(Clipboard, "[\D]*(\d+(\.\d+){0,1})[\D]*", amount)
    If amount1
    {
        Loop 5
        {
            For ind, elem in currencies%A_Index%
            {
                For _, var in elem[1]
                {
                    If InStr(Clipboard, var)
                    {
                        web_request := ComObjCreate("WinHttp.WinHttpRequest.5.1")
                        web_request.Open("GET"
                            , "https://api.getgeoapi.com/api/v2/currency/convert?api_key="
                            . CURRENCY_KEY "&from=" elem[1][1] "&to=" base "&amount="
                            . amount1 "&format=json")
                        web_request.Send()
                        result := amount1 " " elem[2] " to " base ": "
                            . Round(RegExReplace(web_request.ResponseText
                                , ".+""rate_for_amount"":""(\d+\.\d+)"".+", "$u1"), 2)
                        Break 3
                    }
                }
            }
        }
    }
    Else
    {
        result := "Incorrect value"
    }
    Return result
}


;===============================================================================================
;===========================================Datetime functions==================================
;===============================================================================================

Datetime(format)
{
    FormatTime, time_string, %A_Now%, %format%
    Return time_string
}

DatetimeFormat()
{
    Clipboard := StrReplace(StrReplace(StrReplace(Clipboard, "д", "d"), "м", "m"), "М", "M")
    Clipboard := StrReplace(StrReplace(StrReplace(Clipboard, "г", "y"), "э", "gg"), "ч", "h")
    Clipboard := StrReplace(StrReplace(StrReplace(Clipboard, "Ч", "H"), "с", "S"), "п", "t")
    FormatTime, time_string, %A_Now%, %Clipboard%
    Return time_string
}


; 10 hours in a day (0-9), 100 minutes in a hour (00-99), 100 seconds in a minute (00-99).
; Second was accelerated by 100_000/86_400≈1.1574
DecimalTime()
{
    ms := (((A_Hour * 60 + A_Min) * 60 + A_Sec) * 1000 + A_MSec) * 1.1574
    hours := Round(ms // 10000000)
    minutes := Round((ms - hours * 10000000) // 100000)
    seconds := Round((ms - hours * 10000000 - minutes * 100000) // 1000)
    Return hours ":" minutes ":" seconds
}

; 10 months in a year, 6 weeks in a month, 6 days in a week.
; The last 5(6 if leap year) days of the year is a holiday week.
; New Year on the Winter solstice (dec 21-22, old style).
HexalDate()
{
    If (!Mod(A_YYYY, 400) || !Mod(A_YYYY, 4) && Mod(A_YYYY, 100))
    {
        leap_mark := 1
    }
    Else
    {
        leap_mark := 0
    }

    If (A_YDay > 355+leap_mark)
    {
        year := A_YYYY+1
        day := A_YDay - 355 - leap_mark
    }
    Else If (A_YDay > 349)
    {
        year := A_YYYY+1
        day := A_YDay - 360
        Return year " holidays, " day
    }
    Else
    {
        year := A_YYYY
        day := A_YDay + 10
    }

    dd := Mod(day, 6)
    ww := Mod(day, 36) // 6
    mm := day // 36
    Return mm "" ww "" dd ". " year
}

NewDatetime()
{
    Return DecimalTime() " | " HexalDate()
}


;===============================================================================================
;===========================================Text transform======================================
;===============================================================================================

; Sample: gO or STaY  ?nOw i goTTa ChoOse, AND i’Ll aCCePt yoUR iNviTATioN to THe blUeS

Normalize()
{
    ; Go or stay? Now I gotta choose, and I’ll accept your invitation to the blues
    StringLower, result, Clipboard
    Return Trim(RegExReplace(RegExReplace(RegExReplace(result, "[     ]+", " ")
        , "[     ]*([.,!?;])[     ]*", "$u1 ")
        , "(((^\s*|([.!?;]+\s+))[a-zа-яё])| i | i'| i’)", "$u1"), OmitChars := " `t`n`r")
}

Sentence()
{
    ; Go or stay  ?now I gotta choose, and I’ll accept your invitation to the blues
    StringLower, result, Clipboard
    Return RegExReplace(result, "(((^\s*|([.!?;]+\s+))[a-zа-яё])| i | i'| i’)", "$u1")
}

Capitalized()
{
    ; Go Or Stay  ?Now I Gotta Choose, And I’ll Accept Your Invitation To The Blues
    StringUpper result, Clipboard, T
    Return result
}

Lowercase()
{
    ; go or stay  ?now i gotta choose, and i’ll accept your invitation to the blues
    StringLower result, Clipboard
    Return result
}

Uppercase()
{
    ; GO OR STAY  ?NOW I GOTTA CHOOSE, AND I’LL ACCEPT YOUR INVITATION TO THE BLUES
    StringUpper result, Clipboard
    Return result
}

Inverted()
{
    ; Go OR stAy  ?NoW I GOttA cHOoSE, and I’lL AccEpT YOur InVItatIOn TO thE BLuEs
    result := ""
    Loop % StrLen(Clipboard)
    {
        cur_char := Asc(SubStr(Clipboard, A_Index, 1))
        If cur_char Between 65 And 90
        {
            result := result Chr(cur_char + 32)
        }
        Else If cur_char Between 1040 And 1071
        {
            result := result Chr(cur_char + 32)
        }
        Else If cur_char Between 97 And 122
        {
            result := result Chr(cur_char - 32)
        }
        Else If cur_char Between 1072 And 1103
        {
            result := result Chr(cur_char - 32)
        }
        Else If (cur_char == 1025)
        {
            result := result Chr(1105)
        }
        Else If (cur_char == 1105)
        {
            result := result Chr(1025)
        }
        Else
        {
            result := result Chr(Cur_char)
        }
    }
    Return result
}

LayoutSwitch(dict)
{
    qphyx_en_ru := { 113:[1102],112:[1087],104:[1093],121:[1099],120:[1103],122:[1079],119:[1096]
        , 108:[1083],100:[1076],118:[1074],101:[1077],097:[1072],111:[1086],105:[1080],117:[1091]
        , 109:[1084],115:[1089],116:[1090],114:[1088],110:[1085],099:[1094],106:[1081],103:[1075]
        , 107:[1082],102:[1092],098:[1073],081:[1070],080:[1055],072:[1061],089:[1067],088:[1071]
        , 090:[1047],087:[1064],076:[1051],068:[1044],086:[1042],069:[1045],065:[1040],079:[1054]
        , 073:[1048],085:[1059],077:[1052],083:[1057],084:[1058],082:[1056],078:[1053],067:[1062]
        , 074:[1049],071:[1043],075:[1050],070:[1060],066:[1041]}
    qphyx_ru_en := { 1102:[113],1087:[112],1093:[104],1099:[121],1103:[120],1079:[122],1096:[119]
        , 1083:[108],1076:[100],1074:[118],1078:[],   1098:[],   1077:[101],1072:[097],1086:[111]
        , 1080:[105],1091:[117],1084:[109],1089:[115],1090:[116],1088:[114],1085:[110],1094:[099]
        , 1081:[106],1101:[],   1105:[],   1075:[103],1100:[],   1082:[107],1092:[102],1095:[]
        , 1097:[],   1073:[098],1070:[081],1055:[080],1061:[072],1067:[089],1071:[088],1047:[090]
        , 1064:[087],1051:[076],1044:[068],1042:[086],1046:[],   1068:[],   1045:[069],1040:[065]
        , 1054:[079],1048:[073],1059:[085],1052:[077],1057:[083],1058:[084],1056:[082],1053:[078]
        , 1062:[067],1049:[074],1069:[],   1025:[],   1043:[071],1066:[],   1050:[075],1060:[070]
        , 1063:[],   1065:[],   1041:[066]}
    qwerty_en_ru := {113:[1081],119:[1094],101:[1091],114:[1082],116:[1077],121:[1085],117:[1075]
        , 105:[1096],111:[1097],112:[1079],091:[1093],093:[1098],097:[1092],115:[1099],100:[1074]
        , 102:[1072],103:[1087],104:[1088],106:[1086],107:[1083],108:[1076],059:[1078],039:[1101]
        , 122:[1103],120:[1095],099:[1089],118:[1084],098:[1080],110:[1090],109:[1100],044:[1073]
        , 046:[1102],047:[0046],096:[1105],081:[1049],087:[1062],069:[1059],082:[1050],084:[1045]
        , 089:[1053],085:[1043],073:[1064],079:[1065],080:[1047],123:[1061],125:[1068],065:[1060]
        , 083:[1067],068:[1042],070:[1040],071:[1055],072:[1056],074:[1054],075:[1051],076:[1044]
        , 058:[1046],034:[1069],090:[1071],088:[1063],067:[1057],086:[1052],066:[1048],078:[1058]
        , 077:[1066],060:[1041],062:[1070],063:[0044],126:[1025],064:[0034],035:[8470],036:[0059]
        , 094:[0058],038:[0063]}
    qwerty_ru_en := {1081:[113],1094:[119],1091:[101],1082:[114],1077:[116],1085:[121],1075:[117]
        , 1096:[105],1097:[111],1079:[112],1093:[091],1098:[093],1092:[097],1099:[115],1074:[100]
        , 1072:[102],1087:[103],1088:[104],1086:[106],1083:[107],1076:[108],1078:[059],1101:[039]
        , 1103:[122],1095:[120],1089:[099],1084:[118],1080:[098],1090:[110],1100:[109],1073:[044]
        , 1102:[046],0046:[047],1105:[096],1049:[081],1062:[087],1059:[069],1050:[082],1045:[084]
        , 1053:[089],1043:[085],1064:[073],1065:[079],1047:[080],1061:[123],1068:[125],1060:[065]
        , 1067:[083],1042:[068],1040:[070],1055:[071],1056:[072],1054:[074],1051:[075],1044:[076]
        , 1046:[058],1069:[034],1071:[090],1063:[088],1057:[067],1052:[086],1048:[066],1058:[078]
        , 1066:[077],1041:[060],1070:[062],0044:[063],1025:[126],0034:[064],8470:[035],0059:[036]
        , 0058:[094],0063:[038]}
    translit_en_ru := {065:[1040],066:[1041],067:[1062],068:[1044],069:[1045],070:[1060]
        , 071:[1043],072:[1061],073:[1048],074:[1046],075:[1050],076:[1051],077:[1052]
        , 078:[1053],079:[1054],080:[1055],081:[1050],082:[1056],083:[1057],084:[1058]
        , 085:[1059],086:[1042],087:[1042],089:[1049],090:[1047],097:[1072],098:[1073]
        , 099:[1094],100:[1076],101:[1077],102:[1092],103:[1075],104:[1093],105:[1080]
        , 106:[1078],107:[1082],108:[1083],109:[1084],110:[1085],111:[1086],112:[1087]
        , 113:[1082],114:[1088],115:[1089],116:[1090],117:[1091],118:[1074],119:[1074]
        , 121:[1081],122:[1079],088:[1050,1057],120:[1082,1089]}
    translit_ru_en := {1040:[65],1041:[66],1042:[86],1043:[71],1044:[68],1045:[69],1046:[90,72]
        , 1047:[90],1048:[73],1049:[89],1050:[75],1051:[76],1052:[77],1053:[78],1054:[79]
        , 1055:[80],1056:[82],1057:[83],1058:[84],1059:[85],1060:[70],1061:[75,72],1062:[84,83]
        , 1063:[67,72],1064:[83,72],1065:[83,72,67,72],1066:[],1067:[89],1068:[],1069:[69]
        , 1070:[89,85],1071:[89,65],1025:[89,79],1072:[97],1073:[98],1074:[118],1075:[103]
        , 1076:[100],1077:[101],1078:[122,104],1079:[122],1080:[105],1081:[121],1082:[107]
        , 1083:[108],1084:[109],1085:[110],1086:[111],1087:[112],1088:[114],1089:[115],1090:[116]
        , 1091:[117],1092:[102],1093:[107,104],1094:[116,115],1095:[99,104],1096:[115,104]
        , 1097:[115,104,99,104],1098:[],1099:[121],1100:[],1101:[101],1102:[121,117]
        , 1103:[121,97],1105:[121,111]}
    result := ""
    Loop % StrLen(Clipboard)
    {
        cur_char := Asc(SubStr(Clipboard, A_Index, 1))
        If %dict%.haskey(cur_char)
        {
            For ind, elem in %dict%[cur_char]
            {
                result := result Chr(elem)
            }
        }
        Else
        {
            result := result Chr(cur_char)
        }
    }
    Return result
}


;===============================================================================================
;===========================================Labels==============================================
;===============================================================================================

Pass:
    Return

Idle:
    delay := MUS_PAUSE_DELAY * 60000
    IfGreater, A_TimeIdle, %delay%, SendInput {SC124}
    If SPOTIFY
    {
        WinGetTitle, title, ahk_id %SPOTIFY%
        If (((title == "Advertisement") ^ !MUTE) && FileExist NIRCMD_PATH)
        {
            MUTE := !MUTE
            Run internal\nircmd.exe setappvolume Spotify.exe %MUTE%
        }
    }
    Return

Reminder:
    InputBox, user_input, Reminder, Remind me in ... minutes, , 200, 130
    If !ErrorLevel
    {
        If user_input is number
        {
            delay := user_input * 60000
            SetTimer, Alarma, %delay%
        }
        Else
        {
            MsgBox, 53, Incorrect value, The input must be a number!
            IfMsgBox Retry
            {
                GoTo, Reminder
            }
        }
    }
    Return

Alarma:
    MsgBox, 48, ALARMA, ALARMA
    SetTimer, Alarma, Off
    Return

QphyxDisable:
    If QPHYX_DISABLE
    {
        IniWrite, 0, %INI%, Configuration, QphyxDisable
    }
    Else
    {
        IniWrite, 1, %INI%, Configuration, QphyxDisable
    }
    QPHYX_DISABLE := !QPHYX_DISABLE
    Run, qphyx%EXT%
    Return

QphyxLongPress:
    InputBox, user_input, Set new long press delay (only for this session!)
        , New value in seconds (e.g. 0.15), , 444, 130
    If !ErrorLevel
    {
        If user_input is number
        {
            Menu, Func, Delete, &Long press delay (now is %QPHYX_LONG_TIME%s)
            Menu, Func, Delete, &Auto-stop music on AFK delay (now is %MUS_PAUSE_DELAY%m)
            IniWrite, %user_input%, %INI%, Configuration, QphyxLongTime
            QPHYX_LONG_TIME := user_input
            Menu, Func, Add, &Long press delay (now is %QPHYX_LONG_TIME%s), LongPress
            Menu, Func, Add, &Auto-stop music on AFK delay (now is %MUS_PAUSE_DELAY%m), MusTimer
            Run, qphyx%EXT%
        }
        Else
        {
            MsgBox, 53, Incorrect value, The input must be a number!
            IfMsgBox Retry
            {
                GoTo, QphyxLongPress
            }
        }
    }
    Return

MusTimer:
    InputBox, user_input, Set new auto-stop music on AFK delay (only for this session!)
        , New value in minutes (e.g. 10), , 444, 130
    If !ErrorLevel
    {
        If user_input is number
        {
            Menu, Func, Delete, &Auto-stop music on AFK delay (now is %MUS_PAUSE_DELAY%m)
            IniWrite, %user_input%, %INI%, Configuration, MusPauseDelay
            MUS_PAUSE_DELAY := user_input
            Menu, Func, Add, &Auto-stop music on AFK delay (now is %MUS_PAUSE_DELAY%m), MusTimer
        }
        Else
        {
            MsgBox, 53, Incorrect value, The input must be a number!
            IfMsgBox Retry
            {
                GoTo, MusTimer
            }
        }
    }
    Return

AddSavedValue:
    message =
    (
        Enter name for new value (with "&&" for hotkey)
Take into account that "test", "&&test" and "tes&&t" are three different values!
If you enter existing value name it will be overwritten without warning!
    )
    InputBox, user_input, New value name, %message%, , 470, 160
    If !ErrorLevel
    {
        InputBox, user_input_2, Value for %user_input%
            , Enter value for %user_input%`nAll values stored solely in "config.ini", , 444, 160
        If !ErrorLevel
        {
            IniWrite, %user_input_2%, %INI%, SavedValue, %user_input%
            MsgBox, Success!
            Run, menu%EXT%
        }
    }
    Return

DeleteSavedValue:
    InputBox, user_input, Enter deleting value name
        , Enter deleting value name (with "&&" if there is), , 470, 140
    If !ErrorLevel
    {
        If !user_input
        {
            MsgBox, 53, , Input must be not empty!
            IfMsgBox Retry
            {
                GoTo, DeleteSavedValue
            }
        }
        Else
        {
            IniDelete, %INI%, SavedValue, %user_input%
            If !ErrorLevel
            {
                MsgBox, Success (or not ¯\_(ツ)_/¯)
                Run, menu%EXT%
            }
            Else
            {
                MsgBox, 53, Incorrect value
                IfMsgBox Retry
                {
                    GoTo, DeleteSavedValue
                }
            }
        }
    }
    Return

;emoji
    Shrug:
        SendInput ¯\_(ツ)_/¯
        Return
    Lenny:
        SendInput ( ͡° ͜ʖ ͡°)
        Return
    Dude:
        SendInput ಠoಠ
        Return
    Why:
        SendInput ლ(・﹏・ლ)
        Return
    Fight:
        SendInput (ง'̀-'́)ง
        Return
    TakeMyEnergy:
        SendInput ༼ つ ◕_◕ ༽つ
        Return
    Rage:
        SendInput (╯°□°)╯︵ ┻━┻
        Return
    PuttingTableBack:
        SendInput ┬─┬ノ( º _ ºノ)
        Return
    Ashamed:
        SendInput (；一_一)
        Return
    Meh:
        SendInput （＾～＾）
        Return
    Koala:
        SendInput ʕ •ᴥ•ʔ
        Return
    Crazy:
        SendInput (◐‿◑)
        Return
    Hug:
        SendInput (っ⌒‿⌒)っ
        Return
    Yikes:
        SendInput (☉__☉”)
        Return
    wOw:
        SendInput (ﾉﾟ0ﾟ)ﾉ~
        Return
    Upset:
        SendInput ༼ ༎ຶ ෴ ༎ຶ༽
        Return


;(\|), on a 102-key keyboards

 SC02B::
    WinGetTitle, title, A
    If (title != "Heroes of Might and Magic III: Horn of the Abyss")
    {
        Menu, Paste, Show, %A_CaretX%, %A_CaretY%
    }
    Else
    {
        SendInput {SC02B}
    }
    Return
+SC02B::
    WinGetTitle, title, A
    If (title != "Heroes of Might and Magic III: Horn of the Abyss")
    {
        If QPHYX_DISABLE
        {
            Menu, Func, Check, Disa&ble (sh+tilde to toggle)
        }
        Else If !QPHYX_DISABLE
        {
            Menu, Func, Uncheck, Disa&ble (sh+tilde to toggle)
        }
        Menu, Func,  Show, %A_CaretX%, %A_CaretY%
    }
    Else
    {
        SendInput +{SC02B}
    }
    Return
