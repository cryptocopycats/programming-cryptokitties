# Programming Crypto Collectibiles Step-by-Step Book / Guide

_Let's start with CryptoKitties & Copycats. Inside Unique Bits & Bytes on the Blockchain..._



At the heart of crypto collectibles on the blockchain are unique bits & bytes.
For CryptoKitties this is a 240-bit integer that holds the
super "sekretoooo" genome / genes.

Let's use Kitty #1001 as an example
and look at the "magic" 240-bit integer number:

``` ruby
# A 240-bit super "sekretoooo" integer genome

# hexadecimal (base 16)
genome = 0x4a52931ce4085c14bdce014a0318846a0c808c60294a6314a34a1295b9ce
# decimal (base 10)
genome = 512955438081049600613224346938352058409509756310147795204209859701881294
# binary (base 2)
genome = 0b010010100101001010010011000111001110010000001000010111000001010010111101110011100000000101001010000000110001100010000100\
           011010100000110010000000100011000110000000101001010010100110001100010100101000110100101000010010100101011011100111001110
```


Let's convert from decimal (base 10) to hexadecimal (base 16 - 2^4)
and binary (base 2 that is, 0 and 1):

``` ruby
p genome    # printed as decimal (base 10) by default
# => 512955438081049600613224346938352058409509756310147795204209859701881294

p genome.to_s(16)
# => "4a52931ce4085c14bdce014a0318846a0c808c60294a6314a34a1295b9ce"

p genome.to_s(2)
# => "10010100101001010010011000111001110010000001000010111000001010010111101110011100000000101001010000000110001100010000100\
#     011010100000110010000000100011000110000000101001010010100110001100010100101000110100101000010010100101011011100111001110"
```

