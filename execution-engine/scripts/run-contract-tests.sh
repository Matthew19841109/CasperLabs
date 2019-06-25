#!/usr/bin/env bash

set -o errexit

CONTRACTS=(
    "mint-token"
    "transfer-to-account-01"
    "transfer-to-account-02"
    "create-purse-01"
)

source "${HOME}/.cargo/env"

export RUST_BACKTRACE=1

rustup target add --toolchain $(cat rust-toolchain) wasm32-unknown-unknown

for CONTRACT in "${CONTRACTS[@]}"; do
    cargo build -p "${CONTRACT}" --target wasm32-unknown-unknown
done

cargo test -p casperlabs-engine-grpc-server -- --ignored --nocapture
