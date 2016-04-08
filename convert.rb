#!/usr/bin/env ruby

require './screenshoot'

puts 'Starting conversion...'
input = 'test.png'
ScreenShoot.convert_image(input)
puts 'Conversion successful'