So what? Thanks to Kai Turner
who first deciphered the CryptoKitties 240-bit genome
in  [The CryptoKitties Genome Project: On Dominance, Inheritance and Mutation](https://medium.com/@kaigani/the-cryptokitties-genome-project-on-dominance-inheritance-and-mutation-b73059dcd0a4) on January 2018
we  know today
that the genome breaks down into 5-bit chunks.
And every 5-bit chunk is a gene.
And four 5-bit chunks (known as the primary, hidden 1, hidden 2 and hidden 3 gene)
get grouped into a trait
(e.g. fur, pattern, eye color, eye shape, base color, highlight color, and so on)
resulting in 12 trait groups of 4 (x 5-bit) genes
(that is, 12 x 4 x 5-bit = 240 bits).


Let's break the genome into 5-bit chunks
using `Base32.encode` from the [base32-alphabets library / gem](https://github.com/cryptocopycats/base32-alphabets).

``` ruby
require 'base32-alphabets'

Base32.format = :electrologica   # use the Electrologica Alphabet / Variant


# hexadecimal (base 16)
genome = 0x4a52931ce4085c14bdce014a0318846a0c808c60294a6314a34a1295b9ce  # kitty 1001

p Base32.encode( genome )
#=> "09-09-09-09-06-07-07-04-01-01-14-01-09-15-14-14-00-05-05-00-06-06-04-04-13-08-06-08-01-03-03-00-05-05-05-06-06-05-05-03-09-08-09-09-11-14-14-14"
```

Bingo!
Using a [genes / traits chart](https://github.com/cryptocopycats/copycats/blob/master/GENES.md) you can now decipher the genome.
Let's start from left-to-right.


Fur (FU) - Genes 0-3:

|5-Bit Chunk| Gene | Trait      |          |
|----------:|-----:|------------|----------|
| 14        | 0    | ragamuffin | Primary  |
| 14        | 1    | ragamuffin | Hidden 1 |
| 14        | 2    | ragamuffin | Hidden 2 |
| 11        | 3    | himalayan  | Hidden 3 |

Pattern (PA) - Genes 4-7:

|5-Bit Chunk| Gene | Trait       |          |
|----------:|-----:|-------------|----------|
| 09        | 4    | luckystripe | Primary  |
| 09        | 5    | luckystripe | Hidden 1 |
| 08        | 6    | calicool     | Hidden 2 |
| 09        | 7    | luckystripe  | Hidden 3 |

Eye Color (EC) - Genes 8-11:

|5-Bit Chunk| Gene | Trait       |          |
|----------:|-----:|-------------|----------|
| 03        | 8    | mintgreen   | Primary  |
| 05        | 9    | sizzurp     | Hidden 1 |
| 05        | 10   | sizzurp     | Hidden 2 |
| 06        | 11   | chestnut    | Hidden 3 |


and so on. Let's try another kitty #1111:

``` ruby
genome = 0x000042d28390864842e7b9c900c6321086438c6098ca298c728867425cf6b1ac # kitty 1111

p Base32.encode( genome )
#=> "08-11-09-08-07-04-04-06-09-01-01-14-15-14-14-09-00-03-03-03-04-04-04-06-08-14-06-06-01-06-06-10-05-06-06-07-05-02-03-07-08-09-14-15-13-12-13-12"
```

Again using a genes / traits chart you can now decipher the genome.
Let's start from left-to-right.

Fur (FU) - Genes 0-3:

|5-Bit Chunk| Gene | Trait      |          |
|----------:|-----:|------------|----------|
| 12        | 0    | munchkin   | Primary  |
| 13        | 1    | sphynx     | Hidden 1 |
| 12        | 2    | munchkin   | Hidden 2 |
| 13        | 3    | sphynx     | Hidden 3 |

Pattern (PA) - Genes 4-7:

|5-Bit Chunk| Gene | Trait       |          |
|----------:|-----:|-------------|----------|
| 15        | 4    | totesbasic  | Primary  |
| 14        | 5    | totesbasic  | Hidden 1 |
| 09        | 6    | luckystripe | Hidden 2 |
| 08        | 7    | calicool    | Hidden 3 |

Eye Color (EC) - Genes 8-11:

|5-Bit Chunk| Gene | Trait       |          |
|----------:|-----:|-------------|----------|
| 07        | 8    | strawberry  | Primary  |
| 03        | 9    | mintgreen   | Hidden 1 |
| 02        | 10   | topaz       | Hidden 2 |
| 05        | 11   | isotope     | Hidden 3 |

and so on.

What's Base32?

Encoding / decoding numbers in 5-bit chunks is called base 32
because 2^5 (=2*2*2*2*2) results in 32 values.
Using the Electrologica notation / alphabets
(`00 01 02 03 04 05 06 07`
`08 09 10 11 12 13 14 15`
`16 17 18 19 20 21 22 23`
`24 25 26 27 28 29 30 31`) the conversion chart reads:

|Base32 |Binary |Num|Base32 |Binary |Num|Base32 |Binary |Num|Base32 |Binary |Num|
|------:|------:|--:|------:|------:|--:|------:|------:|--:|------:|------:|--:|
| **00** | 00000 | 00 | **08** | 01000 | 08 | **16** | 10000 |16 | **24** | 11000 |24 |
| **01** | 00001 | 01 | **09** | 01001 | 09 | **17** | 10001 |17 | **25** | 11001 |25 |
| **02** | 00010 | 02 | **10** | 01010 | 10 | **18** | 10010 |18 | **26** | 11010 |26 |
| **03** | 00011 | 03 | **11** | 01011 | 11 | **19** | 10011 |19 | **27** | 11011 |27 |
| **04** | 00100 | 04 | **12** | 01100 | 12 | **20** | 10100 |20 | **28** | 11100 |28 |
| **05** | 00101 | 05 | **13** | 01101 | 13 | **21** | 10101 |21 | **29** | 11101 |29 |
| **06** | 00110 | 06 | **14** | 01110 | 14 | **22** | 10110 |22 | **30** | 11110 |30 |
| **07** | 00111 | 07 | **15** | 01111 | 15 | **23** | 10111 |23 | **31** | 11111 |31 |


What about Kai notation / alphabet?

The Kai (Base 32) notation / alphabet is named in honor of Kai Turner
who first deciphered the CryptoKitties 240-bit genome
in 5-bit chunks.
The Kai notation / alphabet
follows base56
and uses (`123456789abcdefghijkmnopqrstuvwx`):
The conversion chart reads:

|Kai    |Binary |Num|Kai    |Binary |Num|Kai    |Binary |Num|Kai    |Binary |Num|
|------:|------:|--:|------:|------:|--:|------:|------:|--:|------:|------:|--:|
| **1** | 00000 | 00 | **9** | 01000 | 08 | **h** | 10000 |16 | **q** | 11000 |24 |
| **2** | 00001 | 01 | **a** | 01001 | 09 | **i** | 10001 |17 | **r** | 11001 |25 |
| **3** | 00010 | 02 | **b** | 01010 | 10 | **j** | 10010 |18 | **s** | 11010 |26 |
| **4** | 00011 | 03 | **c** | 01011 | 11 | **k** | 10011 |19 | **t** | 11011 |27 |
| **5** | 00100 | 04 | **d** | 01100 | 12 | **m** | 10100 |20 | **u** | 11100 |28 |
| **6** | 00101 | 05 | **e** | 01101 | 13 | **n** | 10101 |21 | **v** | 11101 |29 |
| **7** | 00110 | 06 | **f** | 01110 | 14 | **o** | 10110 |22 | **w** | 11110 |30 |
| **8** | 00111 | 07 | **g** | 01111 | 15 | **p** | 10111 |23 | **x** | 11111 |31 |

Note:  - the digit-0 and the letter-l
are NOT used in the kai alphabet / notation.


Let's convert the example kitty genomes to
Kai notation:

``` ruby
require 'base32-alphabets'

Base32.format = :kai   # use the Kai Alphabet / Variant


# hexadecimal (base 16)
genome = 0x4a52931ce4085c14bdce014a0318846a0c808c60294a6314a34a1295b9ce  # kitty 1001

p Base32.encode( genome )
#=> "aaaa788522f2agff16617755e979244166677664a9aacfff"

genome = 0x000042d28390864842e7b9c900c6321086438c6098ca298c728867425cf6b1ac # kitty 1111

p Base32.encode( genome )
#=> "9ca98557a22fgffa144455579f77277b677863489afgeded"
```

Tip: Use the `Base32.fmt` helper to pretty print / format
the encoded string into a group of four (genes). Example:


``` ruby
# hexadecimal (base 16)
genome = 0x4a52931ce4085c14bdce014a0318846a0c808c60294a6314a34a1295b9ce  # kitty 1001

p Base32.fmt( Base32.encode( genome ))
#=> "aaaa 7885 22f2 agff 1661 7755 e979 2441 6667 7664 a9aa cfff"

genome = 0x000042d28390864842e7b9c900c6321086438c6098ca298c728867425cf6b1ac # kitty 1111

p Base32.fmt( Base32.encode( genome ))
#=> "9ca9 8557 a22f gffa 1444 5557 9f77 277b 6778 6348 9afg eded"
```


To be continued...
