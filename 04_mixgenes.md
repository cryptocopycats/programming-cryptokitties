# Inside Breeding - Matron + Sire = New (Offspring) Kitty - All About Gene Swapping, Inheritance & Mewtations


CryptoKitties lets you breed new kitties.
Pick a matron and a sire and
a new bun is in the oven.

Now how does the "magic" mixing of genes work?
What genes do new (offspring) kitties inherit from parents?
What about mewtations, that is, new traits not present in a matron or sire?


The bad news is all CryptoKitties contracts are open source
EXCEPT the "magic" sooper-sekret gene mixing operation formula in the GeneSciene contract.
You can find the byte code in the contract at
[`etherscan.io/address/0xf97e0a5b616dffc913e72455fde9ea8bbe946a2b#code`](https://etherscan.io/address/0xf97e0a5b616dffc913e72455fde9ea8bbe946a2b#code).
If you click on "Switch to Opcode" you will see
an almost endless stream of to-the-metal stack machine byte code
instructions:

```
PUSH1 0x60
PUSH1 0x40
MSTORE
PUSH1 0x04
CALLDATASIZE
LT
PUSH2 0x006c
JUMPI
PUSH4 0xffffffff
PUSH29 0x0100000000000000000000000000000000000000000000000000000000
PUSH1 0x00
CALLDATALOAD
DIV
AND
PUSH4 0x0d9f5aed
DUP2
EQ
PUSH2 0x0071
JUMPI
DUP1
PUSH4 0x1597ee44
EQ
PUSH2 0x009f
JUMPI
DUP1
PUSH4 0x54c15b82
...
```

Now the good news -
thanks to Sean Soria's reverse engineering work - see the article "[CryptoKitties mixGenes Function (December 2017)](https://medium.com/@sean.soria/cryptokitties-mixgenes-function-69207883fc80)" -
the code is now "cracked" and an open book.
Let's look at the `mixGenes` function in pseudocode:

```
def mixGenes(mGenes[48], sGenes[48], babyGenes[48]):

  # PARENT GENE SWAPPING
  for (i = 0; i < 12; i++):
    index = 4 * i
    for (j = 3; j > 0; j--):
      if random() < 0.25:
        swap(mGenes, index+j, index+j-1)
      if random() < 0.25:
        swap(sGenes, index+j, index+j-1)

  # BABY GENES
  for (i = 0; i < 48; i++):
    mutation = 0
    # CHECK MUTATION
    if i % 4 == 0:
      gene1 = mGenes[i]
      gene2 = sGenes[i]
      if gene1 > gene2:
        gene1, gene2 = gene2, gene1
      if (gene2 - gene1) == 1 and iseven(gene1):
        probability = 0.25
        if gene1 > 23:
          probability /= 2
        if random() < probability:
          mutation = (gene1 / 2) + 16

    # GIVE BABY GENES
    if mutation:
      babyGenes[i] = mutation
    else:
      if random() < 0.5:
        babyGenes[i] = mGenes[i]
      else:
        babyGenes[i] = sGenes[i]
```

Yes, that's better.
Let's turn the pseudocode
into working code that you can run at your very own computer off the (block)chain
with a vanilla scripting language.


First, let's prepare the two input parameters, that is,
`mGenes[48]` - the matron's 48 genes
and `sGenes[48]` - the sire's 48 genes.

``` ruby
require 'base32-alphabets'


genome = 0x00004a52931ce4085c14bdce014a0318846a0c808c60294a6314a34a1295b9ce  # kitty 1001

genes_kai = Base32.encode( genome )
p genes_kai
#=> "aaaa788522f2agff16617755e979244166677664a9aacfff"

genes_num = Base32.bytes( genome )
p genes_num
#=> [9, 9, 9, 9, 6, 7, 7, 4, 1, 1, 14, 1, 9, 15, 14, 14, 0, 5, 5, 0, 6, 6, 4, 4, 13, 8, 6, 8, 1, 3, 3, 0, 5, 5, 5, 6, 6, 5, 5, 3, 9, 8, 9, 9, 11, 14, 14, 14]
p genes_num.size
#=> 48
p genes_num.reverse
#=> [14, 14, 14, 11, 9, 9, 8, 9, 3, 5, 5, 6, 6, 5, 5, 5, 0, 3, 3, 1, 8, 6, 8, 13, 4, 4, 6, 6, 0, 5, 5, 0, 14, 14, 15, 9, 1, 14, 1, 1, 4, 7, 7, 6, 9, 9, 9, 9]
```

To get  the matron's 48 genes
or the sire's 48 genes
let's convert the genome using `Base32.bytes` to 5-bit chunks
and than convert every gene (that is, 5-bit chunk)
to an integer number
to get an array of 48 genes e.g.
`[9, 9, 9, 9, 6, 7, 7, 4, 1, 1, 14, 1, 9, 15, 14, 14, 0, 5, 5, 0, 6, 6, 4, 4, 13, 8, 6, 8, 1, 3, 3, 0, 5, 5, 5, 6, 6, 5, 5, 3, 9, 8, 9, 9, 11, 14, 14, 14]`.
Note, the `mixGenes`
function expects the primary genes first, followed by the hidden 1, hidden 2, and
so forth, thus, let's use `reverse` resulting in:
`[14, 14, 14, 11, 9, 9, 8, 9, 3, 5, 5, 6, 6, 5, 5, 5, 0, 3, 3, 1, 8, 6, 8, 13, 4, 4, 6, 6, 0, 5, 5, 0, 14, 14, 15, 9, 1, 14, 1, 1, 4, 7, 7, 6, 9, 9, 9, 9]`


Ready to go! Let's breed a new kitten:

``` ruby
def mixgenes( mgenes, sgenes )  ## returns babygenes
  babygenes = []

  # PARENT GENE SWAPPING
  for i in 0.step(11,1) do ## loop from 0 to 11    # for(i = 0; i < 12; i++)
    index = 4 * i                                  #    index = 4 * i
    for j in 3.step(1,-1) do  ## loop from 3 to 1  #   for (j = 3; j > 0; j--)
      if rand() < 0.25                             #     if random() < 0.25:
        mgenes[index+j-1], mgenes[index+j] =       #       swap(mGenes, index+j, index+j-1)
        mgenes[index+j],   mgenes[index+j-1]
      end
      if rand() < 0.25                             #     if random() < 0.25:
        sgenes[index+j-1], sgenes[index+j] =       #        swap(sGenes, index+j, index+j-1)
        sgenes[index+j],   sgenes[index+j-1]
      end
    end
  end

  # BABY GENES
  for i in 0.step(47,1) do ## loop from 0 to 47    #  for (i = 0; i < 48; i++):
    mutation = nil                                 #    mutation = 0
    # CHECK MUTATION
    if i % 4 == 0                                  #    if i % 4 == 0:
      gene1 = mgenes[i]                            #      gene1 = mGenes[i]
      gene2 = sgenes[i]                            #      gene2 = sGenes[i]
      if gene1 > gene2                             #      if gene1 > gene2:
         gene1, gene2 = gene2, gene1               #        gene1, gene2 = gene2, gene1
      end
      if (gene2 - gene1) == 1 && gene1.even?       #     if (gene2 - gene1) == 1 and iseven(gene1):
        probability = 0.25                         #        probability = 0.25
        if gene1 > 23                              #        if gene1 > 23:
          probability /= 2                         #          probability /= 2
        end
        if rand() < probability                    #        if random() < probability:
          mutation = (gene1 / 2) + 16              #          mutation = (gene1 / 2) + 16
        end
      end
    end
    # GIVE BABY GENES
    if mutation                                    #    if mutation:
      babygenes[i] = mutation                      #      babyGenes[i] = mutation
    else                                           #    else:
      if rand() < 0.5                              #      if random() < 0.5:
        babygenes[i] = mgenes[i]                   #        babyGenes[i] = mGenes[i]
      else                                         #      else:
        babygenes[i] = sgenes[i]                   #        babyGenes[i] = sGenes[i]
      end
    end
  end

  babygenes   # return bagygenes
end # mixgenes
```


![](i/cryptokitties-genes-ii.png)



Let's try the
"magic" sooper-sekret gene mixing operation formula
with a matron and a sire:

``` ruby
mgenome = 0x000063169218f348dc640d171b000208934b5a90189038cb3084624a50f7316c
sgenome = 0x00005a13429085339c6521ef0300011c82438c628cc431a63298e3721f772d29

mgenes = Base32.bytes( mgenome ).reverse
sgenes = Base32.bytes( sgenome ).reverse
p mgenes
#=> [12, 11, 12, 14, 15, 8, 9, 9, 2, 3, 1, 1, 19, 5, 3, 7, 16, 4, 6, 0, 9, 13, 13, 9, 19, 4, 2, 4, 0, 0, 12, 3, 23, 8, 3, 8, 6, 14, 3, 9, 19, 7, 6, 4, 9, 11, 12, 12]
p sgenes
#=> [9, 9, 11, 14, 23, 15, 8, 14, 3, 7, 6, 5, 3, 19, 6, 6, 4, 6, 3, 5, 6, 6, 14, 8, 2, 4, 7, 2, 0, 0, 12, 0, 15, 15, 8, 10, 6, 14, 14, 6, 5, 4, 4, 5, 20, 9, 8, 11]


babygenes1 = mixgenes( mgenes, sgenes )
p babygenes1
#=> [9, 9, 11, 14, 23, 8, 9, 14, 3, 3, 5, 1, 3, 19, 3, 7, 16, 4, 6, 5, 9, 6, 14, 8, 19, 4, 2, 4, 0, 0, 12, 3, 23, 15, 8, 10, 6, 14, 3, 9, 19, 5, 6, 5, 20, 9, 11, 8]
babygenes2 = mixgenes( mgenes, sgenes )
p babygenes2
#=> [12, 9, 11, 11, 15, 23, 9, 9, 5, 2, 3, 6, 3, 19, 5, 6, 4, 4, 3, 5, 9, 6, 13, 9, 19, 4, 7, 4, 0, 0, 12, 12, 15, 3, 8, 10, 6, 3, 14, 9, 19, 5, 5, 4, 9, 9, 11, 8]
babygenes3 = mixgenes( mgenes, sgenes )
p babygenes3
#=> [12, 12, 14, 11, 15, 23, 8, 14, 3, 1, 3, 1, 19, 3, 7, 6, 16, 5, 6, 3, 6, 6, 13, 9, 19, 4, 2, 4, 0, 0, 0, 12, 23, 3, 8, 8, 6, 6, 14, 14, 4, 19, 6, 7, 9, 12, 9, 11]
```

Note: Every time you call mixgenes
with the same matron and sire genes
you will get DIFFERENT offspring genes.
That's the fun casino gambling / lottery part!

The source of the randomness is - surprise, surprise -
the `rand()` function
that returns a rand(om) lottery number between 0.0 and 0.99 on every call
e.g.

``` ruby
p rand()
#=> 0.6964691855978616
p rand()
#=> 0.28613933495037946
p rand()
#=> 0.2268514535642031
```

You can calculate / read the odds / probabilities:

- `rand() < 0.5` means a 50% probability
- `rand() < 0.25`  means a 25% probability
- `rand() < 0.25 /= 2` means a 12.5% probability (0.25 / 2 = 0.125)


Before summing up the offspring odds / probabilities
in full glory
let's wrap up the mixgenes call
and convert the genes back into (base32) kai.

``` ruby
babygenes1_kai = Base32.encode( babygenes1.reverse )
p babygenes1_kai
#=> "9cam676ka4f7b9gp4d11535k9f7a675h84k42644fa9pfcaa"

babygenes2_kai = Base32.encode( babygenes2.reverse )
p babygenes2_kai
#=> "9caa566kaf47b94gdd11585kae7a645576k47436aapgccad"

babygenes3_kai = Base32.encode( babygenes3.reverse )
p babygenes3_kai
#=> "cada87k5ff77994pd111535kae77476h784k2424f9pgcfdd"
```

Voila! Now you can lookup the traits using a chart
or use a gene reader (see above). Let's try:

``` ruby
print_genes( babygenes1.reverse )
```

resulting in:

```
Fur (FU) - Genes 0-3:
 0 | cymric
 1 | cymric
 2 | himalayan
 3 | ragamuffin

Pattern (PA) - Genes 4-7:
 4 | totesbasic
 5 | calicool
 6 | luckystripe
 7 | totesbasic

Eye Color (EC) - Genes 8-11:
 8 | mintgreen
 9 | mintgreen
10 | sizzurp
11 | gold

Eye Shape (ES) - Genes 12-15:
12 | googly
13 | raisedbrow
14 | googly
15 | thicccbrowz

Base Color (BC) - Genes 16-19:
16 | cloudwhite
17 | cottoncandy
18 | aquamarine
19 | mauveover

Highlight Color (HC) - Genes 20-23:
20 | violet
21 | royalpurple
22 | chocolate
23 | swampgreen

Accent Color (AC) - Genes 24-27:
24 | bloodred
25 | granitegrey
26 | peach
27 | granitegrey

Mouth (MO) - Genes 32-35:
32 | tongue
33 | soserious
34 | beard
35 | saycheese
```


Let's sum up the mixgenes offspring odds / probabilities.
What are the chances of getting a gene passed along from
a matron or sire? Let's call them parent A or B.

There's a 50% / 50% chance
of getting the gene from parent A or B.

Now the (random lottery) fun starts.
The mixgenes function swaps the genes (h3 <-> h2, h2 <-> h1, h1 <-> p)
starting at the 3rd hidden (h3) gene up to the primary (p) gene
and the chance for any of the three swaps
to happen are 25% (or 75% to NOT happen).
Resulting in:

- 75%  (0.75) chance of getting the primary (p) gene from parent A or B
- 18.75% (0.75 * 0.25  or 75 / 4) chance of getting the 1st hidden (h1) gene from A or B
- 4.6875% (0.75 * 0.25 * 0.25 or 75 / 4^2) chance of getting the 2nd hidden (h2) gene from A or B
- 1.5625% (0.25 * 0.25 * 0.25  or 100 / 4^3) chance of getting the 3rd hidden (h3) gene from A or B

Note: The chances of 75% + 18.75% + 4.6875% + 1.5625% for the genes (p, h1, h2, h3)
add up to 100%. Bingo! Let's calculate to (double) check:

``` ruby
p     = 0.75
h1    = 0.75 * 0.25
h2    = 0.75 * 0.25 * 0.25
h3    = 0.25 * 0.25 * 0.25
total = p + h1 + h2 + h3

puts "p=#{p}, h1=#{h1}, h2=#{h2}, h3=#{h3}, total=#{total}"
#=> p=0.75, h1=0.1875, h2=0.046875, h3=0.015625, total=1.0
```

Resulting in:

| Matron Gene | Matron % to Pass   | Sire Gene | Sire % to Pass      |
|-------------|-------------------:|-----------|--------------------:|
| p           | 37.5%              | p         | 37.5%               |
| h1          |  9.375% or ~9.4%   | h1        |  9.375% or ~9.4%    |
| h2          |  2.34375% or ~2.3% | h2        |  2.34375% or ~2.3%  |
| h3          |  0.78125% or ~0.8% | h3        |  0.78125% or ~0.8%  |
| total       | 50%                | total     | 50%                 |

Compare with the official CryptoKitties probabilities matrix:

![](i/mixgenes-probabilities-matrix.png)

(Source: [`guide.cryptokitties.co/guide/cat-features/genes`](https://guide.cryptokitties.co/guide/cat-features/genes))

Bingo! The odds / probabilities match up.
Let's celebrate with a distribution curve chart -
a picture is worth a thousand words, isn't it?

![](i/mixgenes-probabilities-curve.png)



What about mewtations?

There's a 25% chance of getting a mutation for tier I & II
and a 12.5% chance for tier III & IIII
but only given A & B contain the right gene mutation pairs.
The "magic" line / condition in mixgenes
reads `if (gene2 - gene1) == 1 && gene1.even?`

In plain english with genes in
"raw" integer numbers the "magic" gene mutation pairs are:

| Tier I  (16-23) | Tier II (24-27) | Tier III (28,29) | Tier IIII (30) |
|-------------|---------------|--------------|-------------|
| 0+1 => 16   |  16+17 => 24  | 24+25 => 28  | 28+29 => 30 |  
| 2+3 => 17   |  18+19 => 25  | 26+27 => 29  |             |
| 4+5 => 18   |  20+21 => 26  |              |             |
| 6+7 => 19   |  22+23 => 27  |              |             |
| 8+9 => 20   |               |              |             |
| 10+11 => 21 |               |              |             |
| 12+13 => 22 |               |              |             |
| 14+15 => 23 |               |              |             |

The "magic" calculation formula in mixgenes reads
`mutation = (gene1/2)+16`. Let's try some calculations
`gene1 = 0; (0/2)+16 => 16` and `gene1 = 2; (2/2)+16 => 17`
and `gene1 = 4; (4/2)+16 => 18` and so on and so forth until `gene1 = 28; (28/2)+16 => 30`.
Note: It's impossible for a mutation to reach `31` with the mixgenes formula e.g.`30+31 = 31`
because to mutate to the new never-before-seen `31` you need `31` itself.

Let's try a loop with `n+(n+1) = n/2+16` if `n` is an even number (e.g. `0`, `2`, `4`, `6`, ...)
to print all mewtation pairs:

``` ruby
(0..31).each do |n|
  if n.even?
    puts "#{n}+#{n+1} = #{n/2+16}"
  end
end
```

Resulting in:

```
 0+1  = 16
 2+3  = 17
 4+5  = 18
 6+7  = 19
 8+9  = 20
10+11 = 21
12+13 = 22
14+15 = 23
16+17 = 24
18+19 = 25
20+21 = 26
22+23 = 27
24+25 = 28
26+27 = 29
28+29 = 30
30+31 = 31
```


The same gene mutation pairs chart in (base32) kai reads:               

| Tier I (h-p) |  Tier II  (q-t)  |  Tier III (u,v) |  Tier IIII (w)  |
|----------|------------|-----------|-------------|
| 1+2 => h |  h+i => q  | q+r => u  | u+v => w    |  
| 3+4 => i |  j+k => r  | s+t => v  |             |
| 5+6 => j |  m+n => s  |           |             |
| 7+8 => k |  o+p => t  |           |             |
| 9+a => m |            |           |             |
| b+c => n |            |           |             |
| d+e => o |            |           |             |
| f+g => p |            |           |             |

Note: It's impossible for a mutation to reach `x` with the mixgenes formula e.g. `w+x = x`.

``` ruby
require 'base32-alphabets'

(0..31).each do |n|
  if n.even?
    puts "#{Kai::ALPHABET[n]}+#{Kai::ALPHABET[n+1]} = #{Kai::ALPHABET[n/2+16]}"
  end
end
```

Resulting in:

```
1+2 = h
3+4 = i
5+6 = j
7+8 = k
9+a = m
b+c = n
d+e = o
f+g = p
h+i = q
j+k = r
m+n = s
o+p = t
q+r = u
s+t = v
u+v = w
w+x = x
```


To sum up - there are 15 possible mutation pairs in four (I, II, III, IIII) tiers / levels:

| Tier                      | Count | Total |
|---------------------------|------:|------:|
| Basic Traits              |    16 |    16 |
| Tier I Mewtations (M1)    |     8 |    24 |
| Tier II Mewtations (M2)   |     4 |    28 |
| Tier III Mewtations (M3)  |     2 |    30 |
| Tier IIII Mewtations (M4) |     1 |    31 |
| "Magic" Trait (*)         |     1 |    32 |

(*): Note: It's impossible for a mutation to reach the "magic" trait with the mixgenes formula.
