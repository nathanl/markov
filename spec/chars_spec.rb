require 'markov/chars'

describe Markov::Chars do

  describe "populating input sequences" do

    let(:input_text) { "abcabcabd" }
    let(:chars) { Markov::Chars.new(input_text) }
    srand(1)

    it "samples the input in the correct chunk size" do
      chars.populate_input_sequences(2)
      expect(chars.input_sequences.keys.all? {|key| key.length == 2}).to be_true
    end

    it "correctly counts the occurrences" do
      chars.populate_input_sequences(2)
      expect(chars.input_sequences).to eq({'ab'=>{'c'=>2, 'd'=>1}, 'bc'=>{'a'=>2}, 'ca'=>{'b'=>2}})
    end

  end

  describe "generated text" do

    let(:input_text) { File.read('input_examples/raven.txt') }
    srand(6)

    it "resembles the original" do
      chars = Markov::Chars.new(input_text)
      chars.populate_input_sequences(4)
      expect(chars.generate(29)).to eq('enchanted on the silken still')
    end

  end
end
