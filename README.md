## Hacker Search

[![Code Climate](https://codeclimate.com/github/mokrzu/hacker_search.png)](https://codeclimate.com/github/mokrzu/hacker_search)
[![Code Climate](https://codeclimate.com/github/mokrzu/hacker_search/coverage.png)](https://codeclimate.com/github/mokrzu/hacker_search)
[![Build Status](https://travis-ci.org/mokrzu/hacker_search.svg?branch=travis)](https://travis-ci.org/mokrzu/hacker_search)
[![Dependency Status](https://gemnasium.com/mokrzu/hacker_search.svg)](https://gemnasium.com/mokrzu/hacker_search)

Analyse and query Hacker News articles, using Chewy(ElasticSearch gem) and Rails 4.

Project in active development.

Use HackerNewsImporter class for updates:
```ruby
$ rails c
> HackerNewsImporter.new.import(9) # import last 9 pages from HackerNews
....
```

===

####Todo list:
* use [kimonolabs.com](http://www.kimonolabs.com/) as HN API source, instead of ruby-hackernews gem
* add additional query fields: [date range, points range, article type]
* analyzers picker
* worker for importing articles periodically

![](https://dl.dropboxusercontent.com/u/7767829/hacker_search.png)

===

####Hints for developing Chewy/Elasticearch application

**Travis integration**

Thanks [Chewy Example](https://github.com/toptal/chewy_example) for configuration hint.

Instead of using default Elastisearch service, which leads to collision between local and travis(test) ES ports:
```yml
# .travis.yml
services:
  - elasticsearch
```
Install and run test cluster manualy:
```yml
# .tavis.yml
before_install:
  - curl -# https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.0.1.tar.gz | tar xz -C /tmp

before_script:
  - TEST_CLUSTER_COMMAND="/tmp/elasticsearch-1.0.1/bin/elasticsearch" bundle exec rake elasticsearch:start
```
Now you could specify expicit ES version, and options, if you want.

**Elasticsearch GUI** could help with debugging.

Try:
* [Marvel with build-in Sense browser](http://www.elasticsearch.org/overview/marvel/download/)
* [ElasticSeach Head browser](http://mobz.github.io/elasticsearch-head/)

**Gemnasium** integration, helped me find out bugs coused by [outdated gems](https://gemnasium.com/mokrzu/hacker_search).

