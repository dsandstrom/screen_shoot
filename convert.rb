#!/usr/bin/env ruby

require './screenshoot'

puts 'Starting conversion...'

input = ARGV[0]
unless input
  puts 'Error: file required'
  exit
end

ScreenShoot.convert_image(input)
puts "\nConversion done"
