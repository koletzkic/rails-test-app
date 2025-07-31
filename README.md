# SignalWire Rails Test App

## Prerequisites
1. docker installed
2. ruby installed - I use rbenv for easy version control - only if gems are going to be edited and any further local development is to be done

### This project uses docker-compose to orchestrate a complete Ruby on Rails stack with some POC monitoring and alerting steps as well

- Build - to build and run the stack simply run `docker-compose up --build -d` from within the `/build` dir 
- web – Rails Application all within `/hello-world` dir (see screenshot)
- db – PostgreSQL
- redis
- metrics exporters - redis/postgres/prom. Just to note the rails bit here was one portion I was not 100% sure on because it seemed quite rails specific and online I read lots of conflicting reports on exporting prom metrics either running within rails it's self via middleware vs a dedicated exporter container. I went for the latter because it is more inline with what I am familiar with and generally in production you would eventually have a dedicated external APM style setup. 
- graafana - for visual dashboards

## Key Metrics to Monitor in Production 

### Rails 

HTTP request rate (req/sec) - Measures throughput; helps detect sudden traffic spikes or drops.
Request duration (latency) - Identifies performance bottlenecks
HTTP error rates (4xx/5xx) - Detects failed or invalid user interactions; high 5xx indicates bugs.
GC time / memory usage 
Active jobs - Detects backlog or delays in background processin of redis 

### DB 

pg_up - Confirms that PostgreSQL is reachable.
pg_stat_activity_count - watch for either too high or dropping to near 0 
Cache hit ratio
slow queries - again more for if a real APM were used
Disk I/O usage

### Redis 

redis_up
Memory used vs. max memory - Spot OOM
Evicted keys - Indicates Redis is dropping data due to memory pressure.
Connected clients - Useful to detect saturation or misuse.
Keyspace hit rate- Low hit rate may suggest app is not caching properly 

## SLO/SLI 

### Ultimetly I would put together SLIs for each key service and build SLOs off of those, but these take a fair amount of time to do properly and my experience with them lies in leveraging cloud monitoring tools to do so e.g datadog/gcp monitoring

Just as an example for the rails portion I would set what counts as a good request usually anything that isn't 5xx and then write a module for calculating the % of good requests, then set a avalibility SLO for that e.g 99.95% over a week and alert on burn rate. Similar thing with latency e.g 99.99% requests must be under 500ms over the course of an hour. 


## AI Tooling 

- I used ChatGPT just in the conversational mode quite heavily for the setup of the rails app as it's been a number of years since I've worked with ruby day to day and setting up a project from scratch it not something I did that often to begin with. So it was very useful for spotting stupid mistakes I'd made with syntax etc 
