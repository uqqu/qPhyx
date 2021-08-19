;===============================================================================================
;============================================Presets============================================
;===============================================================================================

#SingleInstance force
#UseHook On

icon = menu.ico
IfExist, %icon%
    Menu, Tray, Icon, %icon%

global MUS_DELAY
global MUTE_MODE    ; 0 – disable; 1 – "all_mute button"; 2 – mouse click on spotify mute;
                    ; 3 – volume mixer proccess mute; 4 – 2 mode, if cannot – 3 mode
RegRead, LONG_TIME, HKEY_CURRENT_USER\Environment, MUS_DELAY
RegRead, DISABLE, HKEY_CURRENT_USER\Environment, MUTE_MODE
If !MUS_DELAY
{
    RegWrite, REG_SZ, HKEY_CURRENT_USER\Environment, MUS_DELAY, 10
    RegWrite, REG_SZ, HKEY_CURRENT_USER\Environment, MUTE_MODE, 4
    MUS_DELAY := 10
    MUTE_MODE := 4
}

global SPOTIFY := 0
SpotifyDetectProcessId()

global MUTE := 0
global CITY := "Donetsk,UA" ; 48lat 38lon
global SLEEP_DELAY := 33 ; ms ; for correct work with clipboard functions

;api keys
global CURRENCY_KEY
global WEATHER_KEY
RegRead, CURRENCY_KEY, HKEY_CURRENT_USER\Environment, GETGEOAPI
RegRead, WEATHER_KEY, HKEY_CURRENT_USER\Environment, OPENWEATHERMAP

;qphyx-layout functionality
global DISABLE
global LONG_TIME
RegRead, DISABLE, HKEY_CURRENT_USER\Environment, QPHYX_DISABLE
RegRead, LONG_TIME, HKEY_CURRENT_USER\Environment, QPHYX_LONG_TIME


;music control label (auto pause music on long afk; auto mute volume when advertisement)
SetTimer, Idle, 666


;===============================================================================================
;============================================Paste menu=========================================
;===============================================================================================

Menu, Paste, Add, Paste menu, Pass
Menu, Paste, ToggleEnable, Paste menu
Menu, Paste, Icon, Paste menu, %A_AhkPath%, -207

;"clipboard as input; paste as output" submenu
    Normalize_clip   := Func("@Clip").Bind("Normalize")
    Capitaliz_clip   := Func("@Clip").Bind("Capitalized")
    Lowercase_clip   := Func("@Clip").Bind("Lowercase")
    Uppercase_clip   := Func("@Clip").Bind("Uppercase")
    Inverted_clip    := Func("@Clip").Bind("Inverted")
    Sentence_clip    := Func("@Clip").Bind("Sentence")
    En_Ru_L_clip     := Func("@Clip").Bind(Func("Layout_switch").Bind("qwerty_en_ru"))
    Ru_En_L_clip     := Func("@Clip").Bind(Func("Layout_switch").Bind("qwerty_ru_en"))
    En_Ru_Q_clip     := Func("@Clip").Bind(Func("Layout_switch").Bind("qphyx_en_ru"))
    Ru_En_Q_clip     := Func("@Clip").Bind(Func("Layout_switch").Bind("qphyx_ru_en"))
    En_Ru_T_clip     := Func("@Clip").Bind(Func("Layout_switch").Bind("translit_en_ru"))
    Ru_En_T_clip     := Func("@Clip").Bind(Func("Layout_switch").Bind("translit_ru_en"))
    Calc_expr_clip   := Func("@Clip").Bind("Execute")
    Format_time_clip := Func("@Clip").Bind("Format_time")
    Menu, Clip, Add, Nor&malize, % Normalize_clip
    Menu, Clip, Add, &Sentence,  % Sentence_clip
    Menu, Clip, Add, &Capitalized, % Capitaliz_clip
    Menu, Clip, Add, &Lowercase, % Lowercase_clip
    Menu, Clip, Add, &Uppercase, % Uppercase_clip
    Menu, Clip, Add, &Inverted,  % Inverted_clip
    Menu, Clip, Add
    Menu, Clip, Add, &En-Ru qwerty switch, % En_Ru_L_clip
    Menu, Clip, Add, &Ru-En qwerty switch, % Ru_En_L_clip
    Menu, Clip, Add, En-Ru q&phyx switch, % En_Ru_Q_clip
    Menu, Clip, Add, Ru-En &qphyx switch, % Ru_En_Q_clip
    Menu, Clip, Add, E&n-Ru transliteration, % En_Ru_T_clip
    Menu, Clip, Add, Ru-En transliterati&on, % Ru_En_T_clip
    Menu, Clip, Add
    Menu, Clip, Add, C&alculate the expression, % Calc_expr_clip
    Menu, Clip, Add, &FormatTime (e.g. "dd/MM" to "26/03"), % Format_time_clip
    ;currency converter submenu
        Usd_rub_c_c  := Func("@Clip").Bind(Func("Exch_rates").Bind("USD", "RUB", 0))
        Rub_usd_c_c  := Func("@Clip").Bind(Func("Exch_rates").Bind("RUB", "USD", 0))
        Uah_usd_c_c  := Func("@Clip").Bind(Func("Exch_rates").Bind("UAH", "USD", 0))
        Usd_uah_c_c  := Func("@Clip").Bind(Func("Exch_rates").Bind("USD", "UAH", 0))
        Rub_uah_c_c  := Func("@Clip").Bind(Func("Exch_rates").Bind("RUB", "UAH", 0))
        Uah_rub_c_c  := Func("@Clip").Bind(Func("Exch_rates").Bind("UAH", "RUB", 0))
        Usd_eur_c_c  := Func("@Clip").Bind(Func("Exch_rates").Bind("USD", "EUR", 0))
        Eur_usd_c_c  := Func("@Clip").Bind(Func("Exch_rates").Bind("EUR", "USD", 0))
        Unk_to_usd_c := Func("@Clip").Bind(Func("Unknown_currency").Bind("USD"))
        Unk_to_rub_c := Func("@Clip").Bind(Func("Unknown_currency").Bind("RUB"))
        Menu, Conv_c, Add, &USD–RUB, % Usd_rub_c_c
        Menu, Conv_c, Add, &RUB–USD, % Rub_usd_c_c
        Menu, Conv_c, Add
        Menu, Conv_c, Add, U&SD–UAH, % Usd_uah_c_c
        Menu, Conv_c, Add, UA&H–USD, % Uah_usd_c_c
        Menu, Conv_c, Add
        Menu, Conv_c, Add, U&AH–RUB, % Uah_rub_c_c
        Menu, Conv_c, Add, RU&B–UAH, % Rub_uah_c_c
        Menu, Conv_c, Add
        Menu, Conv_c, Add, US&D–EUR, % Usd_eur_c_c
        Menu, Conv_c, Add, &EUR–USD, % Eur_usd_c_c
        Menu, Conv_c, Add
        Menu, Conv_c, Add, ... &to USD, % Unk_to_usd_c
        Menu, Conv_c, Add, ... t&o RUB, % Unk_to_rub_c
    Menu, Clip, Add, Currenc&y converter, :Conv_c
