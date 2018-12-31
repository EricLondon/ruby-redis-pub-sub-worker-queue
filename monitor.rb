#!/usr/bin/env ruby

require_relative 'redis_base'

class RedisClient < RedisBase
  def start
    loop do
      puts `clear` + output
      sleep 1
    end
  end

  protected

  def output
    output = ''
    output << output_from(:queue)
    output << output_from(:processed)
  end

  def output_from(kind)
    data = send("#{kind}_grouped")
    output = "#{kind.capitalize}:\n"
    data.each { |k, v| output << "\t#{k}\t#{v}\n" }
    output << "\n"
  end

  def queue_grouped
    grouped = queue_list.each_with_object(Hash.new(0)) { |task, hsh| hsh[task] += 1 }
    Hash[grouped.sort_by { |k, _v| k }]
  end

  def processed_grouped
    grouped = processed_list.each_with_object({}) do |jsn, hsh|
      item = JSON.parse(jsn)
      worker_uuid = item['worker']
      hsh[worker_uuid] = 0 unless hsh.key?(worker_uuid)
      hsh[worker_uuid] += 1
    end
    Hash[grouped.sort_by { |k, _v| k }]
  end
end

RedisClient.new.start
