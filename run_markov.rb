$PROGRAM_NAME = 'Markov'
$LOAD_PATH.unshift File.dirname(__FILE__)
require 'markov'

text = File.read('const.txt')

m = Markov.new(text)
m.populate_text_profile(5)
# m.see_phrases_occurring(4)
puts "how much to generate? Give me a number."
length = $stdin.gets.strip.to_i
puts m.generate(length)
