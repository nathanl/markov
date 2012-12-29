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

    context "when built using longish phrases" do

      it "is unlikely to diverge from the original text" do
        srand(4)
        words = Markov::Words.new(input_text)
        words.populate_input_sequences(5)
        expect(words.generate(24)).to eq(
          "his eyes have all the seeming of a demon's that is dreaming, And the lamplight o'er him streaming throws his shadow on the floor;"
        )
      end

    end

    context "when built using very short phrases" do

      it "has mostly phrases from the input, but rearranged" do
        srand(4)
        words = Markov::Words.new(input_text)
        words.populate_input_sequences(2)
        expect(words.generate(29)).to eq(
          "his eyes have all the seeming of a demon's that is dreaming, And the only word there spoken was the whispered word, \"Lenore!\" This I sat engaged in guessing,"
        )
      end

    end

    context "when built a word at a time" do

      it "diverges wildly from the text" do
        srand(4)
        words = Markov::Words.new(input_text)
        words.populate_input_sequences(1)
        expect(words.generate(29)).to eq(
          "off my door!\" Quoth the Raven still the tempest and more than muttered, \"other friends have all the floor Shall be shorn and radiant maiden whom the bird or"
        )
      end

    end
  end

end
