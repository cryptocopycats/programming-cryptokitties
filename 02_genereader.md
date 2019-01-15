# Build Your Own CryptoKitties Gene Reader

Let's code a gene reader that deciphers the genome.
Let's automate the lookup of the 5-bit chunks mapping to traits.


Let's (re)use the [copycats library](https://github.com/cryptocopycats/copycats)
that includes an up-to-date list of all traits.
For example, try:

``` ruby
require 'copycats'

pp TRAITS     ## pretty print (pp) TRAITS, that is, list of all traits
```

Resulting in:

``` ruby
{:body=>
  {:genes=>"0-3",
   :name=>"Fur",
   :code=>"FU",
   :kai=>
    {"1"=>"savannah",
     "2"=>"selkirk",
     "3"=>"chantilly",
     "4"=>"birman",
     "5"=>"koladiviya",
     "6"=>"bobtail",
     "7"=>"manul",
     "8"=>"pixiebob",
     "9"=>"siberian",
     "a"=>"cymric",
     "b"=>"chartreux",
     "c"=>"himalayan",
     "d"=>"munchkin",
     "e"=>"sphynx",
     "f"=>"ragamuffin",
     "g"=>"ragdoll",
     "h"=>"norwegianforest",
     "i"=>"mekong",
     "j"=>"highlander",
     "k"=>"balinese",
     "m"=>"lynx",
     "n"=>"mainecoon",
     "o"=>"laperm",
     "p"=>"persian",
     "q"=>"fox",
     "r"=>"kurilian",
     "s"=>"toyger",
     "t"=>"manx",
     "u"=>"lykoi",
     "v"=>"burmilla",
     "w"=>"liger",
     "x"=>""}},
 :pattern=>
  {:genes=>"4-7",
   :name=>"Pattern",
   :code=>"PA",
   :kai=>
    {"1"=>"vigilante",
     "2"=>"tiger",
     "3"=>"rascal",
     "4"=>"ganado",
     "5"=>"leopard",
     "6"=>"camo",
     "7"=>"rorschach",
     "8"=>"spangled",
     "9"=>"calicool",
     "a"=>"luckystripe",
     "b"=>"amur",
     "c"=>"jaguar",
     "d"=>"spock",
     "e"=>"mittens",
     "f"=>"totesbasic",
     "g"=>"totesbasic",
     "h"=>"splat",
     "i"=>"thunderstruck",
     "j"=>"dippedcone",
     "k"=>"highsociety",
     "m"=>"tigerpunk",
     "n"=>"henna",
     "o"=>"arcreactor",
     "p"=>"totesbasic",
     "q"=>"scorpius",
     "r"=>"razzledazzle",
     "s"=>"hotrod",
     "t"=>"allyouneed",
     "u"=>"avatar",
     "v"=>"gyre",
     "w"=>"moonrise",
     "x"=>""}},
 :coloreyes=>
  {:genes=>"8-11",
   :name=>"Eye Color",
   :code=>"EC",
   :kai=>
    {"1"=>"thundergrey",
     "2"=>"gold",
     "3"=>"topaz",
     "4"=>"mintgreen",
     "5"=>"isotope",
     "6"=>"sizzurp",
     "7"=>"chestnut",
     "8"=>"strawberry",
     "9"=>"sapphire",
     "a"=>"forgetmenot",
     "b"=>"dahlia",
     "c"=>"coralsunrise",
     "d"=>"olive",
     "e"=>"doridnudibranch",
     "f"=>"parakeet",
     "g"=>"cyan",
     "h"=>"pumpkin",
     "i"=>"limegreen",
     "j"=>"bridesmaid",
     "k"=>"bubblegum",
     "m"=>"twilightsparkle",
     "n"=>"palejade",
     "o"=>"pinefresh",
     "p"=>"eclipse",
     "q"=>"babypuke",
     "r"=>"downbythebay",
     "s"=>"autumnmoon",
     "t"=>"oasis",
     "u"=>"gemini",
     "v"=>"dioscuri",
     "w"=>"kaleidoscope",
     "x"=>""}},
 :eyes=>
  {:genes=>"12-15",
   :name=>"Eye Shape",
   :code=>"ES",
   :kai=>
    {"1"=>"swarley",
     "2"=>"wonky",
     "3"=>"serpent",
     "4"=>"googly",
     "5"=>"otaku",
     "6"=>"simple",
     "7"=>"crazy",
     "8"=>"thicccbrowz",
     "9"=>"caffeine",
     "a"=>"wowza",
     "b"=>"baddate",
     "c"=>"asif",
     "d"=>"chronic",
     "e"=>"slyboots",
     "f"=>"wiley",
     "g"=>"stunned",
     "h"=>"chameleon",
     "i"=>"alien",
     "j"=>"fabulous",
     "k"=>"raisedbrow",
     "m"=>"tendertears",
     "n"=>"hacker",
     "o"=>"sass",
     "p"=>"sweetmeloncakes",
     "q"=>"oceanid",
     "r"=>"wingtips",
     "s"=>"firedup",
     "t"=>"buzzed",
     "u"=>"bornwithit",
     "v"=>"candyshoppe",
     "w"=>"drama",
     "x"=>""}},
 :color1=>
  {:genes=>"16-19",
   :name=>"Base Color",
   :code=>"BC",
   :kai=>
    {"1"=>"shadowgrey",
     "2"=>"salmon",
     "3"=>"meowgarine",
     "4"=>"orangesoda",
     "5"=>"cottoncandy",
     "6"=>"mauveover",
     "7"=>"aquamarine",
     "8"=>"nachocheez",
     "9"=>"harbourfog",
     "a"=>"cinderella",
     "b"=>"greymatter",
     "c"=>"tundra",
     "d"=>"brownies",
     "e"=>"dragonfruit",
     "f"=>"hintomint",
     "g"=>"bananacream",
     "h"=>"cloudwhite",
     "i"=>"cornflower",
     "j"=>"oldlace",
     "k"=>"koala",
     "m"=>"lavender",
     "n"=>"glacier",
     "o"=>"redvelvet",
     "p"=>"verdigris",
     "q"=>"icicle",
     "r"=>"onyx",
     "s"=>"hyacinth",
     "t"=>"martian",
     "u"=>"hotcocoa",
     "v"=>"shamrock",
     "w"=>"firstblush",
     "x"=>""}},
 :color2=>
  {:genes=>"20-23",
   :name=>"Highlight Color",
   :code=>"HC",
   :kai=>
    {"1"=>"cyborg",
     "2"=>"springcrocus",
     "3"=>"egyptiankohl",
     "4"=>"poisonberry",
     "5"=>"lilac",
     "6"=>"apricot",
     "7"=>"royalpurple",
     "8"=>"padparadscha",
     "9"=>"swampgreen",
     "a"=>"violet",
     "b"=>"scarlet",
     "c"=>"barkbrown",
     "d"=>"coffee",
     "e"=>"lemonade",
     "f"=>"chocolate",
     "g"=>"butterscotch",
     "h"=>"ooze",
     "i"=>"safetyvest",
     "j"=>"turtleback",
     "k"=>"rosequartz",
     "m"=>"wolfgrey",
     "n"=>"cerulian",
     "o"=>"skyblue",
     "p"=>"garnet",
     "q"=>"peppermint",
     "r"=>"universe",
     "s"=>"royalblue",
     "t"=>"mertail",
     "u"=>"inflatablepool",
     "v"=>"pearl",
     "w"=>"prairierose",
     "x"=>""}},
 :color3=>
  {:genes=>"24-27",
   :name=>"Accent Color",
   :code=>"AC",
   :kai=>
    {"1"=>"belleblue",
     "2"=>"sandalwood",
     "3"=>"peach",
     "4"=>"icy",
     "5"=>"granitegrey",
     "6"=>"cashewmilk",
     "7"=>"kittencream",
     "8"=>"emeraldgreen",
     "9"=>"kalahari",
     "a"=>"shale",
     "b"=>"purplehaze",
     "c"=>"hanauma",
     "d"=>"azaleablush",
     "e"=>"missmuffett",
     "f"=>"morningglory",
     "g"=>"frosting",
     "h"=>"daffodil",
     "i"=>"flamingo",
     "j"=>"buttercup",
     "k"=>"bloodred",
     "m"=>"atlantis",
     "n"=>"summerbonnet",
     "o"=>"periwinkle",
     "p"=>"patrickstarfish",
     "q"=>"seafoam",
     "r"=>"cobalt",
     "s"=>"mallowflower",
     "t"=>"mintmacaron",
     "u"=>"sully",
     "v"=>"fallspice",
     "w"=>"dreamboat",
     "x"=>""}},
 :wild=>
  {:genes=>"28-31",
   :name=>"Wild",
   :code=>"WE",
   :kai=>
    {"h"=>"littlefoot",
     "i"=>"elk",
     "j"=>"ducky",
     "k"=>"trioculus",
     "m"=>"daemonwings",
     "n"=>"featherbrain",
     "o"=>"flapflap",
     "p"=>"daemonhorns",
     "q"=>"dragontail",
     "r"=>"aflutter",
     "s"=>"foghornpawhorn",
     "t"=>"unicorn",
     "u"=>"dragonwings",
     "v"=>"alicorn",
     "w"=>"wyrm",
     "x"=>""}},
 :mouth=>
  {:genes=>"32-35",
   :name=>"Mouth",
   :code=>"MO",
   :kai=>
    {"1"=>"whixtensions",
     "2"=>"wasntme",
     "3"=>"wuvme",
     "4"=>"gerbil",
     "5"=>"confuzzled",
     "6"=>"impish",
     "7"=>"belch",
     "8"=>"rollercoaster",
     "9"=>"beard",
     "a"=>"pouty",
     "b"=>"saycheese",
     "c"=>"grim",
     "d"=>"fangtastic",
     "e"=>"moue",
     "f"=>"happygokitty",
     "g"=>"soserious",
     "h"=>"cheeky",
     "i"=>"starstruck",
     "j"=>"samwise",
     "k"=>"ruhroh",
     "m"=>"dali",
     "n"=>"grimace",
     "o"=>"majestic",
     "p"=>"tongue",
     "q"=>"yokel",
     "r"=>"topoftheworld",
     "s"=>"neckbeard",
     "t"=>"satiated",
     "u"=>"walrus",
     "v"=>"struck",
     "w"=>"delite",
     "x"=>""}},
 :environment=>
  {:genes=>"36-39",
   :name=>"Environment",
   :code=>"EN",
   :kai=>
    {"h"=>"salty",
     "i"=>"dune",
     "j"=>"juju",
     "k"=>"tinybox",
     "m"=>"myparade",
     "n"=>"finalfrontier",
     "o"=>"metime",
     "p"=>"drift",
     "q"=>"secretgarden",
     "r"=>"frozen",
     "s"=>"roadtogold",
     "t"=>"jacked",
     "u"=>"floorislava",
     "v"=>"prism",
     "w"=>"junglebook",
     "x"=>""}},
 :secret=>{:genes=>"40-43", :name=>"Secret Y Gene", :code=>"SE", :kai=>{}},
 :prestige=>{:genes=>"44-47", :name=>"Purrstige", :code=>"PU", :kai=>{}}}
```