Menu, Paste, Add, &Clipboard text transform, :Clip

;"selected text as input; paste as output" submenu
    Normalize_sel   := Func("@Sel").Bind("Normalize")
    Capitaliz_sel   := Func("@Sel").Bind("Capitalized")
    Lowercase_sel   := Func("@Sel").Bind("Lowercase")
    Uppercase_sel   := Func("@Sel").Bind("Uppercase")
    Inverted_sel    := Func("@Sel").Bind("Inverted")
    Sentence_sel    := Func("@Sel").Bind("Sentence")
    En_Ru_L_sel     := Func("@Sel").Bind(Func("Layout_switch").Bind("qwerty_en_ru"))
    Ru_En_L_sel     := Func("@Sel").Bind(Func("Layout_switch").Bind("qwerty_ru_en"))
    En_Ru_Q_sel     := Func("@Sel").Bind(Func("Layout_switch").Bind("qphyx_en_ru"))
    Ru_En_Q_sel     := Func("@Sel").Bind(Func("Layout_switch").Bind("qphyx_ru_en"))
    En_Ru_T_sel     := Func("@Sel").Bind(Func("Layout_switch").Bind("translit_en_ru"))
    Ru_En_T_sel     := Func("@Sel").Bind(Func("Layout_switch").Bind("translit_ru_en"))
    Calc_expr_sel   := Func("@Sel").Bind("Execute")
    Format_time_sel := Func("@Sel").Bind("Format_time")
    Menu, Sel, Add, Nor&malize,   % Normalize_sel
    Menu, Sel, Add, &Sentence,    % Sentence_sel
    Menu, Sel, Add, &Capitalized, % Capitaliz_sel
    Menu, Sel, Add, &Lowercase,   % Lowercase_sel
    Menu, Sel, Add, &Uppercase,   % Uppercase_sel
    Menu, Sel, Add, &Inverted,    % Inverted_sel
    Menu, Sel, Add
    Menu, Sel, Add, &En-Ru qwerty switch, % En_Ru_L_sel
    Menu, Sel, Add, &Ru-En qwerty switch, % Ru_En_L_sel
    Menu, Sel, Add, En-Ru &qphyx switch, % En_Ru_Q_sel
    Menu, Sel, Add, Ru-En q&phyx switch, % Ru_En_Q_sel
    Menu, Sel, Add, E&n-Ru transliteration, % En_Ru_T_sel
    Menu, Sel, Add, Ru-En transliterati&on, % Ru_En_T_sel
    Menu, Sel, Add
    Menu, Sel, Add, C&alculate the expression, % Calc_expr_sel
    Menu, Sel, Add, &FormatTime (e.g. "dd/MM" to "26/03"), % Format_time_sel
    ;currency converter submenu
        Usd_rub_c_s  := Func("@Sel").Bind(Func("Exch_rates").Bind("USD", "RUB", 0))
        Rub_usd_c_s  := Func("@Sel").Bind(Func("Exch_rates").Bind("RUB", "USD", 0))
        Uah_usd_c_s  := Func("@Sel").Bind(Func("Exch_rates").Bind("UAH", "USD", 0))
        Usd_uah_c_s  := Func("@Sel").Bind(Func("Exch_rates").Bind("USD", "UAH", 0))
        Rub_uah_c_s  := Func("@Sel").Bind(Func("Exch_rates").Bind("RUB", "UAH", 0))
        Uah_rub_c_s  := Func("@Sel").Bind(Func("Exch_rates").Bind("UAH", "RUB", 0))
        Usd_eur_c_s  := Func("@Sel").Bind(Func("Exch_rates").Bind("USD", "EUR", 0))
        Eur_usd_c_s  := Func("@Sel").Bind(Func("Exch_rates").Bind("EUR", "USD", 0))
        Unk_to_usd_s := Func("@Sel").Bind(Func("Unknown_currency").Bind("USD"))
        Unk_to_rub_s := Func("@Sel").Bind(Func("Unknown_currency").Bind("RUB"))
        Menu, Conv_s, Add, &USD–RUB, % Usd_rub_c_s
        Menu, Conv_s, Add, &RUB–USD, % Rub_usd_c_s
        Menu, Conv_s, Add
        Menu, Conv_s, Add, U&SD–UAH, % Usd_uah_c_s
        Menu, Conv_s, Add, UA&H–USD, % Uah_usd_c_s
        Menu, Conv_s, Add
        Menu, Conv_s, Add, U&AH–RUB, % Uah_rub_c_s
        Menu, Conv_s, Add, RU&B–UAH, % Rub_uah_c_s
        Menu, Conv_s, Add
        Menu, Conv_s, Add, US&D–EUR, % Usd_eur_c_s
        Menu, Conv_s, Add, &EUR–USD, % Eur_usd_c_s
        Menu, Conv_s, Add
        Menu, Conv_s, Add, ... &to USD, % Unk_to_usd_s
        Menu, Conv_s, Add, ... t&o RUB, % Unk_to_rub_s
    Menu, Sel, Add, Currenc&y converter, :Conv_s
Menu, Paste, Add, &Selected text transform, :Sel

