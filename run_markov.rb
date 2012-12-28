$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')
puts $LOAD_PATH.first
require 'markov'

text = File.read('input_examples/constitution.txt')

m = Markov::Chars.new(text)
m.populate_input_sequences(5)
# m.see_phrases_occurring(4)
puts m.generate(500)
