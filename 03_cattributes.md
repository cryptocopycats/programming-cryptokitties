# Statistics, Statistics, Statistics - Cattributes Rarity & Popularity

Crypto collectibles are all about rarity - the more rare a cattribute
the more valuable the kitty in theory.


Let's use the official cattributes totals statistics that you can fetch from the (unofficial, no API-key required)
CryptoKitties web service @ [`api.cryptokitties.co/cattributes`](https://api.cryptokitties.co/cattributes).
Resulting in:

``` json
[
  {
    "description": "totesbasic",
    "type": "pattern",
    "gene": 15,
    "total": "317195"
  },
  {
    "description": "thicccbrowz",
    "type": "eyes",
    "gene": 7,
    "total": "224569"
  },
  {
    "description": "granitegrey",
    "type": "colortertiary",
    "gene": 4,
    "total": "220303"
  },
  {
    "description": "kittencream",
    "type": "colortertiary",
    "gene": 6,
    "total": "215296"
  },
  {
    "description": "pouty",
    "type": "mouth",
    "gene": 9,
    "total": "206095"
  },
  -- snip - many more cattributes --
  {
    "description": "struck",
    "type": "mouth",
    "gene": 29,
    "total": "428"
  },
  {
    "description": "liger",
    "type": "body",
    "gene": 30,
    "total": "328"
  },
  {
    "description": "dreamboat",
    "type": "colortertiary",
    "gene": 30,
    "total": "324"
  }
]
```

The result is ordered by
most popular cattribute to most rare.
And the most popular cattribute is - surprise, surprise -
the infamous totesbasic (pattern) with 317 195 kitties (as of Dec/27, 2018),
followed by thicccbrowz (eyes) with 224 569 kitties,
granitegrey (colortertiary) with 220 303,
kittencream (colortertiary) with 215 296,
pouty (mouth) with 206 095 and so on and so forth.
The most rare cattribute
is dreamboat (colortertiary) with only 324 kitties (as of Dec/27, 2018),
followed by liger (body) with 328,
struck (mouth) with 428 and so on and so forth.

Note: The service uses "internal" keys for the trait types.
`colorprimary` is officially known as base color,
`colorsecondary` is officially known as highlight color,
`colortertiary` is known as accent color,
`eyes` is known as eye shape,
`coloreyes` is known as eye colors,
`body` is known as fur,
and `prestige` is known as purrstige on kitty profile pages.


Let's use the official cattributes totals statistics and let's build a cattributes rarity / popularity statistics
report page that groups all cattributes by trait type
(e.g. fur, pattern, eye color, and so on) and
adds a ranking from 1 to 31 and the popularity / rarity in
percentage (e.g. 0.04%, 5.28%, 11.79%, and so on).

Note: For easy coding along you can find a
local (pretty printed) copy of the [`cattributes.json`](datasets/cattributes.json)
dataset in the [`/datasets`](datasets) folder.

``` ruby
require 'json'
require 'pp'

cattribute_totals = JSON.parse( File.read( './datasets/cattributes.json' ))
pp cattribute_totals
```

Results in:

``` ruby
[{"description"=>"totesbasic",
  "type"=>"pattern",
  "gene"=>15,
  "total"=>"317195"},
 {"description"=>"thicccbrowz",
  "type"=>"eyes",
  "gene"=>7,
  "total"=>"224569"},
 {"description"=>"granitegrey",
  "type"=>"colortertiary",
  "gene"=>4,
  "total"=>"220303"},
 {"description"=>"kittencream",
  "type"=>"colortertiary",
  "gene"=>6,
  "total"=>"215296"},
 {"description"=>"pouty",
   "type"=>"mouth",
   "gene"=>9,
   "total"=>"206095"},
   # ...
]
```


Let's group the cattributes by trait type and sum up the totals:

``` ruby
trait_types = {}

cattribute_totals.each do |h|
  key = h['type'].to_sym
  rec = trait_types[ key ] ||= [0,[]]

  rec[ 0 ] += h['total'].to_i   ## sum up totals for trait type
  rec[ 1 ] << [h['description'], h['total'].to_i]
end

pp trait_types
```

resulting in:

``` ruby
{:pattern=>
  [1241602,
   [["totesbasic", 317195],
    ["luckystripe", 161830],
    ["amur", 125320],
    ["spock", 105256],
    ["tiger", 89676],
    ["rascal", 75962],
    ["calicool", 54377],
    ["spangled", 51884],
    ["rorschach", 43036],
    ["leopard", 41508],
    ["ganado", 37327],
    ["jaguar", 31949],
    ["tigerpunk", 26441],
    ["henna", 16405],
    ["camo", 15520],
    ["dippedcone", 8188],
    ["thunderstruck", 7676],
    ["hotrod", 6634],
    ["mittens", 6236],
    ["highsociety", 5613],
    ["avatar", 3197],
    ["razzledazzle", 2313],
    ["vigilante", 2176],
    ["arcreactor", 1377],
    ["scorpius", 1050],
    ["splat", 1045],
    ["allyouneed", 880],
    ["gyre", 844],
    ["moonrise", 687]]],
 :eyes=>
  [1241610,
   [["thicccbrowz", 224569],
    ["crazy", 162807],
    ["simple", 112456],
    ["wiley", 91547],
    ["raisedbrow", 91092],
    ["googly", 85334],
    ["slyboots", 81779],
    ["chronic", 79515],
    ["wonky", 78383],
    ["otaku", 29477],
    ["stunned", 24654],
    ["swarley", 23219],
    ["sass", 21068],
    ["serpent", 20791],
    ["asif", 19818],
    ["fabulous", 19224],
    ["baddate", 14933],
    ["alien", 10193],
    ["wingtips", 10175],
    ["caffeine", 9642],
    ["sweetmeloncakes", 8126],
    ["wowza", 6457],
    ["buzzed", 4293],
    ["chameleon", 3629],
    ["bornwithit", 2728],
    ["oceanid", 1336],
    ["tendertears", 1135],
    ["drama", 995],
    ["hacker", 954],
    ["candyshoppe", 648],
    ["firedup", 633]]],
 :colortertiary=>
  [1241592,
   [["granitegrey", 220303],
    ["kittencream", 215296],
    ["icy", 93902],
    ["sandalwood", 89729],
    ["purplehaze", 85876],
    ["emeraldgreen", 79258],
    ["frosting", 69356],
    ["azaleablush", 65054],
    ["belleblue", 53065],
    ["morningglory", 43051],
    ["bloodred", 41328],
    ["cashewmilk", 37908],
    ["peach", 33890],
    ["kalahari", 26916],
    ["shale", 21083],
    ["missmuffett", 11960],
    ["daffodil", 11454],
    ["patrickstarfish", 9122],
    ["periwinkle", 7275],
    ["atlantis", 7050],
    ["flamingo", 3810],
    ["seafoam", 3650],
    ["mintmacaron", 3098],
    ["buttercup", 2460],
    ["sully", 1914],
    ["hanauma", 1070],
    ["cobalt", 800],
    ["mallowflower", 542],
    ["summerbonnet", 541],
    ["fallspice", 507],
    ["dreamboat", 324]]],
 :mouth=>
  [1241606,
   [["pouty", 206095],
    ["happygokitty", 185779],
    ["soserious", 158260],
    ["saycheese", 112765],
    ["wuvme", 79136],
    ["grim", 78660],
    ["whixtensions", 67017],
    ["beard", 59657],
    ["tongue", 57448],
    ["gerbil", 53726],
    ["confuzzled", 25344],
    ["dali", 23256],
    ["rollercoaster", 22628],
    ["fangtastic", 22618],
    ["impish", 18029],
    ["belch", 9624],
    ["wasntme", 9480],
    ["cheeky", 8430],
    ["moue", 8011],
    ["starstruck", 6780],
    ["grimace", 6083],
    ["neckbeard", 5981],
    ["yokel", 4278],
    ["topoftheworld", 3443],
    ["samwise", 2408],
    ["walrus", 1997],
    ["majestic", 1392],
    ["ruhroh", 1241],
    ["delite", 811],
    ["satiated", 801],
    ["struck", 428]]],
 :colorsecondary=>
  [1241611,
   [["royalpurple", 175025],
    ["swampgreen", 174520],
    ["lemonade", 170998],
    ["coffee", 157393],
    ["chocolate", 106131],
    ["egyptiankohl", 87692],
    ["barkbrown", 70013],
    ["scarlet", 64011],
    ["skyblue", 45622],
    ["lilac", 25731],
    ["apricot", 24978],
    ["poisonberry", 20354],
    ["springcrocus", 17918],
    ["violet", 17389],
    ["cerulian", 12719],
    ["wolfgrey", 12455],
    ["padparadscha", 9068],
    ["peppermint", 8313],
    ["safetyvest", 7667],
    ["royalblue", 6542],
    ["universe", 5292],
    ["butterscotch", 5093],
    ["turtleback", 4941],
    ["garnet", 2827],
    ["pearl", 2479],
    ["rosequartz", 2330],
    ["cyborg", 1387],
    ["mertail", 818],
    ["prairierose", 784],
    ["ooze", 613],
    ["inflatablepool", 508]]],
 :colorprimary=>
  [1241612,
   [["greymatter", 167426],
    ["cottoncandy", 140009],
    ["mauveover", 134722],
    ["shadowgrey", 120984],
    ["bananacream", 97646],
    ["aquamarine", 94113],
    ["orangesoda", 92002],
    ["salmon", 85352],
    ["cinderella", 66978],
    ["cloudwhite", 53801],
    ["brownies", 36518],
    ["oldlace", 33492],
    ["nachocheez", 19555],
    ["onyx", 17448],
    ["martian", 12841],
    ["verdigris", 11079],
    ["hintomint", 10888],
    ["harbourfog", 9774],
    ["dragonfruit", 7667],
    ["tundra", 6842],
    ["redvelvet", 5647],
    ["koala", 3571],
    ["shamrock", 2812],
    ["meowgarine", 2165],
    ["glacier", 1907],
    ["lavender", 1815],
    ["hotcocoa", 1281],
    ["hyacinth", 1230],
    ["icicle", 900],
    ["cornflower", 665],
    ["firstblush", 482]]],
 :coloreyes=>
  [1241608,
   [["strawberry", 145760],
    ["mintgreen", 137250],
    ["sizzurp", 127703],
    ["topaz", 109431],
    ["gold", 89101],
    ["chestnut", 82573],
    ["sapphire", 82195],
    ["thundergrey", 79701],
    ["cyan", 76755],
    ["coralsunrise", 65583],
    ["dahlia", 45060],
    ["limegreen", 36286],
    ["parakeet", 29883],
    ["olive", 29243],
    ["doridnudibranch", 26772],
    ["bubblegum", 20660],
    ["forgetmenot", 17483],
    ["eclipse", 11498],
    ["pumpkin", 6435],
    ["palejade", 4282],
    ["twilightsparkle", 3396],
    ["dioscuri", 3350],
    ["pinefresh", 2837],
    ["babypuke", 1681],
    ["kaleidoscope", 1507],
    ["autumnmoon", 1465],
    ["oasis", 991],
    ["isotope", 830],
    ["gemini", 725],
    ["downbythebay", 645],
    ["bridesmaid", 527]]],
 :body=>
  [1241616,
   [["ragdoll", 140212],
    ["sphynx", 122295],
    ["munchkin", 116237],
    ["selkirk", 104842],
    ["himalayan", 99657],
    ["ragamuffin", 93617],
    ["cymric", 89254],
    ["birman", 84069],
    ["bobtail", 65851],
    ["koladiviya", 62436],
    ["laperm", 44437],
    ["pixiebob", 39969],
    ["savannah", 37833],
    ["norwegianforest", 21298],
    ["chartreux", 21160],
    ["persian", 13355],
    ["chantilly", 13101],
    ["siberian", 12824],
    ["highlander", 10199],
    ["toyger", 8923],
    ["lynx", 7833],
    ["manul", 7755],
    ["manx", 7305],
    ["mainecoon", 6487],
    ["fox", 2840],
    ["mekong", 2163],
    ["lykoi", 1886],
    ["kurilian", 1603],
    ["balinese", 1249],
    ["burmilla", 598],
    ["liger", 328]]],
 :wild=>
  [71570,
   [["elk", 14086],
    ["dragontail", 10555],
    ["dragonwings", 10130],
    ["littlefoot", 7012],
    ["daemonhorns", 5884],
    ["flapflap", 4311],
    ["daemonwings", 4029],
    ["ducky", 3776],
    ["unicorn", 2840],
    ["trioculus", 2775],
    ["aflutter", 1797],
    ["alicorn", 1393],
    ["wyrm", 1152],
    ["foghornpawhorn", 1020],
    ["featherbrain", 810]]],
 :environment=>
  [30326,
   [["salty", 10116],
    ["finalfrontier", 4798],
    ["tinybox", 2731],
    ["roadtogold", 1916],
    ["frozen", 1573],
    ["drift", 1559],
    ["myparade", 1195],
    ["juju", 1146],
    ["prism", 1133],
    ["jacked", 1014],
    ["secretgarden", 699],
    ["floorislava", 683],
    ["metime", 612],
    ["junglebook", 583],
    ["dune", 568]]],
 :prestige=>
  [5534,
   [["duckduckcat", 1249],
    ["furball", 998],
    ["prune", 921],
    ["reindeer", 636],
    ["thatsawrap", 615],
    ["lit", 570],
    ["holidaycheer", 545]]]}
```


Now let's generate a cattributes rarity / popularity statistics report in text with markdown formatting
and let's use the `TRAITS` list of all traits
from the [copycats library](https://github.com/cryptocopycats/copycats)
to add the official trait type names and two-letter codes:


``` ruby
require 'copycats'

buf = ""
buf << "# Cattributes Rarity / Popularity Statistics\n"
buf << "\n"
buf << "(Source: [`api.cryptokitties.co/cattributes` (JSON)](https://api.cryptokitties.co/cattributes))\n"
buf << "\n\n"

# quick hack - map copycats keys to (internal) cryptokitties trait type keys
#  note: all keys are the same except:
TRAIT_TYPE_MAPPINGS =
{
  :color1 => :colorprimary,
  :color2 => :colorsecondary,
  :color3 => :colortertiary
}

TRAITS.each do |key,h|
  next if key == :secret  ## skip secret (y gene) trait for now

  key = TRAIT_TYPE_MAPPINGS[ key ]  if TRAIT_TYPE_MAPPINGS[ key ]

  rec = trait_types[ key ]
  total = rec[0]
  items = rec[1]

  buf << "## #{h[:name]} (#{h[:code]})\n\n"


  buf << "_#{total} Cats with #{items.size} Cattributes_\n\n"

  buf << "| #|Total (%)|Cattribute|\n"
  buf << "|-:|--------:|----------|\n"

  # note: use reverse to order from most rare to most popular
  items.reverse.each_with_index do |item,i|

    name  = item[0]
    count = item[1]

    rank  = "#{i+1}/#{items.size}"

    percent = Float(100*count)/Float(total)

    buf << "| #{rank} | #{count} (#{('%2.2f' % percent)}) | "
    buf << "**#{name}** |"

    buf << "\n"
  end

  buf << "\n\n"
end

puts buf
```

resulting in:

---

# Cattributes Rarity / Popularity Statistics

(Source: [`api.cryptokitties.co/cattributes` (JSON)](https://api.cryptokitties.co/cattributes))

## Fur (FU)

_1241616 Cats with 31 Cattributes_

| #|Total (%)|Cattribute|
|-:|--------:|----------|
| 1/31 | 328 (0.03) | **liger** |
| 2/31 | 598 (0.05) | **burmilla** |
| 3/31 | 1249 (0.10) | **balinese** |
| 4/31 | 1603 (0.13) | **kurilian** |
| 5/31 | 1886 (0.15) | **lykoi** |
| 6/31 | 2163 (0.17) | **mekong** |
| 7/31 | 2840 (0.23) | **fox** |
| 8/31 | 6487 (0.52) | **mainecoon** |
| 9/31 | 7305 (0.59) | **manx** |
| 10/31 | 7755 (0.62) | **manul** |
| 11/31 | 7833 (0.63) | **lynx** |
| 12/31 | 8923 (0.72) | **toyger** |
| 13/31 | 10199 (0.82) | **highlander** |
| 14/31 | 12824 (1.03) | **siberian** |
| 15/31 | 13101 (1.06) | **chantilly** |
| 16/31 | 13355 (1.08) | **persian** |
| 17/31 | 21160 (1.70) | **chartreux** |
| 18/31 | 21298 (1.72) | **norwegianforest** |
| 19/31 | 37833 (3.05) | **savannah** |
| 20/31 | 39969 (3.22) | **pixiebob** |
| 21/31 | 44437 (3.58) | **laperm** |
| 22/31 | 62436 (5.03) | **koladiviya** |
| 23/31 | 65851 (5.30) | **bobtail** |
| 24/31 | 84069 (6.77) | **birman** |
| 25/31 | 89254 (7.19) | **cymric** |
| 26/31 | 93617 (7.54) | **ragamuffin** |
| 27/31 | 99657 (8.03) | **himalayan** |
| 28/31 | 104842 (8.44) | **selkirk** |
| 29/31 | 116237 (9.36) | **munchkin** |
| 30/31 | 122295 (9.85) | **sphynx** |
| 31/31 | 140212 (11.29) | **ragdoll** |


## Pattern (PA)

_1241602 Cats with 29 Cattributes_

| #|Total (%)|Cattribute|
|-:|--------:|----------|
| 1/29 | 687 (0.06) | **moonrise** |
| 2/29 | 844 (0.07) | **gyre** |
| 3/29 | 880 (0.07) | **allyouneed** |
| 4/29 | 1045 (0.08) | **splat** |
| 5/29 | 1050 (0.08) | **scorpius** |
| 6/29 | 1377 (0.11) | **arcreactor** |
| 7/29 | 2176 (0.18) | **vigilante** |
| 8/29 | 2313 (0.19) | **razzledazzle** |
| 9/29 | 3197 (0.26) | **avatar** |
| 10/29 | 5613 (0.45) | **highsociety** |
| 11/29 | 6236 (0.50) | **mittens** |
| 12/29 | 6634 (0.53) | **hotrod** |
| 13/29 | 7676 (0.62) | **thunderstruck** |
| 14/29 | 8188 (0.66) | **dippedcone** |
| 15/29 | 15520 (1.25) | **camo** |
| 16/29 | 16405 (1.32) | **henna** |
| 17/29 | 26441 (2.13) | **tigerpunk** |
| 18/29 | 31949 (2.57) | **jaguar** |
| 19/29 | 37327 (3.01) | **ganado** |
| 20/29 | 41508 (3.34) | **leopard** |
| 21/29 | 43036 (3.47) | **rorschach** |
| 22/29 | 51884 (4.18) | **spangled** |
| 23/29 | 54377 (4.38) | **calicool** |
| 24/29 | 75962 (6.12) | **rascal** |
| 25/29 | 89676 (7.22) | **tiger** |
| 26/29 | 105256 (8.48) | **spock** |
| 27/29 | 125320 (10.09) | **amur** |
| 28/29 | 161830 (13.03) | **luckystripe** |
| 29/29 | 317195 (25.55) | **totesbasic** |


## Eye Color (EC)

_1241608 Cats with 31 Cattributes_

| #|Total (%)|Cattribute|
|-:|--------:|----------|
| 1/31 | 527 (0.04) | **bridesmaid** |
| 2/31 | 645 (0.05) | **downbythebay** |
| 3/31 | 725 (0.06) | **gemini** |
| 4/31 | 830 (0.07) | **isotope** |
| 5/31 | 991 (0.08) | **oasis** |
| 6/31 | 1465 (0.12) | **autumnmoon** |
| 7/31 | 1507 (0.12) | **kaleidoscope** |
| 8/31 | 1681 (0.14) | **babypuke** |
| 9/31 | 2837 (0.23) | **pinefresh** |
| 10/31 | 3350 (0.27) | **dioscuri** |
| 11/31 | 3396 (0.27) | **twilightsparkle** |
| 12/31 | 4282 (0.34) | **palejade** |
| 13/31 | 6435 (0.52) | **pumpkin** |
| 14/31 | 11498 (0.93) | **eclipse** |
| 15/31 | 17483 (1.41) | **forgetmenot** |
| 16/31 | 20660 (1.66) | **bubblegum** |
| 17/31 | 26772 (2.16) | **doridnudibranch** |
| 18/31 | 29243 (2.36) | **olive** |
| 19/31 | 29883 (2.41) | **parakeet** |
| 20/31 | 36286 (2.92) | **limegreen** |
| 21/31 | 45060 (3.63) | **dahlia** |
| 22/31 | 65583 (5.28) | **coralsunrise** |
| 23/31 | 76755 (6.18) | **cyan** |
| 24/31 | 79701 (6.42) | **thundergrey** |
| 25/31 | 82195 (6.62) | **sapphire** |
| 26/31 | 82573 (6.65) | **chestnut** |
| 27/31 | 89101 (7.18) | **gold** |
| 28/31 | 109431 (8.81) | **topaz** |
| 29/31 | 127703 (10.29) | **sizzurp** |
| 30/31 | 137250 (11.05) | **mintgreen** |
| 31/31 | 145760 (11.74) | **strawberry** |


## Eye Shape (ES)

_1241610 Cats with 31 Cattributes_

| #|Total (%)|Cattribute|
|-:|--------:|----------|
| 1/31 | 633 (0.05) | **firedup** |
| 2/31 | 648 (0.05) | **candyshoppe** |
| 3/31 | 954 (0.08) | **hacker** |
| 4/31 | 995 (0.08) | **drama** |
| 5/31 | 1135 (0.09) | **tendertears** |
| 6/31 | 1336 (0.11) | **oceanid** |
| 7/31 | 2728 (0.22) | **bornwithit** |
| 8/31 | 3629 (0.29) | **chameleon** |
| 9/31 | 4293 (0.35) | **buzzed** |
| 10/31 | 6457 (0.52) | **wowza** |
| 11/31 | 8126 (0.65) | **sweetmeloncakes** |
| 12/31 | 9642 (0.78) | **caffeine** |
| 13/31 | 10175 (0.82) | **wingtips** |
| 14/31 | 10193 (0.82) | **alien** |
| 15/31 | 14933 (1.20) | **baddate** |
| 16/31 | 19224 (1.55) | **fabulous** |
| 17/31 | 19818 (1.60) | **asif** |
| 18/31 | 20791 (1.67) | **serpent** |
| 19/31 | 21068 (1.70) | **sass** |
| 20/31 | 23219 (1.87) | **swarley** |
| 21/31 | 24654 (1.99) | **stunned** |
| 22/31 | 29477 (2.37) | **otaku** |
| 23/31 | 78383 (6.31) | **wonky** |
| 24/31 | 79515 (6.40) | **chronic** |
| 25/31 | 81779 (6.59) | **slyboots** |
| 26/31 | 85334 (6.87) | **googly** |
| 27/31 | 91092 (7.34) | **raisedbrow** |
| 28/31 | 91547 (7.37) | **wiley** |
| 29/31 | 112456 (9.06) | **simple** |
| 30/31 | 162807 (13.11) | **crazy** |
| 31/31 | 224569 (18.09) | **thicccbrowz** |


## Base Color (BC)

_1241612 Cats with 31 Cattributes_

| #|Total (%)|Cattribute|
|-:|--------:|----------|
| 1/31 | 482 (0.04) | **firstblush** |
| 2/31 | 665 (0.05) | **cornflower** |
| 3/31 | 900 (0.07) | **icicle** |
| 4/31 | 1230 (0.10) | **hyacinth** |
| 5/31 | 1281 (0.10) | **hotcocoa** |
| 6/31 | 1815 (0.15) | **lavender** |
| 7/31 | 1907 (0.15) | **glacier** |
| 8/31 | 2165 (0.17) | **meowgarine** |
| 9/31 | 2812 (0.23) | **shamrock** |
| 10/31 | 3571 (0.29) | **koala** |
| 11/31 | 5647 (0.45) | **redvelvet** |
| 12/31 | 6842 (0.55) | **tundra** |
| 13/31 | 7667 (0.62) | **dragonfruit** |
| 14/31 | 9774 (0.79) | **harbourfog** |
| 15/31 | 10888 (0.88) | **hintomint** |
| 16/31 | 11079 (0.89) | **verdigris** |
| 17/31 | 12841 (1.03) | **martian** |
| 18/31 | 17448 (1.41) | **onyx** |
| 19/31 | 19555 (1.57) | **nachocheez** |
| 20/31 | 33492 (2.70) | **oldlace** |
| 21/31 | 36518 (2.94) | **brownies** |
| 22/31 | 53801 (4.33) | **cloudwhite** |
| 23/31 | 66978 (5.39) | **cinderella** |
| 24/31 | 85352 (6.87) | **salmon** |
| 25/31 | 92002 (7.41) | **orangesoda** |
| 26/31 | 94113 (7.58) | **aquamarine** |
| 27/31 | 97646 (7.86) | **bananacream** |
| 28/31 | 120984 (9.74) | **shadowgrey** |
| 29/31 | 134722 (10.85) | **mauveover** |
| 30/31 | 140009 (11.28) | **cottoncandy** |
| 31/31 | 167426 (13.48) | **greymatter** |


## Highlight Color (HC)

_1241611 Cats with 31 Cattributes_

| #|Total (%)|Cattribute|
|-:|--------:|----------|
| 1/31 | 508 (0.04) | **inflatablepool** |
| 2/31 | 613 (0.05) | **ooze** |
| 3/31 | 784 (0.06) | **prairierose** |
| 4/31 | 818 (0.07) | **mertail** |
| 5/31 | 1387 (0.11) | **cyborg** |
| 6/31 | 2330 (0.19) | **rosequartz** |
| 7/31 | 2479 (0.20) | **pearl** |
| 8/31 | 2827 (0.23) | **garnet** |
| 9/31 | 4941 (0.40) | **turtleback** |
| 10/31 | 5093 (0.41) | **butterscotch** |
| 11/31 | 5292 (0.43) | **universe** |
| 12/31 | 6542 (0.53) | **royalblue** |
| 13/31 | 7667 (0.62) | **safetyvest** |
| 14/31 | 8313 (0.67) | **peppermint** |
| 15/31 | 9068 (0.73) | **padparadscha** |
| 16/31 | 12455 (1.00) | **wolfgrey** |
| 17/31 | 12719 (1.02) | **cerulian** |
| 18/31 | 17389 (1.40) | **violet** |
| 19/31 | 17918 (1.44) | **springcrocus** |
| 20/31 | 20354 (1.64) | **poisonberry** |
| 21/31 | 24978 (2.01) | **apricot** |
| 22/31 | 25731 (2.07) | **lilac** |
| 23/31 | 45622 (3.67) | **skyblue** |
| 24/31 | 64011 (5.16) | **scarlet** |
| 25/31 | 70013 (5.64) | **barkbrown** |
| 26/31 | 87692 (7.06) | **egyptiankohl** |
| 27/31 | 106131 (8.55) | **chocolate** |
| 28/31 | 157393 (12.68) | **coffee** |
| 29/31 | 170998 (13.77) | **lemonade** |
| 30/31 | 174520 (14.06) | **swampgreen** |
| 31/31 | 175025 (14.10) | **royalpurple** |


## Accent Color (AC)

_1241592 Cats with 31 Cattributes_

| #|Total (%)|Cattribute|
|-:|--------:|----------|
| 1/31 | 324 (0.03) | **dreamboat** |
| 2/31 | 507 (0.04) | **fallspice** |
| 3/31 | 541 (0.04) | **summerbonnet** |
| 4/31 | 542 (0.04) | **mallowflower** |
| 5/31 | 800 (0.06) | **cobalt** |
| 6/31 | 1070 (0.09) | **hanauma** |
| 7/31 | 1914 (0.15) | **sully** |
| 8/31 | 2460 (0.20) | **buttercup** |
| 9/31 | 3098 (0.25) | **mintmacaron** |
| 10/31 | 3650 (0.29) | **seafoam** |
| 11/31 | 3810 (0.31) | **flamingo** |
| 12/31 | 7050 (0.57) | **atlantis** |
| 13/31 | 7275 (0.59) | **periwinkle** |
| 14/31 | 9122 (0.73) | **patrickstarfish** |
| 15/31 | 11454 (0.92) | **daffodil** |
| 16/31 | 11960 (0.96) | **missmuffett** |
| 17/31 | 21083 (1.70) | **shale** |
| 18/31 | 26916 (2.17) | **kalahari** |
| 19/31 | 33890 (2.73) | **peach** |
| 20/31 | 37908 (3.05) | **cashewmilk** |
| 21/31 | 41328 (3.33) | **bloodred** |
| 22/31 | 43051 (3.47) | **morningglory** |
| 23/31 | 53065 (4.27) | **belleblue** |
| 24/31 | 65054 (5.24) | **azaleablush** |
| 25/31 | 69356 (5.59) | **frosting** |
| 26/31 | 79258 (6.38) | **emeraldgreen** |
| 27/31 | 85876 (6.92) | **purplehaze** |
| 28/31 | 89729 (7.23) | **sandalwood** |
| 29/31 | 93902 (7.56) | **icy** |
| 30/31 | 215296 (17.34) | **kittencream** |
| 31/31 | 220303 (17.74) | **granitegrey** |


## Wild Element (WE)

_71570 Cats with 15 Cattributes_

| #|Total (%)|Cattribute|
|-:|--------:|----------|
| 1/15 | 810 (1.13) | **featherbrain** |
| 2/15 | 1020 (1.43) | **foghornpawhorn** |
| 3/15 | 1152 (1.61) | **wyrm** |
| 4/15 | 1393 (1.95) | **alicorn** |
| 5/15 | 1797 (2.51) | **aflutter** |
| 6/15 | 2775 (3.88) | **trioculus** |
| 7/15 | 2840 (3.97) | **unicorn** |
| 8/15 | 3776 (5.28) | **ducky** |
| 9/15 | 4029 (5.63) | **daemonwings** |
| 10/15 | 4311 (6.02) | **flapflap** |
| 11/15 | 5884 (8.22) | **daemonhorns** |
| 12/15 | 7012 (9.80) | **littlefoot** |
| 13/15 | 10130 (14.15) | **dragonwings** |
| 14/15 | 10555 (14.75) | **dragontail** |
| 15/15 | 14086 (19.68) | **elk** |


## Mouth (MO)

_1241606 Cats with 31 Cattributes_

| #|Total (%)|Cattribute|
|-:|--------:|----------|
| 1/31 | 428 (0.03) | **struck** |
| 2/31 | 801 (0.06) | **satiated** |
| 3/31 | 811 (0.07) | **delite** |
| 4/31 | 1241 (0.10) | **ruhroh** |
| 5/31 | 1392 (0.11) | **majestic** |
| 6/31 | 1997 (0.16) | **walrus** |
| 7/31 | 2408 (0.19) | **samwise** |
| 8/31 | 3443 (0.28) | **topoftheworld** |
| 9/31 | 4278 (0.34) | **yokel** |
| 10/31 | 5981 (0.48) | **neckbeard** |
| 11/31 | 6083 (0.49) | **grimace** |
| 12/31 | 6780 (0.55) | **starstruck** |
| 13/31 | 8011 (0.65) | **moue** |
| 14/31 | 8430 (0.68) | **cheeky** |
| 15/31 | 9480 (0.76) | **wasntme** |
| 16/31 | 9624 (0.78) | **belch** |
| 17/31 | 18029 (1.45) | **impish** |
| 18/31 | 22618 (1.82) | **fangtastic** |
| 19/31 | 22628 (1.82) | **rollercoaster** |
| 20/31 | 23256 (1.87) | **dali** |
| 21/31 | 25344 (2.04) | **confuzzled** |
| 22/31 | 53726 (4.33) | **gerbil** |
| 23/31 | 57448 (4.63) | **tongue** |
| 24/31 | 59657 (4.80) | **beard** |
| 25/31 | 67017 (5.40) | **whixtensions** |
| 26/31 | 78660 (6.34) | **grim** |
| 27/31 | 79136 (6.37) | **wuvme** |
| 28/31 | 112765 (9.08) | **saycheese** |
| 29/31 | 158260 (12.75) | **soserious** |
| 30/31 | 185779 (14.96) | **happygokitty** |
| 31/31 | 206095 (16.60) | **pouty** |


## Environment (EN)

_30326 Cats with 15 Cattributes_

| #|Total (%)|Cattribute|
|-:|--------:|----------|
| 1/15 | 568 (1.87) | **dune** |
| 2/15 | 583 (1.92) | **junglebook** |
| 3/15 | 612 (2.02) | **metime** |
| 4/15 | 683 (2.25) | **floorislava** |
| 5/15 | 699 (2.30) | **secretgarden** |
| 6/15 | 1014 (3.34) | **jacked** |
| 7/15 | 1133 (3.74) | **prism** |
| 8/15 | 1146 (3.78) | **juju** |
| 9/15 | 1195 (3.94) | **myparade** |
| 10/15 | 1559 (5.14) | **drift** |
| 11/15 | 1573 (5.19) | **frozen** |
| 12/15 | 1916 (6.32) | **roadtogold** |
| 13/15 | 2731 (9.01) | **tinybox** |
| 14/15 | 4798 (15.82) | **finalfrontier** |
| 15/15 | 10116 (33.36) | **salty** |


## Purrstige (PU)

_5534 Cats with 7 Cattributes_

| #|Total (%)|Cattribute|
|-:|--------:|----------|
| 1/7 | 545 (9.85) | **holidaycheer** |
| 2/7 | 570 (10.30) | **lit** |
| 3/7 | 615 (11.11) | **thatsawrap** |
| 4/7 | 636 (11.49) | **reindeer** |
| 5/7 | 921 (16.64) | **prune** |
| 6/7 | 998 (18.03) | **furball** |
| 7/7 | 1249 (22.57) | **duckduckcat** |

---

Voila!  Now you can build yourself an always up-to-date
cattribute rarity & popularity cheat sheet
from the original cryptokitties source.
