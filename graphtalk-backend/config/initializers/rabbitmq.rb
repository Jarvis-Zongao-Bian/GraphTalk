require "bunny"

class RabbitMQClient
  def self.start
    connection = Bunny.new
    connection.start
    @channel = connection.create_channel
    @queue = @channel.queue("notifications", durable: true)
  end

  def self.publish(message)
    @queue.publish(message.to_json, persistent: true)
  end
end

RabbitMQClient.start
