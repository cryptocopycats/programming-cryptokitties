# encoding: utf-8

####################################################################
# cryptokitties (offspring) breeding calculator (incl. mewtations)
#  - 100% accurate :-) - uses the mixgenes probabilities and formula [1]
#
#  use like
#
#    pp kittycalc( a, b )   ## pretty print (pp) "raw" odds
#
#  -or-
#
#    print_kittycalc_odds( kittycalc( a, b ) )  ## print "human" readable odds
#
#
#  note: for a detailed step-by-step write-up and code walkthrough
#   see the "Build Your Own CryptoKitties Breeding (Offspring) Calculator" chapter [2]
#   in the free online book titled "Programming Crypto Collectibles Step-by-Step Book / Guide"
#
# [1]: https://github.com/cryptocopycats/programming-cryptocollectibles/blob/master/mixgenes.rb
# [2]: https://github.com/cryptocopycats/programming-cryptocollectibles#build-your-own-cryptokitties-breeding-offspring-calculator


require 'copycats'


a = 0x00004a52931ce4085c14bdce014a0318846a0c808c60294a6314a34a1295b9ce  # kitty 1001
b = 0x000042d28390864842e7b9c900c6321086438c6098ca298c728867425cf6b1ac  # kitty 1111


def kittycalc( a, b )
  agenes_kai = Base32.encode( a ).reverse # note: reverse string for easy array access
  bgenes_kai = Base32.encode( b ).reverse

  odds            = kittycalc_step1( agenes_kai, bgenes_kai )
  odds_mewtations = kittycalc_mewtations( agenes_kai, bgenes_kai )

  ## update odds with mewtations
  odds_mewtations.each do |trait_key, recs|
    next if recs.empty?   ## skip trait types with no mewtations

    recs.each do |rec|
      a_kai          = rec[1][0]
      b_kai          = rec[1][1]
      m_kai          = rec[2]
      odds_mewtation = rec[3]

      odds[trait_key][m_kai] += odds_mewtation
      odds[trait_key][a_kai] -= odds_mewtation / 2.0
      odds[trait_key][b_kai] -= odds_mewtation / 2.0
    end
  end

  ## map kai to trait name
  ## sort by highest odds / probabilities first
  odds.each do |trait_key, hash|
    recs = odds[trait_key].to_a
    recs = recs.map do |rec|
       name = TRAITS[trait_key][:kai][rec[0]]
       ## note: use code (e.g. PU00, PU01, etc.) if trait is unnamed
       code = TRAITS[trait_key][:code]
       name = "#{code}%02d" % Kai::NUMBER[rec[0]]  if name.nil?
       [name,rec[1]]
    end
    recs = recs.sort { |l,r| r[1] <=> l[1] }
    odds[trait_key] = recs
  end

  odds
end


def kittycalc_step1( agenes_kai, bgenes_kai )
  odds = {}

  TRAITS.each_with_index do |(trait_key, trait_hash),i|
     odds[trait_key] ||= Hash.new(0)

     offset = i*4
     [agenes_kai, bgenes_kai].each do |genes_kai|
       p_kai  = genes_kai[0+offset]
       h1_kai = genes_kai[1+offset]
       h2_kai = genes_kai[2+offset]
       h3_kai = genes_kai[3+offset]

       odds[trait_key][p_kai]  += 0.375      # add primary (p) odds
       odds[trait_key][h1_kai] += 0.09375    # add hidden 1 (h1) odds
       odds[trait_key][h2_kai] += 0.0234375  # add hidden 2 (h2) odds
       odds[trait_key][h3_kai] += 0.0078125  # add hidden 3 (h3) odds
     end
  end
  odds
end


def kittycalc_mewtations( agenes_kai, bgenes_kai )
  odds = {}

  #########
  #  4x4 = 16 gene pairs
  #   0 = primary (p)     - 0.75
  #   1 = hidden 1 (h1)   - 0.1875
  #   2 = hidden 2 (h2)   - 0.046875
  #   3 = hidden 3 (h3)   - 0.015625
  pairs = [[0,0],[0,1],[0,2],[0,3],
           [1,0],[1,1],[1,2],[1,3],
           [2,0],[2,1],[2,2],[2,3],
           [3,0],[3,1],[3,2],[3,3]]
  odds_genes = [0.75, 0.1875, 0.046875, 0.015625]

  TRAITS.each_with_index do |(trait_key, trait_hash),i|
    odds[trait_key] ||= []

    offset = i*4
    pairs.each do |pair|
      a_kai = agenes_kai[pair[0]+offset]
      b_kai = bgenes_kai[pair[1]+offset]

      gene1 = Kai::NUMBER[a_kai]  ## convert kai to integer number
      gene2 = Kai::NUMBER[b_kai]

      ## note: mutation code copied from mixgenes formula
      if gene1 > gene2
        gene1, gene2 = gene2, gene1
      end
      if (gene2 - gene1) == 1 && gene1.even?  ## bingo! mewtation pair
        probability = 0.25
        if gene1 > 23
          probability /= 2
        end
        mutation  = (gene1 / 2) + 16

        odds_pair = odds_genes[pair[0]] * odds_genes[pair[1]] * probability

        odds[trait_key] << [pair,
                            [Kai::ALPHABET[gene1], Kai::ALPHABET[gene2]],
                            Kai::ALPHABET[mutation],
                            odds_pair]
      end
    end
    odds[trait_key] = odds[trait_key].sort { |l,r| r[3] <=> l[3] }
  end
  odds
end


odds = kittycalc( a, b )
pp odds


def check_odds( odds )
  odds.each do |trait_key,recs|
    total = recs.reduce(0) {|sum,rec| sum+=rec[1]; sum}
    puts "#{trait_key}: #{total}"
  end
end

check_odds( odds )


def print_kittycalc_odds( odds )
  odds.each do |trait_key, recs|
    trait_hash = TRAITS[trait_key]

    puts "#{trait_hash[:name]} (#{trait_hash[:code]}):"
    recs.each do |rec|
      puts " #{'%5.2f'% (rec[1]*100)}% | #{rec[0]}"
    end
    puts
  end
end

print_kittycalc_odds( odds )

###
# results in:
#
# Fur (FU):
#  49.22% | ragamuffin
#  39.84% | munchkin
#  10.16% | sphynx
#   0.78% | himalayan
#
# Pattern (PA):
#  49.79% | luckystripe
#  37.50% | totesbasic
#   9.38% | totesbasic
#   2.91% | calicool
#   0.43% | tigerpunk
#
# Eye Color (EC):
#  46.44% | mintgreen
#  37.35% | strawberry
#  12.50% | sizzurp
#   1.90% | topaz
#   0.88% | limegreen
#   0.63% | chestnut
#   0.29% | bubblegum
#
# Eye Shape (ES):
#  42.19% | crazy
#  30.47% | thicccbrowz
#  14.06% | raisedbrow
#  13.28% | simple
#
# Base Color (BC):
#  37.50% | greymatter
#  37.35% | shadowgrey
#  11.72% | aquamarine
#  11.72% | orangesoda
#   1.42% | salmon
#   0.29% | cloudwhite
#
# Highlight Color (HC):
#  56.25% | royalpurple
#  40.62% | swampgreen
#   2.34% | chocolate
#   0.78% | lemonade
#
# Accent Color (AC):
#  59.38% | granitegrey
#  40.62% | kittencream
#
# Mouth (MO):
#  58.27% | happygokitty
#  38.28% | pouty
#   2.80% | soserious
#   0.64% | tongue
