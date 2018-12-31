require 'json'
require 'logger'
require 'redis'
require 'securerandom'

require 'pry'

class RedisBase
  def initialize
    @uuid = SecureRandom.uuid
    @logger = Logger.new(STDOUT)

    @queue = ENV.fetch('WORK_QUEUE', 'work_queue')
    @processed = ENV.fetch('WORK_PROCESSED', 'work_processed')
    @channel = ENV.fetch('WORK_CHANNEL', 'work_channel')

    @redis_host = ENV.fetch('REDIS_HOST', 'localhost')
    @redis_port = ENV.fetch('REDIS_PORT', '6379').to_i

    @client = Redis.new(host: @redis_host, port: @redis_port)
  end

  protected

  def queue_list
    @client.lrange @queue, 0, -1
  end

  def processed_list
    @client.lrange @processed, 0, -1
  end

  def log(level, message)
    @logger.send(level, "#{@uuid}: #{message}")
  end

  def queue_work
    @client.rpush @queue, rand(1..5)
  end

  def publish_work
    @client.publish @channel, @queue
  end

  def next_task
    @client.lpop @queue
  end

  def complete_task(task)
    @client.rpush @processed, { worker: @uuid, task: task }.to_json
  end
end
