require 'rubygems'
require 'sinatra'

helpers do
  def card_img(card)
    
    suit = case card[0]
    when 'C'
      'clubs'
    when 'H'
      'hearts'
    when 'D'
      'diamonds'
    when 'S'
      'spades'
    end

    name = case card[1]
    when 'A'
      'ace'
    when 'K'
      'king'
    when 'Q'
      'queen'
    when 'J'
      'jack'
    else
      card[1]
    end

    "<img src='/images/cards/#{suit}_#{name}.jpg' alt='#{name} of #{suit}'>"
  end

  def total(cards)
    tot = 0
    cards.each do |card|
      value = card[1].to_i

      if card[1] == 'A'
        value = tot > 10 ? 1 : 11
      end

      tot += value > 0 ? value : 10
    end
    tot
  end
end

set :sessions, true

get '/' do
  if session[:player_name].nil?
    redirect '/set_player'
  end

  redirect '/blackjack'
end

get '/set_player' do
  erb :set_player
end

post '/setup' do
  session[:player_name] = params[:player_name]
  session[:player_cash] = 500
  suits = %w[H D C S]
  cards = %w[A 2 3 4 5 6 7 8 9 10 K Q J]
  session[:deck] = suits.product(cards).shuffle
  session[:player_hand] = []
  session[:dealer_hand] = []
  2.times { session[:player_hand] << session[:deck].pop }
  2.times { session[:dealer_hand] << session[:deck].pop }
  session[:player_stand] = false
  session[:dealer_stand] = false

  redirect '/blackjack'
end

get '/newgame' do
  erb :getbet
end

get '/blackjack' do
  erb :blackjack
end

post '/player_hit' do
  session[:player_hand] << session[:deck].pop
  erb :blackjack, :layout => false
end

post '/player_stand' do
  session[:player_stand] = true
  erb :blackjack, :layout => false
end