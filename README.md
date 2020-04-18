# install

1. build containers

   ```
     docker-compose build
   ```

1. start containers in background

   ```
     docker-compose up -d
   ```

1. Setup database

   ```
     docker-compose exec -T tasks_manager_core rake db:create db:migrate db:seed

   ```

1. run tests rails

   ```
     docker-compose exec tasks_manager_core rspec
   ```

1. current coverage

   1. [simplecov tasks-manager-core(Rails)](https://edimossilva.gitlab.io/tasks-manager/tasks_manager_core_coverage)

   1. [simplecov auth-provider(Rails)](https://edimossilva.gitlab.io/tasks-manager/auth_provider_coverage)

   1. [simplecov api-gateway(Sinatra)](https://edimossilva.gitlab.io/tasks-manager/api_gateway_coverage)

1. API doc:
   [apipie](https://edimossilva-task-manager.herokuapp.com/apipie)

1. Message Broker:
   [RabbitMq](https://edimossilva-task-manager.herokuapp.com/apipie)

1. Log monitoring:
   [papertrail](https://www.papertrail.com/)

1. Performance monitoring:
   [new relic apm](https://newrelic.com/products/application-monitoring)
