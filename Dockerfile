FROM rust:latest
WORKDIR /pj
COPY . .
RUN rustc src/main.rs
CMD ["./main"]