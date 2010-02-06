#!/usr/bin/ruby

require 'rubygems'
require 'bishop'

@classifier = Bishop::Bayes.new

def train_from_file(category, filename)
	file = File.open filename

	file.each do |line|
		@classifier.train category, line
	end

end

train_from_file "spam","spam_samples.txt"
train_from_file "normal","normal_samples.txt"

@classifier.save ARGV[0]
