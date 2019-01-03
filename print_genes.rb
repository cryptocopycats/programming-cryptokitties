require 'copycats'


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


puts "Kitty #1000:"
print_genes( 0x00004a52931ce4085c14bdce014a0318846a0c808c60294a6314a34a1295b9ce )  # kitty 1001

puts
puts "Kitty #1111:"
print_genes( 0x000042d28390864842e7b9c900c6321086438c6098ca298c728867425cf6b1ac ) # kitty 1111



## use "built-in" pretty printer

genome = Genome.new( 0x00004a52931ce4085c14bdce014a0318846a0c808c60294a6314a34a1295b9ce )
puts genome.build_tables    # outputs tables in text with markdown formatting
