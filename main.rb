require_relative 'scc_wrapper'

$eye = EyeServer.new('ws://localhost:14141')

Player = Struct.new(:name, :is_login, :gameset)

def prepare_game
  line = $stdin.gets
  exit if line == nil
  names = line.split(" ")
  puts "Black: #{names[0]}, White: #{names[1]}"
  $player_black = Player.new(names[0], false, false)
  $player_white = Player.new(names[1], false, false)
end

def start_game
  puts "Game Start"
  $eye.game_start($player_black.name, $player_white.name)
end

def process(player, data)
  case data['type']
  when "ready" then
    player.is_login = true
    if $player_black.is_login and $player_white.is_login then
      start_game
    end
  when "play" then
    puts "hand: #{data['hand']}"
  when "gameset" then
    puts "received: gameset"
    player.gameset = true
    if $player_black.gameset and $player_white.gameset then
      prepare_game
    end
  end
end

$eye.onmessage do |name, data|
  case name
  when $player_black.name then
    puts "Black"
    process($player_black, data)
  when $player_white.name then
    puts "White"
    process($player_white, data)
  end
end

prepare_game

loop do
  sleep 1
end
