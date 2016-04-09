#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'

require 'mini_magick'

class ScreenShoot
  attr_accessor :original_path, :directory, :original_name, :new_name, :new_path

  def initialize(input)
    self.original_path = input
    return unless File.exists?(original_path)

    self.directory = File.dirname(input)
    self.original_name = File.basename(input, '.*')
    self.new_name = "#{@original_name}.jpg"
    self.new_path = File.join(@directory, @new_name)
  end

  def valid?
    [directory, original_name, new_name, new_path].all? { |m| !!m }
  end

  def convert_image
    return unless valid?

    puts "\nStarting: #{original_name}"
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
