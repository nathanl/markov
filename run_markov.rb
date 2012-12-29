$PROGRAM_NAME = 'Markov'
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')
require 'markov'

text = File.read('input_examples/constitution.txt')

m = Markov::Words.new(text)
m.populate_input_sequences(2)
# m.sequences_found_at_least_n_times(4)
puts "How many words to generate? (Default 200)"
length = $stdin.gets.strip.to_i
puts m.generate(length == 0 ? 200 : length)
