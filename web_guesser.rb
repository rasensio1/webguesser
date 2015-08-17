require 'sinatra'
require 'sinatra/reloader'


def render_me(number, message)
  erb :index, :locals => {:number => number, :message => message}
end

def check_guess(guess, number)
    case
      when guess.to_i > (number + 5)
        message = "Way Too high!"
        render_me('??', message)
      when guess.to_i > number 
        message = "Too high!"
        render_me('??', message)
      when guess.to_i < (number - 5)
        message = "Way Too low!"
        render_me('??', message)
      when guess.to_i < number
        message = "Too low!"
        render_me('??', message)
      when guess.to_i == number
        message = "You got it!"
        render_me(number, message)
    end
end

number = rand(100)

get '/' do
  render_me('??', '')
  guess =  params["guess"]
  check_guess(guess, number)
end




