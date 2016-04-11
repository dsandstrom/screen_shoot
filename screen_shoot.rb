#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'

require 'mini_magick'

# Convert PNG screenshots to web-friendly images
class ScreenShoot
  attr_accessor :original_path, :directory, :base_name

  def initialize(input)
    self.original_path = input
    return unless File.exist?(original_path)

    self.directory = File.dirname(input)
    self.base_name = File.basename(input, '.*')
  end

  def new_name
    "#{base_name}.jpg"
  end

  def new_path
    File.join(directory, new_name)
  end

  def valid?
    [directory, base_name].all? { |m| !m.nil? && !m.empty? }
  end

  def convert_image
    return unless valid?

    puts "\nStarting: #{base_name}"
    image = MiniMagick::Image.open(original_path)
    image.resize '1600x'
    image.format 'jpg'
    image.quality 80
    image.write new_path
    puts "Converted: #{image.width}x#{image.height}"
  end

  def self.convert_images(directory)
    puts "\nConverting all png files in #{File.basename(directory)}"
    Dir["#{directory}/*.png"].each do |file|
      ScreenShoot.new(file).convert_image
    end
  end
end
