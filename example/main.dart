import 'dart:typed_data';

import 'package:bip_bech32/src/bech32.dart';

main() {
  Bech32Codec bech32codec = Bech32Codec();
  Bech32 bech32 =
      bech32codec.decode("bc1qw508d6qejxtdg4y5r3zarvary0c5xw7kv8f3t4");
  print(bech32.data);
  print(bech32.hrp);

  Uint8List data = Uint8List.fromList([
    0,
    14,
    20,
    15,
    7,
    13,
    26,
    0,
    25,
    18,
    6,
    11,
    13,
    8,
    21,
    4,
    20,
    3,
    17,
    2,
    29,
    3,
    12,
    29,
    3,
    4,
    15,
    24,
    20,
    6,
    14,
    30,
    22
  ]);
  print(bech32codec.encode(Bech32("bc", data)));
}
