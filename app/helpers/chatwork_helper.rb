require "chatwork"

module ChatworkHelper
  class ChatWorkMess
    def initialize
       @client = ChatWork::Client.new(api_key: ENV["CHATWORK_API"])
    end
  
    def send_message message
        @client.create_message(room_id: ENV["CHATWORK_GROUP_ID"], body: "[toall] #{message}")
    end
  end
end
