require 'base32-alphabets'


genome = 0x4a52931ce4085c14bdce014a0318846a0c808c60294a6314a34a1295b9ce  # kitty 1001

genes_kai = Base32.encode( genome )
p genes_kai
#=> "aaaa788522f2agff16617755e979244166677664a9aacfff"

def kai_to_num( genes_kai )
  genes_num = []
  genes_kai.each_char do |gene|
    genes_num << Kai::NUMBER[gene]
  end
  genes_num
end

genes_num = kai_to_num( genes_kai )
p genes_num
# => [9, 9, 9, 9, 6, 7, 7, 4, 1, 1, 14, 1, 9, 15, 14, 14, 0, 5, 5, 0, 6, 6, 4, 4, 13, 8, 6, 8, 1, 3, 3, 0, 5, 5, 5, 6, 6, 5, 5, 3, 9, 8, 9, 9, 11, 14, 14, 14]
p genes_num.size
# => 48
p genes_num.reverse
# => [14, 14, 14, 11, 9, 9, 8, 9, 3, 5, 5, 6, 6, 5, 5, 5, 0, 3, 3, 1, 8, 6, 8, 13, 4, 4, 6, 6, 0, 5, 5, 0, 14, 14, 15, 9, 1, 14, 1, 1, 4, 7, 7, 6, 9, 9, 9, 9]
