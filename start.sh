docker run -itd --rm --name rt --network rust-test-net rust-test /bin/sh
docker run -itd --rm --name rt-db --network rust-test-net rust-test-db