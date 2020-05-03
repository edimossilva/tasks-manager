# Overview

1. CI/CD (docker + gitlab + heroku):
   [pipeline](https://gitlab.com/edimossilva/tasks-manager/pipelines/latest)

1. Unit test coverage

   1. [simplecov tasks-manager-core (Rails)](https://edimossilva.gitlab.io/tasks-manager/tasks_manager_core_coverage)

   1. [simplecov auth-provider (Rails)](https://edimossilva.gitlab.io/tasks-manager/auth_provider_coverage)

   1. [simplecov api-gateway (Sinatra)](https://edimossilva.gitlab.io/tasks-manager/api_gateway_coverage)

1. System test
   [cypress](https://edimossilva.gitlab.io/tasks-manager/integration)

1. Custom Gems
   [rabbitmq_pub_sub](https://github.com/edimossilva/rabbitmq_pub_sub)

1. Custom images on docker hub:

   1. [node_angular_cypress](https://hub.docker.com/repository/docker/edimossilva/node-angular-cypress)
   1. [rails6](https://hub.docker.com/repository/docker/edimossilva/rails6)

1. API doc:
   [apipie](https://edimossilva-task-manager.herokuapp.com/apipie)

1. Message Broker:
   [RabbitMq](https://www.rabbitmq.com/)

1. Background jobs
   [Sidekiq](https://sidekiq.org/)

1. Cache
   [Redis](https://redis.io/)

1. Log monitoring:
   [papertrail](https://www.papertrail.com/)

1. Performance monitoring:
   [new relic apm](https://newrelic.com/products/application-monitoring)
