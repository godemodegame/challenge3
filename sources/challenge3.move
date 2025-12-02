module challenge3::registry;

use sui::event;

public struct MoveObject has key, store {
    id: sui::object::UID,
    epoch_created: u64,
    version: u64,
}

public struct ObjectCreated has copy, drop {
    object_id: address,
    epoch_created: u64,
    version: u64,
}

public struct ObjectDestroyed has copy, drop {
    object_id: address,
}

public struct EpochEmitted has copy, drop {
    epoch: u64,
}

public fun create_object(ctx: &mut sui::tx_context::TxContext): MoveObject {
    let uid = sui::object::new(ctx);
    let object_address = sui::object::uid_to_address(&uid);
    let current_epoch = sui::tx_context::epoch(ctx);

    let new_object = MoveObject {
        id: uid,
        epoch_created: current_epoch,
        version: 1,
    };

    event::emit(ObjectCreated {
        object_id: object_address,
        epoch_created: current_epoch,
        version: 1,
    });

    new_object
}

public fun destroy_object(object: MoveObject) {
    let MoveObject { id, epoch_created: _, version: _ } = object;
    let object_address = sui::object::uid_to_address(&id);

    event::emit(ObjectDestroyed {
        object_id: object_address,
    });

    sui::object::delete(id);
}

public fun epoch_created(object: &MoveObject): u64 {
    object.epoch_created
}

public fun get_version(object: &MoveObject): u64 {
    object.version
}

public fun emit_epoch(object: &MoveObject) {
    let epoch = epoch_created(object);
    event::emit(EpochEmitted { epoch });
}

entry fun cleanup_object(object: MoveObject) {
    destroy_object(object);
}

entry fun execute_sequence(ctx: &mut sui::tx_context::TxContext) {
    let object = create_object(ctx);
    emit_epoch(&object);
    destroy_object(object);
}
