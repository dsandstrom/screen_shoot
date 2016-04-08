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
    directory = File.dirname(input)
    new_name = "#{name}.jpg"

    image = MiniMagick::Image.open(input)
    image.resize '1600x'
    image.format 'jpg'
    image.quality 80
    image.write File.join(directory, "#{name}.jpg")
    puts "Converted: #{image.width}x#{image.height}"
  end

  def self.convert_images(directory)
    puts "\nConverting all png files in #{File.basename(directory)}"
    Dir["#{directory}/*.png"].each do |file|
      ScreenShoot.convert_image(file)
    end
  end
end
