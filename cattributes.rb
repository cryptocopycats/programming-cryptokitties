require 'json'
require 'pp'

cattribute_totals = JSON.parse( File.read( './datasets/cattributes.json' ))
pp cattribute_totals


########################
## group by trait type

trait_types = {}

cattribute_totals.each do |h|
  key = h['type'].to_sym
  rec = trait_types[ key ] ||= [0,[]]

  rec[ 0 ] += h['total'].to_i   ## sum up totals
  rec[ 1 ] << [h['description'], h['total'].to_i]
end

pp trait_types


puts
puts "Trait Types:"
pp trait_types




require 'copycats'

buf = ""
buf << "# Cattributes Rarity / Popularity Statistics\n"
buf << "\n"
buf < "(Source: [`api.cryptokitties.co/cattributes` (JSON)](https://api.cryptokitties.co/cattributes))\n"
buf << "\n\n"


# quick hack - map copycats keys to (internal) cryptokitties trait type keys
#  note: all keys are the same except:
TRAIT_TYPE_MAPPINGS =
{
  :color1 => :colorprimary,
  :color2 => :colorsecondary,
  :color3 => :colortertiary
}


TRAITS.each do |key,h|
  next if key == :secret  ## skip secret (y gene) trait for now

  key = TRAIT_TYPE_MAPPINGS[ key ]  if TRAIT_TYPE_MAPPINGS[ key ]

  rec = trait_types[ key ]
  total = rec[0]
  items = rec[1]

  buf << "## #{h[:name]} (#{h[:code]})\n\n"

  buf << "_#{total} Cats with #{items.size} Cattributes_\n\n"

  buf << "| #|Total (%)|Cattribute|\n"
  buf << "|-:|--------:|----------|\n"

  # note: use reverse to order from most rare to most popular
  items.reverse.each_with_index do |item,i|

    name  = item[0]
    count = item[1]

    rank  = "#{i+1}/#{items.size}"

    percent = Float(100*count)/Float(total)

    buf << "| #{rank} | #{count} (#{('%2.2f' % percent)}) | "
    buf << "**#{name}** |"

    buf << "\n"
  end

  buf << "\n\n"
end

puts buf