That's quite a list that you do not have to type in.
Let's use the new `TRAITS` hash to "automagically"
decipher the genome.

``` ruby
# hexadecimal (base 16)
genome = 0x00004a52931ce4085c14bdce014a0318846a0c808c60294a6314a34a1295b9ce  # kitty 1001

genes_kai = Base32.encode( genome )
p genes_kai
#=> "aaaa788522f2agff16617755e979244166677664a9aacfff"
genes_kai = genes_kai.reverse    # for easy array access reverse string
p genes_kai
#=> "fffcaa9a466776661442979e55771661ffga2f225887aaaa"

puts "Fur (FU) - Genes 0-3:"
puts " 0 | #{TRAITS[:body][:kai][genes_kai[0]]}"
puts " 1 | #{TRAITS[:body][:kai][genes_kai[1]]}"
puts " 2 | #{TRAITS[:body][:kai][genes_kai[2]]}"
puts " 3 | #{TRAITS[:body][:kai][genes_kai[3]]}"
puts
puts "Pattern (PA) - Genes 4-7:"
puts " 4 | #{TRAITS[:pattern][:kai][genes_kai[4]]}"
puts " 5 | #{TRAITS[:pattern][:kai][genes_kai[5]]}"
puts " 6 | #{TRAITS[:pattern][:kai][genes_kai[6]]}"
puts " 7 | #{TRAITS[:pattern][:kai][genes_kai[7]]}"
puts
puts "Eye Color (EC) - Genes 8-11:"
puts " 8 | #{TRAITS[:coloreyes][:kai][genes_kai[8]]}"
puts " 9 | #{TRAITS[:coloreyes][:kai][genes_kai[9]]}"
puts "10 | #{TRAITS[:coloreyes][:kai][genes_kai[10]]}"
puts "11 | #{TRAITS[:coloreyes][:kai][genes_kai[11]]}"
puts
puts "Eye Shape (ES) - Genes 12-15:"
puts "12 | #{TRAITS[:eyes][:kai][genes_kai[12]]}"
puts "13 | #{TRAITS[:eyes][:kai][genes_kai[13]]}"
puts "14 | #{TRAITS[:eyes][:kai][genes_kai[14]]}"
puts "15 | #{TRAITS[:eyes][:kai][genes_kai[15]]}"
puts
puts "Base Color (BC) - Genes 16-19:"
puts "16 | #{TRAITS[:color1][:kai][genes_kai[16]]}"
puts "17 | #{TRAITS[:color1][:kai][genes_kai[17]]}"
puts "18 | #{TRAITS[:color1][:kai][genes_kai[18]]}"
puts "19 | #{TRAITS[:color1][:kai][genes_kai[19]]}"
puts
puts "Highlight Color (HC) - Genes 20-23:"
puts "20 | #{TRAITS[:color2][:kai][genes_kai[20]]}"
puts "21 | #{TRAITS[:color2][:kai][genes_kai[21]]}"
puts "22 | #{TRAITS[:color2][:kai][genes_kai[22]]}"
puts "23 | #{TRAITS[:color2][:kai][genes_kai[23]]}"
puts
puts "Accent Color (AC) - Genes 24-27:"
puts "24 | #{TRAITS[:color3][:kai][genes_kai[24]]}"
puts "25 | #{TRAITS[:color3][:kai][genes_kai[25]]}"
puts "26 | #{TRAITS[:color3][:kai][genes_kai[26]]}"
puts "27 | #{TRAITS[:color3][:kai][genes_kai[27]]}"
puts
puts "Mouth (MO) - Genes 32-35:"
puts "32 | #{TRAITS[:mouth][:kai][genes_kai[32]]}"
puts "33 | #{TRAITS[:mouth][:kai][genes_kai[33]]}"
puts "34 | #{TRAITS[:mouth][:kai][genes_kai[34]]}"
puts "35 | #{TRAITS[:mouth][:kai][genes_kai[35]]}"
```

