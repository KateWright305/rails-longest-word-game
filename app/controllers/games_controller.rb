require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    @letters = generate_grid(10)
  end

  def score
    @word = params[:word]
    @letters = params[:letters]

    if !valid_grid?(@word, @letters)
      @message = "Sorry, your word cannot be built from the grid."
    elsif !english_word?(@word)
      @message = "Sorry, this is not a valid English word."
    else
      @message = "Congratulations! #{@word} is a valid English word!"
    end
  end

  def generate_grid(grid_size)
    letters = ("a".."z").to_a
    grid_words = []
    i = 0
    while i < 10
      grid_words << letters.sample
      i += 1
    end
    return grid_words
  end

  def valid_grid?(word, letters)
    remaining_letters = letters.chars

    word.chars.all? do |letter|
      index = remaining_letters.index(letter)

      if index
        remaining_letters.delete_at(index)
        true
      else
        false
      end
    end
  end

  def english_word?(word)
    return false if word.empty?

    url = "https://dictionary.lewagon.com/#{word}"
    response = URI.open(url).read
    result = JSON.parse(response)

    result["found"]
  end
end
