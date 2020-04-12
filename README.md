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
    - docker-compose exec -T tasks_manager_core rake db:create db:migrate db:seed

   ```

1. run tests rails

   ```
     docker-compose exec tasks_manager_core rspec
   ```

1. current coverage:
   [simplecov](https://edimossilva.gitlab.io/tasks-manager)

1. current deploy (api root url):
   [heroku](https://edimossilva-task-manager.herokuapp.com)

1. API doc:
   [apipie](https://edimossilva-task-manager.herokuapp.com/apipie)

1. Log monitoring:
   [papertrail](https://www.papertrail.com/)

1. Performance monitoring:
   [new relic apm](https://newrelic.com/products/application-monitoring)