;"input_box as input; paste as output" submenu
    Normalize_inp   := Func("@Inp").Bind("Normalize")
    Capitaliz_inp   := Func("@Inp").Bind("Capitalized")
    Lowercase_inp   := Func("@Inp").Bind("Lowercase")
    Uppercase_inp   := Func("@Inp").Bind("Uppercase")
    Inverted_inp    := Func("@Inp").Bind("Inverted")
    Sentence_inp    := Func("@Inp").Bind("Sentence")
    En_Ru_L_inp     := Func("@Inp").Bind(Func("Layout_switch").Bind("qwerty_en_ru"))
    Ru_En_L_inp     := Func("@Inp").Bind(Func("Layout_switch").Bind("qwerty_ru_en"))
    En_Ru_Q_inp     := Func("@Inp").Bind(Func("Layout_switch").Bind("qphyx_en_ru"))
    Ru_En_Q_inp     := Func("@Inp").Bind(Func("Layout_switch").Bind("qphyx_ru_en"))
    En_Ru_T_inp     := Func("@Inp").Bind(Func("Layout_switch").Bind("translit_en_ru"))
    Ru_En_T_inp     := Func("@Inp").Bind(Func("Layout_switch").Bind("translit_ru_en"))
    Calc_expr_inp   := Func("@Inp").Bind("Execute")
    Format_time_inp := Func("@Inp").Bind("Format_time")
    Menu, Inp, Add, Nor&malize,   % Normalize_inp
    Menu, Inp, Add, &Sentence,    % Sentence_inp
    Menu, Inp, Add, &Capitalized, % Capitaliz_inp
    Menu, Inp, Add, &Lowercase,   % Lowercase_inp
    Menu, Inp, Add, &Uppercase,   % Uppercase_inp
    Menu, Inp, Add, &Inverted,    % Inverted_inp
    Menu, Inp, Add
    Menu, Inp, Add, &En-Ru qwerty switch, % En_Ru_L_inp
    Menu, Inp, Add, &Ru-En qwerty switch, % Ru_En_L_inp
    Menu, Inp, Add, En-Ru &qphyx switch, % En_Ru_Q_inp
    Menu, Inp, Add, Ru-En q&phyx switch, % Ru_En_Q_inp
    Menu, Inp, Add, E&n-Ru transliteration, % En_Ru_T_inp
    Menu, Inp, Add, Ru-En transliterati&on, % Ru_En_T_inp
    Menu, Inp, Add
    Menu, Inp, Add, C&alculate the expression, % Calc_expr_inp
    Menu, Inp, Add, &FormatTime (e.g. "dd/MM" to "26/03"), % Format_time_inp
    ;currency converter submenu
        Usd_rub_c_i  := Func("@Inp").Bind(Func("Exch_rates").Bind("USD", "RUB", 0))
        Rub_usd_c_i  := Func("@Inp").Bind(Func("Exch_rates").Bind("RUB", "USD", 0))
        Uah_usd_c_i  := Func("@Inp").Bind(Func("Exch_rates").Bind("UAH", "USD", 0))
        Usd_uah_c_i  := Func("@Inp").Bind(Func("Exch_rates").Bind("USD", "UAH", 0))
        Rub_uah_c_i  := Func("@Inp").Bind(Func("Exch_rates").Bind("RUB", "UAH", 0))
        Uah_rub_c_i  := Func("@Inp").Bind(Func("Exch_rates").Bind("UAH", "RUB", 0))
        Usd_eur_c_i  := Func("@Inp").Bind(Func("Exch_rates").Bind("USD", "EUR", 0))
        Eur_usd_c_i  := Func("@Inp").Bind(Func("Exch_rates").Bind("EUR", "USD", 0))
        Unk_to_usd_i := Func("@Inp").Bind(Func("Unknown_currency").Bind("USD"))
        Unk_to_rub_i := Func("@Inp").Bind(Func("Unknown_currency").Bind("RUB"))
        Menu, Conv_i, Add, &USD–RUB, % Usd_rub_c_i
        Menu, Conv_i, Add, &RUB–USD, % Rub_usd_c_i
        Menu, Conv_i, Add
        Menu, Conv_i, Add, U&SD–UAH, % Usd_uah_c_i
        Menu, Conv_i, Add, UA&H–USD, % Uah_usd_c_i
        Menu, Conv_i, Add
        Menu, Conv_i, Add, U&AH–RUB, % Uah_rub_c_i
        Menu, Conv_i, Add, RU&B–UAH, % Rub_uah_c_i
        Menu, Conv_i, Add
        Menu, Conv_i, Add, US&D–EUR, % Usd_eur_c_i
        Menu, Conv_i, Add, &EUR–USD, % Eur_usd_c_i
        Menu, Conv_i, Add
        Menu, Conv_i, Add, ... &to USD, % Unk_to_usd_i
        Menu, Conv_i, Add, ... t&o RUB, % Unk_to_rub_i
    Menu, Inp, Add, Currenc&y converter, :Conv_i
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
    Time_pst     := Func("@Clip").Bind(Func("Datetime").Bind("hh:mm:ss tt"))
    Date_pst     := Func("@Clip").Bind(Func("Datetime").Bind("MMMM dd"))
    DT_pst       := Func("@Clip").Bind(Func("Datetime").Bind("dddd, MMMM dd yyyy hh:mm:ss tt"))
    New_time_pst := Func("@Clip").Bind("Decimal_time")
    New_date_pst := Func("@Clip").Bind("Hexal_date")
    New_datetime := Func("@Clip").Bind("New_datetime")
    Menu, DT_P, Add, &Time, % Time_pst
    Menu, DT_P, Add, &Date, % Date_pst
    Menu, DT_P, Add, DateTi&me, % DT_pst
    Menu, DT_P, Add, De&cimal time, % New_time_pst
    Menu, DT_P, Add, &Hexal date, % New_date_pst
    Menu, DT_P, Add, &New datetime, % New_datetime
Menu, Paste, Add, &Datetime, :DT_P

;exchange rates submenu
    Usd_rub_r_p := Func("@Clip").Bind(Func("Exch_rates").Bind("USD", "RUB"))
    Rub_usd_r_p := Func("@Clip").Bind(Func("Exch_rates").Bind("RUB", "USD"))
    Uah_usd_r_p := Func("@Clip").Bind(Func("Exch_rates").Bind("UAH", "USD"))
    Usd_uah_r_p := Func("@Clip").Bind(Func("Exch_rates").Bind("USD", "UAH"))
    Rub_uah_r_p := Func("@Clip").Bind(Func("Exch_rates").Bind("RUB", "UAH"))
    Uah_rub_r_p := Func("@Clip").Bind(Func("Exch_rates").Bind("UAH", "RUB"))
    Usd_eur_r_p := Func("@Clip").Bind(Func("Exch_rates").Bind("USD", "EUR"))
    Eur_usd_r_p := Func("@Clip").Bind(Func("Exch_rates").Bind("EUR", "USD"))
    Menu, Rates_p, Add, &USD–RUB, % Usd_rub_r_p
    Menu, Rates_p, Add, &RUB–USD, % Rub_usd_r_p
    Menu, Rates_p, Add
    Menu, Rates_p, Add, U&SD–UAH, % Usd_uah_r_p
    Menu, Rates_p, Add, UA&H–USD, % Uah_usd_r_p
    Menu, Rates_p, Add
    Menu, Rates_p, Add, U&AH–RUB, % Uah_rub_r_p
    Menu, Rates_p, Add, RU&B–UAH, % Rub_uah_r_p
    Menu, Rates_p, Add
    Menu, Rates_p, Add, US&D–EUR, % Usd_eur_r_p
    Menu, Rates_p, Add, &EUR–USD, % Eur_usd_r_p
