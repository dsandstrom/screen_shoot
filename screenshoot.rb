#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'

require 'mini_magick'

MiniMagick.logger.level = Logger::DEBUG

class ScreenShoot
  def self.convert_image(input)
    image = MiniMagick::Image.open(input)
    image.resize '1600x'
    image.format 'jpg'
    image.quality 80
    image.write 'output.jpg'
    puts "new dimensions: #{image.width}x#{image.height}"
  end
end
