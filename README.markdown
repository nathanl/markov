# Markov

A simple little Markov chain generator. It constructs fun gibberish, like this, based on the Constitution:

> ...with foreign Powers and to all other, shall be failure the House of President, the Disagree to that the two this Congress of them, or from the People of the absent transmit sealed text is unable cause, without due prohibited States; To establish Justice shall exist within, the supreme Court. The articularly described by a majority of the elected, which shall flee from Arrest during shall have in any State.

That's gibberish based on "what word is likely to come next, based on the input text?" All the words are real, but the phrases are nonsense.

It can also make gibberish based on "what character is likely to come next?" That might look like:

> The United of No Morrow mosterm office President; he United, noon the Senators ander subjection, shall taker supremovalue shall nor it. No States, on of their Afficernment withose, themsel Captural States: but nothe Presidented by two or public Vicer thereof thereof, Tax or, if nor, upon of Revery present a naval juring one form of Senators for, which shall have a Prespection or requalifice of the United as to all inspeech, withorizensation, the Gover in a Qual Stater withirds or, any Triate seaty

In this case, the resemblance to the Constitution is looser: "withose" and "Vicer" aren't real words, but they follow the same sort of patterns as the English in the original. We probably wouldn't see something like "clandinoso" unless the input text was (eg) Spanish.

## Using it

I haven't bothered to make this user friendly yet, as it was just a fun experiment of my own. But you can play with it as follows.

First, you'll need to have Ruby installed.

Then get the code for this project - either `git clone git@github.com:nathanl/markov.git` or download a zip and unzip it.

Next `bundle install` in the directory.

Then you can `ruby ./run_markov.rb`.

Any further customization you want (eg, using something other than the U.S. Constitution as input) will require modifying that script.

## Legal Agreement

You can do whatever you want with this (not that it's very useful), unless what you want to do is create spam, in which case, by using the aforementioned software you do solmenly agree that you will punch yourself in the face 58 times for each spam message you send using text generated by said software, and the punches don't count unless they make you bleed.