Menu, Paste, Add, E&xchange rate, :Rates_p

Weather_pst := Func("@Clip").Bind(Func("Weather").Bind(CITY))
Menu, Paste, Add, Current &weather, % Weather_pst


;===============================================================================================
;============================================Message menu=======================================
;===============================================================================================

Menu, Func, Add, Message menu, Pass
Menu, Func, ToggleEnable, Message menu
Menu, Func, Icon, Message menu, %A_AhkPath%, -207

Compare_msg := Func("Compare")
Menu, Func, Add, C&ompare selected with clipboard, % Compare_msg
Menu, Func, Add

;"clipboard text as input; message box as output" submenu
    Normalize_c_msg   := Func("@C_Msg").Bind("Normalize")
    Capitaliz_c_msg   := Func("@C_Msg").Bind("Capitalized")
    Lowercase_c_msg   := Func("@C_Msg").Bind("Lowercase")
    Uppercase_c_msg   := Func("@C_Msg").Bind("Uppercase")
    Inverted_c_msg    := Func("@C_Msg").Bind("Inverted")
    Sentence_c_msg    := Func("@C_Msg").Bind("Sentence")
    En_Ru_L_c_msg     := Func("@C_Msg").Bind(Func("Layout_switch").Bind("qwerty_en_ru"))
    Ru_En_L_c_msg     := Func("@C_Msg").Bind(Func("Layout_switch").Bind("qwerty_ru_en"))
    En_Ru_Q_c_msg     := Func("@C_Msg").Bind(Func("Layout_switch").Bind("qphyx_en_ru"))
    Ru_En_Q_c_msg     := Func("@C_Msg").Bind(Func("Layout_switch").Bind("qphyx_ru_en"))
    En_Ru_T_c_msg     := Func("@C_Msg").Bind(Func("Layout_switch").Bind("translit_en_ru"))
    Ru_En_T_c_msg     := Func("@C_Msg").Bind(Func("Layout_switch").Bind("translit_ru_en"))
    Calc_expr_c_msg   := Func("@C_Msg").Bind("Execute")
    Format_time_c_msg := Func("@C_Msg").Bind("Format_time")
    Menu, C_Msg, Add, Nor&malize,   % Normalize_c_msg
    Menu, C_Msg, Add, &Sentence,    % Sentence_c_msg
    Menu, C_Msg, Add, &Capitalized, % Capitaliz_c_msg
    Menu, C_Msg, Add, &Lowercase,   % Lowercase_c_msg
    Menu, C_Msg, Add, &Uppercase,   % Uppercase_c_msg
    Menu, C_Msg, Add, &Inverted,    % Inverted_c_msg
    Menu, C_Msg, Add
    Menu, C_Msg, Add, &En-Ru qwerty switch, % En_Ru_L_c_msg
    Menu, C_Msg, Add, &Ru-En qwerty switch, % Ru_En_L_c_msg
    Menu, C_Msg, Add, En-Ru &qphyx switch, % En_Ru_Q_c_msg
    Menu, C_Msg, Add, Ru-En q&phyx switch, % Ru_En_Q_c_msg
    Menu, C_Msg, Add, E&n-Ru transliteration, % En_Ru_T_c_msg
    Menu, C_Msg, Add, Ru-En transliterati&on, % Ru_En_T_c_msg
    Menu, C_Msg, Add
    Menu, C_Msg, Add, C&alculate the expression, % Calc_expr_c_msg
    Menu, C_Msg, Add, &FormatTime (e.g. "dd/MM" to "26/03"), % Format_time_c_msg
    ;currency converter submenu
        Usd_rub_c_m_c  := Func("@C_Msg").Bind(Func("Exch_rates").Bind("USD", "RUB", 0))
        Rub_usd_c_m_c  := Func("@C_Msg").Bind(Func("Exch_rates").Bind("RUB", "USD", 0))
        Uah_usd_c_m_c  := Func("@C_Msg").Bind(Func("Exch_rates").Bind("UAH", "USD", 0))
        Usd_uah_c_m_c  := Func("@C_Msg").Bind(Func("Exch_rates").Bind("USD", "UAH", 0))
        Rub_uah_c_m_c  := Func("@C_Msg").Bind(Func("Exch_rates").Bind("RUB", "UAH", 0))
        Uah_rub_c_m_c  := Func("@C_Msg").Bind(Func("Exch_rates").Bind("UAH", "RUB", 0))
        Usd_eur_c_m_c  := Func("@C_Msg").Bind(Func("Exch_rates").Bind("USD", "EUR", 0))
        Eur_usd_c_m_c  := Func("@C_Msg").Bind(Func("Exch_rates").Bind("EUR", "USD", 0))
        Unk_to_usd_m_c := Func("@C_Msg").Bind(Func("Unknown_currency").Bind("USD"))
        Unk_to_rub_m_c := Func("@C_Msg").Bind(Func("Unknown_currency").Bind("RUB"))
        Menu, Conv_m_c, Add, &USD–RUB, % Usd_rub_c_m_c
        Menu, Conv_m_c, Add, &RUB–USD, % Rub_usd_c_m_c
        Menu, Conv_m_c, Add
        Menu, Conv_m_c, Add, U&SD–UAH, % Usd_uah_c_m_c
        Menu, Conv_m_c, Add, UA&H–USD, % Uah_usd_c_m_c
        Menu, Conv_m_c, Add
        Menu, Conv_m_c, Add, U&AH–RUB, % Uah_rub_c_m_c
        Menu, Conv_m_c, Add, RU&B–UAH, % Rub_uah_c_m_c
        Menu, Conv_m_c, Add
        Menu, Conv_m_c, Add, US&D–EUR, % Usd_eur_c_m_c
        Menu, Conv_m_c, Add, &EUR–USD, % Eur_usd_c_m_c
        Menu, Conv_m_c, Add
        Menu, Conv_m_c, Add, ... &to USD, % Unk_to_usd_m_c
        Menu, Conv_m_c, Add, ... t&o RUB, % Unk_to_rub_m_c
    Menu, C_Msg, Add, Currenc&y converter, :Conv_m_c
Menu, Func, Add, &Clipboard text transform, :C_Msg

