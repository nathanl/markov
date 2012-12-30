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

    # TODO - DRY up and make clearer
    def generate(desired_length = 20)
      chain = []
      # Here I'm splitting it so that I can ask its length in the correct
      # units - chars or words
      links = random_input_sequence.split(separator)
      chunk_size = links.length

      chain += links

      while chain.length < desired_length

        next_link = proportional_sample(input_sequences[links.join(separator)])

        # If we've just produced the last full sequence from the input, punt
        # and get a random one. 
        # For example, if the input was "abcabd", "d" is an OK thing to
        # follow "ab", but we won't be able to find anything for "bd"
        if next_link.empty?
          if input_sequences.keys.last == links.join(separator)
            next_link = random_input_sequence
          else
            raise MalformedSequenceError.new("No entry for '#{links}'")
          end
        end

        # Whatever we came up with, tack it onto the chain
        chain << next_link
        links = links[1..-1] + Array(next_link)
      end
      chain.join(separator)
    end

    def separator
      raise NotImplementedError.new "You must specify a separator"
    end

    def sequences_found_at_least_n_times(n = 2)
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
  class MalformedSequenceError < StandardError; end;
end
