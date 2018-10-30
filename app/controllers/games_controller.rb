class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @answer = params[:answer]
    if check_if_is_english_word(@answer) && check_if_word_is_in_grid(@answer, params[:letters])
      @word = 'this is an english word'
    else
      @word = 'make a new try'
    end
  end

  private

  require 'open-uri'

  def check_if_is_english_word(answer)
    response = open("https://wagon-dictionary.herokuapp.com/#{answer}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def check_if_word_is_in_grid(answer, letters)
    answer.split("").map { |char| letters.include?(char) }
  end
end
