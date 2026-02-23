class GamesController < ApplicationController
  VOWELS = %w[A E I O U].freeze
  def new
    @letters = Array.new(10) { ("A".."Z").to_a.sample }
  end

  def score
    @letters = params[:letters].to_s.strip.split(/\s+/).map(&:upcase)
    @word = params[:word].to_s.strip.upcase
    @can_be_formed = can_be_formed?(@word, @letters)
    @valid_word = english_word?(@word)
    @score = @can_be_formed && @valid_word ? @word.length : 0
  end

  private

  def can_be_formed?(word, letters)
  temp_letters = letters.dup
  word.chars.all? do |char|
    if temp_letters.include?(char)
      temp_letters.delete_at(temp_letters.index(char))
      true
    else
      false
    end
  end
  end

  def english_word?(word)
    word.length > 1
  end
end
