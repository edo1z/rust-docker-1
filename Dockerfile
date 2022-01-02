FROM rust:latest
WORKDIR /pj
COPY . .
RUN apt update -y && apt install -y iputils-ping default-mysql-client
CMD ["cargo","run"]