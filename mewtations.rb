## print mewtation pairs

(0..31).each do |n|
  if n.even?
    puts "#{n}+#{n+1} = #{n/2+16}"
  end
end


## print mewtation pairs (in kai)

require 'base32-alphabets'

(0..31).each do |n|
  if n.even?
    puts "#{Kai::ALPHABET[n]}+#{Kai::ALPHABET[n+1]} = #{Kai::ALPHABET[n/2+16]}"
  end
end
