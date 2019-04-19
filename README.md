# bip_bech32

[![pub package](https://img.shields.io/pub/v/bip_bech32.svg)](https://pub.dartlang.org/packages/bip_bech32)

Dart implementing [BIP173 spec](https://github.com/bitcoin/bips/blob/master/bip-0173.mediawiki)

Convert from [bitcoinj](https://github.com/bitcoinj/bitcoinj/blob/master/core/src/main/java/org/bitcoinj/core/Bech32.java)

## Install

dart pub package

[bip_bech32](https://pub.dartlang.org/packages/bip_bech32)

## Example

```dart
Bech32Codec bech32codec = Bech32Codec();
  Bech32 bech32 =
      bech32codec.decode("bc1qw508d6qejxtdg4y5r3zarvary0c5xw7kv8f3t4");
  print(bech32.data);
  print(bech32.hrp);

  Uint8List data = Uint8List.fromList([0, 14, 20, 15, 7, 13, 26, 0, 25, 18, 6, 11, 13, 8, 21, 4, 20, 3, 17, 2, 29, 3, 12, 29, 3, 4, 15, 24, 20, 6, 14, 30, 22]);
  print(bech32codec.encode(Bech32("bc", data)));
```

[example](https://github.com/OrangeWallet/bech32/blob/master/example/main.dart)

## License

[MIT](https://github.com/OrangeWallet/bech32/blob/master/LICENSE.md)

## Thanks

[bitcoinj](https://github.com/bitcoinj/bitcoinj)
