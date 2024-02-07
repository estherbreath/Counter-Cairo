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

      #[external(v0)]
    impl CounterImpl of ICounter<ContractState> {
        fn increase(ref self: ContractState) {
            self.count.write(self.count.read() + 1);
        }
        fn decrease(ref self: ContractState) {
            assert(self.count.read() > 0, 'Count is Zero');
            self.count.write(self.count.read() - 1);
        }
    }

     fn get_count(self: @ContractState) -> u256 {
            self.count.read()
        }

        fn increase_by_value(ref self: ContractState, value: u256) {
            self.count.write(self.count.read() + value);
        }

             fn decrease_by_value(ref self: ContractState, value: u256) {
            assert(self.count.read() > 0, 'Count is Zero');
            self.count.write(self.count.read() - value);
        }
    }
