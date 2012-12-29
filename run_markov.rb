$PROGRAM_NAME = 'Markov'
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')
require 'markov'

text = File.read('input_examples/constitution.txt')

m = Markov::Chars.new(text)
m.populate_input_sequences(5)
# m.see_phrases_occurring(4)
puts "How many characters to generate? (Default 200)"
length = $stdin.gets.strip.to_i
puts m.generate(length == 0 ? 200 : length)
