require "filename_increment/version"
require 'pathname'

class FilenameIncrement
  class Error < StandardError; end

  class FileNotFound < IOError; end

  ORDINALS = %w[th st nd rd]

  attr_reader :path

  def initialize(filepath, options = {})
    @options = options

    @platform = @options[:platform] || Gem::Platform.local.os
    @file = parse(filepath)
    @start = @options[:start] || 1

    @file = parse(filepath)
    puts @file

    if @start == 1 && (@platform == 'win32' || @platform == 'windows')
      @start += 1
    end

    if @options[:fs].is_a? TrueClass
      if File.exist?(filepath)
        name = @file[:name]
        dest = filepath

        while File.exist?(dest)
          @start += 1
          @file[:basename] = format(name, @start) + @file[:extname]

          dest = File.join(@file[:dirname], @file[:basename])
        end
      else
        # raise error if file not found
        raise FileNotFound.new('File not found')
      end
    else
      @file[:basename] = format(@file[:name], @start) + @file[:extname]
    end

    @path = Pathname.new(@file[:dirname]).join(@file[:basename])
  end

  def to_s
    @path.cleanpath.to_s
  end

  private

  def parse(filepath)
    pathname = Pathname.new(filepath)

    path = {path: filepath}
    path[:dirname] = pathname.dirname
    path[:basename] = pathname.basename
    path[:name] = pathname.basename(pathname.extname)
    path[:extname] = pathname.extname

    path
  end

  def ordinal(number)
    raise TypeError.new('expected a number') unless number.is_a? Numeric

    ORDINALS[((number % 100) - 20) % 10] || ORDINALS[number % 100] || ORDINALS[0]
  end

  def to_ordinal(number)
    raise TypeError.new('expected a number') unless number.is_a? Numeric

    "#{number}#{ordinal(number)}"
  end

  def format(stem, number)
    case @platform
    when 'win32', 'windows'
      number > 1 ? "#{stem} (#{number})" : stem
    when 'linux'
      if number == 0
        stem
      elsif number == 1
        "#{stem} (copy)"
      elsif number == 2
        "#{stem} (another copy)"
      else
        "#{stem} (#{to_ordinal(number)} copy)"
      end
    when 'darwin'
      if number == 1
        "#{stem} copy"
      elsif number > 1
        "#{stem} (#{stem} copy #{number})"
      end
    else
      number > 1 ? "#{stem} (#{number})" : stem
    end
  end
end
