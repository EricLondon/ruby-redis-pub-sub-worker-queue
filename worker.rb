#!/usr/bin/env ruby

require_relative 'redis_base'

class RedisWorker < RedisBase
  def initialize
    super
    @pub_sub = Redis.new(host: @redis_host, port: @redis_port)
  end

  def start
    log :info, 'WORKER STARTED'
    resume_work
    subscribe
  end

  protected

  def resume_work
    log :info, 'WORKER RESUME: START'
    has_work = false
    begin
      result = check_work
      has_work = true if result
    end while has_work
    log :info, 'WORKER RESUME: END'
  end

  def check_work
    task = next_task
    return false unless task

    work(task)
    true
  end

  def subscribe
    @pub_sub.subscribe(@channel) do |on|
      on.subscribe do |channel, _subscriptions|
        log :info, "WORKER SUBSCRIBED TO: #{channel}"
      end

      on.message do |channel, message|
        check_work if channel == @channel && message == @queue
      end
    end
  end

  def work(task)
    log :info, "TASK START: #{task}"

    # TODO: do actual work here
    sleep(task.to_i)

    complete_task(task)
    log :info, "TASK END: #{task}"
  rescue StandardError => e
    # TODO: put task back in work queue
    log :error, e
  end
end

RedisWorker.new.start
