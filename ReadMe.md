# Challenge 3

Sui Move module for atomic transactions with object lifecycle management.

## Usage

### Building

```bash
sui move build
```

### Publishing

```bash
sui client publish
```

### PTB Command

```bash
sui client ptb \
  --move-call 0x826ec0f75ccb5744f49327d7b2f1b78ed96dbcecdd09ef3d512636bf023c77f3::registry::create_object \
  --assign obj \
  --move-call 0x826ec0f75ccb5744f49327d7b2f1b78ed96dbcecdd09ef3d512636bf023c77f3::registry::emit_epoch obj \
  --move-call 0x826ec0f75ccb5744f49327d7b2f1b78ed96dbcecdd09ef3d512636bf023c77f3::registry::destroy_object obj
```
