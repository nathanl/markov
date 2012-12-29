module Markov
  class Base
    attr_accessor :input, :chunk_size, :input_sequences

    def initialize(input)
      @input = input

      # Structure in which to store info about sequences in the source input.
      # Populated, it will have information like this:
      # {'ca' => {'t' => 1, 'b' => 2}}
      # This represents that we've seen "ca" three times: once followed by t,
      # and twice followed by b.
      # Initializing the hash like this makes it very smart: if we ever ask
      # about occurrences of "ca", it will go ahead and create it, like this:
      # {'ca' => {}}
      # That hash that IT points to has a default value of 0, so we can say:
      # input_sequences['ca']['n'] += 1
      # ... and be sure that it will work properly.
      @input_sequences = Hash.new {|hash, key| hash[key] = Hash.new(0) }
    end

    def generate(desired_length = 20)
      output_text = ''
      chunk_size = input_sequences.keys.first.length

      # Seed the output text with a random choice of our sequences
      output_text << random_input_sequence

      while output_text.length < desired_length

        sequence = output_text[-chunk_size..-1]
        new_text = proportional_sample(input_sequences[sequence])

        # If no luck, pick a random sequence
        if new_text.empty?
          new_text = random_input_sequence
        end

        # Whatever we came up with, tack it onto the output
        output_text << new_text
      end
      output_text
    end

    def see_phrases_occurring(n = 2)
      input_sequences.select {|k, v| v.length > n }.sort_by{|k, v| 0 - v.length }.each do |k,v|
        puts "#{k} : #{v.length}"
      end
      return true
    end

    private

    def random_input_sequence
      input_sequences.keys.sample
    end

    # Given a hash where the values indicate occurrences
    # of the key, choose a random key based on its proportion
    # of the total occurrences
    # Eg: 
    # {:foo => 20, :bar => 20}     # each should have a 50% chance
    # {:foo => 2, :bar => 18}      #  bar should have a 90% chance
    def proportional_sample(hash)
      sum = hash.reduce(0) {|total, tuple| total + tuple[1]} 
      roll = rand(sum)

      total = 0
      hash.each do |key, value|
        total += value
        return key if total > roll
      end
    end

  end
end
