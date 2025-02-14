require "bunny"

class CommentNotificationWorker
  def self.start
    connection = Bunny.new
    connection.start
    channel = connection.create_channel
    queue = channel.queue("notifications", durable: true)

    puts "Waiting for notifications..."

    queue.subscribe(block: true) do |_delivery_info, _properties, body|
      notification = JSON.parse(body)
      puts "📢 New Comment in Discussion #{notification["discussion_id"]}: #{notification["message"]} by #{notification["user"]}"
    end
  end
end
