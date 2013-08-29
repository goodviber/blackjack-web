require 'rubygems'
require 'sinatra'
require 'pry'

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

    "<img src='/images/cards/#{suit}_#{name}.jpg' alt='#{name} of #{suit}' class='card'>"
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
  session[:player_cash] = 500
  erb :set_player
end

post '/new_player' do
  binding.pry
  if params[:bet].to_i < 1 || params[:bet].to_i > 500
    @error = "You must enter a positive integer less than 500 for your bet."
    erb :set_player
  elsif params[:player_name] == ''
    @error = "You must enter a name."
    erb :set_player
  end

  session[:current_bet] = params[:bet].to_i
  session[:player_name] = params[:player_name]
  redirect '/setup'
end

get '/setup' do
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
  @gameover = false
  @player_stand = session[:player_stand]

  erb :blackjack
end

post '/hit_stand' do
  if params.include?('hit')
    redirect '/player_hit'
  end

  redirect '/player_stand'
end

get '/player_hit' do
  session[:player_hand] << session[:deck].pop
  erb :blackjack, :layout => false
end

get '/player_stand' do
  session[:player_stand] = true
  erb :blackjack, :layout => false
end

post '/play_again' do
  if params[:bet].to_i < 1 || params[:bet].to_i > session[:player_cash]
    @error = "You must enter a positive bet which you have enough cash to
      cover"
    @gameover = true
    erb :blackjack
  end

  session[:current_bet] = params[:bet].to_i
  redirect '/setup'
end