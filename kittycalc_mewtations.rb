# encoding: utf-8

require 'base32-alphabets'


###########################
require_relative './traits.rb'


a = 0x00004a52931ce4085c14bdce014a0318846a0c808c60294a6314a34a1295b9ce  # kitty 1001
b = 0x000042d28390864842e7b9c900c6321086438c6098ca298c728867425cf6b1ac  # kitty 1111





def kittycalc_mewtations( a, b )
  agenes_kai = Base32.encode( a ).reverse # note: reverse string for easy array access
  bgenes_kai = Base32.encode( b ).reverse

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

odds = kittycalc_mewtations( a, b )
pp odds



def print_kittycalc_mewtations_odds( odds )
  gene_names = ['p','h1','h2','h3']

  odds.each do |trait_key, recs|
    trait_hash = TRAITS[trait_key]

    next if recs.empty?   ## skip trait types with no mewtations

    puts "#{trait_hash[:name]} (#{trait_hash[:code]}) - #{recs.size} Mewtation Pair(s):"
    recs.each do |rec|
      a_kai = rec[1][0]
      b_kai = rec[1][1]
      m_kai = rec[2]

      a = trait_hash[:kai][a_kai]
      b = trait_hash[:kai][b_kai]
      m = trait_hash[:kai][m_kai]

      ## use code (e.g. PU00, PU01, etc.) if trait is unnamed
      code = trait_hash[:code]
      a = "#{code}%02d" % Kai::NUMBER[a_kai]  if a.nil?
      b = "#{code}%02d" % Kai::NUMBER[b_kai]  if b.nil?
      m = "#{code}%02d" % Kai::NUMBER[m_kai]  if m.nil?

      print " #{'%5.2f'% (rec[3]*100)}% | "
      print "%-18s" % "#{m}"
      print " | "
      print "%-5s" % "#{gene_names[rec[0][0]]}+#{gene_names[rec[0][1]]}"
      print " | "
      print "#{a}+#{b}"
      print "\n"
    end
    puts
  end
end

print_kittycalc_mewtations_odds( odds )
