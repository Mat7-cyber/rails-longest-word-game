require "open-uri"

class GamesController < ApplicationController

  def new
    @letters = []
    10.times do
      @letters << ("A".."Z").to_a.sample
    end
  end

  def score
    @grid = params[:grid].downcase.split(' ')
    @input = params[:input].downcase.chars
    @input.all? { |letter| @input.count(letter) <= @grid.count(letter) }

    
    @url = "https://dictionary.lewagon.com/#{params[:input]}"
    uri = URI.parse(@url).read
    dictionary = JSON.parse(uri)["found"]
    if dictionary && @input.all? { |letter| @input.count(letter) <= @grid.count(letter) }
      @answer = "Congratulations! #{params[:input]} is a valid English word!"
    elsif @input.all? { |letter| @input.count(letter) <= @grid.count(letter) }
      @answer = "Sorry but #{params[:input]} does not seem to be a valid English word..."
    else
      @answer = "Sorry but #{params[:input]} can't be built out of #{@letters}" 
    end
  end
end
