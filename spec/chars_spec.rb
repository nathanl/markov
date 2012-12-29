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

    context "when produced from roughly word-size chunks" do

      it "has mostly real words, rearranged" do
        srand(6)
        chars = Markov::Chars.new(input_text)
        chars.populate_input_sequences(4)
        expect(chars.generate(29)).to eq('enchanted on the silken still')
      end

    end

    context "when produced from smaller chunks" do

      it "contains nonsense words that resemble the original ones" do
        srand(1)
        chars = Markov::Chars.new(input_text)
        chars.populate_input_sequences(3)
        expect(chars.generate(42)).to eq(' Doubtle my chamber his I hat my bothing, ')
      end

    end

    context "when produced from even smaller chunks" do

      it "bears an even looser resemblance to the original" do
        srand(15)
        chars = Markov::Chars.new(input_text)
        chars.populate_input_sequences(2)
        expect(chars.generate(68)).to eq("Hophinget soudden my sping, prom the all bacif frong o'er, Thispourd")
      end

    end

  end
end
