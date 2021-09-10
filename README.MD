# qPhyx
## ↓ English part

> Remark: my English is really far from perfect. If you are able to read Russian, you should look at the [appropriate section](#-russian-part)

**qPhyx** is а unified universal phonetic biscripted keyboard layout with the best possible scores of typing convenience and a set of additions to the usual method of typing.

Project began as an alternate phonetic bilingual layout. In the aftermath many features went beyond the usual layout and now it became something more. It can be logically divided into three parts:
1. Default letter layout
2. Uncommon symbol layout with some features
3. Arisen in the process add-on with many features

The first two depend on each other and are in this repository. Third can be used as such and moved to [a separate repository](https://github.com/uqqu/menu), but planned and once was as a part of one-piece project.

Benefits:
1. A unified typing system, both for current supported scripts and for future ones.
2. Full support for Latin and Cyrillic scripts with all features without separate language layouts.
3. Support for language mods that retain all of the benefits of a unified system, while at the same time removing all of the limitations of unification for individual languages.
4. Extended symbol support.
5. The best objective scores for the convenience of typing.
6. Additional internal and external ([menu](https://github.com/uqqu/menu)) functionality.

To fully understand what the project is, it is highly recommended that you read a semi-chronological description of it piece by piece. A description in general terms is fatally incomplete and may give a false impression of it.
<br>Another good method of familiarizing yourself with a project is to use it.
<br>Even better, both of them.


## Letter layer

> For a better understanding of this part it is recommended to have a look at the [external/calculation.xlsx](https://github.com/uqqu/layout/blob/master/external/calculation.xlsx)

Тhe arrangement of the letters was as objective as possible.


### Frequency analyses

First, various frequency analyses were found and stored with their average value *(so this is a meta-analysis?)*. A total of 25 analyses were selected based on different samples. All valid analyses found were taken into account.

For English, the following analyses (resource references) were included in the final view for the base character frequency:

  * [norvig.com](http://norvig.com/mayzner.html)
  * [ac.uk](https://core.ac.uk/download/pdf/231084615.pdf)
  * [sttmedia.com](https://www.sttmedia.com/characterfrequency-english)
  * [nd.edu](https://www3.nd.edu/~busiforc/handouts/cryptography/letterfrequencies.html)
  * [pi.math.cornell.edu](http://pi.math.cornell.edu/~mec/2003-2004/cryptography/subs/frequencies.html)
  * [lexico.com](https://www.lexico.com/explore/which-letters-are-used-most)
  * [cs.wellesley.edu](http://cs.wellesley.edu/~fturbak/codman/letterfreq.html)
  * [en.algoritmy.net](http://en.algoritmy.net/article/40379/Letter-frequency-English)
  * [practicalcryptography.com](http://practicalcryptography.com/cryptanalysis/letter-frequencies-various-languages/english-letter-frequencies/)

For Russian, the following analyses were included for the base character frequency:

  * [dict.ruslang.ru](http://dict.ruslang.ru/freq.php?act=show&dic=freq_letters)
  * [sttmedia.com](https://www.sttmedia.com/characterfrequency-russian)
  * [simia.net](http://simia.net/letters/index.html)
  * [lg--web.chat.ru](http://lg--web.chat.ru/texts.html)
  * [practicalcryptography.com](http://practicalcryptography.com/cryptanalysis/letter-frequencies-various-languages/russian-letter-frequencies/)
  * Яглом А.М., Яглом И.М., Вероятость и информация, М.: Наука, 1973. / с.238

For English, the following bigram analyses were selected for paired symbol frequency:

  * [joyofdata.de](https://www.joyofdata.de/blog/frequency-of-character-combinations/)
  * [gist.github.com/lydell](https://gist.github.com/lydell/c439049abac2c9226e53)
  * [homepages.math.uic.edu](http://homepages.math.uic.edu/~leon/mcs425-s08/handouts/char_freq2.pdf)
  * [practicalcryptography.com](http://practicalcryptography.com/cryptanalysis/letter-frequencies-various-languages/english-letter-frequencies/)
  * [link.springer.com](https://link.springer.com/content/pdf/10.3758/BF03201360.pdf)

For Russian, the following bigram analyses were selected for paired symbol frequency:

  * [statistica.ru](http://statistica.ru/local-portals/data-mining/analiz-tekstov/)
  * [joyofdata.de](https://www.joyofdata.de/blog/frequency-of-character-combinations/)
  * [practicalcryptography.com](http://practicalcryptography.com/cryptanalysis/letter-frequencies-various-languages/russian-letter-frequencies/)


### Selection of convenience criteria

To objectively evaluate the ease of use of the layout, it is necessary to allocate the appropriate criteria. They are:
  * hand alteration (the probability that both hands will be used to type any random pair of letters)
  * even handload
  * even fingerload
  * minimum chance for double sequentially usage of the same finger (bearing in mind base key repeating).
  * maximum usage on the most convenience groups (see below)

For the latter criteria letter-part of default non-ergonomic keyboard were divided into 6(7) groups by convenience:
> Despite the fact that such a division itself is somewhat subjective, the allocation of the first group does not cause any questions - these are home finger positions, where you do not need to make any movements, only pressing. In future scores, the focus of this criterion will be on the first group, as the most objective.

> *hereinafter in "excel-view"*

![Groups of keys by convenience](https://github.com/uqqu/layout/blob/master/external/readme_images/groups_animated.gif "Groups of keys by convenience")
<br>[Last frame](https://github.com/uqqu/layout/blob/master/external/readme_images/groups.png)


### Layout creation

Past points have been systematized and automated in [external/calculation.xlsx](https://github.com/uqqu/layout/blob/master/external/calculation.xlsx) to further create the layout.
> You can also try to change the current layout or create your own in this file. All scores change dynamically, depending on the current view.

Many variations have been tried for both languages. Some were extremely successful, and are still on the sheet <code>[en/ru] archive</code>. However, the final form of layouts must skillfully balance between all criteria. And also in view of the original purpose of the phonetic layout, it is necessary to take into account the phonetic dependence of the layouts of the two languages. After much ordeal, such a double layout became the following parts:

![Latin letter layout](https://github.com/uqqu/layout/blob/master/external/readme_images/letters_lat.png "Latin letter layout")

![Cyrillic letter layout](https://github.com/uqqu/layout/blob/master/external/readme_images/letters_cyr.png "Cyrillic letter layout")


### Result numbers

I'll list it all:
  * hand alteration – 67.73% (en) and 73.32% (ru)
  * handload – 49.69/50.31% and 50.64/49.36%
  * maximum difference of finger load – 3.86% and 7.48%
  * chance for double sequentially usage of the same finger – 3.38% and 4.37%
  * "home" group usage – 64.01% and 57.72%
<br><sub>and also a nice look and mnemonic rows</sub>


### Existing alternative layouts

One more clarification – you can still compare these layouts directly with each other, but you can not with the "topic-starter" – they are conceptually different. All numbers below are just a general idea (and a little bit to show how bad the standard <code>qwerty</code> and <code>йцукен</code> are).
> Only letters are counted in the calculations! The rates of character-oriented layouts on the base layer may be somewhat inaccurate. But only "somewhat," as one should not overestimate the frequency of non-alphabetic characters, especially for English.

<details>
  <summary>qwerty (en)</summary>
  <ul>
    <li>hand alteration – 51.68%</li>
    <li>handload – 58.47/41.53%</li>
    <li>maximum difference of finger load – 19.99%</li>
    <li>chance for double sequentially usage of the same finger – 7.29%</li>
    <li>"home" group usage – 26.09%</li>
  </ul>
</details>
<details>
  <summary>workman (en)</summary>
  <ul>
    <li>hand alteration – 54.89%</li>
    <li>handload – 51.70/48.30%</li>
    <li>maximum difference of finger load – 11.28%</li>
    <li>chance for double sequentially usage of the same finger – 3.15%</li>
    <li>"home" group usage – 62.73%</li>
  </ul>
</details>
<details>
  <summary>colemak (en)</summary>
  <ul>
    <li>hand alteration – 57.23%</li>
    <li>handload – 48.31/51.69%</li>
    <li>maximum difference of finger load – 12.48%</li>
    <li>chance for double sequentially usage of the same finger – 1.84%</li>
    <li>"home" group usage – 64.01%</li>
  </ul>
</details>
<details>
  <summary>dvorak (en)</summary>
  <ul>
    <li>hand alteration – 68.19%</li>
    <li>handload – 43.33/56.67%</li>
    <li>maximum difference of finger load – 9.83%</li>
    <li>chance for double sequentially usage of the same finger – 2.97%</li>
    <li>"home" group usage – 58.33%</li>
  </ul>
</details>
<details>
  <summary>qwpr (en)</summary>
  <ul>
    <li>hand alteration – 57.23%</li>
    <li>handload – 48.31/51.69%</li>
    <li>maximum difference of finger load – 14.06%</li>
    <li>chance for double sequentially usage of the same finger – 4.41%</li>
    <li>"home" group usage – 61.62%</li>
  </ul>
</details>
<details>
  <summary>йцукен (ru)</summary>
  <ul>
    <li>hand alteration – 53.54%</li>
    <li>handload – 53.23/46.63%</li>
    <li>maximum difference of finger load – 29.51%</li>
    <li>chance for double sequentially usage of the same finger – 19.79%</li>
    <li>"home" group usage – 33.97%</li>
  </ul>
  <sub>An interesting fact: two-thirds of all presses in the йцукен are on the index fingers. And such a grouping of the most popular characters as a result leads to the fact that and every fifth press will be performed by the same finger. What kind of "ten-finger typing" can we talk about in this situation?</sub>
</details>
<details>
  <summary>яверты (ru)</summary>
  (** only the letters of the main letter block were taken into account)
  <ul>
    <li>hand alteration – 48.36%</li>
    <li>handload – 50.41/46.84%</li>
    <li>maximum difference of finger load – 13.24%</li>
    <li>chance for double sequentially usage of the same finger – 9.38%</li>
    <li>"home" group usage – 61.62%</li>
  </ul>
</details>

> More layouts, and their appearance can be found in .xlsx file. Here are listed only the main parameters of the most important layouts to mention.


#### Result
Let's start with the English layouts: <code>qwerty</code> is frankly bad, if not rougher. Any existing layout (including the ones not listed) is much better. If you look at the opposite result, everything is not so clear, but <code>dvorak</code>, according to the main points, takes the lead.
I will not fully compare <code>dvorak</code> and <code>qPhyx</code>, because this comparison is incorrect, as I mentioned in the beginning. But even for a general idea you can note that on the whole the numbers of the topic-starter if not better, then at least at the level of the leader.


And now let's move on to the Russian layouts... Everything is bad. For the Russian language there is simply no sane alternative layouts. The ones that are available are hardly better than the standard <code>йцукен</code>, and this is despite the fact that there are even more questions to <code>йцукен</code> than to its <code>qwerty</code> counterpart.

<br>

> ↓ NB!
<br>At this stage it is worth getting a little ahead of ourselves and noting that the English layout, in fact, is the common layout of the Latin alphabet, which with the help of the extended character diacritics and language modes allows you to write in almost all languages based on the Latin or Cyrillic alphabet.
<br>Thus, we get a unified system for all Latin- Cyrillic-based languages. By system I mean everything you are now and further reading - all the concepts and everything that follows from them, be it phonetic continuity or symbolic unity... It's worth telling the latter already, isn't it?


## Symbol layer
> One of the reason of making *"one more"* layout – symbol mismatch in different languages and their limited number.

The following requirements were imposed on the symbol layer:
* symbols unity on the any letter layout
* a clear delineation between symbol and letter layers
* group symbols in the logical categories
* more symbols, add diacritic
* it is necessary to keep in mind the convenience groups for symbols too
* all of this should fit in the 60% ANSI-keyboard (see below for example)
* it should contain main (and maybe some more) controlling commands

![60% keyboard explanation](https://cdn.thewirecutter.com/wp-content/media/2021/05/20210527_mech-keyboard_layout.png "60% keyboard explanation")
<sub>Source: [nytimes.com](https://www.nytimes.com/wirecutter/blog/how-to-shop-for-a-mechanical-keyboard/); Illustration: Sarah Macreading, Dana Davis</sub>


Let's get acquainted with the result in three (two and a half) stages, fortunately, there is something to tell at each of them.

### Lite variant
![Lite symbol layout](https://github.com/uqqu/layout/blob/master/external/readme_images/symbols_lite.png "Lite symbol layout")
> First of all – yes this layout suggests to non-standard keyboard usage as `long presses`. I am not going to prove to you that it is a comfortably – if you are convinced otherwise you still won't believe me. But I'm sure if you use this functionality enough to use it automatically, then you will agree with me. We won't mention this subject any more.

In green are highlighted main symbols, which there are also in the `qwerty` layout; in gray are highlighted additional symbols, which I thought I should add (this is probably the most subjective part). In the corner placed two diacritic symbols for accents.

As you can see, all of the conditions above are met:
* symbols are the separate layers and these layers is independent of any language
* symbols are grouped (base math, currencies, punctuation, brackets with mirror reflection around the home row) 
* additional symbols with often usage cases
* most usage symbols/groups placed on the most convenience groups
* all these within 60% keyboard (even less so far)
* there are controlling (navigation) commands

### Complete variant
![Complete symbol layout](https://github.com/uqqu/layout/blob/master/external/readme_images/symbols_complete.png "Complete symbol layout")

> It may look very strange and very unfamiliar, but I assure – it's only because it's unfamiliar.

Let's see what are changed: 

#### Num row.
Base numbers are not changed. I don't think that ascending order for them is a bad thing. Alternate layers for nums contains not the best possible variants, but it is logical and, in general, num-layers is the less convenience, and they get the least attention.
#### Extended diacritic.
It allows you to write in French, Spanish, Portuguese, Italian, German (with eszett at the same row), Turkish, Esperanto and many more languages as well.
#### Controlling keys are swapped and reassigned: 
  * `backspace` now used for music control
  * `enter` performs the functions of `backspace` and `delete`
  * `caps lock` was be replaced by `enter`
  * base `tilde` as `esc`
  * `caps lock` function thrown out (it was meant to be)
    * if you want, you can map `caps lock` function on `esc`, but for some cases you still may use `esc` instead of `tilde` as `esc`

And again – it may look very strange, but these remapping were all done only to increase convenience.

## Implementation

Omitting a bunch of different attempts: letter layer has been implemented by the native keyboard layout generation tool – [Microsoft Keyboard Layout Creator](https://www.microsoft.com/en-us/download/details.aspx?id=102134), symbol layer was realized with [AHK](https://www.autohotkey.com/).

Generated `MKLC` layouts for your `Windows` – [external/qphyx_la/](https://github.com/uqqu/layout/tree/master/external/MKLC_qphyx_la), [external/qphyx_ru/](https://github.com/uqqu/layout/tree/master/external/MKLC_qphyx_ru)

AHK script is more variable. Base script functionality is, of course, symbolic layers addition. Base "long press" delay is 0.15s. You can change it in `config.ini` (will generate with first start). Early on in you may want to increase this value up to 0.2. In the process of getting used to it, you may decrease it up to 0.1 (recommend is 0.12)

## Additional features

* Clipboard swap – `Ctrl-Shift-g` (`v` in qwerty-view) – paste clipboard value, save pasted value (if paste in selected area) in clipboard
* Active/minimize predefined app – `Win-[any key]` – set your favorite apps in the `config.ini` file (create `AltApps` section) and switch between them. If process does not exist – start it. This way faster, easier and more flexible than `Win-[1-9]`. Pattern for `.ini`:
```
{scancode_number}={process_name},{path_to_file}
```
Example – bind `nvim` on `Win–q`:
```
010=nvim-qt.exe,C:\Shortcuts\nvim-qt.exe.lnk
```
* Full arrow replacement with `alt-[mstr]` (with shift/ctrl/shift-ctrl. alt-(sh)-ctrl-[st] used for bol and eol)
* Move windows with `Win-(shift)-mstr` (`hjkl` in qwerty-view) as well as with `arrows`
* If you collide with case, which require some "standard" key behavior – you can toggle script work on air with `Shift-tilde`
* And many more features available on `\|` key (ansi-keyboards) with [menu](https://github.com/uqqu/menu) addon!

## FAQ

<dl>
  <dt>Do I need to install <a href="https://www.autohotkey.com/">AutoHotKey</a>?</dt>
  <dd>Only for using the <code>.ahk</code> version. Using a compiled identical <code>.exe</code> version does not require any additional installations.</dd>
  <dt>What about layout for ergonomic keyboards?</dt>
  <dd>This project is aimed at standard non-ergonomic keyboards. Porting this layout to any other keyboard it is a special process. I think very highly of ergonomic keyboards and I will be glad realize version for one of them someday, but now there are no any version for keyboards different of standard.</dd>
  <dt>Can I use it on Linux?</dt>
  <dd>No. As I know, there are only hard ways to realize "long presses" on Linux, and I'm not ready to take on them now. It is possible to implement a version with additional modifier instead of "long" trigger, but it will no longer be the original project.</dd>
  <dt>Can I use it on Mac?</dt>
  <dd>No, current version can be used only on Windows. I weren't interested in ways to realize it on Mac.</dd>
  <dt>Can I use it on Android?</dt>
  <dd>Yes, partially. It cannot be done for <code>G.Board</code>, but there is an app with totally customization – <a href="https://play.google.com/store/apps/details?id=kl.ime.oh&hl=en">Multiling O Keyboard</a>. You can find layout pattern for this app with screenshot examples at the <a href="https://github.com/uqqu/layout/tree/master/external/android">external/android/</a>.</dd>
  <dt>Latin layout has empty keys?</dt>
  <dd>Yes. With the separating letter and symbol layers, keys with the potential-letter functions may be used only for letters. There is no problem with that, it's even more comfortably because now letters allocated to more convenient positions.</dd>
  <dt>...and yet they are not completely empty?</dt>
  <dd>Yes, technically, <code>x</code>, <code>c</code> and <code>b</code> keys (in qwerty-view) send <code>U+001E</code>, which does not appear in the printout, but can be used by third-party programs. I have not yet encountered a case where this would be bad, but potentially, if there are any, it can be removed.</dd>
  <dt>Can I use symbol layout with <code>qwerty</code>?</dt>
  <dd>You can, but it won't be as comfortable as it planned.</dd>
  <dt>Can I use letter layout without symbols?</dt>
  <dd>Unfortunately no. You will be missing base symbols, which were placed on "potential-letter" keys.</dd>
  <dt>So, what languages can I write in exactly?</dt>
  <dd>ANSWER</dd>
  <dt>Has this project something to do with touch typing?</dt>
  <dd>Of course! The main goal in maximizing convenience with touch typing and minimizing unnecessary moves (especially, moves that make you have to take your hands off your "home" positions)</dd>
  <dt>Should I first train with touch typing before use this layout?</dt>
  <dd>If you are asking yourself this question – you should, regardless of future using this layout. And if you are not experienced in touch typing – maybe it is even better! Pay close attention to the following question for more details.</dd>
  <dt>I am a grandmaster of <code>colemak</code>/<code>dvorak</code>/<code>workman</code>/etc, will I get any profit from switching to this layout?</dt>
  <dd>If you're happy with your current layout, and you're not looking for anything more than just a layout, there's no reason. However, if you want to switch, note that the process of switching to any new layout is very long and discomfortable. And the better you mastered the old layout, the more unpleasant the switching to the new one will be. The first time you will be slow and clumsy, and it will be really annoying. Also later you will sometimes have "phantom" typing, when one letter of the entire stream suddenly will typed from old layout. Pretty infuriating thing. I am by no means discouraging you, just that you should be prepared in advance for all the things described.</dd>
  <dt>...and I'm a grandmaster of <code>qwerty</code>! Will I ge...</dt>
  <dd>*interrupts* Right now, take any third-party layout. I would be pleased if the layout that is the focus of this entire text was chosen, but even if not, there are many other layouts for Latin, and some of them are very good. But not for the Russian. It is bad there. Anyway, try to give up <code>qwerty</code>. This is an extremely important layout for typing history, but leave its use to museum workers.</dd>
  <dt>I can't use <code>arrows</code>/<code>numpad</code>!</dt>
  <dd>That's the way it's supposed to be. If you want to try this layout, you should be used to keep your hands on "home" positions.</dd>
  <dt>I can't "scream" with <code>Caps Lock</code>!</dt>
  <dd>That's great. That's the way it's supposed to be.</dd>
  <dt>... but I need <code>Caps Lock</code> function for my PL or some other case!</dt>
  <dd>This layout is for general use. In general cases this function is harmful. For special cases you always can add mapping for <code>Caps Lock</code> and comment <code>SetCapsLockState</code> on <code>qphyx.ahk</code>. But, please, don't overuse it.</dd>
  <dt>Is this project relative to <a href="https://github.com/uqqu/menu">menu</a>?</dt>
  <dd>Yes, once they were an one-piece project, but while the functionality was becoming more and more they were separated in two projects. But they have connections with each other (e.g. you can regulate "long press" delay with <code>menu</code> and some more). For connection between them you should correct path to relative in <code>config.ini</code> for both.</dd>
  <dt>Some other integrations?</dt>
  <dd>Just start at the right time – <a href="https://github.com/magicstep/ViATc-English">ViATc</a>. If you use it – correct path to <code>ViATc-x.x.xen.ahk</code> in the <code>config.ini</code>. That's all.</dd>
  <dt>Troubles with <code>config.ini</code></dt>
  <dd>Don't create it yourself, let it be generated at startup, and only then edit it. For functionality with switching between applications, add a line <code>[AltApps]</code> at the end of the settings file, and afterwards, on separate lines, arrange your applications according to the appropriate pattern.</dd>
</dl>



## ↓ Russian part

**qPhyx** – единая универсальная фонетическая двускриптовая раскладка с лучшими возможными показателями удобства печати и рядом дополнений к привычному методу набора.

Проект начинался как альтернативная фонетическая двуязычная раскладка. Впоследствии многие функции вышли за рамки обычной раскладки, и проект стал чем-то большим. Его можно логично разделить на три части:
1. Клавиатурная раскладка стандартного вида;
2. Символьная раскладка с некоторыми особенностями и функциями;
3. Возникшее в процессе дополнение, включающее в себя некоторый набор функций.

Первые две части связаны друг с другом, и находятся в этом репозитории. Третья часть, хоть и планировалась как часть цельного проекта, и долгое время ею была, сейчас вынесена в [отдельный репозиторий](https://github.com/uqqu/menu).

Преимущества:
1. Единая система набора, как для текущих поддерживаемых письменностей, так и для будущих.
2. Полная поддержка латинской и кириллической письменности со всеми особенностями без отдельных языковых раскладок.
3. Поддержка языковых модов, сохраняющих все преимущества единой системы, и в то же время снимающих все ограничения юнификации с отдельных языков.
4. Расширенная символьная поддержка.
5. Лучшие объективные показатели удобства набора.
6. Дополнительный внутренний и внешний ([menu](https://github.com/uqqu/menu)) функционал.

Для полного понимания, чем является проект, настоятельно рекомендуется ознакомиться с его полухронологическим описанием по частям. Описание общими фразами является фатально неполным и может вызвать ложное представление об оном.
<br>Также хорошим методом ознакомления с проектом является его использование.
<br>Лучше, конечно же, и то и другое.


## Буквенный слой

> Для лучшего понимания этой части рекомендуется обратиться к [external/calculation.xlsx](https://github.com/uqqu/layout/blob/master/external/calculation.xlsx).

Расположение букв было максимально, насколько это возможно, лишено субъективщины. Объективные критерии, голые цифры.


### Анализы частотности

Первым делом были отобраны различные анализы частотности букв для интересующих языков из которых были выведены средние значения *(получается, мета-анализ)*. Всего было отобрано 25 анализов основанных на разных выборках. Учитывались все достоверные найденные анализы.

Для английского языка для базовой символьной частотности в финальный вид были включены следующие анализы (ссылки на ресурсы):

  * [norvig.com](http://norvig.com/mayzner.html)
  * [ac.uk](https://core.ac.uk/download/pdf/231084615.pdf)
  * [sttmedia.com](https://www.sttmedia.com/characterfrequency-english)
  * [nd.edu](https://www3.nd.edu/~busiforc/handouts/cryptography/letterfrequencies.html)
  * [pi.math.cornell.edu](http://pi.math.cornell.edu/~mec/2003-2004/cryptography/subs/frequencies.html)
  * [lexico.com](https://www.lexico.com/explore/which-letters-are-used-most)
  * [cs.wellesley.edu](http://cs.wellesley.edu/~fturbak/codman/letterfreq.html)
  * [en.algoritmy.net](http://en.algoritmy.net/article/40379/Letter-frequency-English)
  * [practicalcryptography.com](http://practicalcryptography.com/cryptanalysis/letter-frequencies-various-languages/english-letter-frequencies/)

Для русского явыка для базовой символьной частотности были включены следующие анализы:

  * [dict.ruslang.ru](http://dict.ruslang.ru/freq.php?act=show&dic=freq_letters)
  * [sttmedia.com](https://www.sttmedia.com/characterfrequency-russian)
  * [simia.net](http://simia.net/letters/index.html)
  * [lg--web.chat.ru](http://lg--web.chat.ru/texts.html)
  * [practicalcryptography.com](http://practicalcryptography.com/cryptanalysis/letter-frequencies-various-languages/russian-letter-frequencies/)
  * Яглом А.М., Яглом И.М., Вероятость и информация, М.: Наука, 1973. / с.238.

Для английского языка для парной символьной частотности были отобраны следующие биграммные анализы:

  * [joyofdata.de](https://www.joyofdata.de/blog/frequency-of-character-combinations/)
  * [gist.github.com/lydell](https://gist.github.com/lydell/c439049abac2c9226e53)
  * [homepages.math.uic.edu](http://homepages.math.uic.edu/~leon/mcs425-s08/handouts/char_freq2.pdf)
  * [practicalcryptography.com](http://practicalcryptography.com/cryptanalysis/letter-frequencies-various-languages/english-letter-frequencies/)
  * [link.springer.com](https://link.springer.com/content/pdf/10.3758/BF03201360.pdf)

Для русского языка для парной символьной частотности были отобраны следующие биграммные анализы:

  * [statistica.ru](http://statistica.ru/local-portals/data-mining/analiz-tekstov/)
  * [joyofdata.de](https://www.joyofdata.de/blog/frequency-of-character-combinations/)
  * [practicalcryptography.com](http://practicalcryptography.com/cryptanalysis/letter-frequencies-various-languages/russian-letter-frequencies/)


### Отбор критериев удобства

Для объективной оценки удобства использования раскладки необходимо выделить соответствующие критерии. Ими стали:

  * чередование рук (вероятность, с которой для набора любой случайной пары букв будут задействованы обе руки)
  * равномерная нагрузка рук
  * равномерная нагрузка пальцев
  * минимизация вероятности использования одного пальца на два набора подряд (с учётом базовой вероятности повтора одной буквы)
  * максимальное использование наиболее удобных групп (см. далее)

Для последнего критерия буквенная часть стандартной не эргономичной клавиатуры была разделена на 6(7) групп по удобству.
> Несмотря на то, что само подобное разделение является несколько субъективным, выделение первой группы не вызывает никаких вопросов – это домашние позиции пальцев, где вам не нужно совершать никаких движений, только нажатие. В будущей оценке основное внимание на этот критерий будет обращено именно на первую группу, как на самую объективную.

> *Здесь и далее в "excel-виде"*

![Группы клавиш по удобству](https://github.com/uqqu/layout/blob/master/external/readme_images/groups_animated.gif "Группы клавиш по удобству")
<br>[Последний фрейм](https://github.com/uqqu/layout/blob/master/external/readme_images/groups.png)


### Создание раскладки

Прошлые пункты были систематизированны и автоматизированны в [external/calculation.xlsx](https://github.com/uqqu/layout/blob/master/external/calculation.xlsx), для дальнейшего создания раскладки. 
> Вы также можете попробовать изменить текущую раскладку или создать свою в данном файле. Все оценки изменяются динамически, в зависимости от текущего вида.

Было опробованно множество вариантов для обоих языков. Некоторые оказались крайне удачными, и до сих пор хранятся на листе <code>[en/ru] archive</code>. Однако финальный вид раскладок должен умело балансировать между всеми критериями. А также в виду изначальной цели создания фонетической раскладки, необходимо учитывать фонетическую зависимость раскладок двух языков. Спустя многие мытарства такой двойной раскладкой стали следующие части:

![Latin letter layout](https://github.com/uqqu/layout/blob/master/external/readme_images/letters_lat.png "Latin letter layout")

![Cyrillic letter layout](https://github.com/uqqu/layout/blob/master/external/readme_images/letters_cyr.png "Cyrillic letter layout")


### Так что же, Веничка, что же всё-таки с цифрами? Нам страшно интересно...

Да ведь я понимаю, что интересно. Сейчас, сейчас перечислю:
  * чередование рук – 67.73% (en) и 73.32% (ru)
  * равномерность нагрузки рук – 49.69/50.31% и 50.64/49.36%
  * максимальная разница нагрузки пальцев – 3.86% и 7.48%
  * вероятность "чистого" повторного нажатия одним пальцем – 3.38% и 4.37%
  * использование "домашней" группы – 64.01% и 57.72%
<br><sub>а ещё приятный внешний вид и мнемонические ряды</sub>


### Так-так-так, – говорите вы, – а альтернативные раскладки? Ведь всё уже придумано до тебя.

Сейчас я вам покажу альтернативные раскладки.
<br>Но сначала ещё одно уточнение – напрямую сравнивать эти раскладки между собой ещё можно, а вот с "топик-стартером" не получится – они концептуально разные. Все цифры ниже служат исключительно для общего представления (и немножко для демонстрации, насколько стандартные <code>qwerty</code> и <code>йцукен</code> плохи).
> В подсчётах учитываются только буквы! Показатели символьно-ориентированных на базовом слое раскладок могут быть несколько неточными. Но лишь "несколько", т.к. не стоит переоценивать частоту небуквенных символов, особенно для английского языка.

<details>
  <summary>qwerty (en)</summary>
  <ul>
    <li>чередование рук – 51.68%</li>
    <li>равномерность нагрузки рук – 58.47/41.53%</li>
    <li>максимальная разница нагрузки пальцев – 19.99%</li>
    <li>вероятность "чистого" повторного нажатия одним пальцем – 7.29%</li>
    <li>использование "домашней" группы – 26.09%</li>
  </ul>
</details>
<details>
  <summary>workman (en)</summary>
  <ul>
    <li>чередование рук – 54.89%</li>
    <li>равномерность нагрузки рук – 51.70/48.30%</li>
    <li>максимальная разница нагрузки пальцев – 11.28%</li>
    <li>вероятность "чистого" повторного нажатия одним пальцем – 3.15%</li>
    <li>использование "домашней" группы – 62.73%</li>
  </ul>
</details>
<details>
  <summary>colemak (en)</summary>
  <ul>
    <li>чередование рук – 57.23%</li>
    <li>равномерность нагрузки рук – 48.31/51.69%</li>
    <li>максимальная разница нагрузки пальцев – 12.48%</li>
    <li>вероятность "чистого" повторного нажатия одним пальцем – 1.84%</li>
    <li>использование "домашней" группы – 64.01%</li>
  </ul>
</details>
<details>
  <summary>dvorak (en)</summary>
  <ul>
    <li>чередование рук – 68.19%</li>
    <li>равномерность нагрузки рук – 43.33/56.67%</li>
    <li>максимальная разница нагрузки пальцев – 9.83%</li>
    <li>вероятность "чистого" повторного нажатия одним пальцем – 2.97%</li>
    <li>использование "домашней" группы – 58.33%</li>
  </ul>
</details>
<details>
  <summary>qwpr (en)</summary>
  <ul>
    <li>чередование рук – 57.23%</li>
    <li>равномерность нагрузки рук – 48.31/51.69%</li>
    <li>максимальная разница нагрузки пальцев – 14.06%</li>
    <li>вероятность "чистого" повторного нажатия одним пальцем – 4.41%</li>
    <li>использование "домашней" группы – 61.62%</li>
  </ul>
</details>
<details>
  <summary>йцукен (ru)</summary>
  <ul>
    <li>чередование рук – 53.54%</li>
    <li>равномерность нагрузки рук – 53.23/46.63%</li>
    <li>максимальная разница нагрузки пальцев – 29.51%</li>
    <li>вероятность "чистого" повторного нажатия одним пальцем – 19.79%</li>
    <li>использование "домашней" группы – 33.97%</li>
  </ul>
  <sub>Интересный факт: две трети всех нажатий в йцукен приходятся на указательные пальцы. А подобная сгруппированность популярнейших символов в результате приводит к тому, что и каждое пятое нажатие будет выполняться одним и тем же пальцем. О каком "десятипальцевом наборе" в такой ситуации может идти речь?</sub>
</details>
<details>
  <summary>яверты (ru)</summary>
  (** учитывались только буквы основного буквенного блока)
  <ul>
    <li>чередование рук – 48.36%</li>
    <li>равномерность нагрузки рук – 50.41/46.84%</li>
    <li>максимальная разница нагрузки пальцев – 13.24%</li>
    <li>вероятность "чистого" повторного нажатия одним пальцем – 9.38%</li>
    <li>использование "домашней" группы – 61.62%</li>
  </ul>
</details>

> Больше раскладок, а также их внешний вид можете найти в .xlsx файле. Здесь перечислены лишь основные показатели наиболее важных к упоминанию раскладок.


#### Результат
Начнём с английских раскладок: <code>qwerty</code> откровенно плох, если не сказать грубее. Любая существующая раскладка (в том числе из неперечисленных) в разы и разы лучше. Если смотреть на обратный результат, то всё не так однозначно, но <code>dvorak</code>, по основным пунктам, всё-таки забирает первенство.
Полноценно сравнивать <code>dvorak</code> и <code>qPhyx</code> я не стану, так как это сравнение некорректно, о чём я обмолвился изначально. Но даже для общего представления вы можете отметить, что в целом цифры топик-стартера если уж не лучше, то как минимум на уровне лидера.


А теперь перейдём к русским раскладкам... Всё очень плохо. Для русского языка попросту отсутствуют вменяемые альтернативные раскладки. Те что есть, едва ли лучше стандартного <code>йцукен</code>, и это при том, что к <code>йцукен</code> вопросов ещё больше, чем к его собрату <code>qwerty</code>.

<br>

> ↓ NB!
<br>На этом этапе стоит забежать несколько наперёд и отметить, что английская раскладка, на деле является общей раскладкой латиницы, которая при помощи расширенной диакритики и языковых модов символьной раскладки позволяет писать практически на всех языках, в основе которых лежит латиница или кириллица.
<br>Таким образом, получается единая система для всех латинице- и кириллице-основанных языков. Под системой я подразумеваю всё, что вы сейчас и далее читаете – все концепты и всё из них вытекающее, будь то фонетическая преемственность или символьное единство... Стоит уже и последнем рассказать, не так ли?


## Символьный слой
> Одна из причин создания *"и ещё одной"* раскладки – несоответствие символов в различных языках и их ограниченное количество.

К символьному слою были выставлены следующие требования:
* единство символов для любой буквенной раскладки
* чёткое разграничение между буквенным и символьным слоями
* группировка символов по логическим категориям
* больше символов; добавление диакритических символов
* расположение с учётом "групп удобства" всё ещё более чем актуально
* всё это должно быть вписано в 60% ANSI-клавиатуру (объяснение ниже)
* наличие основных (а может быть и чуть больше) управляющих команд
* решение вопроса специфических языковых символов/букв, отличных от стандартной латиницы или русской кириллицы

![Объяснение, что есть 60% клавиатура](https://cdn.thewirecutter.com/wp-content/media/2021/05/20210527_mech-keyboard_layout.png "Объяснение, что есть 60% клавиатура")
<sub>Источник: [nytimes.com](https://www.nytimes.com/wirecutter/blog/how-to-shop-for-a-mechanical-keyboard/); Иллюстрация: Sarah Macreading, Dana Davis</sub>


Давайте познакомимся с результатом в три (2.5) этапа, благо, есть что рассказать на каждом из них.

### Облегчённый вариант
![Облегчённый символьный вариант](https://github.com/uqqu/layout/blob/master/external/readme_images/symbols_lite.png "Облегчённый символьный вариант")
> Перво-наперво – да, эта раскладка предполагает нестандартное использование компьютерной клавиатуры, а именно – `длинные` или `долгие нажатия`. Я не собираюсь доказывать, что это удобно – если вы убеждены в обратном, вы всё равно мне не поверите. Могу лишь сказать, что если вы переведёте эту функциональность в автоматизм (в процессе использования, конечно же), тогда вы со мной согласитесь. А этот процесс абсолютно не сложен. За сим всё, больше мы этот вопрос поднимать не будем.

Зелёным выделены основные символы, знакомые всем со стандартной `qwerty` раскладки. Серым выделены дополнительные символы, которыми я счёл нужным дополнить раскладку (пожалуй, это самая субъективная часть всего проекта). В углу, под извечным `Ъ` расположились акут и гравис, в первую очередь как маркёры основного и побочного ударений.

Как видно, все условия соблюдены:
* символы образуют собственный, независимый от какого бы то ни было языка слой
* символы сгруппированы по категориям (базовая математика, валюты, пунктуация, скобки с зеркальным отображением вокруг домашнего ряда)
* дополнительные символы из числа востребованных
* распределение с учётом "групп удобства"
* всё вмещено в 60% клавиатуру (даже чуть меньше, ведь цифровой ряд ещё впереди)
* присутствуют управляющие (навигационные) команды

### Полный вариант
![Полный символьный вариант](https://github.com/uqqu/layout/blob/master/external/readme_images/symbols_complete.png "Полный символьный вариант")

> Несомненно, это выглядит крайне странно и непривычно. Но уверяю, это именно оттого, что непривычно.

Давайте взглянем, что изменилось:

#### Цифровой ряд.
Базовые позиции не изменились. Я не разделяю мнения, что обычный порядок по возрастанию плох, и их нужно перемешивать. 
<br>Под бывшими `-` и `=` расположены кнопки пользовательского ввода, которые будучи пустыми выполняют функцию увеличения или уменьшения числа под курсором <sub>(используйте только в текстовых полях. Вне их поведение функции неконтроллируемо).</sub>. Если определены пользователем – отправляют символ или их комбинацию. Определение рекомендуется для добавления сверх-дополнительных символов (в частности для абхазского и фарерского языков).

#### Расширенная диакритика.
С её помощью раскладка может быть использована для всех языков, имеющих в своём алфавите или регулярно использующих диакритику. К слову, за исключением английского, диакритику в той или иной мере использует абсолютное большинство языков на латинице. В частности, из первых 15 крупнейших языков этой категории регулярная диакритика отсутствует только у непосредственно английского и индонезийского. За наглядными примерами обратитесь к [external/languages.xlsx](https://github.com/uqqu/layout/blob/master/external/languages.xlsx), лист `Latin alphabets`.

#### Управляющие клавиши изменены по позициям и переназначены.
  * `backspace` теперь используется для управления воспроизведением
  * `enter` выполняет функции `backspace` и `delete`
  * `caps lock` был заменён на `enter`
  * базовая `tilde` теперь `esc`
  * функция `caps lock` удалена (так и запланировано)
    * если сильно понадобится, вы можете определить функцию `caps lock` на `esc`, но в некоторых редких случаях вам может понадобиться "оригинальный" `esc` а не `tilde` как `esc`

Опять же – это выглядит довольно странно, но это сделано исключительно для повышения удобства.

#### Языковые символы
Под шифтом в цифровом ряду расположены специфичные символы для разных языков. В их числе как самостоятельные символы, так и вспомогательные, являющиеся стандартными символами с добавленной диакритикой, предназначенные для упрощённого ввода для определённых языков. В отображении выше показан вид с основными модификациями для латиницы и кириллицы. В зависимости от потребностей пользователя (регулярных или разовых) они могут быть изменены в одну из 30+ для латиницы и 5 для кириллицы модификаций. "Язык" модификации зависит от текущего языка раскладки. Рассмотрим модификации поподробнее:


### Модификации
Латинская и кириллическая стороны модификаций несколько разнятся концептуально, что обусловлено символьными особенностями участников этих категорий. Начнём с латинской:

12 доступных символов разбиты на две категории – самостоятельные символы и символы упрощённого набора.
Самостоятельные символы – `ł đ ı ß ø æ œ`, с небольшой оговоркой абзацем ниже, доступны из любых модификаций, что, следовательно, позволяет использовать языки, доступ к которым они открывают также из любых модификаций.
Символы упрощённого набора – это те самые символы, что будут меняться при выборе модификации, в зависимости от потребностей выбранного языка.

Здесь стоит отдельно рассмотреть три символа:
  * ñ – латинская n с диакритической тильдой. Принадлежит к вспомогательной категории, однако символ сам по себе, без прочих, открывает упрощённый набор для испанского языка и всех языков, на которые повлиял последний, которые, как мы знаем из истории, немалочисленны. Из-за этого он занял свободное место в модификациях, в которых набор вспомогательных символов закончился на четырёх.
  * ł – латинская l с диагональным штрихом. Ситуация зеркальная по отношению к предыдущему символу – символ, хоть и является буквой с диакритикой, является самостоятельным, т.к. не может быть корректно отображён в виде с комбинируемой диакритикой. Также он имеет достаточно ограниченное использование, и от него не зависят прочие символы. Из-за этого, в модификациях, требующих 6 дополнительных символов, последнее место было отдано от "ł". Но таких модификаций не так много, что не делает этот факт чересчур значимым.
  * đ – латинская d со штрихом. Здесь нас интересуют две конкретные модификации – старо-английский/исландский и язык мосси. Всё дело в том, что в данных модификациях используются собственные вариации данного символа, имеющие собственное название и применение. Во всех модификациях, помимо оговоренных выше, это `đ Đ`, для старо-английского это `ð Ð`, для мосси – `ɖ Ɖ`. Обратите внимание, что варианты в верхнем регистре, несмотря на единое начертание, являются разными юникод-символами.

Итак, теперь мы можем разбить все языки на такие категории:

#### Полностью поддерживаемые языки
Языки, которые для своего набора не требуют изменения модификации, при этом не имея никаких ограничений в наборе – английский, испанский, французский, немецкий, вьетнамский, ...

#### Диакритически поддерживаемые языки с опциональной модификацией для упрощения набора
Позвольте на примере – турецкий: язык может быть использован с любой модификацией (к примеру, с основной `ñ å ä ö ü`, при наборе дополнительных символов в два нажатия через диакритические символы, но при выбранной турецкой модификации (`ç ş ğ ö ü`) эти же символы становятся доступны через одинарное нажатие, не теряя общей функциональности.

#### Диакритически поддерживаемые языки (без/с частичной) опциональной модификацей для упрощения набора
Языки с крайне богатой диакритикой, такие как польский, чешский или словацкий, попросту не помещаются для упрощённого набора, однако полноценно доступны через диакритику с любой модификацией.

#### Модификационно поддерживаемые языки
Языки, полноценный набор на которых возможен только на специальных модификациях. Ещё раз отмечу, что специальные модификации сохраняют все возможности набора на языках предыдущих категорий.
<sub>Согласно <a href="https://w3techs.com/technologies/overview/content_language">w3techs.com</a> в этой категории нет языков с долей использования в интернете более 0.05%</sub>

#### Неподдерживаемые языки
Языки с основной письменностью отличной от латиницы и кириллицы. Для всех из них поддерживаются все варианты романизации (в том числе, из разряда недоступных на стандартной ISO basic latin).

После такого распределения получается 24 5-символьных модификации (7 из которых содержат ñ), 7 6-символьных модификаций, и 5 кириллических, о которых ниже.
Общий охват первой и второй групп, с учётом кириллических, составил 88.86% интернета.

> Более наглядно и детально всё это отражено в файле [external/languages.xlsx](https://github.com/uqqu/layout/blob/master/external/languages.xlsx). А также сравнение алфавитов, 200+ основных мировых языков, 150+ нигеро-конголезских языков.

А теперь про кириллическую группу:

Так как здесь отсутствуют единые "над-символы", использование которых может быть востребовано из любой модификации, а также учитывая, что все символы являются отдельными, в виду того факта, что комбинируемая диакритика крайне печально работает с кириллицей, все 12 мест являются динамическими. Это позволило объединить в группах целые ряды языков, итоговое количество которых – 4 группы + 1 отдельный язык (абхазский, и ему даже не хватило одного места). Также это влияет на то, что здесь нет "основной" модификации, хотя, фактически, из-за располажения по востребованности, её место занимает группа "украинский, белорусский, ...". Но так или иначе, в кириллической раскладке, в отличии от латинской, вас не будут интересовать прочие модификации, вы лишь единожды выбираете ту, использование которой вам может пригодиться. Поэтому все данные языки были приравнены ко второй категории поддержки языков, хотя они относятся в равной мере как к первой, так и к четвёртой категориям.


## Реализация

Опуская множество попыток при помощи различных средств из разных категорий: буквенный слой был реализован средством генерации нативных клавиатурных раскладок – [Microsoft Keyboard Layout Creator](https://www.microsoft.com/en-us/download/details.aspx?id=102134), символьный слой реализован через [AHK](https://www.autohotkey.com/).

Сгенерированные `MKLC` раскладки для `Windows` – [external/MKLC_qphy_lat/](https://github.com/uqqu/layout/tree/master/external/MKLC_qphy_lat), [external/MKLC_qphy/cyr/](https://github.com/uqqu/layout/tree/master/external/MKLC_qphy_cyr)

AHK сценарий более содержателен. Но основная его функциональность заключается в добавлении символьных слоёв с "длинными" нажатиями. Базово длительность последних – 0.15с. Вы можете изменить её в файле `config.ini` (будет сгенерирован после первого запуска) или в соответствующем пункте в [menu](https://github.com/uqqu/menu). На первое время вы захотите увеличить время реакции вплоть до 0.2. Привыкая к этой функциональности время срабатывания будет уменьшаться вами вплоть до 0.1 (кмк, 0.12 оптимально).


## Дополнительная функциональность

* Вставка с сохранением выделенного в буфер обмена (или просто clipboard swap) – `Ctrl-Shift-g` (`v` в qwerty-виде);
* Активация/свёртка предустановленных приложений – `Win-[любая клавиша]` – определите свои любимые приложения в `config.ini` в секции `AltApps` и переключайтесь между ними. Если процесс ещё не запущен – запускает его. Этот путь быстрее, проще и более гибкий нежели стандартный `Win-[1-9]`. Шаблон для добавления в `.ini`:
```
{сканкод}={имя_процесса},{путь_к_файлу}
```
Пример – установим `nvim` на `Win–q`:
```
SC010=nvim-qt.exe,C:\Shortcuts\nvim-qt.exe.lnk
```
* Полная замена стрелок с `alt-[мстр]` (с `shift/ctrl/shift-ctrl`. `alt-(sh)-ctrl-[ст]` используются для перемещения в начало и конец линии соответственно)
* Перемещение окон с помощью `Win-(shift)-[мстр]` (`[ролд]` в йцукен-виде) так же, как и при помощи `стрелок`
* Инкрементация/декрементация (увеличение/уменьшение числа на 1) клавишами пользовательского определения (если не назначено другое значение). Используйте исключительно в текстовых полях!
* Исправление dotted/dotless i – включается в `config.ini` (или через соответствующий пункт в `menu`). Заменяет iI, в домашней позиции на iİ, а ıİ под 8 на ıI. В первую очередь для турецкого, азербайджанского языков и казахской латиницы
* Исправление `седиль` в `кому` для румынского языка, для исправления распространённого ложного написания. Включено по умолчанию. Работает только для румынской модификации. Делает использование седили невозможным. Может быть отключено в `config.ini`
* Если же вы столкнулись со случааем, в котором вам нужно "стандартное" поведение клавиш – вы можете на лету приостановить работу скрипта сочетанием `Shift-tilde`
* Перезапуск скрипта – `Ctrl-Shift-tilde`
* Вся остальная функциональность, в том числе, упрощённая настойка `qphyx` `config.ini` находится на клавише `\|` (для ansi клавиатур), но работает с помощью [menu](https://github.com/uqqu/menu).


## Установка

### Windows

1. Запустите установочные файлы в папках [external/MKLC_qphy_lat](https://github.com/uqqu/layout/blob/master/external/MKLC_qphy_lat) и [external/MKLC_qphy_cyr](https://github.com/uqqu/layout/blob/master/external/MKLC_qphy_cyr).
2. Выберите установившиеся раскладки как языки ввода в настройках вашей ОС.
3 (опционально) Установите <a href="https://www.autohotkey.com/">AHK</a>, если предпочитаете использовать нескомпилированную версию.
4. Разместите [modes.ini](https://github.com/uqqu/layout/blob/master/modes.ini) и [qphyx.exe](https://github.com/uqqu/layout/blob/master/qphyx.exe) или его нескомпилированный аналог – [qphyx.ahk](https://github.com/uqqu/layout/blob/master/qphyx.ahk) в папке по вашему выбору.
4. Запустите `qphyx.*` для генерации файла `config.ini`
5. (опционально) Если используете или собираетесь использовать смежный проект [menu](https://github.com/uqqu/menu):
5.1 В `config.ini` рядом с `qphyx.*` укажите путь к папке menu.
5.2 В `config.ini` рядом с `menu.*`, после первого запуска, укажите путь к папке `qphyx`.
5.3 Перезапустите `qphyx.*`. Если пути указаны верно, `qphyx` сам перезапустит `menu`, а тот, в свою очередь, после перезапуска обзаведётся пунктом `Qphyx settings` в `message menu`.
6. Ознакомьтесь с использованием и функционалом.
7. (опционально) Добавьте `qphyx.*` в автозагрузку (не добавляйте `menu`, если используете. `qphyx` сам вызывает его, если путь из пункта 5.1 указан верно)

### Android

1. Установите <a href="https://play.google.com/store/apps/details?id=kl.ime.oh&hl=en">Multiling O Keyboard</a>.
2. Выберите DIY layout для английского языка.
3. Вставьте содержимое файла [multiling_o_keyboard_lat.txt](https://github.com/uqqu/layout/blob/master/external/android/multiling_o_keyboard_lat.txt).
4. Выберите DIY layout для русского языка.
5. Вставьте содержимое файла [multiling_o_keyboard_cyr.txt](https://github.com/uqqu/layout/blob/master/external/android/multiling_o_keyboard_cyr.txt).
6. Настройте внешний вид в настройках на свой вкус.


## ЧАВО
<dl>
  <dt>Нужно ли устанавливать <a href="https://www.autohotkey.com/">AutoHotKey</a>?</dt>
  <dd>Только для использования <code>.ahk</code> версии. Использование скомпилированной идентичной <code>.exe</code> версии не требует никаких дополнительных установок.</dd>
  <dt>А что насчёт раскладки для эргономических клавиатур?</dt>
  <dd>Этот проект направлен на стандартные не эргономические клавиатуры. Пененос этой раскладки на любую другую клавиатуру это отдельный процесс. Я буду рад когда-нибудь сделать это, но на текущий момент нет версий для любых клавиатур отличных от стандартной.</dd>
  <dt>Возможно ли использовать это на Linux?</dt>
  <dd>Нет. Насколько я интересовался вопросом – там есть только сложные пути реализации отлова длинных нажатий, и за эти варианты я сейчас взяться не готов. Конечно, можно назначить любую клавишу как модификатор, и перенести весь слой длинных нажатий под этот модификатор. Но это уже будет не совсем то, что я делал. Или совсем не то.</dd>
  <dt>Могу я использовать это на Mac?</dt>
  <dd>Нет, текущая версия используется только на Windows. Честно говоря, я пока даже не интересовался вопросом реализации этой раскладки на Mac.</dd>
  <dt>Может хоть на Android?</dt>
  <dd>Да! Правда, не для монополиста <code>G.Board</code>, но есть приложение с полнейшей кастомизацией – <a href="https://play.google.com/store/apps/details?id=kl.ime.oh&hl=en">Multiling O Keyboard</a>. Шаблоны раскладок для этого приложения и скриншоты можно найти тут: <a href="https://github.com/uqqu/layout/tree/master/external/android">external/android/</a>.</dd>
  <dt>В латинской раскладке присутствуют пустые клавиши?</dt>
  <dd>Да. В виду разделения буквенного и символьных слоёв, клавиши с потенциально-буквенным назначением могут быть использованы только для букв. Но в том, что они пустые нет никакой проблемы – количество символов от этого уж явно не пострадало, а буквы расположены на самых удобных позициях, не теснясь с конкурентами на место.</dd>
  <dt>...но они не совсем пустые?</dt>
  <dd>Да, технически, <code>ч</code>, <code>с</code> и <code>и</code> клавиши (в йцукен-виде) отправляют <code>U+001E</code>, который не отображается на печати, но может быть использован сторонними программами, для дополнительных назначений, к примеру. Я не сталкивался со случаями, где это решение давало бы сбои, но если (когда) такие найдутся, это всегда можно убрать. Пока пользы больше.</dd>
  <dt>Могу я использовать символьную раскладку с <code>йцукен</code>?</dt>
  <dd>Вы-то, конечно, можете, но это будет не так удобно, как это планировалось (планировалось не использовать <code>йцукен</code>).</dd>
  <dt>Могу я использовать буквенную раскладку без символьной?</dt>
  <dd>А вот тут, к сожалению, нет. Вам объективно не будет хватать базовых символов.</dd>
  <dt>И всё-таки, на каких конкретно языках можно писать?</dt>
  <dd>Если вы уже ознакомились с частью про модификации в символьной части, загляните в [external/languages.xlsx](https://github.com/uqqu/layout/blob/master/external/languages.xlsx). Там есть ответ на ваш вопрос для <b>200+</b> языков.</dd>
  <dt>Связан ли как-то этот проект и метод слепого набора?</dt>
  <dd>Конечно! Одна из целей как раз в максимизации удобства слепого набора и минимизации лишних движений (в особенности – движений отрывающих руки с их домашних позиций).</dd>
  <dt>Нужно ли мне сначала потренироваться в слепом наборе, прежде чем знакомиться с этим проектом?</dt>
  <dd>Если вы уже об этом задумались – однозначно стоит, и вне зависимости от того, собираетесь ли вы потом знакомиться с данным проектом. А если всё-таки собираетесь, то даже лучше сначала ознакомиться с проектом, а уже пользуясь выбранной раскладкой тренироваться в слепом наборе. Следующий вопрос ответит, почему так.</dd>
  <dt>Я грандмастер набора текста на <code>colemak</code>/<code>dvorak</code>/<code>workman</code>/др, есть ли смысл переходить на эту раскладку?</dt>
  <dd>На ваше усмотрение, конечно. Вы получите меньше преимуществ в пункте буквенной раскладки, но все остальные никуде не делись. Однако если вы захотите перейти, учтите, что процесс перехода на любую новую раскладку длителен и дискомфортен. И чем лучше вы владели предыдущей раскладкой, тем больнее будет переход на новую. Первое время вы будете очень медленными и неуклюжими, и это будет бесить. Также потом могут иногда проявляться фантомные нажатия, когда в процессе потокового набора палец на один символ идёт по старому автоматизму. Тоже довольно бесячая вещь. Я ни в коем случае не отговариваю вас, просто вы должны быть заранее готовы ко всему описанному.</dd>
  <dt>...а я грандмастер набора текста на <code>qwerty</code>! Есть ли мн...</dt>
  <dd>*перебивает* Прямо сейчас возьмите любую стороннюю раскладку. Мне будет приятно, если выбор остановится на раскладке, которой посвящён весь данный текст, но даже если нет – существует множество других раскладок для латиницы, и некоторые из них очень даже хороши. Но не для русского. Там всё плохо. Так или иначе, постарайтесь отказаться от <code>qwerty</code> и <code>йцукен</code>. Это крайне важные раскладки для истории набора текста, но оставьте их использование музейным работникам.</dd>
  <dt>Я не могу использовать <code>стрелки</code> и <code>цифровой блок</code>!</dt>
  <dd>Так и задумано. Если вы хотите попробовать эту раскладку, как она и планировалась, вам нужно привыкнуть к тому, чтобы поменьше отрывать руки от домашних позиций.</dd>
  <dt>Я не могу кричать капсом!</dt>
  <dd>Восхитительно. Так и задумано.</dd>
  <dt>... но мне нужен <code>Caps Lock</code> для моего ЯП или для чего-то ещё!</dt>
  <dd>Эта раскладка для общего пользования. А для общего пользования функция <code>Caps Lock</code> вредна... Ладно, если что, вы можете установить в <code>config.ini</code> параметр <code>EscAsCaps</code> в 1, и переключать состояние <code>Caps Lock</code> через <code>Esc</code>. Даже дополнительные буквенные символы из цифрового ряда будут инвертированы. Только пожалуйста, не злоупотребляйте этим.</dd>
  <dt>Этот проект родственен с <a href="https://github.com/uqqu/menu">menu</a>?</dt>
  <dd>Да, когда-то это был единый проект, но с постоянным добавлением нового функционала было принято решение о его разделении на два проекта. Но и сейчас они тесно связаны друг с другом. К примеру, вы можете выставлять время срабатывания длинного нажатия через <code>input-box</code> вызываемый <code>menu</code>, и управлять прочими пунктами настроек, а <code>qphyx</code> сам вызывает <code>menu</code> в подходящий момент, дабы избежать конфликта назначений. Для связи между ними нужно лишь в <code>config.ini</code> обоих проектов указать путь к родственнику.</dd>
  <dt>Ещё какие-нибудь интеграции?</dt>
  <dd>Просто вызов в нужное время, для исключения конфликтов – <a href="https://github.com/magicstep/ViATc-English">ViATc</a>. Если вы пользуетесь этим проектом, просто укажите путь к основному файлу <code>ViATc-x.x.xen.ahk</code> в <code>config.ini</code>, только и всего.</dd>
  <dt>Проблемы с <code>config.ini</code></dt>
  <dd>Не создавайте его сами, дайте ему сгенерироваться при запуске, и лишь потом правьте. Для функциональности с переключением между приложениями в секции <code>[AltApps]</code> на отдельных строках, располагайте ваши приложения по соответствующему образцу.</dd>
</dl>


### Дальнейшие планы

 * Переложение на другие письменности
 * Собственный анализ частотности для русского (обязательно) и английского (возможно)
 * Частотность других языков (в порядке используемости)
 * Географическая SVG-карта с покрытием языков
 
 * ?Диакритическе хуки в юникоде
 * ?Диакритика с кириллицей
 * ?з́ и с́ отдельными символами в юникоде


## Copyrights

Icon was downloaded for free from [icons8.com](https://icons8.com/icon/l0UsZRTvcGel/laptop-coding)


## License
[MIT](https://choosealicense.com/licenses/mit/)
