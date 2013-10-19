$PROGRAM_NAME = 'Markov'
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')
require 'markov'

# Convenience functions for keyboard input
def get_input;   $stdin.gets.strip; end
def get_integer; get_input.to_i;    end
def integer_default(input, default)
  input = input.to_i
  input == 0 ? default : input
end

puts "Using the US Constitution as input"
text = File.read('input_examples/constitution.txt')

puts "Do you want new sequences of the original words or characters?"
until (type = gets).match(/(words|characters|chars)/i)
  puts "I'm sorry, I don't understand. Please type 'words' or 'characters'"
end

case type
when /words/
  puts "Generating new sequences of the original words"
  m = Markov::Words.new(text)

  default_context = 2
  puts "How many words to consider as context? (Default #{default_context})"
  context = get_integer
  m.populate_input_sequences(integer_default(context, default_context))

  default_wordcount = 200
  puts "How many words to generate? (Default #{default_wordcount})"
  wordcount = get_integer
  puts m.generate(integer_default(wordcount, default_wordcount))

when /characters|chars/
  puts "Generating new sequences of the original characters"
  m = Markov::Chars.new(text)

  default_context = 3
  puts "How many characters to consider as context? (Default #{default_context})"
  context = get_integer
  m.populate_input_sequences(integer_default(context, default_context))

  default_charcount = 1_000
  puts "How many characters to generate? (Default #{default_charcount})"
  charcount = get_integer
  puts m.generate(integer_default(charcount, default_charcount))
end
