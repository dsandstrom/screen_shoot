#!/usr/bin/env ruby

require './screenshoot'

puts 'Starting conversion...'

input = ARGV[0]
unless input
  puts 'Error: file required'
  exit
end

if File.file?(input)
  ScreenShoot.convert_image(input)
elsif File.directory?(input)
  ScreenShoot.convert_images(input)
end

puts "\nConversion done"
