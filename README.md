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
    - docker-compose exec -T rails rake db:create
    - docker-compose exec -T rails rake db:migrate
    - docker-compose exec -T rails rspec

   ```

1. run tests rails
   ```
     docker-compose exec rails rspec
   ```

1. current coverage
  [coverage](https://edimossilva.gitlab.io/tasks-manager)
