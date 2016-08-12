require 'redis-namespace'
redis_connection = Redis.new(:host => "#{ENV["REDIS_HOST"]}", :port => "#{ENV["REDIS_PORT"]}", :thread_safe => true)
Redis.current = Redis::Namespace.new(:eventr, :redis => redis_connection)

$eventr_redis = Redis::Namespace.new(:eventr_app, :redis => redis_connection)