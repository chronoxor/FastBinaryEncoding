require_relative '../proto/test'

puts Test::StructSimple.new.to_s
puts Test::StructOptional.new.to_s
puts Test::StructNested.new.to_s
