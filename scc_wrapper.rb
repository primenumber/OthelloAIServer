require_relative 'SimpleChatRubyClient/simple_chat'

class EyeServer
  def initialize(uri)
    @scc = SimpleChatClient.new(uri)
    @scc.onconnect do
      puts "connecetd server"
      if File.exist?('config.json') then
        puts "config.json exist"
        json = File.open('config.json').read
        puts json
        obj = JSON.parse(json)
        @scc.init(obj['id'])
      else
        @scc.new_user('othello')
      end
    end
    @scc.onlogin do |user|
      puts "login success"
      puts user['id']
      if !File.exist?('config.json') then
        file = File.open('config.json')
        file.write JSON.generate({'id' => user['id']})
        file.close
      end
    end
  end
  def onmessage
    @scc.onmessage do |name, message, type, tags|
      next unless tags.include?("othello")
      yield(name, JSON.parse(message))
    end
  end
  def game_start(black_name, white_name)
    puts black_name
    send_data({
      "type" => "command",
      "message" => "start",
      "black" => black_name,
      "white" => white_name
    })
  end
  def send_data(data)
    puts data
    @scc.send_message(JSON.generate(data), ["othello"])
  end
end
