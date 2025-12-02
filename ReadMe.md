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
  --move-call <PACKAGE_ID>::registry::create_object \
  --assign obj \
  --move-call <PACKAGE_ID>::registry::emit_epoch obj \
  --move-call <PACKAGE_ID>::registry::destroy_object obj
```
