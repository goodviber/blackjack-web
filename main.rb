require 'rubygems'
require 'sinatra'
require './blackjack.rb'

set :sessions, true

get '/' do
  erb :new_player
end

post '/generate_player' do
  if params[:player_name].empty?
    @error = "You have to enter a name."
    halt erb :new_player
  end

  session[:player_name] = params[:player_name]
  session[:player_cash] = 500
  session[:deck] = Deck.new
  session[:player_hand] = []
  session[:dealer_hand] = []
  session[:dealer_hidden] = true
  2.times { session[:player_hand] << session[:deck].deal }
  2.times { session[:dealer_hand] << session[:deck].deal }
  redirect '/game'
end

get '/game' do
  @player_total = 0
  session[:player_hand].each { |card| @player_total += card.value }
  @dealer_total = 0
  session[:dealer_hand].each { |card| @dealer_total += card.value }
  erb :game
end

