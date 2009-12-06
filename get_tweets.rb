#!/usr/bin/ruby

require 'rubygems'
require 'twitter'
ARGV[0].split(',').each do |user|
  Twitter::Search.new.from(user).per_page(100).each do |tweet|
    puts tweet.text
  end
end