;"selected text as input; message box as output" submenu
    Normalize_s_msg   := Func("@S_Msg").Bind("Normalize")
    Capitaliz_s_msg   := Func("@S_Msg").Bind("Capitalized")
    Lowercase_s_msg   := Func("@S_Msg").Bind("Lowercase")
    Uppercase_s_msg   := Func("@S_Msg").Bind("Uppercase")
    Inverted_s_msg    := Func("@S_Msg").Bind("Inverted")
    Sentence_s_msg    := Func("@S_Msg").Bind("Sentence")
    En_Ru_L_s_msg     := Func("@S_Msg").Bind(Func("Layout_switch").Bind("qwerty_en_ru"))
    Ru_En_L_s_msg     := Func("@S_Msg").Bind(Func("Layout_switch").Bind("qwerty_ru_en"))
    En_Ru_Q_s_msg     := Func("@S_Msg").Bind(Func("Layout_switch").Bind("qphyx_en_ru"))
    Ru_En_Q_s_msg     := Func("@S_Msg").Bind(Func("Layout_switch").Bind("qphyx_ru_en"))
    En_Ru_T_s_msg     := Func("@S_Msg").Bind(Func("Layout_switch").Bind("translit_en_ru"))
    Ru_En_T_s_msg     := Func("@S_Msg").Bind(Func("Layout_switch").Bind("translit_ru_en"))
    Calc_expr_s_msg   := Func("@S_Msg").Bind("Execute")
    Format_time_s_msg := Func("@S_Msg").Bind("Format_time")
    Menu, S_Msg, Add, Nor&malize,   % Normalize_s_msg
    Menu, S_Msg, Add, &Sentence,    % Sentence_s_msg
    Menu, S_Msg, Add, &Capitalized, % Capitaliz_s_msg
    Menu, S_Msg, Add, &Lowercase,   % Lowercase_s_msg
    Menu, S_Msg, Add, &Uppercase,   % Uppercase_s_msg
    Menu, S_Msg, Add, &Inverted,    % Inverted_s_msg
    Menu, S_Msg, Add
    Menu, S_Msg, Add, &En-Ru qwerty switch, % En_Ru_L_s_msg
    Menu, S_Msg, Add, &Ru-En qwerty switch, % Ru_En_L_s_msg
    Menu, S_Msg, Add, En-Ru &qphyx switch, % En_Ru_Q_s_msg
    Menu, S_Msg, Add, Ru-En q&phyx switch, % Ru_En_Q_s_msg
    Menu, S_Msg, Add, E&n-Ru transliteration, % En_Ru_T_s_msg
    Menu, S_Msg, Add, Ru-En transliterati&on, % Ru_En_T_s_msg
    Menu, S_Msg, Add
    Menu, S_Msg, Add, C&alculate the expression, % Calc_expr_s_msg
    Menu, S_Msg, Add, &FormatTime (e.g. "dd/MM" to "26/03"), % Format_time_s_msg
    ;currency converter submenu
        Usd_rub_c_m_s  := Func("@S_Msg").Bind(Func("Exch_rates").Bind("USD", "RUB", 0))
        Rub_usd_c_m_s  := Func("@S_Msg").Bind(Func("Exch_rates").Bind("RUB", "USD", 0))
        Uah_usd_c_m_s  := Func("@S_Msg").Bind(Func("Exch_rates").Bind("UAH", "USD", 0))
        Usd_uah_c_m_s  := Func("@S_Msg").Bind(Func("Exch_rates").Bind("USD", "UAH", 0))
        Rub_uah_c_m_s  := Func("@S_Msg").Bind(Func("Exch_rates").Bind("RUB", "UAH", 0))
        Uah_rub_c_m_s  := Func("@S_Msg").Bind(Func("Exch_rates").Bind("UAH", "RUB", 0))
        Usd_eur_c_m_s  := Func("@S_Msg").Bind(Func("Exch_rates").Bind("USD", "EUR", 0))
        Eur_usd_c_m_s  := Func("@S_Msg").Bind(Func("Exch_rates").Bind("EUR", "USD", 0))
        Unk_to_usd_m_s := Func("@S_Msg").Bind(Func("Unknown_currency").Bind("USD"))
        Unk_to_rub_m_s := Func("@S_Msg").Bind(Func("Unknown_currency").Bind("RUB"))
        Menu, Conv_m_s, Add, &USD–RUB, % Usd_rub_c_m_s
        Menu, Conv_m_s, Add, &RUB–USD, % Rub_usd_c_m_s
        Menu, Conv_m_s, Add
        Menu, Conv_m_s, Add, U&SD–UAH, % Usd_uah_c_m_s
        Menu, Conv_m_s, Add, UA&H–USD, % Uah_usd_c_m_s
        Menu, Conv_m_s, Add
        Menu, Conv_m_s, Add, U&AH–RUB, % Uah_rub_c_m_s
        Menu, Conv_m_s, Add, RU&B–UAH, % Rub_uah_c_m_s
        Menu, Conv_m_s, Add
        Menu, Conv_m_s, Add, US&D–EUR, % Usd_eur_c_m_s
        Menu, Conv_m_s, Add, &EUR–USD, % Eur_usd_c_m_s
        Menu, Conv_m_s, Add
        Menu, Conv_m_s, Add, ... &to USD, % Unk_to_usd_m_s
        Menu, Conv_m_s, Add, ... t&o RUB, % Unk_to_rub_m_s
    Menu, S_Msg, Add, Currenc&y converter, :Conv_m_s
Menu, Func, Add, &Selected text transform, :S_Msg

