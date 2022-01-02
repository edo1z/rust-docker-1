## DocketでRustを動かす（だけ）

### Dockerfile

```
FROM rust:latest
WORKDIR /pj
COPY . .
CMD ["cargo","run"]
```

### イメージの構築・実行

```
> docker build -t rust-test .
> docker run --rm rust-test
Hello, world!
```

## MySQLと連動

- MySQLのコンテナを作る。
- ネットワークを作成して、RustとMySQLを同じネットワークに入れる。
- mysql -h {コンテナ名} でアクセスできるようになる。

### Dockerfile
#### Rust

```
FROM rust:latest
WORKDIR /pj
COPY . .
RUN apt update -y && apt install -y default-mysql-client
CMD ["cargo","run"]
```

#### MySQL

```
FROM mysql:8.0.27

ENV MYSQL_DATABASE=rust-test-db
ENV MYSQL_ROOT_PASSWORD=password
ENV MYSQL_USER=user
ENV MYSQL_PASSWORD=password
```

### イメージの構築・実行

```
> docker build -t rust-test .
> docker build -t rust-test-db ./db
> docker network create rust-test-net

> docker run -itd --rm --name rt --network rust-test-net rust-test /bin/sh
> docker run -itd --rm --name rt-db --network rust-test-net rust-test-db
```

### RustのコンテナからMySQLに接続してみる

```
> docker exec -it rt sh
# mysql -u user -p -h rt-db
MySQL [(none)]> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| rust-test-db       |
+--------------------+
```
