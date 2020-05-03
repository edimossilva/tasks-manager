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