;"input box as input; message box as output" submenu
    Normalize_i_msg   := Func("@I_Msg").Bind("Normalize")
    Capitaliz_i_msg   := Func("@I_Msg").Bind("Capitalized")
    Lowercase_i_msg   := Func("@I_Msg").Bind("Lowercase")
    Uppercase_i_msg   := Func("@I_Msg").Bind("Uppercase")
    Inverted_i_msg    := Func("@I_Msg").Bind("Inverted")
    Sentence_i_msg    := Func("@I_Msg").Bind("Sentence")
    En_Ru_L_i_msg     := Func("@I_Msg").Bind(Func("Layout_switch").Bind("qwerty_en_ru"))
    Ru_En_L_i_msg     := Func("@I_Msg").Bind(Func("Layout_switch").Bind("qwerty_ru_en"))
    En_Ru_Q_i_msg     := Func("@I_Msg").Bind(Func("Layout_switch").Bind("qphyx_en_ru"))
    Ru_En_Q_i_msg     := Func("@I_Msg").Bind(Func("Layout_switch").Bind("qphyx_ru_en"))
    En_Ru_T_i_msg     := Func("@I_Msg").Bind(Func("Layout_switch").Bind("translit_en_ru"))
    Ru_En_T_i_msg     := Func("@I_Msg").Bind(Func("Layout_switch").Bind("translit_ru_en"))
    Calc_expr_i_msg   := Func("@I_Msg").Bind("Execute")
    Format_time_i_msg := Func("@I_Msg").Bind("Format_time")
    Menu, I_Msg, Add, Nor&malize,   % Normalize_i_msg
    Menu, I_Msg, Add, &Sentence,    % Sentence_i_msg
    Menu, I_Msg, Add, &Capitalized, % Capitaliz_i_msg
    Menu, I_Msg, Add, &Lowercase,   % Lowercase_i_msg
    Menu, I_Msg, Add, &Uppercase,   % Uppercase_i_msg
    Menu, I_Msg, Add, &Inverted,    % Inverted_i_msg
    Menu, I_Msg, Add
    Menu, I_Msg, Add, &En-Ru qwerty switch, % En_Ru_L_i_msg
    Menu, I_Msg, Add, &Ru-En qwerty switch, % Ru_En_L_i_msg
    Menu, I_Msg, Add, En-Ru &qphyx switch, % En_Ru_Q_i_msg
    Menu, I_Msg, Add, Ru-En q&phyx switch, % Ru_En_Q_i_msg
    Menu, I_Msg, Add, E&n-Ru transliteration, % En_Ru_T_i_msg
    Menu, I_Msg, Add, Ru-En transliterati&on, % Ru_En_T_i_msg
    Menu, I_Msg, Add
    Menu, I_Msg, Add, C&alculate the expression, % Calc_expr_i_msg
    Menu, I_Msg, Add, &FormatTime (e.g. "dd/MM" to "26/03"), % Format_time_i_msg
    ;currency converter submenu
        Usd_rub_c_m_i  := Func("@I_Msg").Bind(Func("Exch_rates").Bind("USD", "RUB", 0))
        Rub_usd_c_m_i  := Func("@I_Msg").Bind(Func("Exch_rates").Bind("RUB", "USD", 0))
        Uah_usd_c_m_i  := Func("@I_Msg").Bind(Func("Exch_rates").Bind("UAH", "USD", 0))
        Usd_uah_c_m_i  := Func("@I_Msg").Bind(Func("Exch_rates").Bind("USD", "UAH", 0))
        Rub_uah_c_m_i  := Func("@I_Msg").Bind(Func("Exch_rates").Bind("RUB", "UAH", 0))
        Uah_rub_c_m_i  := Func("@I_Msg").Bind(Func("Exch_rates").Bind("UAH", "RUB", 0))
        Usd_eur_c_m_i  := Func("@I_Msg").Bind(Func("Exch_rates").Bind("USD", "EUR", 0))
        Eur_usd_c_m_i  := Func("@I_Msg").Bind(Func("Exch_rates").Bind("EUR", "USD", 0))
        Unk_to_usd_m_i := Func("@I_Msg").Bind(Func("Unknown_currency").Bind("USD"))
        Unk_to_rub_m_i := Func("@I_Msg").Bind(Func("Unknown_currency").Bind("RUB"))
        Menu, Conv_m_i, Add, &USD–RUB, % Usd_rub_c_m_i
        Menu, Conv_m_i, Add, &RUB–USD, % Rub_usd_c_m_i
        Menu, Conv_m_i, Add
        Menu, Conv_m_i, Add, U&SD–UAH, % Usd_uah_c_m_i
        Menu, Conv_m_i, Add, UA&H–USD, % Uah_usd_c_m_i
        Menu, Conv_m_i, Add
        Menu, Conv_m_i, Add, U&AH–RUB, % Uah_rub_c_m_i
        Menu, Conv_m_i, Add, RU&B–UAH, % Rub_uah_c_m_i
        Menu, Conv_m_i, Add
        Menu, Conv_m_i, Add, US&D–EUR, % Usd_eur_c_m_i
        Menu, Conv_m_i, Add, &EUR–USD, % Eur_usd_c_m_i
        Menu, Conv_m_i, Add
        Menu, Conv_m_i, Add, ... &to USD, % Unk_to_usd_m_i
        Menu, Conv_m_i, Add, ... t&o RUB, % Unk_to_rub_m_i
    Menu, I_Msg, Add, Currenc&y converter, :Conv_m_i
Menu, Func, Add, &Input text to transform, :I_Msg
Menu, Func, Add

;time submenu
    Time_msg     := Func("@C_Msg").Bind(Func("Datetime").Bind("hh:mm:ss tt"))
    Date_msg     := Func("@C_Msg").Bind(Func("Datetime").Bind("MMMM dd"))
    DT_msg       := Func("@C_Msg").Bind(Func("Datetime").Bind("dddd, MMMM dd yyyy hh:mm:ss tt"))
    New_time_msg := Func("@C_Msg").Bind("Decimal_time")
    New_date_msg := Func("@C_Msg").Bind("Hexal_date")
    New_dt_msg   := Func("@C_Msg").Bind("New_datetime")
    Menu, DT_M, Add, &Time, % Time_msg
    Menu, DT_M, Add, &Date, % Date_msg
    Menu, DT_M, Add, DateTi&me, % DT_msg
    Menu, DT_M, Add, De&cimal time, % New_time_msg
    Menu, DT_M, Add, &Hexal date, % New_date_msg
    Menu, DT_M, Add, &New datetime, % New_dt_msg
Menu, Func, Add, &Datetime, :DT_M

;exchange rates submenu
    Usd_rub_r_m := Func("@C_Msg").Bind(Func("Exch_rates").Bind("USD", "RUB"))
    Rub_usd_r_m := Func("@C_Msg").Bind(Func("Exch_rates").Bind("RUB", "USD"))
    Uah_usd_r_m := Func("@C_Msg").Bind(Func("Exch_rates").Bind("UAH", "USD"))
    Usd_uah_r_m := Func("@C_Msg").Bind(Func("Exch_rates").Bind("USD", "UAH"))
    Rub_uah_r_m := Func("@C_Msg").Bind(Func("Exch_rates").Bind("RUB", "UAH"))
    Uah_rub_r_m := Func("@C_Msg").Bind(Func("Exch_rates").Bind("UAH", "RUB"))
    Usd_eur_r_m := Func("@C_Msg").Bind(Func("Exch_rates").Bind("USD", "EUR"))
    Eur_usd_r_m := Func("@C_Msg").Bind(Func("Exch_rates").Bind("EUR", "USD"))
    Menu, Rates_m, Add, &USD–RUB, % Usd_rub_r_m
    Menu, Rates_m, Add, &RUB–USD, % Rub_usd_r_m
    Menu, Rates_m, Add
    Menu, Rates_m, Add, U&SD–UAH, % Usd_uah_r_m
    Menu, Rates_m, Add, UA&H–USD, % Uah_usd_r_m
    Menu, Rates_m, Add
    Menu, Rates_m, Add, U&AH–RUB, % Uah_rub_r_m
    Menu, Rates_m, Add, RU&B–UAH, % Rub_uah_r_m
    Menu, Rates_m, Add
    Menu, Rates_m, Add, US&D–EUR, % Usd_eur_r_m
    Menu, Rates_m, Add, &EUR–USD, % Eur_usd_r_m
