require 'sinatra'
require 'sinatra/reloader'
require 'pry'

@@guesses = 0

def render_me(number, message)
  erb :index, :locals => {:number => number,
                          :message => message,
                          :guesses => @@guesses}
end

SECRET_NUMBER = rand(100)

def check_guess(guess)
    case
      when guess.to_i > (SECRET_NUMBER + 5)
        message = "Way Too high!"
        render_me('??', message)
      when guess.to_i > SECRET_NUMBER 
        message = "Too high!"
        render_me('??', message)
      when guess.to_i < (SECRET_NUMBER - 5)
        message = "Way Too low!"
        render_me('??', message)
      when guess.to_i < SECRET_NUMBER
        message = "Too low!"
        render_me('??', message)
      when guess.to_i == SECRET_NUMBER
        message = "You got it!"
        render_me(SECRET_NUMBER, message)
    end
end

get '/' do
  @@guesses -= 1
  if @@guesses < 1
    last_num = SECRET_NUMBER  
    SECRET_NUMBER = rand(100) 
    @@guesses = 5
    render_me(last_num, "Out of guesses, here's a new one")
  else 
    render_me('??', '')
    guess =  params["guess"]
    check_guess(guess)
  end
end

