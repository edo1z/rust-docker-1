docker build -t rust-test .
docker build -t rust-test-db ./db
docker network create rust-test-net