Menu, Func, Add, E&xchange rate, :Rates_m

Weather_msg := Func("@C_Msg").Bind(Func("Weather").Bind(CITY))
Menu, Func, Add, Current &weather, % Weather_msg

;reminder
Menu, Func, Add, &Reminder, Reminder

Menu, Func, Add
Menu, Func, Add
Menu, Func, Add, Settings, Pass
Menu, Func, ToggleEnable, Settings
Menu, Func, Icon, Settings, %A_AhkPath%, -206

If LONG_TIME
{
    ;global DISABLE bool
    Menu, Func, Add, Disa&ble (sh+tilde to toggle), Disable
    ;global LONG_TIME int
    Menu, Func, Add, &Long press delay (now is %LONG_TIME%s), Long_press
}
;global MUS_DELAY int
Menu, Func, Add, &Auto-stop music on AFK delay (now is %MUS_DELAY%m), Mus_timer
;global MUTE_MODE int
Menu, Func, Add, Select &mute mode for spotify advertisement (now is %MUTE_MODE%), Mute_mode


;===============================================================================================
;==========================================Spotify functions====================================
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

MuteSecondMode(title)
{
    WinGet, Style, Style, % "ahk_id " SPOTIFY
    WinGetTitle, active_title, A
    CoordMode, Mouse, Screen
    MouseGetPos, xpos, ypos
    WinGetPos, x, y, h, w, ahk_id %SPOTIFY%
    If (Style & 0x10000000 && h > 500 && w > 500)
    {
        nx := x+h-130
        ny := y+w-55
        If (active_title != title)
        {
            WinSet, Transparent, 1, ahk_id %SPOTIFY%
        }
        Else If !MUTE
        {
            nx := x+h-165
        }
        MUTE := !MUTE
        WinSet, AlwaysOnTop, 1, ahk_id %SPOTIFY%
        BlockInput, On
        Click, %nx%, %ny%
        MouseMove, %xpos%, %ypos%
        BlockInput, Off
        WinSet, AlwaysOnTop, 0, ahk_id %SPOTIFY%
        If (active_title != title)
        {
            WinActivate, %active_title%
            WinSet, Transparent, Off, ahk_id %SPOTIFY%
        }
        Return 1
    }
    Else
    {
        Return 0
    }
}

