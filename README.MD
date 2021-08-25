# qPhyx
## ↓ English part

> Remark: my English is really far from perfect. If you are able to read Russian, you should look at the [appropriate section](#-russian-part)

**qPhyx** began as an alternate phonetic bilingual/biscripted keyboard layout. In the aftermath many features went beyond the usual layout and now it became something more. It can be logically divided into three parts:
1. Default letter layout
2. Uncommon symbol layout with some features
3. Arisen in the process add-on with many features

The first two depend on each other and are in this repository. Third can be used as such and moved to [a separate repository](https://github.com/da3/menu), but planned and once was as a part of one-piece project.

This project can't be described briefly. It must either be tried or described in detail. Even better, both of them.

## Letter layout

> For a better understanding of this part it is recommended to have a look at the [external/calculating.xlsx](https://github.com/da3/layout/blob/master/external/calculation.xlsx)

Now it looks like this (*hereinafter in "excel-scheme" view*):
![English letter layout](https://github.com/da3/layout/blob/master/external/readme_images/letters_en.png "English letter layout")
... for English, and like this:
![Russian letter layout](https://github.com/da3/layout/blob/master/external/readme_images/letters_ru.png "Russian letter layout")
... for Russian language.

Тhe arrangement of the letters was as objective as possible:
* First, various frequency analyses were found on the Internet and stored with their average value *(so this is a meta-analysis?)*

  For English – [simia.net](http://simia.net/letters/index.html), [sttmedia.com](https://www.sttmedia.com/characterfrequency-english), [algoritmy.net](http://en.algoritmy.net/article/40379/Letter-frequency-English), [cornell.edu](http://pi.math.cornell.edu/~mec/2003-2004/cryptography/subs/frequencies.html), [lexico.com](https://www.lexico.com/explore/which-letters-are-used-most), wiki
  
  For Russian – [simia.net](http://simia.net/letters/index.html), [sttmedia.com](https://www.sttmedia.com/characterfrequency-russian), [ruslang.ru](http://dict.ruslang.ru/freq.php?act=show&dic=freq_letters)

* In addition to the previous were collected frequency analyses of letter pairs – bigrams (English – [uic.edu](http://homepages.math.uic.edu/~leon/mcs425-s08/handouts/char_freq2.pdf), Russian – [statistica.ru](http://statistica.ru/local-portals/data-mining/analiz-tekstov/))
* Letter-part of default non-ergonomic keyboard were categorized into 6*(7)* groups by convenience:
![Groups of keys by convenience](https://github.com/da3/layout/blob/master/external/readme_images/groups.png "Groups of keys by convenience")
* Were summarized objective criteria for evaluating layout convenience: 
  * hand alteration
  * uniform hands load
  * uniform fingers load
  * maximum usage on the most convenience groups from the previous point
  * minimum chance for double sequentially usage of the same finger (bearing in mind 3.22% for English and 1.76% for Russian base key repeating).
* Based on past points all letters were placed in their positions for English and Russian. 
* Russian layout was moved to phonetic-view with English layout, and English layout was adapted for better summarized result with great performance for both.

## Symbol layout
> One of the reason of making *"one more"* layout – symbol mismatch in different languages and their limited number.

The following requirements were imposed on the symbol layout:
* Symbols unity on the any language;
* A clear delineation between symbol and letter layouts (or now more correctly – *layers*);
* Group symbols in the logical categories;
* Мore symbols, add diacritic;
* It is necessary to keep in mind the convenience groups for symbols too;
* All of this should fit in the 60% ANSI-keyboard (see below for example);
* It should contain main (and maybe some more) controlling commands.

![60% keyboard explanation](https://cdn.thewirecutter.com/wp-content/media/2021/05/20210527_mech-keyboard_layout.png "60% keyboard explanation")
Source: [nytimes.com](https://www.nytimes.com/wirecutter/blog/how-to-shop-for-a-mechanical-keyboard/); Illustration: Sarah Macreading, Dana Davis


With all these requirements the result were two variants: more classical and "complete".

### Lite variant
![Lite symbol layout](https://github.com/da3/layout/blob/master/external/readme_images/symbols_lite.png "Lite symbol layout")
> First of all – yes this layout suggests to non-standard keyboard usage as `long presses`. I am not going to prove to you that it is a comfortably – if you are convinced otherwise you still won't believe me. But I'm sure if you use this functionality enough to use it automatically, then you will agree with me. We won't mention this subject any more.

In green are highlighted main symbols, which there are also in the qwerty-layout; in gray are highlighted additional symbols, which I thought I should add (this is probably the most subjective part). In the corner placed two diacritic symbols for accents.

As you can see, all of the conditions above are met:
* Symbols are the separate layers and these layers is independent of any language;
* Symbols are grouped (base math, currencies, punctuation, brackets with mirror reflection around the home row); 
* Additional symbols with often usage cases; 
* Most usage symbols/groups placed on the most convenience groups; 
* All these within 60% keyboard (even less so far);
* There are controlling (navigation) commands.

### Complete variant
![Complete symbol layout](https://github.com/da3/layout/blob/master/external/readme_images/symbols_complete.png "Complete symbol layout")

> It may look very strange and very unfamiliar, but I assure – it's only because it's unfamiliar.

Let's see what are changed: 
* Num row. Base numbers are not changed. I don't think that ascending order for them is a bad thing. Alternate layers for nums contains not the best possible variants, but it is logical and, in general, num-layers is the less convenience, and they get the least attention
* Extended diacritic allows you to write in French, Spanish, Portuguese, Italian, German (with eszett at the same row), Turkish, Esperanto and many more languages as well
* Controlling keys are swapped and reassigned: 
  * `backspace` now used for music control;
  * `enter` performs the functions of `backspace` and `delete`;
  * `caps lock` was be replaced by `enter`; 
  * base `tilde` as `esc`;
  * `caps lock` function thrown out (it was meant to be);
    * if you want, you can map `caps lock` function on `esc`, but for some cases you still may use `esc` instead of `tilde` as `esc`

And again – it may look very strange, but these remapping were all done only to increase convenience.

## Implementation

Omitting a bunch of different attempts: letter layer has been implemented by the native keyboard layout generation tool – [Microsoft Keyboard Layout Creator](https://www.microsoft.com/en-us/download/details.aspx?id=102134), symbol layer was realized with [AHK](https://www.autohotkey.com/).

Generated `MKLC` layouts for your `Windows` – [external/qphyx_en/](https://github.com/da3/layout/tree/master/external/MKLC_qphyx_en), [external/qphyx_ru/](https://github.com/da3/layout/tree/master/external/MKLC_qphyx_ru)

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
* Move windows with `Win-(shift)-mstr` (`hjkl` in qwerty-view) as well as with `arrows`
* Don't forget about `non-breaking space` with `Shift-space`
* If you collide with case, which require some "standard" key behavior – you can toggle script work on air with `Shift-tilde`
* And many more features available on `\|` key (ansi-keyboards) with [menu](https://github.com/da3/menu) addon!

## FAQ

Q: What about layout for ergonomic keyboards?

A: This project is aimed at standard non-ergonomic keyboards. Porting this layout to any other keyboard it is a special process. I think very highly of ergonomic keyboards and I will be glad realize version for one of them someday, but now there are no any version for keyboards different of standard.

Q: Can I use it on Linux?

A: No. As I know, there are only hard ways to realize "long presses" on Linux, and I'm not ready to take on them now. It is possible to implement a version with additional modifier instead of "long" trigger, but it will no longer be the original project.

Q: Can I use it on Mac?

A: No, current version can be used only on Windows. I weren't interested in ways to realize it on Mac.

Q: Can I use it on Android?

A: Yes, partially. It cannot be done for `G.Board`, but there is an app with totally customization – [Multiling O Keyboard](https://play.google.com/store/apps/details?id=kl.ime.oh&hl=en). You can find layout pattern for this app with screenshot examples at the [external/android/](https://github.com/da3/layout/tree/master/external/android).

Q: English layout has empty keys?

A: Yes. With the separating letter and symbol layers, keys with the potential-letter functions may be used only for letters. There is no problem with that, it's even more comfortably because now letters allocated to more convenient positions.

Q: ...and yet they are not completely empty?

A: Yes, technically, `x`, `c` and `b` keys (in qwerty-view) send U+001E "Record Separator", which does not appear in the printout, but can be used by third-party programs. I have not yet encountered a case where this would be bad, but potentially, if there are any, it can be removed.

Q: Can I use symbol layout with `qwerty`?

A: You can, but it won't be as comfortable as it planned.

Q: Can I use letter layout without symbols?

A: Unfortunately no. You will be missing base symbols, which were placed on "potential-letter" keys.

Q: Has this project something to do with blind typing?

A: Of course! The main goal in maximizing convenience with blind typing and minimizing unnecessary moves (especially, moves that make you have to take your hands off your "home" positions)

Q: Should I first train with blind typing before use this layout?

A: If you are asking yourself this question – you should, regardless of future using this layout. And if you are not experienced in blind typing – maybe it is even better! Pay close attention to the following question for more details.

Q: I am grandmaster of qwerty/dvorak/workman/etc, will I get any profit from switching to this layout?

A: Yes, but the process of switching to any new layout is very long and discomfortable. And the better you mastered the old layout, the more unpleasant the switching to the new one will be. The first time you will be slow and clumsy, and it will be really annoying. Also later you will sometimes have "phantom" typing, when one letter of the entire stream suddenly will typed from old layout. Pretty infuriating thing. Switching, especially from `qwerty`, worth it, but you have to be ready for it.

Q: I can't use arrows/numpad!

A: That's the way it's supposed to be. If you want to try this layout, you should be used to keep your hands on "home" positions.

Q: I can't "scream" with `Caps Lock`!

A: That's great. That's the way it's supposed to be.

Q: ... but I need `Caps Lock` function for my PL or some other case!

A: This layout is for general use. In general cases this function is harmful. For special cases you always can add mapping for `Caps Lock` and comment `SetCapsLockState` on `qphyx.ahk`. But, please, don't overuse it.

Q: This project is relative to [menu](https://github.com/da3/menu)?

A: Yes, once they were an one-piece project, but while the functionality was becoming more and more they were separated in two projects. But they have connections with each other (e.g. you can regulate "long press" delay with `menu` and some more). For connection between them you should correct path to relative in`config.ini` for both.

Q: Some other integrations?

A: Just start at the right time – [ViATc](https://github.com/magicstep/ViATc-English). If you use it – correct path to `ViATc-x.x.xen.ahk` in the `config.ini`. That's all.

Q: Troubles with `config.ini`

A: Don't create it yourself, let it be generated at startup, and only then edit it. For functionality with switching between applications, add a line `[AltApps]` at the end of the settings file, and afterwards, on separate lines, arrange your applications according to the appropriate pattern.

## ↓ Russian part

**qPhyx** начинался как альтернативная фонетическая двуязычная клавиатурная раскладка. Впоследствии многие функции вышли за рамки обычной раскладки, и проект стал чем-то большим. Его можно логично разделить на три части:
1. Клавиатурная раскладка стандартного вида
2. Символьная раскладка с некоторыми особенностями и функциями
3. Возникшее в процессе дополнение, включающее в себя некоторый набор функций

Первые две части связаны друг с другом, и находятся в этом репозитории. Третья часть, хоть и планировалась как часть цельного проекта, и долгое время ею была, сейчас вынесена в [отдельный репозиторий](https://github.com/da3/menu). 

Проект довольно сложно описать одновременно и кратко, и ясно. Его нужно хронологически описать по частям или просто попробовать. Лучше и то и другое.

## Буквенная раскладка

> Для лучшего понимания этой части рекомендуется обратиться к [external/calculating.xlsx](https://github.com/da3/layout/blob/master/external/calculation.xlsx)

Сейчас это выглядит так (*здесь и далее в виде "excel-схем"*):
![English letter layout image](https://github.com/da3/layout/blob/master/external/readme_images/letters_en.png "English letter layout")
... для английского, и вот так:
![Russian letter layout image](https://github.com/da3/layout/blob/master/external/readme_images/letters_ru.png "Russian letter layout")
... для русского языка.

Расположение букв на раскладке было максимально, насколько это возможно, лишено субъективщины. Объективные критерии, голые цифры.
* Первым делом на просторах интернета были отобраны различные анализы частотности букв для интересующих языков из которых были выведены средние значения *(получается, мета-анализ)*

  Для английского – [simia.net](http://simia.net/letters/index.html), [sttmedia.com](https://www.sttmedia.com/characterfrequency-english), [algoritmy.net](http://en.algoritmy.net/article/40379/Letter-frequency-English), [cornell.edu](http://pi.math.cornell.edu/~mec/2003-2004/cryptography/subs/frequencies.html), [lexico.com](https://www.lexico.com/explore/which-letters-are-used-most), wiki
  
  Для русского – [simia.net](http://simia.net/letters/index.html), [sttmedia.com](https://www.sttmedia.com/characterfrequency-russian), [ruslang.ru](http://dict.ruslang.ru/freq.php?act=show&dic=freq_letters)

* В дополнение к предыдущему были найдены таблицы частотности конкретных сочетаний двух букв – биграмм (английский – [uic.edu](http://homepages.math.uic.edu/~leon/mcs425-s08/handouts/char_freq2.pdf), русский – [statistica.ru](http://statistica.ru/local-portals/data-mining/analiz-tekstov/))
* Буквенная часть стандартной не эргономичной клавиатуры была разделена на 6*(7)* групп по удобству:
![Группы клавиш по удобству](https://github.com/da3/layout/blob/master/external/readme_images/groups.png "Группы клавиш по удобству")
* Были отобраны объективные критерии оценки удобства раскладки: 
  * чередование рук
  * равномерная нагрузка рук
  * равномерная нагрузка пальцев
  * максимальное использование наиболее удобных групп из прошлого пункта
  * минимизация вероятности использования одного пальца на два набора подряд (с учётом базовой вероятности повтора одной буквы в 3.22% для английского, и 1.76% для русского).
* На основе прошлых пунктов все буквы были распределены на свои позиции для обоих языков.
* Позже русская раскладка была экспериментально опробована в виде фонетического переложения с английской. Эксперимент оказался весьма удачным, а в английскую версию были внесены финальные коррективы, с оглядкой на фонетическую зависимость.

## Символьная раскладка
> Одна из причин создания *"и ещё одной"* раскладки – несоответствие символов в различных языках и их ограниченное количество.

К символьной раскладке были выставлены следующие требования:
* Единство символов для любого языка;
* Чёткое разграничение между буквенной и символьной раскладками (или, теперь более корректно, – *слоями*);
* Группировка символов по логическим категориям;
* Больше символов; добавление диакритических символов;
* Расположение с учётом "групп удобства" всё ещё более чем актуально;
* Всё это должно быть вписано в 60% ANSI-клавиатуру (объяснение ниже);
* Наличие основных (а может быть и чуть больше) управляющих команд.

![Объяснение, что есть 60% клавиатура](https://cdn.thewirecutter.com/wp-content/media/2021/05/20210527_mech-keyboard_layout.png "Объяснение, что есть 60% клавиатура")
Источник: [nytimes.com](https://www.nytimes.com/wirecutter/blog/how-to-shop-for-a-mechanical-keyboard/); Illustration: Sarah Macreading, Dana Davis


В результате, со всеми требованиями, получилось две версии раскладки: более стандартная и полная (соответственно – менее стандартная).

### Облегчённый вариант
![Облегчённый символьный вариант](https://github.com/da3/layout/blob/master/external/readme_images/symbols_lite.png "Облегчённый символьный вариант")
> Перво-наперво – да, эта раскладка предполагает нестандартное использование компьютерной клавиатуры, а именно – `длинные` или `долгие нажатия`. Я не собираюсь доказывать, что это удобно – если вы убеждены в обратном, вы всё равно мне не поверите. Могу лишь сказать, что если вы переведёте эту функциональность в автоматизм (в процессе использования, конечно же), тогда вы со мной согласитесь. А этот процесс абсолютно не сложен. За сим всё, больше мы этот вопрос поднимать не будем.

Зелёным выделены основные символы, перекочевавшие со стандартной qwerty раскладки. Серым выделены дополнительные символы, которыми я счёл нужным дополнить раскладку (пожалуй, это самая субъективная часть всего проекта). В углу, под извечным `Ъ` расположились акут и гравис, в первую очередь как маркёры основного и побочного ударений.

Как видно, все условия соблюдены:
* Символы образуют собственный, независимый от какого бы то ни было языка слой;
* Символы сгруппированы по категориям (базовая математика, валюты, пунктуация, скобки с зеркальным отображением вокруг домашнего ряда);
* Дополнительные символы из числа востребованных;
* Распределение с учётом "групп удобства";
* Всё вмещено в 60% клавиатуру (даже чуть меньше, ведь цифровой ряд ещё впереди);
* Присутствуют управляющие (навигационные) команды.

### Полный вариант
![Полный символьный вариант](https://github.com/da3/layout/blob/master/external/readme_images/symbols_complete.png "Полный символьный вариант")

> Несомненно, это выглядит крайне странно и непривычно. Но уверяю, это именно оттого, что непривычно.

Давайте взглянем, что изменилось:
* Показался цифровой ряд. Базовые позиции не изменились. Я не разделяю мнения, что обычный порядок по возрастанию плох, и их нужно перемешивать. Альтернативные слои содержат не самые востребованные из всех возможных символы, но выполняют, в первую очередь, логическую роль. Да и в целом, будем откровенны – из всех символов, альтернативные слои для цифрового ряда наименее удобные, и распределять символы на них наравне с остальными рядами было бы неправильно.
* Расширенная диакритика – с её помощью раскладка может быть использована для французского, испанского, португальского, итальянского, немецкого (с эсцетом в том же цифровом ряду), турецкого, эсперанто и многих других языков.
* Управляющие клавиши изменены по позициым и переназначены:
  * `backspace` теперь используется для управления воспроизведением;
  * `enter` выполняет функции `backspace` и `delete`;
  * `caps lock` был заменён на `enter`; 
  * базовая `tilde` теперь `esc`;
  * функция `caps lock` удалена (так и запланировано);
    * если сильно надо, вы можете определить функцию `caps lock` на `esc`, но в некоторых редких случаях вам может понадобиться "оригинальный" `esc` а не `tilde` как `esc`

И ещё раз – это выглядит очень странно, но это сделано исключительно для повышения удобства.


## Реализация

Опуская множество попыток при помощи множества различных средств из разных категорий: буквенный слой был реализован средством генерации нативных клавиатурных раскладок – [Microsoft Keyboard Layout Creator](https://www.microsoft.com/en-us/download/details.aspx?id=102134), символьный слой реализован через [AHK](https://www.autohotkey.com/).

Сгенерированные `MKLC` раскладки для `Windows` – [external/qphyx_en/](https://github.com/da3/layout/tree/master/external/MKLC_qphyx_en), [external/qphyx_ru/](https://github.com/da3/layout/tree/master/external/MKLC_qphyx_ru)


AHK сценарий более содержателен. Но основная его функциональность заключается в добавлении символьных слоёв с "длинными" нажатиями. Базово длительность последних – 0.15с. Вы можете изменить её в файле `config.ini` (будет сгенерирован после первого запуска). На первое время вы захотите увеличить время реакции вплоть до 0.2. Привыкая к этой функциональности время срабатывания будет уменьшаться вами вплоть до 0.1 (кмк, 0.12 оптимально).

## Дополнительная функциональность

* Вставка с сохранением выделенного в буфер обмена (или просто clipboard swap) – `Ctrl-Shift-g` (`g` в qwerty-виде);
* Активация/свёртка предустановленных приложений – `Win-[любая клавиша]` – определите свои любимые приложения в `config.ini` (необходимо создать секцию `AltApps`) и переключайтесь между ними. Если процесс ещё не запущен – запускает его. Этот путь быстрее, проще и более гибкий нежели стандартный `Win-[1-9]`. Шаблон для добавления в `.ini`:
```
{числовая_часть_сканкода}={имя_процесса},{путь_к_файлу}
```
Пример – установим `nvim` на `Win–q`:
```
010=nvim-qt.exe,C:\Shortcuts\nvim-qt.exe.lnk
```
* Перемещение окон с помощью `Win-(shift)-мстр` (`ролд` в йцукен-виде) так же, как и при помощи `стрелок`
* Не забудьте о `неразрывном пробеле` через `Shift-пробел`
* Если же вы столкнулись со случааем, в котором вам нужно "стандартное" поведение клавиш – вы можете на лету приостановить работу скрипта сочетанием `Shift-tilde`
* А вся остальная функциональность находится на клавише `\|` (для ansi клавиатур), но работает с помощью [menu](https://github.com/da3/menu).

## ЧАВО

В: А что насчёт раскладки для эргономических клавиатур?

О: Этот проект направлен на стандартные не эргономические клавиатуры. Пененос этой раскладки на любую другую клавиатуру это отдельный процесс. Я буду рад когда-нибудь сделать это, но на текущий момент нет версий для любых клавиатур отличных от стандартной.

В: Возможно ли использовать это на Linux?

О: Нет. Насколько я интересовался вопросом – там есть только сложные пути реализации отлова длинных нажатий, и за эти варианты я сейчас взяться не готов. Конечно, можно назначить любую клавишу как модификатор, и перенести весь слой длинных нажатий под этот модификатор. Но это уже будет не совсем то, что я делал. Или совсем не то.

В: Могу я использовать это на Mac?

О: Нет, текущая версия используется только на Windows. Честно говоря, я пока даже не интересовался вопросом реализации этой раскладки на Mac.

В: Может хоть на Android?

О: Да! Правда, не для монополиста `G.Board`, но есть приложение с полнейшей кастомизацией – [Multiling O Keyboard](https://play.google.com/store/apps/details?id=kl.ime.oh&hl=en). Шаблоны раскладок для этого приложения и скриншоты можно найти тут: [external/android/](https://github.com/da3/layout/tree/master/external/android/).

В: В английской раскладке присутствуют пустые клавиши?

О: Да. В виду разделения буквенного и символьных слоёв, клавиши с потенциально-буквенным назначением могут быть использованы только для букв. Но в том, что они пустые нет никакой проблемы – количество символов от этого уж явно не пострадало, а буквы расположены на самых удобных позициях, не теснясь с конкурентами на место.

В: ...но они не совсем пустые?

О: Да, технически, `ч`, `с` и `и` клавиши (в йцукен-виде) отправляют U+001E "Record Separator", который не отображается на печати, но может быть использован сторонними программами, для дополнительных назначений, к примеру. Я не сталкивался со случаями, где это решение давало бы сбои, но если такие найдутся, это всегда можно убрать. Пока пользы больше.

В: Могу я использовать символьную раскладку с `йцукен`?

О: Вы-то, конечно, можете, но это будет не так удобно, как это планировалось (планировалось не использовать `йцукен`).

В: Могу я использовать буквенную раскладку без символьной?

О: А вот тут, к сожалению, нет. Вам объективно не будет хватать базовых символов.

В: Связан ли как-то этот проект и метод слепого набора?

О: Конечно! Основная цель как раз в максимизации удобства слепого набора и минимизации лишних движений (в особенности – движений отрывающих руки с их домашних позиций).

В: Нужно ли мне сначала потренироваться в слепом наборе, прежде чем знакомиться с этим проектом?

О: Если вы уже об этом задумались – однозначно стоит, и вне зависимости от того, собираетесь ли вы потом знакомиться с данным проектом. А если всё-таки собираетесь, то даже лучше сначала ознакомиться с проектом, а уже пользуясь выбранной раскладкой тренироваться в слепом наборе. Следующий вопрос ответит, почему так.

В: Я грандмастер набора текста на qwerty/dvorak/workman/др, есть ли смысл переходить на эту раскладку?

О: Смысл есть, несомненно, но процесс перехода на любую новую раскладку длителен и дискомфортен. И чем лучше вы владели предыдущей раскладкой, тем больнее будет переход на новую. Первое время вы будете очень медленными и неуклюжими, и это будет бесить. Также потом могут иногда проявляться фантомные нажатия, когда в процессе потокового набора палец на один символ идёт по старому автоматизму. Тоже довольно бесячая вещь. Но смена раскладки стоит того, особенно, если вы переходите с `йцукен`. Просто вы должны быть заранее готовы ко всему описанному.

В: Я не могу использовать стрелки и цифровой блок!

О: Так и задумано. Если вы хотите попробовать эту раскладку, как она и планировалась, вам нужно привыкнуть к тому, чтобы поменьше отрывать руки от домашних позиций.

В: Я не могу кричать капсом!

О: Восхитительно. Так и задумано.

В: ... но мне нужен `Caps Lock` для моего ЯП или для чего-то ещё!

О: Эта раскладка для общего пользования. А для общего пользования функция `Caps Lock` вредна. Для частных случаев вы можете добавить собственное назначение для этой функции и закомментировать строку `SetCapsLockState` в `qphyx.ahk`. Но пожалуйста, не злоупотребляйте ей.

В: Этот проект родственен с [menu](https://github.com/da3/menu)?

О: Да, когда-то это был единый проект, но с постоянным добавлением нового функционала было принято решение о его разделении на два проекта. Но и сейчас они тесно связаны друг с другом. К примеру, вы можете выставлять время срабатывания длинного нажатия через `input-box`, вызываемый `menu`, а `qphyx` сам вызывает `menu` в подходящий момент, дабы избежать конфликта назначений. Для связи между ними нужно лишь в `config.ini` обоих проектов указать путь к родственнику.

В: Ещё какие-нибудь интеграции?

О: Просто вызов в нужное время, для исключения конфликтов – [ViATc](https://github.com/magicstep/ViATc-English). Если вы пользуетесь этим проектом, просто укажите путь к основному файлу `ViATc-x.x.xen.ahk` в `config.ini`.

В: Проблемы с `config.ini`

О: Не создавайте его сами, дайте ему сгенерироваться при запуске, и лишь потом правьте. Для функциональности с переключением между приложениями добавьте в конец файла настроек строку `[AltApps]`, а после ниже, на отдельных строках, располагайте ваши приложения по соответствующему образцу.


## Copyrights

Icon was downloaded for free from [icons8.com](https://icons8.com/icon/l0UsZRTvcGel/laptop-coding)


## License
[MIT](https://choosealicense.com/licenses/mit/)
