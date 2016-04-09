#!/usr/bin/env ruby

require './screenshoot'

puts 'Starting conversion...'

input = ARGV[0]
unless input
  puts 'Error: file or folder required'
  exit
end

if File.file?(input)
  ScreenShoot.new(input).convert_image
elsif File.directory?(input)
  ScreenShoot.convert_images(input)
else
  puts "\nError: no files found"
end

puts "\nConversion done"
