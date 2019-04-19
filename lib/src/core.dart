import 'dart:math';

import 'dart:typed_data';

const String separator = "1";

const charset = [
  "q",
  "p",
  "z",
  "r",
  "y",
  "9",
  "x",
  "8",
  "g",
  "f",
  "2",
  "t",
  "v",
  "d",
  "w",
  "0",
  "s",
  "3",
  "j",
  "n",
  "5",
  "4",
  "k",
  "h",
  "c",
  "e",
  "6",
  "m",
  "u",
  "a",
  "7",
  "l",
];

const CHARSET_REV = [
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  15,
  -1,
  10,
  17,
  21,
  20,
  26,
  30,
  7,
  5,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  29,
  -1,
  24,
  13,
  25,
  9,
  8,
  23,
  -1,
  18,
  22,
  31,
  27,
  19,
  -1,
  1,
  0,
  3,
  16,
  11,
  28,
  12,
  14,
  6,
  4,
  2,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  29,
  -1,
  24,
  13,
  25,
  9,
  8,
  23,
  -1,
  18,
  22,
  31,
  27,
  19,
  -1,
  1,
  0,
  3,
  16,
  11,
  28,
  12,
  14,
  6,
  4,
  2,
  -1,
  -1,
  -1,
  -1,
  -1
];

int _polymod(Uint8List values) {
  int c = 1;
  values.forEach((v_i) {
    int c0 = (c >> 25) & 0xff;
    c = ((c & 0x1ffffff) << 5) ^ (v_i & 0xff);
    if ((c0 & 1) != 0) c ^= 0x3b6a57b2;
    if ((c0 & 2) != 0) c ^= 0x26508e6d;
    if ((c0 & 4) != 0) c ^= 0x1ea119fa;
    if ((c0 & 8) != 0) c ^= 0x3d4233dd;
    if ((c0 & 16) != 0) c ^= 0x2a1462b3;
  });
  return c;
}

Uint8List _expandHrp(String hrp) {
  var result = hrp.codeUnits.map((c) => c >> 5).toList();
  return Uint8List.fromList(
      result += [0] + hrp.codeUnits.map((c) => c & 31).toList());
}

Uint8List createChecksum(String hrp, Uint8List values) {
  var enc = _expandHrp(hrp) + values + [0, 0, 0, 0, 0, 0];
  int mod = _polymod(Uint8List.fromList(enc)) ^ 1;
  Uint8List ret = Uint8List(6);
  for (int i = 0; i < 6; ++i) {
    ret[i] = (mod >> (5 * (5 - i))) & 31;
  }
  return ret;
}

bool verifyChecksum(String hrp, Uint8List values) {
  return _polymod(Uint8List.fromList(_expandHrp(hrp) + values)) == 1;
}

Uint8List arrayCopy(bytes, srcOffset, result, destOffset, bytesLength) {
  for (var i = srcOffset; i < bytesLength; i++) {
    result[destOffset + i] = bytes[i];
  }
  return result;
}

Uint8List copyOfRange(Uint8List original, int from, int to) {
  int newLength = to - from;
  if (newLength < 0) throw Exception(from.toString() + " > " + to.toString());
  Uint8List copy = Uint8List(newLength);
  return arrayCopy(
      original, from, copy, 0, min(original.length - from, newLength));
}
