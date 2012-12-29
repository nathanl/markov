require 'markov/words'

describe Markov::Words do

  describe "populating input sequences" do

    let(:input_text) { 
      "Big cats eat rats. Small cats eat rats. All cats eat gnats."
    }
    let(:words) { Markov::Words.new(input_text) }
    srand(1)

    it "samples the input in the correct chunk size" do
      words.populate_input_sequences(2)
      expect(words.input_sequences.keys.all? {|key| key.split(' ').length == 2}).to be_true
    end

    it "correctly counts the occurrences" do
      words.populate_input_sequences(2)
      expect(words.input_sequences).to eq(
        {
          'Big cats' => {'eat'=>1}, 
          'cats eat' => {'rats.' => 2, 'gnats.' => 1},
          "eat rats."=>{"Small"=>1, "All"=>1},
          'rats. Small' => {'cats' => 1},
          'Small cats' => {'eat' => 1},
          'rats. All' => {'cats' => 1},
          'All cats' => {'eat' => 1}
        }
      )
    end
  end

  describe "generated text" do

    let(:input_text) { File.read('input_examples/raven.txt') }

    context "when produced from roughly word-size chunks" do

      it "has mostly real phrases, rearranged" do
        srand(1)
        words = Markov::Words.new(input_text)
        words.populate_input_sequences(4)
        expect(words.generate(29)).to eq('enchanted on the silken still')
      end

    end
  end

  describe "always forming sequences that occur in the input" do

    let(:input_text) { File.read('input_examples/constitution.txt') }

    it "doesn't screw up" do
      srand(3)
      words = Markov::Words.new(input_text)
      words.populate_input_sequences(4)
      expect{words.generate(29)}.not_to raise_error(Markov::MalformedSequenceError)
    end

  end
end
