$LOAD_PATH.unshift File.dirname(__FILE__)
require 'markov'

text = File.read('const.txt')

m = Markov::Chars.new(text)
m.populate_input_sequences(5)
# m.see_phrases_occurring(4)
puts m.generate(500)