prints

```
Fur (FU) - Genes 0-3:
 0 | ragamuffin
 1 | ragamuffin
 2 | ragamuffin
 3 | himalayan

Pattern (PA) - Genes 4-7:
 4 | luckystripe
 5 | luckystripe
 6 | calicool
 7 | luckystripe

Eye Color (EC) - Genes 8-11:
 8 | mintgreen
 9 | sizzurp
10 | sizzurp
11 | chestnut

Eye Shape (ES) - Genes 12-15:
12 | crazy
13 | simple
14 | simple
15 | simple

Base Color (BC) - Genes 16-19:
16 | shadowgrey
17 | orangesoda
18 | orangesoda
19 | salmon

Highlight Color (HC) - Genes 20-23:
20 | swampgreen
21 | royalpurple
22 | swampgreen
23 | lemonade

Accent Color (AC) - Genes 24-27:
24 | granitegrey
25 | granitegrey
26 | kittencream
27 | kittencream

Mouth (MO) - Genes 32-35:
32 | happygokitty
33 | happygokitty
34 | soserious
35 | pouty
```

Note: Every trait has four genes
(primary, hidden 1, hidden 2, and hidden 3).
The primary gene is the "cattribute", that is,
the visible trait listed on the official kitty profile page.
Let's (double) check for the Kitty #1001:

