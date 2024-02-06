#[starknet::interface]
trait ICounter<T> {
    fn increase(ref self: T);
    fn decrease(ref self: T);
    fn get_count(self: @T) -> u256;
    fn increase_by_value(ref self: T, value: u256);
    fn decrease_by_value(ref self: T, value: u256);
}

#[starknet::contract]
mod Counter {
    use super::ICounter;
    #[storage]
    struct Storage {
        count: u256
    }
}