MuteThirdMode(title)
{
    MUTE := !MUTE
    BlockInput, On
    Run sndvol
    WinWait Volume Mixer
    WinGet, clist, ControlList, Volume Mixer
    counter := 2
    Loop, parse, clist, `n
    {
        ControlGetText, text, %A_LoopField%, Volume Mixer
        If (InStr(text, title) || InStr(text, "Spotify"))
        {
            If counter
            {
                counter--
            }
            Else
            {
                ControlFocus, %A_LoopField%, Volume Mixer
                ControlSend, %A_LoopField%, {Space}{Esc}, Volume Mixer
                counter := 2
            }
        }
    }
    BlockInput, Off
}

;===============================================================================================
;===========================================Tools functions=====================================
;===============================================================================================

;decorators
@Clip(func, params*)
{
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
    InputBox, userInput, %func%, Input for %func% function, , 300, 150
    If !ErrorLevel
    {
        saved_value := Clipboard
        Sleep, SLEEP_DELAY
        Clipboard := userInput
        Sleep, SLEEP_DELAY
        result := %func%(params)
        SendInput %result%
        Clipboard := saved_value
    }
}
@C_Msg(func, params*)
{
    result := %func%(params)
    MsgBox, 260, %func%, %result% `nSave result to clipboard?
    IfMsgBox Yes
    {
        Clipboard := result
    }
}
@S_Msg(func, params*)
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
@I_Msg(func, params*)
{
    InputBox, userInput, %func%, Input for %func% function, , 300, 150
    If !ErrorLevel
    {
        saved_value := Clipboard
        Sleep, SLEEP_DELAY
        Clipboard := userInput
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
    expr := StrReplace( RegExReplace(expr, "\s") , ",", ".")
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
    webRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    webRequest.Open("GET", "https://api.openweathermap.org/data/2.5/weather?q=" q_city
        . "&appid=" WEATHER_KEY "&units=metric")
    webRequest.Send()
    stat := RegExReplace(webRequest.ResponseText, ".+""main"":""(\w+)"".+", "$u1")
    StringUpper stat, stat, T
    temp := RegExReplace(webRequest.ResponseText, ".+""temp"":(-?\d+.\d+).+", "$u1")
    feel := RegExReplace(webRequest.ResponseText, ".+""feels_like"":(-?\d+.\d+).+", "$u1")
    wind := RegExReplace(webRequest.ResponseText, ".+""speed"":(\d+.\d+).+", "$u1")
    Return stat "`n" temp "° (" feel "°)`n" wind "m/s"
}

Exch_rates(base, symbol, amount:=1)
{
    If !CURRENCY_KEY
    {
        Return "Not found api key in environment variables (search 'GETGEOAPI')"
    }
    If !amount
    {
        amount := RegExReplace(RegExReplace(Clipboard, "[^\d+\.,]"), ",", ".")
    }
    webRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    webRequest.Open("GET", "https://api.getgeoapi.com/api/v2/currency/convert?api_key="
        . CURRENCY_KEY "&from=" base "&to=" symbol "&amount=" amount "&format=json")
    webRequest.Send()
    Return Round(RegExReplace(webRequest.ResponseText
        , ".+""rate_for_amount"":""(\d+\.\d+)"".+", "$u1"), 2)
}

Unknown_currency(base)
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
                        webRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
                        webRequest.Open("GET"
                            , "https://api.getgeoapi.com/api/v2/currency/convert?api_key="
                            . CURRENCY_KEY "&from=" elem[1][1] "&to=" base "&amount=" 
                            . amount1 "&format=json")
                        webRequest.Send()
                        result := amount1 " " elem[2] " to " base ": "
                            . Round(RegExReplace(webRequest.ResponseText
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
    FormatTime, timeString, %A_Now%, %format%
    Return timeString
}

Format_time()
{
    Clipboard := StrReplace(StrReplace(StrReplace(Clipboard, "д", "d"), "м", "m"), "М", "M")
    Clipboard := StrReplace(StrReplace(StrReplace(Clipboard, "г", "y"), "э", "gg"), "ч", "h")
    Clipboard := StrReplace(StrReplace(StrReplace(Clipboard, "Ч", "H"), "с", "S"), "п", "t")
    FormatTime, timeString, %A_Now%, %Clipboard%
    Return timeString
}


; 10 hours in a day (0-9), 100 minutes in a hour (00-99), 100 seconds in a minute (00-99).
; Second was accelerated by 100_000/86_400≈1.1574
Decimal_time()
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
Hexal_date()
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

New_datetime()
{
    time := Decimal_time()
    date := Hexal_date()
    Return time " | " date
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
    Loop % Strlen(Clipboard)
    {
        cur_char := Asc(Substr(Clipboard, A_Index, 1))
        If cur_char between 65 and 90
        {
            result := result Chr(cur_char + 32)
        }
        Else If cur_char between 1040 and 1071
        {
            result := result Chr(cur_char + 32)
        }
        Else If cur_char between 97 and 122
        {
            result := result Chr(cur_char - 32)
        }
        Else If cur_char between 1072 and 1103
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

Layout_switch(dict)
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
    Loop % Strlen(Clipboard)
    {
        cur_char := Asc(Substr(Clipboard, A_Index, 1))
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
    delay := MUS_DELAY * 60000
    IfGreater, A_TimeIdle, %delay%, SendInput {SC124}
    If (SPOTIFY && MUTE_MODE)
    {
        WinGetTitle, title, ahk_id %SPOTIFY%
        If ((title == "Advertisement") ^ MUTE)
        {
            If (MUTE_MODE == 1)
            {
                MUTE := !MUTE
                SendInput {SC120}
            }
            Else If (MUTE_MODE == 2)
            {
                MuteSecondMode(title)
            }
            Else If ((MUTE_MODE == 3) || (MUTE_MODE == 4) && !MuteSecondMode(title))
            {
                MuteThirdMode(title)
            }
        }
    }
    Return

Reminder:
    InputBox, userInput, Reminder, Remind me in ... minutes, , 200, 130
    If !ErrorLevel
    {
        If userInput is number
        {
            delay := userInput * 60000
            SetTimer, Alarma, %delay%
        }
        Else
        {
            MsgBox, 53, Incorrect value, The input must be a number!
            IfMsgBox Retry
            {
                Goto, Reminder
            }
        }
    }
    Return

Alarma:
    MsgBox, 48, ALARMA, ALARMA
    SetTimer, Alarma, Off
    Return

Disable:
    If DISABLE
    {
        RegWrite, REG_SZ, HKEY_CURRENT_USER, Environment, QPHYX_DISABLE, 0
    }
    Else
    {
        RegWrite, REG_SZ, HKEY_CURRENT_USER, Environment, QPHYX_DISABLE, 1
    }
    DISABLE := !DISABLE
    Run, qphyx.exe
    Return

Long_press:
    InputBox, userInput, Set new long press delay (only for this session!)
        , New value in seconds (e.g. 0.15), , 444, 130
    If !ErrorLevel
    {
        If userInput is number
        {
            Menu, Func, Delete, &Long press delay (now is %LONG_TIME%s)
            Menu, Func, Delete, &Auto-stop music on AFK delay (now is %MUS_DELAY%m)
            Menu, Func, Delete, Select &mute mode for spotify advertisement (now is %MUTE_MODE%)
            RegWrite, REG_SZ, HKEY_CURRENT_USER, Environment, QPHYX_LONG_TIME, %userInput%
            LONG_TIME := userInput
            Menu, Func, Add, &Long press delay (now is %LONG_TIME%s), Long_press
            Menu, Func, Add, &Auto-stop music on AFK delay (now is %MUS_DELAY%m), Mus_timer
            Menu, Func, Add
                , Select &mute mode for spotify advertisement (now is %MUTE_MODE%), Mute_mode
            Run, qphyx.exe
        }
        Else
        {
            MsgBox, 53, Incorrect value, The input must be a number!
            IfMsgBox Retry
            {
                Goto, Long_press
            }
        }
    }
    Return

Mus_timer:
    InputBox, userInput, Set new auto-stop music on AFK delay (only for this session!)
        , New value in minutes (e.g. 10), , 444, 130
    If !ErrorLevel
    {
        If userInput is number
        {
            Menu, Func, Delete, &Auto-stop music on AFK delay (now is %MUS_DELAY%m)
            Menu, Func, Delete, Select &mute mode for spotify advertisement (now is %MUTE_MODE%)
            RegWrite, REG_SZ, HKEY_CURRENT_USER, Environment, MUS_DELAY, %userInput%
            MUS_DELAY := userInput
            Menu, Func, Add, &Auto-stop music on AFK delay (now is %MUS_DELAY%m), Mus_timer
            Menu, Func, Add
                , Select &mute mode for spotify advertisement (now is %MUTE_MODE%), Mute_mode
        }
        Else
        {
            MsgBox, 53, Incorrect value, The input must be a number!
            IfMsgBox Retry
            {
                Goto, Mus_timer
            }
        }
    }
    Return

Mute_mode:
    msg = 
    (
    0 is disable feature;
1 is global mute mode without mouse click and calling any processes;
2 is mouse click mode (force spotify window and click on mute button);
3 is process mute mode (call windows volume mixer and toggle mute on all spotify processes);
4 is combine of 2 and 3 (call 2 mode, if spotify window is closed or minimized – call 3 mode).
    )
    InputBox, userInput, Set new mute mode for spotify advertisement
        , %msg%, , 600, 200
    If !ErrorLevel
    {
        If userInput is number
        {
            Menu, Func, Delete, Select &mute mode for spotify advertisement (now is %MUTE_MODE%)
            RegWrite, REG_SZ, HKEY_CURRENT_USER, Environment, MUTE_MODE, %userInput%
            MUTE_MODE := userInput
            Menu, Func, Add
                , Select &mute mode for spotify advertisement (now is %MUTE_MODE%), Mute_mode
        }
        Else
        {
            MsgBox, 53, Incorrect value, The input must be a number!
            IfMsgBox Retry
            {
                Goto, Mus_timer
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
        If DISABLE
        {
            Menu, Func, Check, Disa&ble (sh+tilde to toggle)
        }
        Else If !DISABLE
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
