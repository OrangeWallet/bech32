import 'dart:convert';

import 'dart:typed_data';

import 'package:bip_bech32/src/core.dart';

class Bech32 {
  Bech32(this.hrp, this.data);

  final String hrp;
  final Uint8List data;
}

class Bech32Codec extends Codec<Bech32, String> {
  Bech32Decoder get decoder => Bech32Decoder();
  Bech32Encoder get encoder => Bech32Encoder();

  String encode(Bech32 data) {
    return Bech32Encoder().convert(data);
  }

  Bech32 decode(String data) {
    return Bech32Decoder().convert(data);
  }
}

class Bech32Encoder extends Converter<Bech32, String> {
  @override
  String convert(Bech32 input) {
    String hrp = input.hrp;
    Uint8List data = input.data;
    if (hrp.length < 1)
      throw Exception(
          "Human-readable part is too short: " + hrp.length.toString());
    if (input.hrp.length > 83)
      throw Exception(
          "Human-readable part is too long: " + hrp.length.toString());
    hrp = hrp.toLowerCase();
    Uint8List checksummed =
        Uint8List.fromList(data + createChecksum(hrp, data));
    return hrp + separator + checksummed.map((i) => charset[i]).join();
  }
}

class Bech32Decoder extends Converter<String, Bech32> {
  @override
  Bech32 convert(String str) {
    // bool lower = false, upper = false;
    if (str.length < 8)
      throw Exception("Input too short: " + str.length.toString());
    if (str.length > 90)
      throw Exception("Input too long: " + str.length.toString());
    // for (int i = 0; i < str.length; ++i) {
    //     int c = str.codeUnitAt(i);
    //     if (c < 33 || c > 126) throw new AddressFormatException.InvalidCharacter(c, i);
    //     if (c >= 'a'.codeUnitAt(0) && c <= 'z'.codeUnitAt(0)) {
    //         if (upper)
    //             throw new AddressFormatException.InvalidCharacter(c, i);
    //         lower = true;
    //     }
    //     if (c >= 'A'.codeUnitAt(0) && c <= 'Z'.codeUnitAt(0)) {
    //         if (lower)
    //             throw new AddressFormatException.InvalidCharacter(c, i);
    //         upper = true;
    //     }
    // }
    final int pos = str.lastIndexOf('1');
    if (pos < 1) throw Exception("Missing human-readable part");
    final int dataPartLength = str.length - 1 - pos;
    if (dataPartLength < 6)
      throw Exception("Data part too short: " + dataPartLength.toString());
    var values = Uint8List(dataPartLength);
    for (int i = 0; i < dataPartLength; ++i) {
      int c = str.codeUnitAt(i + pos + 1);
      if (CHARSET_REV[c] == -1) throw Exception('InvalidCharacter');
      values[i] = CHARSET_REV[c];
    }
    String hrp = str.substring(0, pos).toLowerCase();
    if (!verifyChecksum(hrp, values)) throw Exception('InvalidChecksum');
    return Bech32(hrp, copyOfRange(values, 0, values.length - 6));
  }
}
