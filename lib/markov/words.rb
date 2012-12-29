require 'markov/base'

module Markov
  class Words < Base
    def populate_input_sequences(chunk_size = 4)
      input.gsub(/[\n]+/, ' ').split(' ').each_cons(chunk_size + 1) do |chunk|

        following_word = chunk.pop
        sequence       = chunk.join(' ')

        # Note that we've seen this following word 1 (more) time
        input_sequences[sequence][following_word] += 1
      end

      true
    end

    def joiner
      ' '
    end

  end
end
