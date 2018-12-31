#!/usr/bin/env ruby

require_relative 'redis_base'

class RedisProducer < RedisBase
  def start
    loop do
      queue_work
      publish_work
      sleep 0.25
    end
  end
end

RedisProducer.new.start
