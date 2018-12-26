require 'copycats'


pp TRAITS

#=> {:body=>
#  {:genes=>"0-3",
#   :name=>"Fur",
#   :code=>"FU",
#   :kai=>
#    {"1"=>"savannah",
#     "2"=>"selkirk",
#     "3"=>"chantilly",
# ...
#  }}


# hexadecimal (base 16)
genome = 0x4a52931ce4085c14bdce014a0318846a0c808c60294a6314a34a1295b9ce  # kitty 1001

genes_kai = Base32.encode( genome )
p genes_kai
# => "aaaa788522f2agff16617755e979244166677664a9aacfff"
genes_kai = genes_kai.reverse    # for easy array access reverse string
p genes_kai
# => "fffcaa9a466776661442979e55771661ffga2f225887aaaa"

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

## ...
