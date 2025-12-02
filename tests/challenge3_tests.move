#[test_only]
module challenge3::registry_tests;

use challenge3::registry;
use sui::test_scenario;

#[test]
fun test_object_lifecycle() {
    let user = @0xA;

    let mut scenario = test_scenario::begin(user);
    {
        let ctx = test_scenario::ctx(&mut scenario);
        let object = registry::create_object(ctx);

        assert!(registry::get_version(&object) == 1, 0);
        assert!(registry::epoch_created(&object) >= 0, 1);

        registry::destroy_object(object);
    };
    test_scenario::end(scenario);
}

#[test]
fun test_execute_sequence() {
    let user = @0xB;

    let mut scenario = test_scenario::begin(user);
    {
        registry::execute_sequence(test_scenario::ctx(&mut scenario));
    };
    test_scenario::end(scenario);
}
