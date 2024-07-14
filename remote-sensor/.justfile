_default:
    just --list

run:
    cargo watch -x 'check' -s 'cargo run --release'
