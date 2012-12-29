require 'markov/chars'

# Make random behavior predictable
srand(1)

describe Markov::Chars do
  let(:input_text) {
    File.read('input_examples/constitution.txt')
  }

  it "should be awesome" do
    chars = Markov::Chars.new(input_text)
    chars.populate_input_sequences(4)
    expect(chars.generate(50)).to eq('Coin, and Proceed of Vote; the Executives after of')
  end
end
