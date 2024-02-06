#[starknet::contract]
mod ImplCounter {
    use super::ICounter;
    #[storage]
    struct Storage {
        count: u256
    }
}