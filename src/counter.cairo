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

    #[cfg(test)]
mod test {
    use core::serde::Serde;
    use super::{ICounter, Counter, ICounterDispatcher, ICounterDispatcherTrait};
    use starknet::ContractAddress;
    use starknet::contract_address::contract_address_const;
    use array::ArrayTrait;
    use snforge_std::{declare, ContractClassTrait};

     // helper function
    fn deploy_contract() -> ContractAddress {
        let contract_class = declare('Counter');

        let contract_address = contract_class.deploy(@ArrayTrait::new()).unwrap();
        contract_address
    }

      #[test]
    fn test_correct_count() {
        let contract_address = deploy_contract();
        let dispatcher = ICounterDispatcher { contract_address };

        assert(dispatcher.get_count() == 0, 'Wrong Count');
    }

    #[test]
    fn test_increase() {
        let contract_address = deploy_contract();
        let dispatcher = ICounterDispatcher { contract_address };
        let previous_count = dispatcher.get_count();
        dispatcher.increase();
        assert(dispatcher.get_count() == previous_count + 1, 'Increase function not working');
    }

}
