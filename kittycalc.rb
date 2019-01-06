# encoding: utf-8

require 'copycats'

a = 0x00004a52931ce4085c14bdce014a0318846a0c808c60294a6314a34a1295b9ce  # kitty 1001
b = 0x000042d28390864842e7b9c900c6321086438c6098ca298c728867425cf6b1ac  # kitty 1111

agenes_kai = Base32.encode( a ).reverse # note: reverse string for easy array access
p agenes_kai
#=> "fffcaa9a466776661442979e55771661ffga2f225887aaaa"

bgenes_kai = Base32.encode( b ).reverse # note: reverse string for easy array access
p bgenes_kai
#=> "dedegfa984368776b77277f975554441affgf22a75589ac9"


ODDS_BABY_TRAITS = {}
ODDS_BABY_TRAITS[:body] ||= Hash.new(0)

####
# step 1) add odds for parent a
trait = TRAITS[:body][:kai][agenes_kai[0]]
ODDS_BABY_TRAITS[:body][trait] += 0.375      # primary (p) - add ragamuffin (37.5%)
pp ODDS_BABY_TRAITS
#=> {:body=>{"ragamuffin"=>0.375}}

trait = TRAITS[:body][:kai][agenes_kai[1]]
ODDS_BABY_TRAITS[:body][trait] += 0.09375    # hidden 1 (h1) - add ragamuffin (9.375%)
pp ODDS_BABY_TRAITS
#=> {:body=>{"ragamuffin"=>0.46875}}

trait = TRAITS[:body][:kai][agenes_kai[2]]
ODDS_BABY_TRAITS[:body][trait] += 0.0234375  # hidden 2 (h2) - add ragamuffin (2.34375%)
pp ODDS_BABY_TRAITS
#=> {:body=>{"ragamuffin"=>0.4921875}}

trait = TRAITS[:body][:kai][agenes_kai[3]]
ODDS_BABY_TRAITS[:body][trait] += 0.0078125  # hidden 3 (h3) - add himalayan (0.78125%)
pp ODDS_BABY_TRAITS
#=> {:body=>{"ragamuffin"=>0.4921875, "himalayan"=>0.0078125}}

####
# step 2) add odds for parent b
trait = TRAITS[:body][:kai][bgenes_kai[0]]
ODDS_BABY_TRAITS[:body][trait] += 0.375      # primary (p) - add munchkin (37.5%)
pp ODDS_BABY_TRAITS
#=> {:body=>{"ragamuffin"=>0.4921875, "himalayan"=>0.0078125, "munchkin"=>0.375}}

trait = TRAITS[:body][:kai][bgenes_kai[1]]
ODDS_BABY_TRAITS[:body][trait] += 0.09375    # hidden 1 (h1) - add sphynx (9.375%)
pp ODDS_BABY_TRAITS
#=> {:body=>{"ragamuffin"=>0.4921875, "himalayan"=>0.0078125, "munchkin"=>0.375, "sphynx"=>0.09375}}

trait = TRAITS[:body][:kai][bgenes_kai[2]]
ODDS_BABY_TRAITS[:body][trait] += 0.0234375  # hidden 2 (h2) - add munchkin (2.34375%)
pp ODDS_BABY_TRAITS
#=> {:body=>{"ragamuffin"=>0.4921875, "himalayan"=>0.0078125, "munchkin"=>0.3984375, "sphynx"=>0.09375}}

trait = TRAITS[:body][:kai][bgenes_kai[3]]
ODDS_BABY_TRAITS[:body][trait] += 0.0078125  # hidden 3 (h3) - add sphinx (0.78125%)
pp ODDS_BABY_TRAITS
#=> {:body=> {"ragamuffin"=>0.4921875, "himalayan"=>0.0078125, "munchkin"=>0.3984375, "sphynx"=>0.1015625}}

## sort
ODDS_BABY_TRAITS[:body] = ODDS_BABY_TRAITS[:body].to_a.sort { |l,r| r[1] <=> l[1] }
pp ODDS_BABY_TRAITS
#=> {:body=> [["ragamuffin", 0.4921875], ["munchkin", 0.3984375], ["sphynx", 0.1015625], ["himalayan", 0.0078125]]}




def kittycalc( a, b )
  agenes_kai = Base32.encode( a ).reverse # note: reverse string for easy array access
  bgenes_kai = Base32.encode( b ).reverse

  odds = {}

  TRAITS.each_with_index do |(trait_key, trait_hash),i|
     odds[trait_key] ||= Hash.new(0)

     offset = i*4
     [agenes_kai, bgenes_kai].each do |genes_kai|
       p_kai  = genes_kai[0+offset]
       h1_kai = genes_kai[1+offset]
       h2_kai = genes_kai[2+offset]
       h3_kai = genes_kai[3+offset]

       ## kai to trait name mapping (e.g. '1' => 'savannah', etc.)
       kai = trait_hash[:kai]
       p  = kai[p_kai]
       h1 = kai[h1_kai]
       h2 = kai[h2_kai]
       h3 = kai[h3_kai]

       ## use code (e.g. PU00, PU01, etc.) if trait is unnamed
       code = trait_hash[:code]
       p  = "#{code}%02d" % Kai::NUMBER[p_kai]   if p.nil?
       h1 = "#{code}%02d" % Kai::NUMBER[h1_kai]  if h1.nil?
       h2 = "#{code}%02d" % Kai::NUMBER[h2_kai]  if h2.nil?
       h3 = "#{code}%02d" % Kai::NUMBER[h3_kai]  if h3.nil?

       odds[trait_key][p]  += 0.375      # add primary (p) odds
       odds[trait_key][h1] += 0.09375    # add hidden 1 (h1) odds
       odds[trait_key][h2] += 0.0234375  # add hidden 2 (h2) odds
       odds[trait_key][h3] += 0.0078125  # add hidden 3 (h3) odds
     end

     ## sort by highest odds / probabilities first
     odds[trait_key] = odds[trait_key].to_a.sort { |l,r| r[1] <=> l[1] }
  end
  odds
end


odds = kittycalc( a, b )
puts "kittycalc odds:"
pp odds



def print_kittycalc_odds( odds )
  odds.each do |trait_key, recs|
    trait_hash = TRAITS[trait_key]

    puts "#{trait_hash[:name]} (#{trait_hash[:code]}) - Genes #{trait_hash[:genes]}:"
    recs.each do |rec|
      puts " #{'%5.2f'% (rec[1]*100)}% | #{rec[0]}"
    end
    puts
  end
end


print_kittycalc_odds( odds )
