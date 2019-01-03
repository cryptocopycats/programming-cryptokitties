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
