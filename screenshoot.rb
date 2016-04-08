#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'

require 'mini_magick'

# MiniMagick.logger.level = Logger::DEBUG

class ScreenShoot
  def self.convert_image(input)
    return unless File.exists?(input)

    name = File.basename(input, '.*')
    puts "\nStarting: #{name}"
    new_name = "#{name}.jpg"

    image = MiniMagick::Image.open(input)
    image.resize '1600x'
    image.format 'jpg'
    image.quality 80
    image.write "#{name}.jpg"
    puts "Converted: #{image.width}x#{image.height}"
  end
end
