require 'markov/chars'

# Make random behavior predictable
srand(1)

describe Markov::Chars do

  let(:input_text) { "abcabcabd" }

  describe "populating input sequences" do
    let(:chars) { Markov::Chars.new(input_text) }

    it "samples the input in the correct chunk size" do
      chars.populate_input_sequences(2)
      expect(chars.input_sequences.keys.all? {|key| key.length == 2}).to be_true
    end

    it "correctly counts the occurrences" do
      chars.populate_input_sequences(2)
      expect(chars.input_sequences).to eq({'ab'=>{'c'=>2, 'd'=>1}, 'bc'=>{'a'=>2}, 'ca'=>{'b'=>2}})
    end

  end

  describe "generating output" do

    let(:input_text) {
      File.read('input_examples/constitution.txt')
    }

    it "should be awesome" do
      chars = Markov::Chars.new(input_text)
      chars.populate_input_sequences(4)
      expect(chars.generate(50)).to eq('Coin, and Proceed of Vote; the Executives after of')
    end

  end
end
