require_relative '../proto/test'

puts Test::StructSimple.new.to_json
puts
puts Test::StructOptional.new.to_json
puts
puts Test::StructNested.new.to_json
puts
