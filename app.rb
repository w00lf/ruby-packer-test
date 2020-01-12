#! /usr/bin/env ruby
begin 
  require 'rubygems'
  # Currently application creates wrong LOAD_PATH consisting of paths withthout disk letter:
  # /__enclose_io_memfs__/lib/ruby...
  # TODO: Fix
  $LOAD_PATH.map! { |n| 'C:' + n }
  # Something is wrong with rubygems gems lookup, workaround to load deps directly
  FS_GEMS_DIR = "C:/__enclose_io_memfs__/lib/ruby/gems/2.4.0/gems"
  VENDOR_GEMS_DIR = "C:/__enclose_io_memfs__/local/vendor/bundle/ruby/2.4.0/gems"
  [FS_GEMS_DIR, VENDOR_GEMS_DIR].each do |folder|
    Dir.entries(folder).each do |dir|
      puts("Dir is #{dir}")
      lib_path = File.join(folder, dir, 'lib')
      puts("Addding #{lib_path}")
      $LOAD_PATH.unshift(lib_path)
    end
  end

  puts("Load path is:")
  puts($LOAD_PATH)
  puts("*" * 100)
  
  require 'bundler'
  # Try to load byebug.so directly - does not work
  require 'C:/__enclose_io_memfs__/local/vendor/bundle/ruby/2.4.0/gems/byebug-11.0.1/lib/byebug/byebug'
  require 'byebug'
  byebug
  # Bundler setup does not work either:
  #   C:/__enclose_io_memfs__/local/Gemfile not found
  # require 'bundler/setup'
  require 'openssl'
  require 'nokogiri'
  require 'open-uri'

  # Fetch and parse HTML document
  doc = Nokogiri::HTML(open('https://nokogiri.org/tutorials/installing_nokogiri.html'))

  puts "### Search for nodes by css"
  doc.css('nav ul.menu li a', 'article h2').each do |link|
    puts link.content
  end

  puts "### Search for nodes by xpath"
  doc.xpath('//nav//ul//li/a', '//article//h2').each do |link|
    puts link.content
  end

  puts "### Or mix and match."
  doc.search('nav ul.menu li a', '//article//h2').each do |link|
    puts link.content
  end
  
rescue Exception => e
  puts 'error'
  puts e.message
  e.backtrace.each(&method(:puts))
end