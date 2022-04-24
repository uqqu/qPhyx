# qPhyx
# ↓ English part

> Remark: if you are able to read Russian, you should look at the [appropriate section](#-russian-part)

> Letter layout was divided from project to [separate repository](https://github.com/uqqu/layout)

**qPhyx** is a layout supplement script to the keyboard layout that transform latter into a multilingual layout with extended symbol support and a few extra features.

Benefits:
1. Unified symbol and language typing system.
2. Full support for all languages in Latin and Cyrillic scripts, with all features, without separate language layouts.
3. Extended symbol support.
4. Additional internal and external functionality.

> The best way to get to know a project is to use it


## Letter layouts

> <details>
>    <summary>tl;dr</summary>
>    You can use any letter layout, but it is preferable to use <a href="https://github.com/uqqu/qPhyx/tree/master/external/layouts">adapted versions</a>, which have been cleared of non-alphabetic characters, beause they are fully provided by the described script.
> </details>

One of the goals pursued by the project is the complete separation of the layers. To do this, the following conditions must be met:
* the alphabetic characters of the main script are completely arranged in the letter part of the keyboard, with the condition of upper case at the modifier `Shift` (an obvious condition, which, however, is neglected by some Cyrillic keyboard layouts);
* numeric characters are completely arranged in the numeric row;
* all other symbols are completely arranged in their own layers.

This division of responsibilities, in other words – a modular system, allows you to use each of the parts independently of the others. In the existing layouts, however, these layers are chaotically jumbled between each other, putting a lot of restrictions on each of the parts, which also leads to the fact that for the smallest change the entire likeness of the system must be changed and used as a fork of the original layout version, with potential unnecessary cascading reassignments.

In order to separate layers, many popular keyboard layouts have been modified into adapted forms. In the adapted layouts there were no changes in the positioning of the alphabetic characters located in the alphabetic part of the keyboard, which allows you to use them as before. The auxiliary characters as well as the alphabetic characters that are outside the alphabetic part have been changed.

The alphabetic characters in the main part have deliberately not been repositioned, in order to keep the original look and typing skills of their users, even though, after adaptation, many of the alphabetic characters can be assigned to more convenient positions.

Adapted layouts for Latin and Cyrillic, ready to install and use, are in the folder [external/layouts](https://github.com/uqqu/qPhyx/tree/master/external/layouts).


## Symbol layers

> <details>
>    <summary>tl;dr</summary>
>    There are three layers – under <code>Alt</code>, under <code>"long" presses</code> (base 0.15s, can be changed by user), and under their combination. 
>    <br><br>All three layers are located in the alphabetic part of the keyboard + numeric row with diacritical symbols.
>    <br><br>All characters are grouped into logical categories and arranged with maximum typing convenience.
>    <br><br>Total coverage – 83 auxiliary characters + 24 diacritics + 8 control commands.
> </details>

The following requirements were specified for the symbol layers:
* extended symbol support;
* auxiliary diacritics support;
* division by logical categories;
* adding control commands to minimize unnecessary movements;
* location within the standard 60% ANSI keyboard;
* location of the most popular symbols in the most convenient positions and layers

<details>
    <summary>An explanation of what a 60% keyboard is</summary>
    <img src="https://cdn.thewirecutter.com/wp-content/media/2021/05/20210527_mech-keyboard_layout.png">
    <sub>Source: <a href="https://www.nytimes.com/wirecutter/blog/how-to-shop-for-a-mechanical-keyboard/">nytimes.com</a>; Illustration: Sarah Macreading, Dana Davis</sub>
</details>

### Layer modifiers

There are two ways to typing symbols on the layers:
* select the layer to be typed directly at the moment of input, by pressing the modifier;
* switching between layers with subsequent typing.

This project uses the first way, as it minimizes intermediate actions.

When selecting the "obvious" modifiers, excluding the combined held modifiers due to the inconvenience of this kind of modifiers, `Shift` and `Ctrl` due to their own use, as well as `AltGr`, for its ambiguous use, only `Alt` was left.

The non-obvious modifier chosen was "long press". Yes, it is somewhat different from the usual method of interaction with the keyboard, but, I assure you, this modifier is much more convenient than even the usual `Alt/Ctrl/Shift`, and you can see for yourself once you get used to this functionality, turning it into automatism.

As a small confirmation of these words – after many trials and comparisons, the most popular symbols are located under the long press modifier, precisely because of its convenience, compared to the others.

The basic value of the trigger time for this modifier is 0.15s. It can be reassigned by the user to a more comfortable value at any time. After introducing it into automatism it is likely to be a comfortable value of about 0.11s.

So we got two layers of single modifiers, and one layer of their combination - a long press with `Alt`, which is not equivalent to the combination of two held modifiers, for the reasons described in the last paragraph.

### Symbol allocation

As mentioned earlier, the most demanded symbols were located under the long-press modifier; alternate views and symbols with less demand were located under `Alt`; an auxiliary set of symbols were located under their `AltLong` combination.

#### Main symbol set (long presses)
![Main symbol set](https://github.com/uqqu/qPhyx/blob/master/external/readme_images/symbols_long.png "Main symbol set")

As you can see, there are mostly symbols that are familiar to everyone from the standard layouts.
* symbols are grouped into categories – basic math, punctuation, currencies, brackets;
* the first two categories, as the most demanded of all, are located at the home finger positions;
* graphically and/or logically close symbols are on vertically adjacent positions;
* brackets are mirrored around the home row – opening at the top, closing at the bottom;
* in the upper right corner is the most demanded diacritic combining symbol "acute" primarily as a marker of the main accent.

Looking ahead to the additional functionality section, the `decr` and `incr` keys in the numeric row are responsible for decreasing/increasing the highlighted number by 1, but can be reassigned by the user to enter additional symbols.

#### Alternative symbol set (`Alt`)
![Alternative symbol set](https://github.com/uqqu/qPhyx/blob/master/external/readme_images/symbols_alt.png "Alternative symbol set")

Half of the symbols in this set are alternate representations of the main set symbols at the same positions:
* hyphen (used as a minus) and minus;
* asterisk (as multiplication) and multiplication symbol;
* middle dash and long dash;
* acute (main accent) and grave (secondary accent);
* exclamation mark and inverted counterpart;
* single quote (used as apostrophe) and apostrophe;
* …

The inheritance of logical category positions is also followed for symbols that have no alternative representation.

The right hand finger home positions have "arrow" navigation, to minimize hand tearing to press them. Here, on either side of the home row are also the "forward"/"backward" and "undo"/"redo" commands.

The numeric row contains all the used superscript combined diacritics (apart from acute and grave, which have their own position in the alphabetic part of the keyboard).

#### Auxiliary symbol set (`AltLong`)
![Auxiliary symbol set](https://github.com/uqqu/qPhyx/blob/master/external/readme_images/symbols_alt_long.png "Auhiliary symbol set")

This layer contains the less demanded symbols of different categories. The inheritance of the positions of the logical categories is followed as much as possible.

The keys that contain the control commands on the alternate layer have no assignments on the `AltLong` layer, in order to preserve the ability to repeat the command through key-holding.

In the numeric row there is a subscript combined diacritic, which in half of the cases is a subscript variant of a similar symbol from the previous layer. The two remaining places in the numeric row after the allocation were given to auxiliary symbols.


## Language layer

> <details>
>    <summary>tl;dr</summary>
>    The numeric row below <code>Shift</code> contains a number of specific language characters.
>    <br><br>This set can be selected from many preset ones, depending on the user's needs. Each set provides access to a number of languages, as they are grouped to provide maximum coverage for each set.
>    <br><br>The character set is selectable separately for Cyrillic (Russian) and Latin (English) layouts.
>    <br><br>The minimal total simultaneous coverage of any pair of sets is 77.7% of the languages of the Internet (share of use), the maximum (the main sets) is 84.5% of the Internet. Total coverage of all sets is 90.1% + 9.9% of all romanization variants of languages with main script different from Latin or Cyrillic.
>    <br><br>Switching between sets, if necessary, is performed "on the fly" in three presses.
> </details>

Perhaps you noticed that the numeric row has no option with `Shift`? That is where the language layer is located.

The main idea of the language layer is that it acts as an open access to typing in **any** writing language, with no ties to a particular language, no cascading restrictions on typing, and no effect on the convenience of typing for those users who do not use it, although the latter may have a rare need for it someday, too.

Of course, it is not possible to fit all the available additional language characters in 12 positions, so this layer/module gives the end user a choice of preset language character positions, separately for Cyrillic and Latin (the character set depends on the language of the current active layout).

Basically, the "main" sets are chosen for each script that have the greatest potential use and coverage. The user can switch to any other set as they use it, either for one-time needs or for further primary use.
<br>Pressing the corresponding key in the numeric row with pressed `Shift` will pass the character in lowercase, and the already familiar "long" press with `Shift` will enter its version in uppercase.

### Character allocation to sets

The allocation of characters to the sets was designed to provide maximum coverage for each set.

Symbols from the language layer sets can be logically divided into two categories:
* independent, graphically unique symbols;
* graphically equivalent characters of the basic writing script with added diacritics.

From the characters of the first category, opening access to typing in the most popular languages of the Latin script, a core set was formed, present in the most part of Latin character sets.

Characters in the second category are potentially available for typing even without the use of a language layer, through an additional diacritic that fully covers the needs of all minimally used languages.
However, it is necessary to provide input of such characters through a single press, without additional diacritics input, which we will call "simplified typing" hereafter.

The modifiable parts of the character sets consist of just the simplified character set, to increase the convenience of the users of these languages.

There are also graphically unique characters in the modifiable part of character sets that are not available to input from other character sets, but which have limited relevance and are of interest only to speakers of such languages.

It follows that each character set which contains the base set, in addition to language-specific characters (be they unique characters or simplified characters), open up the possibility of text input in a number of the most popular languages which can be in demand from any character set.


The situation is somewhat different for Cyrillic sets:
* most Cyrillic languages have a fairly extensive set of additional characters, different from the base script;
* almost all specific characters are graphically unique, and those rare ones that can potentially be displayed in a combined diacritic form cannot be displayed correctly in the majority of fonts;
* in Cyrillic sets it is not possible to identify a core set of potentially most popular characters – each set is of interest to its own group of users.

In connection with the above, Cyrillic sets are fully dynamic, and each of them contains its own unique set of characters.

#### Examples
Let's look at the main character sets for Latin and Cyrillic.

Latin main set – `ñ å ä ö ü ł đ ı ß ø æ œ`

The first 5 characters are dynamic and in this combination are present only in this set. The remaining 7 characters are stably present in most sets, extending their coverage to them.

This character set opens up access to full-fledged typing in the following languages: Spanish *(and several dozen other languages it has influenced)*, German, French, Vietnamese, Swedish, Danish, Finnish, and Norwegian.
Also, a set of unique graphical characters opens up basic typing capability (with input of other specific characters via diacritics) to Turkish, Polish, and Slovenian.

> This does not list the myriad languages available for typing (both in basic script and via diacritics) without using a language layer – their support is self-evidently implied

The Latin sets are divided into two categories:
* supportive – which provide simplified typing: Turkish, Polish, Romanian, Hungarian, and 25 other sets, totaling more than 40 languages;
* allowing – sets with unique graphic characters necessary for a language that can only be typed in a given set: Icelandic/Old English, Maltese, Azerbaijani, a number of African languages (Hausa, Mossi, Fula, Yoruba, etc.), …

A total of 37 Latin sets were formed, 22 of which were formed with the basic symbol set, `łđıßøæœ`.
In other 7 sets, in which 6 dynamic positions were required, additional position was sacrificed from `ł`.
The remaining 8 sets are for languages with a large number of additional symbols, in which the basic symbol set has been truncated, in varying degrees, in favor of the main language of the set.

<details>
    <summary>Some clarifications and attention to the specifics of languages</summary>
    <ul>
        <li>in sets based on the Turkish variant of the Latin alphabet, there is a small optional repositioning of the characters <code>iI</code> and <code>ıİ</code>, for more logical typing – <code>iİ</code> and <code>ıI</code> (switchable setting);</li>
        <li>when selecting the Romanian language set, there is an optional replacement of the diacritical cedilla with a comma, to correct a popular misuse of the first one (switchable setting);</li>
        <li>in the "Icelandic/Old English" and "Mossi" sets, the symbol <code>đĐ</code> is replaced by the variants of the lettering used in these languages – <code>ðÐ</code> and <code>ɖƉ</code>, respectively;</li>
        <li>in sets in which the number of dynamic characters was restricted to 4, <code>ñ</code> was added, not even related to the main language of the set, as a character with maximum extension of coverage, without dependence on other characters;</li>
        <li>in some sets, in which the number of dynamic characters required 6 positions, additional place was sacrificed from <code>ł</code>;</li>
        <li>the sets for Polish, Lithuanian and Hungarian are provided both in a full form, with a truncated basic set, and as a partial simplified input, where the basic symbol set is present, and some language symbols are given to combined input (mostly with a single diacritical symbol - acute for Polish and Hungarian, ogonek for Lithuanian + ż);</li>
        <li>the sets for Czech and Slovak, even with abandoning the basic symbol set, are still partial-simplifying (without řďťťň for Czech, without acute forms for Slovak);</li>
        <li>the Polish, Lithuanian, Latvian, and Hungarian sets have only partially simplified typing, due to the extremely widespread use of diacritics in these languages. Simplified typing, if possible, covers characters with different diacritics, leaving for combined typing letters with a single diacritical symbol (acute for Polish and Hungarian, ogonek for Lithuanian);</li>
        <li>the previous two points can be fixed and optimized by <a href="https://github.com/uqqu/qPhyx#user-assignments">additional user assignments</a>;</li>
        <li>depending on the user's needs (switchable setting), the simplified characters can be input as in a combined form (two characters – letter+diacritics), or as a single Unicode character;</li>
        <li>the same dynamic characters occurring in different sets are located in the same positions, where possible.</li>
    </ul>
</details>

<details>
    <summary>All Latin sets (37)</summary>
    <table>
        <tr>
            <td>Main</td>
            <td>ñ</td>
            <td>å</td>
            <td>ä</td>
            <td>ö</td>
            <td>ü</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Turkish</td>
            <td>ç</td>
            <td>ş</td>
            <td>ğ</td>
            <td>ö</td>
            <td>ü</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Polish (partial + base)</td>
            <td>ñ</td>
            <td>ą</td>
            <td>ę</td>
            <td>ż</td>
            <td>ó</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Polish (full − base)</td>
            <td>ć</td>
            <td>ń</td>
            <td>ó</td>
            <td>ś</td>
            <td>ź</td>
            <td>ł</td>
            <td>ą</td>
            <td>ę</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>ż</td>
        </tr>
        <tr>
            <td>Czech (partial − base)</td>
            <td>á</td>
            <td>é</td>
            <td>ó</td>
            <td>í</td>
            <td>ú</td>
            <td>ý</td>
            <td>ů</td>
            <td>ě</td>
            <td>ß</td>
            <td>š</td>
            <td>č</td>
            <td>ž</td>
        </tr>
        <tr>
            <td>Romanian</td>
            <td>î</td>
            <td>ă</td>
            <td>â</td>
            <td>ș</td>
            <td>ț</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Hungarian (partial + base)</td>
            <td>ñ</td>
            <td>ő</td>
            <td>ű</td>
            <td>ö</td>
            <td>ü</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Hungarian (full − base)</td>
            <td>á</td>
            <td>é</td>
            <td>ó</td>
            <td>í</td>
            <td>ú</td>
            <td>ł</td>
            <td>ö</td>
            <td>ü</td>
            <td>ß</td>
            <td>ø</td>
            <td>ő</td>
            <td>ű</td>
        </tr>
        <tr>
            <td>Slovene, Croatian (Gaj's latin), Romany</td>
            <td>č</td>
            <td>š</td>
            <td>ž</td>
            <td>ǵ</td>
            <td>ć</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Slovak (full − base)</td>
            <td>ň</td>
            <td>ô</td>
            <td>ä</td>
            <td>ö</td>
            <td>ü</td>
            <td>ľ</td>
            <td>ď</td>
            <td>ť</td>
            <td>ß</td>
            <td>š</td>
            <td>č</td>
            <td>ž</td>
        </tr>
        <tr>
            <td>Turkic languages (full − base)</td>
            <td>ñ</td>
            <td>ê</td>
            <td>ä</td>
            <td>ö</td>
            <td>ü</td>
            <td>ū</td>
            <td>ə</td>
            <td>ı</td>
            <td>ţ</td>
            <td>ş</td>
            <td>ç</td>
            <td>ğ</td>
        </tr>
        <tr>
            <td>Lithuanian (partial + base)</td>
            <td>č</td>
            <td>š</td>
            <td>ž</td>
            <td>ė</td>
            <td>ū</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Lithuanian (full − base)</td>
            <td>ą</td>
            <td>ę</td>
            <td>ė</td>
            <td>ų</td>
            <td>ū</td>
            <td>ł</td>
            <td>į</td>
            <td>ż</td>
            <td>ß</td>
            <td>š</td>
            <td>č</td>
            <td>ž</td>
        </tr>
        <tr>
            <td>Latvian (full − base)</td>
            <td>ā</td>
            <td>ē</td>
            <td>ī</td>
            <td>ū</td>
            <td>ǵ</td>
            <td>ļ</td>
            <td>ķ</td>
            <td>ņ</td>
            <td>ß</td>
            <td>š</td>
            <td>č</td>
            <td>ž</td>
        </tr>
        <tr>
            <td>Estonian (base − ł)</td>
            <td>õ</td>
            <td>š</td>
            <td>ä</td>
            <td>ö</td>
            <td>ü</td>
            <td>ž</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Albanian, Northern Sotho</td>
            <td>ç</td>
            <td>š</td>
            <td>ê</td>
            <td>ô</td>
            <td>ë</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Old English, Icelandic</td>
            <td>þ</td>
            <td>ƿ</td>
            <td>ſ</td>
            <td>ö</td>
            <td>ᵹ</td>
            <td>ł</td>
            <td>ð</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Urdu (Roman script) (base − ł)</td>
            <td>ū</td>
            <td>ṛ</td>
            <td>ṣ</td>
            <td>ṭ</td>
            <td>ẓ</td>
            <td>z̤</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Uzbek</td>
            <td>ç</td>
            <td>ş</td>
            <td>ḡ</td>
            <td>ō</td>
            <td>ñ</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Southern-Berber, Kanuri</td>
            <td>ǝ</td>
            <td>ŋ</td>
            <td>ɣ</td>
            <td>ʕ</td>
            <td>ɍ</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Twi, Yoruba (Benin) ...</td>
            <td>ñ</td>
            <td>ŋ</td>
            <td>ɲ</td>
            <td>ɛ</td>
            <td>ɔ</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Northern Sami (base − ł)</td>
            <td>č</td>
            <td>š</td>
            <td>ž</td>
            <td>á</td>
            <td>ŋ</td>
            <td>ŧ</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Esperanto (base − ł)</td>
            <td>ĉ</td>
            <td>ŝ</td>
            <td>ĝ</td>
            <td>ĥ</td>
            <td>ĵ</td>
            <td>ǔ</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Kurdish (Hawar alphabet)</td>
            <td>ç</td>
            <td>ş</td>
            <td>ê</td>
            <td>î</td>
            <td>û</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Turkmen (base − łđœ)</td>
            <td>ç</td>
            <td>ş</td>
            <td>ä</td>
            <td>ö</td>
            <td>ü</td>
            <td>ý</td>
            <td>ň</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>ž</td>
        </tr>
        <tr>
            <td>Irish, Sundanese, Luba-Katanga</td>
            <td>á</td>
            <td>é</td>
            <td>í</td>
            <td>ó</td>
            <td>ú</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Luxembourgish, Uyghur</td>
            <td>é</td>
            <td>ë</td>
            <td>ä</td>
            <td>ö</td>
            <td>ü</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Maltese</td>
            <td>ñ</td>
            <td>ċ</td>
            <td>ġ</td>
            <td>ż</td>
            <td>ħ</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Maori, Samoan, Niuean</td>
            <td>ā</td>
            <td>ē</td>
            <td>ī</td>
            <td>ō</td>
            <td>ū</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Haitian, Javanese, Kikuyu</td>
            <td>é</td>
            <td>è</td>
            <td>ò</td>
            <td>ĩ</td>
            <td>ũ</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Hausa</td>
            <td>ɓ</td>
            <td>ɗ</td>
            <td>ƙ</td>
            <td>r̃</td>
            <td>ƴ</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Volta–Niger languages (Yoruba, Igbo, ...)</td>
            <td>ṅ</td>
            <td>ṣ</td>
            <td>ẹ</td>
            <td>ọ</td>
            <td>ụ</td>
            <td>ị</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Western Frisian (base − ł)</td>
            <td>â</td>
            <td>ê</td>
            <td>é</td>
            <td>ô</td>
            <td>û</td>
            <td>ú</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Venda</td>
            <td>ṅ</td>
            <td>ḓ</td>
            <td>ḽ</td>
            <td>ṋ</td>
            <td>ṱ</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Sicilian</td>
            <td>à</td>
            <td>è</td>
            <td>ì</td>
            <td>ò</td>
            <td>ù</td>
            <td>ḍ</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Fula</td>
            <td>ɓ</td>
            <td>ɗ</td>
            <td>ŋ</td>
            <td>ɲ</td>
            <td>ƴ</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Mossi</td>
            <td>ɓ</td>
            <td>ɩ</td>
            <td>ʋ</td>
            <td>ɛ</td>
            <td>ɔ</td>
            <td>ł</td>
            <td>ɖ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
    </table>
</details>

Let's move on to Cyrillic sets.
<br>As mentioned earlier, in Cyrillic sets all positions are dynamic, due to which their number is much smaller than in Latin sets.

All Cyrillic sets are "allowing" because complete typing in the languages of these sets is not possible without using them.

Characters from Cyrillic sets are always input in a single form (with the exception of з́ and с́, which do not have a coherent representation).

The main Cyrillic set in terms of potential demand – `ґ є і ї ӏ ў ѣ ѵ ѳ ӂ ӕ ӧ`

This character set provides access to full-fledged typing in Ukrainian, Belarusian, Moldovan, Rusyn, Ossetian, Komi, a dialect of Ruska Roma, a number of Caucasian languages, and pre-revolutionary Russian.

<details>
    <summary>All Cyrillic sets (6)</summary>
    <table>
        <tr>
            <td>Ukrainian, Belarusian, Caucasian, …</td>
            <td>ґ</td>
            <td>є</td>
            <td>і</td>
            <td>ї</td>
            <td>ӏ</td>
            <td>ў</td>
            <td>ѣ</td>
            <td>ѵ</td>
            <td>ѳ</td>
            <td>ӂ</td>
            <td>ӕ</td>
            <td>ӧ</td>
        </tr>
        <tr>
            <td>Serbian, Montenegrin, Interslavic, …</td>
            <td>ѓ</td>
            <td>ќ</td>
            <td>ђ</td>
            <td>ћ</td>
            <td>љ</td>
            <td>њ</td>
            <td>ѣ</td>
            <td>џ</td>
            <td>ј</td>
            <td>ѕ</td>
            <td>з́</td>
            <td>с́</td>
        </tr>
        <tr>
            <td>Kazakh, Mongolian, Uzbek, Kyrgyz, Tajik, …</td>
            <td>ғ</td>
            <td>қ</td>
            <td>ң</td>
            <td>ҷ</td>
            <td>ҳ</td>
            <td>ү</td>
            <td>ә</td>
            <td>һ</td>
            <td>ө</td>
            <td>і</td>
            <td>Ұ</td>
            <td>ӯ</td>
        </tr>
        <tr>
            <td>Bashkir, Chuvash, Tatar, …</td>
            <td>ғ</td>
            <td>ҡ</td>
            <td>ң</td>
            <td>ӑ</td>
            <td>ӗ</td>
            <td>ү</td>
            <td>ә</td>
            <td>һ</td>
            <td>ө</td>
            <td>җ</td>
            <td>ҙ</td>
            <td>ҫ</td>
        </tr>
        <tr>
            <td>Abkhazian</td>
            <td>ӷ</td>
            <td>қ</td>
            <td>ҟ</td>
            <td>ҷ</td>
            <td>ҳ</td>
            <td>ҩ</td>
            <td>ә</td>
            <td>ҵ</td>
            <td>ӡ</td>
            <td>ҭ</td>
            <td>ҽ</td>
            <td>ҿ</td>
        </tr>
        <tr>
            <td>Yakut, Even(ki), Altai, Krymchak, …</td>
            <td>ҕ</td>
            <td>ҥ</td>
            <td>ҋ</td>
            <td>һ</td>
            <td>ӏ</td>
            <td>ү</td>
            <td>ӈ</td>
            <td>ј</td>
            <td>ө</td>
            <td>ӫ</td>
            <td>ӱ</td>
            <td>ӧ</td>
        </tr>
    </table>
</details>

The currently active character sets are also displayed in the script GUI.

![Displaying language sets](https://github.com/uqqu/qPhyx/blob/master/external/readme_images/lang_modes.png)

Some final statistics:
> *according to the use of languages on the Internet by <a href="https://w3techs.com/technologies/overview/content_language">w3techs.com</a> of 24.04.2022*
* fully supported languages on any modes – 76.73% (90.20% without simplified typing)
* fully supported languages on main modes – 8.12%
* fully supported languages on additional modes – 5.36%
* romanized versions of languages of other scripts: all versions – 9.45%, some – 0.01%

For details on all *(200+)* languages, categories, usability, alphabets, and support, see <a href="https://github.com/uqqu/qPhyx/blob/master/external/languages.xlsx">external/languages.xlsx</a> 


## Additional features

### Paired brackets

Switchable option.
<br>Automatically closes brackets and quotation marks `<>`, `«»`, `""`, `“”`, `()`, `[]` and `{}`, setting the carriage position between them.
<br>Automatic closing single quotes is not provided, as this symbol is often used in the meaning of apostrophe, where a paired quote would be undesirable.

### Numrow shifting (01…9 instead of 1…90)
Switchable option.
<br>Shifts the numeric row one position to the right, moving the zero to the first position.

### Replacing text on the clipboard

Called by pressing `Ctrl-Shift-v`.
<br>Pastes text from the clipboard in place of the selected text, saving the latter as a new clipboard value.

### Changing the case of selected text

Switchable option.
<br>Called by pressing `Shift` twice.
<br>When called, it reverses the case of each character.
<br>When called with `Ctrl` or `Alt` it changes the case to upper or lower, respectively.

### Navigation with `Alt+[hjkl]`

Navigation via simulated arrow keys supports all the original modifiers:
* with `Shift` to navigate with highlighting;
* with `Ctrl` for word navigation (`j` and `k` will move the carriage to the beginning and end of the line, respectively);
* with `LWin` instead of `Alt` to control window position. With additional `Shift` to position the window between screens.

### Other assignments and hotkeys

Unbreakable space – `Shift-Space` (switchable functionality)
<br>Minimize all windows – `LWin-Enter`
<br>Restore minimized windows – `LWin-Enter long`
<br>Pause/resume the script – `Shift-Tilde`
<br>Restart the script – `Ctrl-Shift-Tilde`

### GUI

The script has a minimal hinting graphical interface, called via `Alt+F1` or by clicking on an icon in the tray.
<br>The interface displays in the corresponding tabs:
* main layer – the user's system letter layout, language sets, reassignments;
* three tabs of symbol layers - long presses, `Alt`, `Alt Long`;
* tab with scan codes for user assignments;
* list of all language sets for two scripts with switching between them by double click;
* list of all hotkeys for both script control and other functions.

The GUI can be modified depending on certain settings, displaying the view provided by these options. This includes the current language sets, paired bracket functionality, and custom reassignments.

The layer tabs respond to keystrokes on the physical keyboard, prompting its position on the screen.
<br>Switching between tabs can be done by pressing the `F1-F7` keys.

Other settings are managed in the menu called by `LWin+F1` or by right mouse clicking on the tray icon.

### User assignments

There are three types of user assignments:
* assignment of additional keys in the number row, which, being empty, perform the functions of decreasing and increasing the selected number by 1;
* additional assignments in the letter part of the keyboard for the Latin script. After adapting the Latin layouts, there are 7 additional positions that can be used in addition to the language layer, depending on the individual needs of the user;
* assignment for switching between applications in combination with the `LWin` modifier. Starts the application if it is not running.

The assignments are defined in the `config.ini` file, which is generated next to the executable file of the script after the first run.

For the first two types, the assignments are defined in the `AdditionalAssignments` section by the pattern `<key_scan_code>=<assignable_character>`. The scan codes of the numeric keys are pre-specified in this section with empty assignments. Scan codes of other keys can be viewed in the corresponding GUI tab. It's possible to specify modifier `Shift` (set as `+` before scan code) for assignments in alphabetic part of the keyboard. It is possible to specify unicode character value by pattern `{U+<symbol_code>}`.

Assignments for switching focus between applications are defined in the `AltApps` section by the pattern `<key_scan_code>=<process_name>,<path_to_executable_file>`. Specifying modifiers is not required.

After making changes via `config.ini`, the script needs to be restarted.
<br>When making changes via the menu option (only for key assignments in the numeric row) a restart is not required.

### Controlling key reassignments

In addition to what has been described in the previous sections, the user is suggested to try out the reassignment of control keys such as `Backspace`, `Enter`, `CapsLock` and `Esc`. Their more comfortable positioning with minimized unnecessary hand movements can be enabled in the corresponding menu item.
<br>Suggested assignment:
* `Enter` performs the `Backspace` function; with `Shift` pressed – `Delete`;
* `CapsLock` performs the function of `Enter`;
* `Tilde` performs the `Esc` function;
* `Backspace` performs media control functions (base press - play/pause; with `Shift` - increase volume; with `Alt` - decrease volume; with `Shift Long` - next media item; with `Alt Long` - previous media item);
* The `CapsLock` function can be assigned to `Esc` by a separate setting.

This arrangement is more ergonomic and minimizes movement that detaches the fingers from home positions.

The current reassignments, both user and toggle control key options, are displayed in the GUI.

An example of a display with control key reassignment, parentheses, and numeric row shifting and key reassignment settings enabled:

![GUI with options](https://github.com/uqqu/qPhyx/blob/master/external/readme_images/long_with_options.png)

### Automatically disabling the script in certain applications

Long presses can be undesirable in some applications, affecting their performance.
<br>Such applications are added to the `config.ini` file in the `BlackList` section with the pattern `<ord_number> = <process_name>`, after which the script activity in these applications will be automatically suspended.


## Instalation

> Windows only

1. *(optional)* Install [adapted](https://github.com/uqqu/qPhyx/tree/master/external/layouts) versions of your Latin and/or Cyrillic layouts, select them in the OS settings and reboot the system.
2. *(optional)* Install <a href="https://www.autohotkey.com/">AHK</a>, if you prefer to use an uncompiled version of the script.
3. Place the files `qphyx.exe` (or `qphyx.ahk`), `modes.ini` and the files `.ico` in a folder of your choice, run `qphyx.*`.
4. Familiarize yourself with the usage. Set up in the menu (right mouse click on the tray icon or `LWin+F1`) the language sets, "long" press trigger duration and other options.
5. *(optional)* Add `qphyx.*` to the startup.


---


# ↓ Russian part

> Буквенная раскладка была отделена от проекта и перенесена в [отдельный репозиторий](https://github.com/uqqu/layout)

**qPhyx** – дополнение к клавиатурной раскладке, превращающее её в мультиязычную, едино-символьную расширенную раскладку с повышенным удобством набора и некоторыми дополнительными функциями.

Преимущества:
1. Единая символьная и языковая система набора.
2. Полная поддержка всех языков латинской и кириллической письменностей, со всеми особенностями, без отдельных языковых раскладок.
3. Расширенная символьная поддержка.
4. Дополнительный внутренний и внешний функционал.

> Лучший способ познакомиться с проектом – использовать его


## Буквенные раскладки

> <details>
>    <summary>tl;dr</summary>
>    Вы можете использовать любую буквенную раскладку, но предпочтительно использовать их <a href="https://github.com/uqqu/qPhyx/tree/master/external/layouts">адаптированные версии</a>, очищенные от небуквенных символов, так как последние в полной мере предоставляются описываемым дополнением.
> </details>

Одна из целей, преследуемых проектом – полное разделение слоёв. Для этого должны соблюдаться следующие условия:
* буквенные символы основной письменности полностью расположены в пределах буквенной части клавиатуры, с условием верхнего регистра при модификаторе `Shift` (очевидное условие, которым, однако, пренебрегают некоторые кириллические раскладки);
* цифровые символы полностью расположены в цифровом ряду;
* все прочие символы полностью расположены на собственных слоях.

Подобное разделение зон ответственности, другими словами – модульная система, позволяет использовать каждую из частей независимо от прочих. В существующих же раскладках эти слои хаотично перемешаны между собой, налагая массу ограничений на каждую из частей, что также приводит к тому, что для малейшего изменения всё подобие системы должно быть изменено и использовано как форк изначального варианта раскладки, с потенциальными излишними каскадными переназначенями.

Для разграничения слоёв многие популярные клавиатурные раскладки были приведены в адаптированный вид. В адаптированных раскладках не было изменений позиционирования буквенных символов, расположенных в буквенной части клавиатуры, что позволяет использовать их как и ранее. Изменениям подверглись вспомогательные символы, а также буквенные символы, находящиеся за пределами буквенной части.

Буквенные символы основной части намеренно не были перепозиционированны, для сохранения изначального вида и навыков набора их пользователей, несмотря на то, что после адаптации, многие буквенные символы могут быть назначены на более удобные позиции.

Вы также можете использовать и стандартные виды раскладок, однако в таком случае некоторые символы будут повторяться, а сам принцип логического разделения зон несколько пострадает.

Адаптированные раскладки для латиницы и кириллицы, готовые к установке и использованию, находятся в папке [external/layouts](https://github.com/uqqu/qPhyx/tree/master/external/layouts).


## Символьные слои

> <details>
>    <summary>tl;dr</summary>
>    Есть три слоя – под <code>Alt</code>, под <code>"длинными" нажатиями</code> (базово – 0.15с, изменяется пользователем), и под их комбинацией.
>    <br><br>Все три слоя расположены в буквенной части клавиатуры + цифровой ряд с диакритическими символами.
>    <br><br>Все символы сгруппированы по логическим категориям и расположены с максимальным удобством набора.
>    <br><br>Общий охват – 83 вспомогательных символа + 24 диакритических символа + 8 управляющих команд.
> </details>

К символьному слою были выставлены следующие требования:
* расширенная символьная поддержка;
* поддержка добавочной диакритики;
* разделение по логическим категориям;
* добавление управляющих команд, для минимизации лишних движений;
* расположение в пределах стандартной 60% ANSI-клавиатуры;
* расположение наиболее востребованных символов на наиболее удобных позициях и слоях.

<details>
    <summary>Границы 60% клавиатуры</summary>
    <img src="https://cdn.thewirecutter.com/wp-content/media/2021/05/20210527_mech-keyboard_layout.png">
    <sub>Источник: <a href="https://www.nytimes.com/wirecutter/blog/how-to-shop-for-a-mechanical-keyboard/">nytimes.com</a>; Иллюстрация: Sarah Macreading, Dana Davis</sub>
</details>

### Модификаторы слоёв

Для набора символов на слоях существует два подхода:
* выбор слоя для набора непосредственно в момент ввода, через зажатие модификатора;
* переключение между слоями с последующим набором.

В данном проекте используется первый подход, так как он позволяет минимизировать промежуточные действия.

При выборе "очевидных" модификаторов, исключив комбинируемые удерживаемые модификаторы, ввиду неудобства такого рода модификаторов, `Shift` и `Ctrl` из-за их собственного применения, а также `AltGr`, за его неоднозначное использование, остался лишь `Alt`.

В качестве неочевидного модификатора было выбрано "длинное нажатие". Да, это несколько расходится с привычным методом взаимодействия с клавиатурой, но, уверяю, этот модификатор гораздо удобнее даже привычных `Alt/Ctrl/Shift`, в чём вы сможете убедиться сами, как только привыкнете к этой функциональности, переведя её в автоматизм. Как только это произойдёт, набор символов с этим модификатором окажется столь же простым как и обычный набор буквенных символов в нижнем регистре.

В качестве небольшого подтверждения этих слов – после многих проб и сравнений, самые востребованные символы расположились под модификатором длинного нажатия, именно из-за его удобства, по сравнению с прочими.

Базовое значение длительности зажатия для срабатывания данного модификатора – 0.15с. Может быть в любой момент переназначено пользователем на более комфортное. После введения в автоматизм, комфортным скорее всего окажется значение около 0.11с.

Таким образом получилось два слоя одинарных модификаторов, а также один слой из их комбинации – долгое нажатие с `Alt`, что не эквивалентно комбинации из двух удерживаемых модификаторов, по причинам, описанным в прошлом абзаце.

### Распределение символов

Как было озвучено ранее, самые востребованные символы были расположены под модификатором длинного нажатия; альтернативные отображения и символы с меньшей востребованностью – под `Alt`; вспомогательный набор символов – под их комбинацией `AltLong`.

#### Основной набор символов (длинные нажатия)
![Основной набор символов](https://github.com/uqqu/qPhyx/blob/master/external/readme_images/symbols_long.png "Основной набор символов")

Как вы можете видеть, здесь расположены преимущественно символы, знакомые всем по стандартным раскладкам.
* символы сгруппированы по категориям – базовая математика, пунктуация, валюты, скобки;
* первые две категории, как самые востребованные из всех, находятся на домашних позициях пальцев;
* графически и/или логически близкие символы расположены на вертикально смежных позициях;
* скобки расположены зеркально вокруг домашнего ряда – открывающие вверху, закрывающие внизу;
* в правом верхнем углу расположен самый востребованный диакритический комбинируемый символ "акут", в первую очередь как маркер основного ударения.

Забегая наперёд, в раздел дополнительной функциональности, клавиши `decr` и `incr` в цифровом ряду отвечают за уменьшение/увеличение выделенного числа на 1, но могут быть переназначены пользователем для ввода дополнительных символов.

#### Альтернативный набор символов (`Alt`)
![Альтернативный набор символов](https://github.com/uqqu/qPhyx/blob/master/external/readme_images/symbols_alt.png "Альтернативный набор символов")

Половина символов данного набора представляет собой альтернативные отображения символов основного набора, расположенных на тех же позициях:
* дефис (используемый как минус) и минус;
* звёздочка (как умножение) и символ умножения;
* среднее тире и длинное тире;
* акут (основное ударение) и гравис (побочное ударение);
* восклицательный знак и перевёрнутый аналог;
* одинарная кавычка-апостроф и апостроф;
* …

Наследование позиций логических категорий соблюдено также и для символов, не имеющих альтернативного отображения.

На домашних позициях пальцев правой руки расположена навигация "стрелками", для минимизации отрыва руки для нажатий последних в стандартном расположении. Здесь же, по обе стороны от домашнего ряда, также расположены команды "вперёд"/"назад" и "отменить"/"повторить".

В цифровом ряду расположена вся используемая надстрочная комбинируемая диакритика (помимо акута и грависа, имеющих собственную позицию в буквенной части клавиатуры).

#### Вспомогательный набор символов (`AltLong`)
![Вспомогательный набор символов](https://github.com/uqqu/qPhyx/blob/master/external/readme_images/symbols_alt_long.png "Вспомогательный набор символов")

На этом слое расположены менее востребованные символы разных категорий. Наследование позиций логических категорий по возможности соблюдено.

Клавиши, на которых расположены управляющие команды на альтернативном слое, не имеют назначений на слое `AltLong`, для сохранения возможности повтора команды через удержание клавиши.

В цифровом ряду расположена подстрочная комбинируемая диакритика, в половине случаев представляющая собой подстрочный вариант аналогичного символа из прошлого слоя. Два оставшихся после распределения места в цифровом ряду были отданы вспомогательным символам.


## Языковой слой

> <details>
>    <summary>tl;dr</summary>
>    В цифровом ряду под <code>Shift</code> расположен ряд специфичных языковых символов.
>    <br><br>Этот набор может быть выбран из многих предустановленных, в зависимости от потребностей пользователя. Каждый набор открывает доступ к целому ряду языков, так как они сгруппированы для обеспечения максимального охвата для каждого набора.
>    <br><br>Набор символов выбирается раздельно для кириллической (русской) и латинской (английской) раскладок.
>    <br><br>Минимальный полноценный одновременный охват любой пары наборов – 77.7% языков интернета (доля использования), максимальный (основные наборы) – 84.5% интернета. Общий охват всех наборов – 90.1% + 9.9% всех версий романизации языков, основная письменность которых отличается от латинской и кириллической.
>    <br><br>Переключение между наборами, в случае необходимости, выполняется "на лету" в три нажатия.
> </details>

Возможно, вы обратили внимание на то, что цифровой ряд не имеет варианта с `Shift`. Именно там и расположен языковой слой.

Основная идея языкового слоя состоит в том, что он выступает в роли открывающего доступ к набору на **любом** языке письменности, без привязки к конкретному языку, без каскадных ограничений набора и никак не сказывается на удобстве набора для тех пользователей, которые им не пользуются, хотя и у последних когда-никогда может возникнуть редкая потребность в нём.

Конечно, уместить все возможные дополнительные языковые символы в 12 позиций не представляется возможным, потому данный слой/модуль предоставляет конечному пользователю выбор из предустановленных позиционирований языковых символов, раздельно для кириллицы и латиницы (набор символов зависит от языка текущей активной раскладки).

Базово выбраны "основные" наборы для каждой письменности, имеющие наибольшее потенциальное использование и охват. Пользователь может в процессе использования переключаться на любой другой набор, как для разовых потребностей, так и для дальнейшего основного использования.
<br>Нажатие соответствующей клавиши в цифровом ряду с зажатым `Shift` передаст на ввод символ в нижнем регистре, а, уже знакомое, "длинное" нажатие с `Shift` введёт её вариант в верхнем регистре.

### Распределение символов по наборам

Распределение символов по наборам проводилось таким образом, чтобы обеспечить максимальный охват для каждого набора.

Символы из наборов языкового слоя можно логически разделить на две категории:
* самостоятельные, графически уникальные символы;
* графически эквивалентные символам базового набора письменности с добавленной диакритикой.

Из символов первой категории, открывающих доступ к набору текста на популярнейших языках латинской письменности был сформирован базовый набор, присутствующий в большинстве латинских наборов символов.

Символы второй категории потенциально доступны к набору даже без использования языкового слоя, через добавочную диакритику, которая в полной мере покрывает потребности всех минимально используемых языков.
Однако необходимо предоставить ввод подобных символов через одинарное нажатие, без дополнительного ввода диакритики, который в дальнейшем мы будем называть "упрощённым вводом".

Изменяемые части символьных наборов состоят как раз из символов упрощённого ввода, для повышения удобства пользователей этих языков.

Также в изменяемой части символьных наборов встречаются и графически уникальные символы, недоступные ко вводу из других символьных наборов, однако имеющие ограниченную востребованность и представляющие интерес исключительно для носителей подобных языков.

Из этого следует, что каждый набор символов, содержащий базовый набор, помимо специфичных символов конкретного языка (будь то уникальные символы или символы упрощённого ввода), открывает возможность ввода на целом ряде популярнейших языков, доступ к которым может быть востребован из любого набора символов.


Для кириллических наборов положение несколько иное:
* большинство кириллических языков имеют довольно обширный набор дополнительных символов, отличных от базовой письменности;
* практически все специфичные символы являются графически уникальными, а те редкие, что потенциально могут быть отображены в виде с комбинируемой диакртикой, не могут быть корректно отображены на подавляющем большинстве шрифтов;
* в кириллических наборах не представляется возможным выделить единый набор потенциально самых востребованных символов – каждый набор представляет интерес для своей группы пользователей.

В связи с вышеперечисленным, кириллические наборы являются полностью динамическими, и каждый из них содержит свой уникальный набор символов.

#### Примеры
Рассмотрим наборы символов для латиницы и кириллицы.

Латинский основной набор – `ñ å ä ö ü ł đ ı ß ø æ œ`

Первые 5 символов являются динамическими и в таком сочетании присутствуют только в данном наборе. Остальные 7 символов стабильно присутствуют в большинстве наборов, распространяя на них свой охват.

Данный набор символов открывает доступ к полноценному набору на следующих языках: испанский *(и несколько десятков прочих, на которые он повлиял)*, немецкий, французский, вьетнамский, шведский, датский, финский и норвежский.
Также набор уникальных графических символов открывает базовую возможность ввода (со вводом прочих специальных языковых символов через диакритику) к турецкому, польскому и словенскому.

> Здесь не перечислено огромное множество языков, доступных ко вводу (как на базовой письменности, так и через диакритику) без использования языкового слоя – их поддержка подразумевается сама собой

Латинские наборы разделены на две категории:
* поддерживающие – предоставляющие упрощённый ввод: турецкий, польский, румынский, венгерский, и 25 прочих наборов, в сумме охватывающих более 40 языков;
* позволяющие – наборы с уникальными графическими символами, необходимыми для языка, которые могут быть введены только на данном наборе: исландский/древнеанглийский, мальтийский, азербайджанский, ряд африканских языков (хауса, мосси, фула, йоруба, и т.д.), …

Всего сформировано 37 латинских наборов, 22 из которых сформированы с базовым набором символов – `łđıßøæœ`.
В ещё 7 наборах, в которых потребовалось 6 динамических позиций, дополнительное место было пожертвовано от `ł`.
Оставшиеся 8 наборов предназначены для языков с большим количеством дополнительных символов, в которых базовый набор символов был в разной степени урезан, в пользу основного языка набора.

<details>
    <summary>Отдельные уточнения и учёт языковых особенностей</summary>
    <ul>
        <li>в наборах, основанных на турецком варианте латиницы предусмотрено небольшое опциональное перепозиционирование символов <code>iI</code> и <code>ıİ</code>, для более логичного ввода – <code>iİ</code> и <code>ıI</code> (переключаемая опция);</li>
        <li>при выборе румынского языкового набора предусмотрена опциональная замена диакритической седили на кому, для исправления распространённого ошибочного использования первой (переключаемая опция);</li>
        <li>в наборах "исландский/древнеанглийский" и "мосси" символ <code>đĐ</code> заменён на варианты начертания, использующиеся в данных языках – <code>ðÐ</code> и <code>ɖƉ</code>, соответственно;</li>
        <li>в наборы, в которых количество динамических символов ограничилось 4, была добавлена <code>ñ</code>, даже не относясь к основному языку набора, в качестве символа с максимальным расширением охвата, без зависимости от прочих символов;</li>
        <li>наборы для польского, литовского и венгерского языков предусмотрены как в полном виде, с урезанным базовым набором, так и в виде частичного упрощённого ввода, где присутствует базовый набор символов, а некоторые языковые символы отданы на комбинированный ввод (преимущественно с единым диакритическим символом – акут для польского и венгерского, огонек для литовского + ż);</li>
        <li>наборы для чешского и словацкого, даже при отказе от базового набора символов, всё равно являются частично-упрощающими (без řďťň для чешского, без акутных форм для словацкого);</li>
        <li>прошлые два пункта могут быть исправлены и оптимизированы <a href="https://github.com/uqqu/qPhyx#%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D0%BE%D0%B2%D0%B0%D1%82%D0%B5%D0%BB%D1%8C%D1%81%D0%BA%D0%B8%D0%B5-%D0%BD%D0%B0%D0%B7%D0%BD%D0%B0%D1%87%D0%B5%D0%BD%D0%B8%D1%8F">дополнительными пользовательскими назначениями</a>;</li>
        <li>в зависимости от потребностей пользователя (переключаемая настройка), символы упрощённого ввода могут подаваться на ввод как в комбинированном виде (два символа – буква+диакритика), так и в виде цельного юникод-символа;</li>
        <li>одинаковые динамические символы, встречающиеся в разных наборах, расположены на одних и тех же позициях, где это было возможно.</li>
    </ul>
</details>

<details>
    <summary>Все варианты латинских наборов (37)</summary>
    <table>
        <tr>
            <td>Main</td>
            <td>ñ</td>
            <td>å</td>
            <td>ä</td>
            <td>ö</td>
            <td>ü</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Turkish</td>
            <td>ç</td>
            <td>ş</td>
            <td>ğ</td>
            <td>ö</td>
            <td>ü</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Polish (partial + base)</td>
            <td>ñ</td>
            <td>ą</td>
            <td>ę</td>
            <td>ż</td>
            <td>ó</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Polish (full − base)</td>
            <td>ć</td>
            <td>ń</td>
            <td>ó</td>
            <td>ś</td>
            <td>ź</td>
            <td>ł</td>
            <td>ą</td>
            <td>ę</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>ż</td>
        </tr>
        <tr>
            <td>Czech (partial − base)</td>
            <td>á</td>
            <td>é</td>
            <td>ó</td>
            <td>í</td>
            <td>ú</td>
            <td>ý</td>
            <td>ů</td>
            <td>ě</td>
            <td>ß</td>
            <td>š</td>
            <td>č</td>
            <td>ž</td>
        </tr>
        <tr>
            <td>Romanian</td>
            <td>î</td>
            <td>ă</td>
            <td>â</td>
            <td>ș</td>
            <td>ț</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Hungarian (partial + base)</td>
            <td>ñ</td>
            <td>ő</td>
            <td>ű</td>
            <td>ö</td>
            <td>ü</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Hungarian (full − base)</td>
            <td>á</td>
            <td>é</td>
            <td>ó</td>
            <td>í</td>
            <td>ú</td>
            <td>ł</td>
            <td>ö</td>
            <td>ü</td>
            <td>ß</td>
            <td>ø</td>
            <td>ő</td>
            <td>ű</td>
        </tr>
        <tr>
            <td>Slovene, Croatian (Gaj's latin), Romany</td>
            <td>č</td>
            <td>š</td>
            <td>ž</td>
            <td>ǵ</td>
            <td>ć</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Slovak (full − base)</td>
            <td>ň</td>
            <td>ô</td>
            <td>ä</td>
            <td>ö</td>
            <td>ü</td>
            <td>ľ</td>
            <td>ď</td>
            <td>ť</td>
            <td>ß</td>
            <td>š</td>
            <td>č</td>
            <td>ž</td>
        </tr>
        <tr>
            <td>Turkic languages (full − base)</td>
            <td>ñ</td>
            <td>ê</td>
            <td>ä</td>
            <td>ö</td>
            <td>ü</td>
            <td>ū</td>
            <td>ə</td>
            <td>ı</td>
            <td>ţ</td>
            <td>ş</td>
            <td>ç</td>
            <td>ğ</td>
        </tr>
        <tr>
            <td>Lithuanian (partial + base)</td>
            <td>č</td>
            <td>š</td>
            <td>ž</td>
            <td>ė</td>
            <td>ū</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Lithuanian (full − base)</td>
            <td>ą</td>
            <td>ę</td>
            <td>ė</td>
            <td>ų</td>
            <td>ū</td>
            <td>ł</td>
            <td>į</td>
            <td>ż</td>
            <td>ß</td>
            <td>š</td>
            <td>č</td>
            <td>ž</td>
        </tr>
        <tr>
            <td>Latvian (full − base)</td>
            <td>ā</td>
            <td>ē</td>
            <td>ī</td>
            <td>ū</td>
            <td>ǵ</td>
            <td>ļ</td>
            <td>ķ</td>
            <td>ņ</td>
            <td>ß</td>
            <td>š</td>
            <td>č</td>
            <td>ž</td>
        </tr>
        <tr>
            <td>Estonian (base − ł)</td>
            <td>õ</td>
            <td>š</td>
            <td>ä</td>
            <td>ö</td>
            <td>ü</td>
            <td>ž</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Albanian, Northern Sotho</td>
            <td>ç</td>
            <td>š</td>
            <td>ê</td>
            <td>ô</td>
            <td>ë</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Old English, Icelandic</td>
            <td>þ</td>
            <td>ƿ</td>
            <td>ſ</td>
            <td>ö</td>
            <td>ᵹ</td>
            <td>ł</td>
            <td>ð</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Urdu (Roman script) (base − ł)</td>
            <td>ū</td>
            <td>ṛ</td>
            <td>ṣ</td>
            <td>ṭ</td>
            <td>ẓ</td>
            <td>z̤</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Uzbek</td>
            <td>ç</td>
            <td>ş</td>
            <td>ḡ</td>
            <td>ō</td>
            <td>ñ</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Southern-Berber, Kanuri</td>
            <td>ǝ</td>
            <td>ŋ</td>
            <td>ɣ</td>
            <td>ʕ</td>
            <td>ɍ</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Twi, Yoruba (Benin), …</td>
            <td>ñ</td>
            <td>ŋ</td>
            <td>ɲ</td>
            <td>ɛ</td>
            <td>ɔ</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Northern Sami (base − ł)</td>
            <td>č</td>
            <td>š</td>
            <td>ž</td>
            <td>á</td>
            <td>ŋ</td>
            <td>ŧ</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Esperanto (base − ł)</td>
            <td>ĉ</td>
            <td>ŝ</td>
            <td>ĝ</td>
            <td>ĥ</td>
            <td>ĵ</td>
            <td>ǔ</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Kurdish (Hawar alphabet)</td>
            <td>ç</td>
            <td>ş</td>
            <td>ê</td>
            <td>î</td>
            <td>û</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Turkmen (base − łđœ)</td>
            <td>ç</td>
            <td>ş</td>
            <td>ä</td>
            <td>ö</td>
            <td>ü</td>
            <td>ý</td>
            <td>ň</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>ž</td>
        </tr>
        <tr>
            <td>Irish, Sundanese, Luba-Katanga</td>
            <td>á</td>
            <td>é</td>
            <td>í</td>
            <td>ó</td>
            <td>ú</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Luxembourgish, Uyghur</td>
            <td>é</td>
            <td>ë</td>
            <td>ä</td>
            <td>ö</td>
            <td>ü</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Maltese</td>
            <td>ñ</td>
            <td>ċ</td>
            <td>ġ</td>
            <td>ż</td>
            <td>ħ</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Maori, Samoan, Niuean</td>
            <td>ā</td>
            <td>ē</td>
            <td>ī</td>
            <td>ō</td>
            <td>ū</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Haitian, Javanese, Kikuyu</td>
            <td>é</td>
            <td>è</td>
            <td>ò</td>
            <td>ĩ</td>
            <td>ũ</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Hausa</td>
            <td>ɓ</td>
            <td>ɗ</td>
            <td>ƙ</td>
            <td>r̃</td>
            <td>ƴ</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Volta–Niger languages (Yoruba, Igbo, …)</td>
            <td>ṅ</td>
            <td>ṣ</td>
            <td>ẹ</td>
            <td>ọ</td>
            <td>ụ</td>
            <td>ị</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Western Frisian (base − ł)</td>
            <td>â</td>
            <td>ê</td>
            <td>é</td>
            <td>ô</td>
            <td>û</td>
            <td>ú</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Venda</td>
            <td>ṅ</td>
            <td>ḓ</td>
            <td>ḽ</td>
            <td>ṋ</td>
            <td>ṱ</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Sicilian</td>
            <td>à</td>
            <td>è</td>
            <td>ì</td>
            <td>ò</td>
            <td>ù</td>
            <td>ḍ</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Fula</td>
            <td>ɓ</td>
            <td>ɗ</td>
            <td>ŋ</td>
            <td>ɲ</td>
            <td>ƴ</td>
            <td>ł</td>
            <td>đ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
        <tr>
            <td>Mossi</td>
            <td>ɓ</td>
            <td>ɩ</td>
            <td>ʋ</td>
            <td>ɛ</td>
            <td>ɔ</td>
            <td>ł</td>
            <td>ɖ</td>
            <td>ı</td>
            <td>ß</td>
            <td>ø</td>
            <td>æ</td>
            <td>œ</td>
        </tr>
    </table>
</details>

Перейдём к кириллическим наборам.
<br>Как было упомянуто ранее, в кириллических наборах все позиции являются динамическими, за счёт чего их количество значительно меньше латинских наборов.

Все кириллические наборы являются "позволяющими", так как полноценный ввод текста на языках этих наборов невозможен без их использования.

Символы из кириллических наборов всегда подаются на ввод в едином виде (за исключением з́ и с́, не имеющих цельного представления).

Основной по потенциальной востребованности набор – `ґ є і ї ӏ ў ѣ ѵ ѳ ӂ ӕ ӧ`

Данный набор символов открывает доступ к полноценному набору текста на украинском, белорусском, молдавском, русинском, осетинском, языке коми, диалекте руска рома, ряде кавказских языков, дореволюционном русском.

<details>
    <summary>Все варианты кириллических наборов (6)</summary>
    <table>
        <tr>
            <td>Ukrainian, Belarusian, Caucasian, …</td>
            <td>ґ</td>
            <td>є</td>
            <td>і</td>
            <td>ї</td>
            <td>ӏ</td>
            <td>ў</td>
            <td>ѣ</td>
            <td>ѵ</td>
            <td>ѳ</td>
            <td>ӂ</td>
            <td>ӕ</td>
            <td>ӧ</td>
        </tr>
        <tr>
            <td>Serbian, Montenegrin, Interslavic, …</td>
            <td>ѓ</td>
            <td>ќ</td>
            <td>ђ</td>
            <td>ћ</td>
            <td>љ</td>
            <td>њ</td>
            <td>ѣ</td>
            <td>џ</td>
            <td>ј</td>
            <td>ѕ</td>
            <td>з́</td>
            <td>с́</td>
        </tr>
        <tr>
            <td>Kazakh, Mongolian, Uzbek, Kyrgyz, Tajik, …</td>
            <td>ғ</td>
            <td>қ</td>
            <td>ң</td>
            <td>ҷ</td>
            <td>ҳ</td>
            <td>ү</td>
            <td>ә</td>
            <td>һ</td>
            <td>ө</td>
            <td>і</td>
            <td>Ұ</td>
            <td>ӯ</td>
        </tr>
        <tr>
            <td>Bashkir, Chuvash, Tatar, …</td>
            <td>ғ</td>
            <td>ҡ</td>
            <td>ң</td>
            <td>ӑ</td>
            <td>ӗ</td>
            <td>ү</td>
            <td>ә</td>
            <td>һ</td>
            <td>ө</td>
            <td>җ</td>
            <td>ҙ</td>
            <td>ҫ</td>
        </tr>
        <tr>
            <td>Abkhazian</td>
            <td>ӷ</td>
            <td>қ</td>
            <td>ҟ</td>
            <td>ҷ</td>
            <td>ҳ</td>
            <td>ҩ</td>
            <td>ә</td>
            <td>ҵ</td>
            <td>ӡ</td>
            <td>ҭ</td>
            <td>ҽ</td>
            <td>ҿ</td>
        </tr>
        <tr>
            <td>Yakut, Even(ki), Altai, Krymchak, …</td>
            <td>ҕ</td>
            <td>ҥ</td>
            <td>ҋ</td>
            <td>һ</td>
            <td>ӏ</td>
            <td>ү</td>
            <td>ӈ</td>
            <td>ј</td>
            <td>ө</td>
            <td>ӫ</td>
            <td>ӱ</td>
            <td>ӧ</td>
        </tr>
    </table>
</details>


Текущие активные наборы символов также отображены в GUI скрипта.

![Отображение языковых наборов](https://github.com/uqqu/qPhyx/blob/master/external/readme_images/lang_modes.png)

Немного финальной статистики:
> *согласно данным использования языков в интернете с <a href="https://w3techs.com/technologies/overview/content_language">w3techs.com</a> за 24.04.2022*
* полностью поддерживаемые языки на любых наборах – 76.73% (90.20% без упрощённого ввода);
* полностью поддерживаемые языки на основных наборах – 8.12%;
* полностью поддерживаемые языки на дополнительных наборах – 5.36%;
* романизированные версии языков прочих письменностей: все версии – 9.45%, некоторые – 0.01%;

Подробнее со всеми *(200+)* языками, категориями, используемостью, алфавитами и поддержкой можно ознакомиться в файле <a href="https://github.com/uqqu/qPhyx/blob/master/external/languages.xlsx">external/languages.xlsx</a> 


## Дополнительная функциональность

### Парные скобки/кавычки

Переключаемая функциональность.
<br>Автоматически закрывает скобки и кавычки `<>`, `«»`, `""`, `“”`, `()`, `[]` и `{}`, устанавливая позицию каретки между ними.
<br>Автоматическое закрытие одинарных кавычек не предусмотрено, так как данный символ часто используется в значении апострофа, где парная кавычка будет нежелательной.

### Сдвиг цифрового ряда для начала с нуля (01…9 вместо 1…90)
Переключаемая функциональность.
<br>Сдвигает цифровой ряд на одну позицию вправо, перемещая ноль в первую позицию.

### Замена текста в буфере обмена

Вызывается нажатием `Ctrl-Shift-v`.
<br>Вставляет текст из буфера обмена вместо выделенного текста, сохраняя последний в качестве нового значения буфера.

### Изменение регистра выделенного текста

Переключаемая функциональность.
<br>Вызывается двойным нажатием на `Shift`.
<br>При вызове изменяет регистр каждого символа на обратный.
<br>При вызове с `Ctrl` или `Alt` меняет регистр на верхний или нижний, соответственно.

### Навигация через `Alt+[hjkl]`

Навигация через имитацию клавиш-стрелок поддерживает все изначальные модификаторы:
* с `Shift` для навигации с выделением;
* с `Ctrl` для навигации по словам (`j` и `k` будут выполнять функции перемещения каретки в начало и конец строки, соответственно);
* с `LWin` вместо `Alt` для управления положением окна. С дополнительным `Shift` для позиционирования окна между экранами.

### Прочие назначения и горячие клавиши

Неразрывный пробел – `Shift-Space` (переключаемая функциональность)
<br>Свернуть все окна – `LWin-Enter`
<br>Восстановить свёрнутые окна – `LWin-Enter long`
<br>Пауза/возобновление работы скрипта – `Shift-Tilde`
<br>Перезапуск скрипта – `Ctrl-Shift-Tilde`

### GUI

Скрипт имеет минимальный подсказывающий графический интерфейс, вызываемый через `Alt+F1` или кликом по иконке в трее.
<br>В интерфейсе в соответствующих вкладках отображены:
* базовый слой – системная буквенная раскладка пользователя, языковые наборы, переназначения;
* три вкладки символьных слоёв – длинные нажатия, `Alt`, `Alt Long`;
* вкладка со скан-кодами клавиш для пользовательских назначений;
* список всех языковых наборов для двух письменностей с переключением двойным нажатием;
* список всех горячих клавиш как для управления скриптом, так и для прочих функций.

GUI может изменяться в зависимости от некоторых настроек, отображая вид предусматриваемый данными опциями. В их числе текущие языковые наборы, функциональность парных скобок, пользовательские переназначения.

Вкладки слоёв реагируют на нажатия клавиш на физической клавиатуре, подсказывая её положение на экране.
<br>Переключение между вкладками может быть осуществлено клавишами `F1-F7`.

Управление прочими настройками расположено в меню, вызываемом через `LWin+F1` или ПКМ по иконке в трее.

### Пользовательские назначения

Предусмотрены пользовательские назначения трёх типов:
* назначения дополнительных клавиш в цифровом ряду, которые, будучи пустыми, выполняют функции уменьшения и увеличения выделенного числа на 1;
* дополнительные назначения в буквенной части клавиатуры для латинской письменности. После адаптации латинских раскладок в них появилось 7 дополнительных позиций, которые могут быть использованы в дополнение к языковому слою, в зависимости от индивидуальных потребностей пользователя;
* назначения для переключения между приложениями в комбинации с модификатором `LWin`. Запускает приложение, если оно не запущено.

Назначения прописываются в файле `config.ini`, который генерируется рядом с исполняемым файлом скрипта после первого запуска.

Для первых двух типов, назначения прописывается в секции `AdditionalAssignments` по шаблону `<скан_код_клавиши>=<назначаемый_символ>`. Скан коды клавиш цифрового ряда предварительно указаны в этой секции с пустыми назначениями. Скан коды прочих клавиш можно посмотреть в соответствующей вкладке GUI. Возможно указание модификатора `Shift` (указывается как `+` перед скан кодом) для назначений в буквенной части клавиатуры. Возможно указание unicode значения символа по шаблону `{U+<код_символа>}`.

Назначения для переключения фокуса между приложениями прописываются в секции `AltApps` по шаблону `<скан_код_клавши>=<имя_процесса>,<путь_к_исполняемому_файлу>`. Указание модификаторов не требуется.

После внесения изменений через `config.ini` требуется перезапуск скрипта.
<br>При внесении изменений через пункт меню (только для назначений клавиш в цифровом ряду) перезапуск не требуется.

### Переназначения управляющих клавиш

В дополнение к перечисленному в прошлых разделах, пользователю предлагается опробовать переназначение управляющих клавиш, таких как `Backspace`, `Enter`, `CapsLock` и `Esc`. Их более комфортное расположение с минимизацией лишних движений рук может быть включено в соответствующем пункте меню.
<br>Предлагаемое назначение:
* `Enter` выполняет функцию `Backspace`; с зажатым `Shift` – `Delete`;
* `CapsLock` выполняет функцию `Enter`;
* `Tilde` выполняет функцию `Esc`;
* `Backspace` выполняет функции управления медиа (нажатие – воспроизведение/пауза; с `Shift` – увеличить громкость; с `Alt` – уменьшить громкость; с `Shift Long` – следующий медиа-элемент; с `Alt Long` – предыдущий медиа-элемент);
* Функция `CapsLock` может быть назначена на `Esc` отдельной настройкой.

Подобное расположение является более эргономичным и позволяет минимизировать движения, отрывающие пальцы от домашних позиций.

Текущие переназначения, как пользовательские, так и переключение опции управляющих клавиш, отображаются в GUI.

Пример отображения с включёнными настройками переназначения управляющих клавиш, парных скобок, сдвигом цифрового ряда и переназначением клавиш в цифровом ряду:

![GUI с опциями](https://github.com/uqqu/qPhyx/blob/master/external/readme_images/long_with_options.png)

### Автоматическое отключение скрипта в отдельных приложениях

Отлов длинных нажатий может быть нежелательным в некоторых приложениях, сказываясь на их работе.
<br>Такие приложения вносятся в файл `config.ini` в секцию `BlackList` по шаблону `<порядковый_номер>=<имя_процесса>`, после чего действие скрипта в данных приложениях будет автоматически приостанавливаться.


## Установка и запуск

> Только для Windows

1. *(опционально)* Установите [адаптированные](https://github.com/uqqu/qPhyx/tree/master/external/layouts) версии ваших раскладок для латиницы и кириллицы, выберите их в настройках ОС и перезагрузите систему.
2. *(опционально)* Установите <a href="https://www.autohotkey.com/">AHK</a>, если предпочитаете использовать нескомпилированную версию скрипта.
3. Разместите файлы `qphyx.exe` (или `qphyx.ahk`), `modes.ini` и файлы `.ico` в папке по вашему выбору, запустите `qphyx.*`.
4. Ознакомьтесь с использованием. Настройте в меню (ПКМ по иконке в трее или `LWin+F1`) языковые наборы, время срабатывания "длинных" нажатий и прочие пункты.
5. *(опционально)* Добавьте `qphyx.*` в автозагрузку.