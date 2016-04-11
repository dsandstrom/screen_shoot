#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'

require 'mini_magick'
require 'image_optimizer'
require 'mozjpeg'
require 'filesize'

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

  def temp_name
    "#{base_name}.temp.jpg"
  end

  def temp_path
    File.join(directory, temp_name)
  end

  def valid?
    [directory, base_name].all? { |m| !m.nil? && !m.empty? }
  end

  def convert_to_jpg
    puts "\nStarting: #{base_name}"
    image = MiniMagick::Image.open(original_path)
    image.resize '1600x'
    image.format 'jpg'
    image.write temp_path
    puts "Converted: #{image.width}x#{image.height}"
  end

  def optimize
    unoptimized_size = pretty_file_size(temp_path)
    ImageOptimizer.new(temp_path, quiet: true).optimize
    temp_file = File.new(temp_path)
    FileUtils.cp(temp_path, new_path)
    new_file = File.new(new_path)
    Mozjpeg.compress(
      temp_file,
      new_file,
      arguments: '-quality 85 -quant-table 2 -notrellis'
    )
    optimized_size = pretty_file_size(new_path)
    FileUtils.rm(temp_path)
    puts "Optimized: #{unoptimized_size} => #{optimized_size}"
  end

  def convert_image
    return unless valid?

    convert_to_jpg
    optimize
  end

  def self.convert_images(directory)
    puts "\nConverting all png files in #{File.basename(directory)}"
    Dir["#{directory}/*.png"].each do |file|
      ScreenShoot.new(file).convert_image
    end
  end

  private

  def pretty_file_size(path)
    size = File.size(path)
    Filesize.from("#{size} B").pretty
  end
end
