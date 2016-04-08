#!/usr/bin/env ruby

require './screenshoot'

puts 'Starting conversion...'

input = ARGV[0]
unless input
  puts 'Error: file required'
  exit
end

screen_shoot = ScreenShoot.new
if File.file?(input)
  screen_shoot.convert_image(input)
elsif File.directory?(input)
  screen_shoot.convert_images(input)
end

puts "\nConversion done"