- Fur: ragamuffin
- Pattern: luckystripe
- Eye Color: mintgreen
- Eye Shape: crazy
- Base Color: shadowgrey
- Highlight Color: swampgreen
- Accent Color: granitegrey
- Mouth: happygokitty

And the official page:

![](i/cattributes1001.png)

(Source: [`cryptokitties.co/kitty/1001`](https://www.cryptokitties.co/kitty/1001))

Bingo! The cattributes match up.

For easy (re)use lets put together a more "generic"
`print_genes` method:

``` ruby
print_genes( 0x00004a52931ce4085c14bdce014a0318846a0c808c60294a6314a34a1295b9ce ) # kitty 1001
print_genes( 0x000042d28390864842e7b9c900c6321086438c6098ca298c728867425cf6b1ac ) # kitty 1111
```

And the code:

``` ruby
def print_genes( genome )

  genes_kai = Base32.encode( genome )
  genes_kai = genes_kai.reverse    # for easy array access reverse string

  TRAITS.each_with_index do |(trait_key, trait_hash),i|

     # note: skip wild, environment, secret, prestige for now
     next if [:wild,   :environment,
              :secret, :prestige].include? trait_key

     offset = i*4
     puts "#{trait_hash[:name]} (#{trait_hash[:code]}) - Genes #{trait_hash[:genes]}:"
     puts "#{'%2d' % (0+offset)} | #{trait_hash[:kai][genes_kai[0+offset]]}"
     puts "#{'%2d' % (1+offset)} | #{trait_hash[:kai][genes_kai[1+offset]]}"
     puts "#{'%2d' % (2+offset)} | #{trait_hash[:kai][genes_kai[2+offset]]}"
     puts "#{'%2d' % (3+offset)} | #{trait_hash[:kai][genes_kai[3+offset]]}"
     puts
  end
end
```

Resulting in

```
Fur (FU) - Genes 0-3:
 0 | ragamuffin
 1 | ragamuffin
 2 | ragamuffin
 3 | himalayan

Pattern (PA) - Genes 4-7:
 4 | luckystripe
 5 | luckystripe
 6 | calicool
 7 | luckystripe

Eye Color (EC) - Genes 8-11:
 8 | mintgreen
 9 | sizzurp
10 | sizzurp
11 | chestnut

Eye Shape (ES) - Genes 12-15:
12 | crazy
13 | simple
14 | simple
15 | simple

Base Color (BC) - Genes 16-19:
16 | shadowgrey
17 | orangesoda
18 | orangesoda
19 | salmon

Highlight Color (HC) - Genes 20-23:
20 | swampgreen
21 | royalpurple
22 | swampgreen
23 | lemonade

Accent Color (AC) - Genes 24-27:
24 | granitegrey
25 | granitegrey
26 | kittencream
27 | kittencream

Mouth (MO) - Genes 32-35:
32 | happygokitty
33 | happygokitty
34 | soserious
35 | pouty
```

See a difference? There's no difference :-).

Note:
The copycats library / gem has a built-in gene reader and pretty printer.
Let's try it:


``` ruby
genome = Genome.new( 0x00004a52931ce4085c14bdce014a0318846a0c808c60294a6314a34a1295b9ce )
puts genome.build_tables    # outputs tables in text with markdown formatting
```

Resulting in:

---

Fur (FU) - Genes 0-3:

|Gene  |Binary   |Kai  |Trait    |   |
|------|---------|-----|---------|---|
| 0 | 01110 | f | **ragamuffin** | p |
| 1 | 01110 | f | ragamuffin | h1 |
| 2 | 01110 | f | ragamuffin | h2 |
| 3 | 01011 | c | himalayan | h3 |

p = primary, h1 = hidden 1, h2 = hidden 2, h3 = hidden 3

Pattern (PA) - Genes 4-7:

|Gene  |Binary   |Kai  |Trait    |   |
|------|---------|-----|---------|---|
| 4 | 01001 | a | **luckystripe** | p |
| 5 | 01001 | a | luckystripe | h1 |
| 6 | 01000 | 9 | calicool | h2 |
| 7 | 01001 | a | luckystripe | h3 |

Eye Color (EC) - Genes 8-11:

|Gene  |Binary   |Kai  |Trait    |   |
|------|---------|-----|---------|---|
| 8 | 00011 | 4 | **mintgreen** | p |
| 9 | 00101 | 6 | sizzurp | h1 |
| 10 | 00101 | 6 | sizzurp | h2 |
| 11 | 00110 | 7 | chestnut | h3 |

Eye Shape (ES) - Genes 12-15:

|Gene  |Binary   |Kai  |Trait    |   |
|------|---------|-----|---------|---|
| 12 | 00110 | 7 | **crazy** | p |
| 13 | 00101 | 6 | simple | h1 |
| 14 | 00101 | 6 | simple | h2 |
| 15 | 00101 | 6 | simple | h3 |

Base Color (BC) - Genes 16-19:

|Gene  |Binary   |Kai  |Trait    |   |
|------|---------|-----|---------|---|
| 16 | 00000 | 1 | **shadowgrey** | p |
| 17 | 00011 | 4 | orangesoda | h1 |
| 18 | 00011 | 4 | orangesoda | h2 |
| 19 | 00001 | 2 | salmon | h3 |

Highlight Color (HC) - Genes 20-23:

|Gene  |Binary   |Kai  |Trait    |   |
|------|---------|-----|---------|---|
| 20 | 01000 | 9 | **swampgreen** | p |
| 21 | 00110 | 7 | royalpurple | h1 |
| 22 | 01000 | 9 | swampgreen | h2 |
| 23 | 01101 | e | lemonade | h3 |

Accent Color (AC) - Genes 24-27:

|Gene  |Binary   |Kai  |Trait    |   |
|------|---------|-----|---------|---|
| 24 | 00100 | 5 | **granitegrey** | p |
| 25 | 00100 | 5 | granitegrey | h1 |
| 26 | 00110 | 7 | kittencream | h2 |
| 27 | 00110 | 7 | kittencream | h3 |

Mouth (MO) - Genes 32-35:

|Gene  |Binary   |Kai  |Trait    |   |
|------|---------|-----|---------|---|
| 32 | 01110 | f | **happygokitty** | p |
| 33 | 01110 | f | happygokitty | h1 |
| 34 | 01111 | g | soserious | h2 |
| 35 | 01001 | a | pouty | h3 |

---
