TREAT_ONCE_AS_LONG := False


;incr/decrement func works on current selected (marked) number or character
;the function changes the integer part for numbers (including floats)
;    or unicode order for other (only last character), omitting the combining characters
;if there is no selection – it will select next (or last) character without incr/decrementing
IncrDecr(n)
{
    If WinActive("ahk_group BlackList")
        Return
    saved_value := A_Clipboard
    SendEvent("^{SC02E}")
    Sleep(50)
    If IsNumber(A_Clipboard)
    {
        If IsFloat(A_Clipboard)
            A_Clipboard := Round(A_Clipboard + 1*n, StrLen(A_Clipboard) - InStr(A_Clipboard, "."))
        Else
            A_Clipboard := A_Clipboard + 1*n
        new_value_len := StrLen(A_Clipboard)
        Send(A_Clipboard . "{Left " . new_value_len . "}" . "+{Right " . new_value_len . "}")
        A_Clipboard := saved_value
        Return
    }
    ;else
    If StrLen(A_Clipboard) == 1
    {
        order := Ord(A_Clipboard) + 1*n
    }
    Else
    {
        order := Ord(SubStr(A_Clipboard, 0)) + 1*n
        Send("{Right}+{Left}")
    }
    If order == 31
    {
        order := 32
    }
    Else If order < 31
    {
        A_Clipboard := saved_value
        Return
    }
    While RegExMatch(Chr(order), "\p{M}|\p{C}") || order == 6277 || order == 6278
        order := order + 1*n

    Try SendEvent("{Text}" . Chr(order))
    Send("{Left}")
    Send("+{Right}")
    A_Clipboard := saved_value
}

LongOnce()
{
    Global TREAT_ONCE_AS_LONG
    TREAT_ONCE_AS_LONG := True
}

;shortcuts
Incr()
{
    IncrDecr(1)
}

Decr()
{
    IncrDecr(-1)
}
