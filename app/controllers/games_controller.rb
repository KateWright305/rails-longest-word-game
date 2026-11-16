class GamesController < ApplicationController
  def new
    @letters = generate_grid(10)
  end

  def score
    @word = params[:word]
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
end
