require 'pp'
class Markov
  attr_accessor :source_text, :chunk_size, :text_profile

  def initialize(text)
    @source_text = text

    # Structure in which to store info about sequences in the source text.
    # Populated, it will have information like this:
    # {'ca' => {'t' => 1, 'b' => 2}}
    # This represents that we've seen "ca" three times: once followed by t,
    # and twice followed by b.
    # Initializing the hash like this makes it very smart: if we ever ask
    # about occurrences of "ca", it will go ahead and create it, like this:
    # {'ca' => {}}
    # That hash that IT points to has a default value of 0, so we can say:
    # text_profile['ca']['n'] += 1
    # ... and be sure that it will work properly.
    @text_profile = Hash.new {|hash, key| hash[key] = Hash.new(0) }
  end
  
  # Given a chunk of characters and a length,
  # add to our sequence counts all information
  # you can glean from it.
  #
  # For example:
  #
  # chunk size: 3
  # sample text: 'tasty'
  # 'tas' is followed by 't'
  # 'ast' is followed by 'y'
  def populate_text_profile(chunk_size = 4)
    source_text.gsub(/[\n]+/, ' ').chars.each_cons(chunk_size + 1) do |chunk|

      # Make a string from the array of characters
      chunk = chunk.join('')

      following_char = chunk.slice!(-1)

      # Note that we've seen this following char 1 (more) time
      text_profile[chunk][following_char] += 1
    end

    true
  end

  def generate(desired_length = 20)
    output_text = ''
    chunk_size = text_profile.keys.first.length

    # Seed the output text with a random choice of our sequences
    output_text << random_sample_text

    while output_text.length < desired_length

      sequence = output_text[-chunk_size..-1]
      new_text = proportional_sample(text_profile[sequence])

      # If no luck, pick a random sequence
      if new_text.empty?
        new_text = random_sample_text
      end

      # Whatever we came up with, tack it onto the output
      output_text << new_text
    end
    output_text
  end

  def see_phrases_occurring(n = 2)
    text_profile.select {|k, v| v.length > n }.sort_by{|k, v| 0 - v.length }.each do |k,v|
      puts "#{k} : #{v.length}"
    end
    return true
  end

  private

  def random_sample_text
    text_profile.keys.sample
  end

  # Given a hash where the values indicate occurrences
  # of the key, choose a random key based on its proportion
  # of the total occurrences
  # Eg: {:foo => 20, :bar => 20} # each should have a 50% chance
  # {:foo => 2, :bar => 18}      # bar should be chosen 90% of the time
  def proportional_sample(hash)
    sum = 0
    hash.each { |k,v| sum += v }
    roll = rand(sum)

    total = 0
    hash.each do |k, v|
      total += v
      return k if total > roll
    end
  end

end
