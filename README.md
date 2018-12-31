### Ruby Redis Pub/Sub Worker Queue

See blog post: https://ericlondon.com/2018/12/31/ruby-redis-pub-sub-worker-queue.html

```
# start containers
$ docker-compose build && docker-compose --compatibility up

# view containers
$ docker ps
CONTAINER ID        IMAGE                   COMMAND                  CREATED             STATUS              PORTS                    NAMES
55bb702657fc        redis-worker_worker     "/app/worker.rb"         3 minutes ago       Up 3 minutes                                 redis-worker_worker_9
8bdbb033e247        redis-worker_worker     "/app/worker.rb"         3 minutes ago       Up 3 minutes                                 redis-worker_worker_6
256a165d1897        redis-worker_worker     "/app/worker.rb"         3 minutes ago       Up 3 minutes                                 redis-worker_worker_7
b5f2256d839b        redis-worker_worker     "/app/worker.rb"         3 minutes ago       Up 3 minutes                                 redis-worker_worker_2
9d6b6646c481        redis-worker_worker     "/app/worker.rb"         3 minutes ago       Up 3 minutes                                 redis-worker_worker_8
68b4fd1ac5e3        redis-worker_worker     "/app/worker.rb"         3 minutes ago       Up 3 minutes                                 redis-worker_worker_4
185da4e137df        redis-worker_worker     "/app/worker.rb"         3 minutes ago       Up 3 minutes                                 redis-worker_worker_10
a0eb6d2f82a7        redis-worker_producer   "/app/producer.rb"       3 minutes ago       Up 3 minutes                                 redis-worker_producer_1
d0b18174daa6        redis-worker_worker     "/app/worker.rb"         3 minutes ago       Up 3 minutes                                 redis-worker_worker_1
9405439235da        redis-worker_worker     "/app/worker.rb"         3 minutes ago       Up 3 minutes                                 redis-worker_worker_3
9904f7ab16af        redis-worker_worker     "/app/worker.rb"         3 minutes ago       Up 3 minutes                                 redis-worker_worker_5
657d2386da40        redis:latest            "docker-entrypoint.s…"   3 minutes ago       Up 3 minutes        0.0.0.0:6379->6379/tcp   redis-worker_redis_1

# start monitor script
$ docker exec -it a0eb6d2f82a7 /app/monitor.rb

# example output
Queue:
	1	19
	2	30
	3	21
	4	24
	5	25

Processed:
	079f5841-e0fa-46da-83a1-3e9ad0ed1816	61
	2795fd22-6ccb-4a4e-9489-3d7fb2d42dca	60
	430f5d00-8f84-46fb-9fbe-0a9d5ebea8a5	67
	4b70afa3-d77a-4f25-94f2-f2d3e281b578	60
	5aae5ae8-4124-4df6-976c-cf9ddafdf240	62
	7466716d-0306-48b4-bd2f-5d93778daf81	64
	795d07fd-c45a-4a0a-8903-a22329ac52ec	65
	9874b347-16cb-4f3e-87ed-6a54ae86e926	57
	adb258a5-ba05-44dd-a1a3-c6e9ebfd3c1b	58
	fe4f78bf-7dff-4302-ba67-ca3fe578d9f1	62
  ```
