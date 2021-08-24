# qPhyx
## ↓ English part
> Remark: my English is very far from perfect. If you are able to read Russian, you should look at the appropriate section

**qPhyx** began as an alternate phonetic bilingual/biscripted keyboard layout. In the aftermath many features went beyond the usual layout and now it became something more. Now these are three interrelated parts:
1. Default letter layout
2. Uncommon symbol layout with some features
3. Arisen in the process add-on with many features

The first two depend on each other. Third can be used as such, but planned and once was as a part of one-piece project.

I can't describe this project briefly. It must either be tried or described in detail. Even better, both of them.

## Letter layout

> For a better understanding of this part it is recommended to have a look at the **external/calculating.xlsx**

Now it looks like this (*hereinafter in "excel-scheme" view*):
![English letter layout image](https://github.com/adam-p/markdown-here/raw/master/src/common/images/icon48.png "English letter layout")
... for English, and like this:
![Russian letter layout image](https://github.com/adam-p/markdown-here/raw/master/src/common/images/icon48.png "Russian letter layout")
... for Russian language.

Тhe arrangement of the letters was as objective as possible:
* First, various frequency analyses were found on the Internet and stored with their average value

  For English – [simia.net](http://simia.net/letters/index.html), [sttmedia.com](https://www.sttmedia.com/characterfrequency-english), [algoritmy.net](http://en.algoritmy.net/article/40379/Letter-frequency-English), [cornell.edu](http://pi.math.cornell.edu/~mec/2003-2004/cryptography/subs/frequencies.html), [lexico.com](https://www.lexico.com/explore/which-letters-are-used-most), wiki
  
  For Russian – [simia.net](http://simia.net/letters/index.html), [sttmedia.com](https://www.sttmedia.com/characterfrequency-russian), [ruslang.ru](http://dict.ruslang.ru/freq.php?act=show&dic=freq_letters)

  In addition to the previous were collected frequency analyses of letter pairs (English – [uic.edu](http://homepages.math.uic.edu/~leon/mcs425-s08/handouts/char_freq2.pdf), Russian – [statistica.ru](http://statistica.ru/local-portals/data-mining/analiz-tekstov/))
* Letter-part of default non-ergonomic keyboard were categorized into 6(7) groups for convenience:
![Groups of keys for convenience](https://github.com/adam-p/markdown-here/raw/master/src/common/images/icon48.png "Groups of keys for convenience")
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


With all these requirements the result was two variants: more classical and "complete".

### Lite variant
![English letter layout image](https://github.com/adam-p/markdown-here/raw/master/src/common/images/icon48.png "English letter layout")
> First of all – yes this layout suggests to non-standard keyboard usage as long presses. I am not going to prove to you that it is a comfortably – if you are convinced otherwise you still won't believe me. But I'm sure if you use this functionality enough to use it automatically, then you will agree with me. We won't mention this subject any more.

In green are highlighted main symbols, which there are also in the qwerty-layout; in gray are highlighted additional symbols, which I thought I should add (this is probably the most subjective part). In the corner placed two diacritic symbols for accents.

As you can see, all of the conditions above are met:
* symbols are the separate layers and these layers is independent of any language;
* symbols are grouped (base math, currencies, punctuation, brackets with mirror reflection around the home row); 
* additional symbols with often usage cases; 
* most usage symbols/groups placed on the most convenience groups; 
* all these within 60% keyboard (even less so far);
* there are controlling (navigation) commands.

### Complete variant
![English letter layout image](https://github.com/adam-p/markdown-here/raw/master/src/common/images/icon48.png "English letter layout")

> It may look very strange and very unfamiliar, but I assure – it's only because it's unfamiliar.

Let's see what are changed: 
* Num row. Base numbers are not changed. I don't think that ascending order for them is a bad thing. Alternate layers for nums contains not the best possible variants, but it is logical and, in general, num-layers is the less convenience, and they get the least attention
* Extended diacritic allows you to write in French, Spanish, Portuguese, Italian, German, Turkish, Esperanto and many more languages as well
* Controlling keys are swapped and reassigned: 
  * `backspace` now used for music control;
  * `enter` performs the functions of `backspace` and `delete`;
  * `caps lock` was be replaced by `enter`; 
  * base `tilde` as `esc`;
  * `caps lock` function thrown out (it was meant to be).

And again – it may look very strange, but these remapping were all done only to increase convenience.

## Implementation of first two parts

Omitting a bunch of different attempts: letter layer was realized with [Microsoft keyboard layout creator](https://www.microsoft.com/en-us/download/details.aspx?id=102134), symbol layer was realized with [AHK](https://www.autohotkey.com/).

With MKLC you get .exe files, which add full-fledged input language layout to your Windows. Generated layouts for installing for `en` and `ru` languages placed at the **external/qphyx_[en/ru]/**

AHK layer is more interesting: base script functionality is, of course, symbolic layers addition. Base "long press" delay is 0.15s. Early on in you may want to increase this value up to 0.2. In the process of getting used to it, you may decrease it up to 0.1 (recomended is 0.12)

## License
[MIT](https://choosealicense.com/licenses/mit/)