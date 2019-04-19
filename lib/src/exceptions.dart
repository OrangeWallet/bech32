class TooShortHumanReadable implements Exception {
  final int length;

  TooShortHumanReadable(this.length);

  String toString() => "Human-readable part is too short: $length";
}

class TooLongHumanReadable implements Exception {
  final int length;

  TooLongHumanReadable(this.length);

  String toString() => "Human-readable part is too long: $length";
}

class TooShortInput implements Exception {
  final int length;

  TooShortInput(this.length);

  String toString() => "Input part is too short: $length";
}

class TooLongInput implements Exception {
  final int length;

  TooLongInput(this.length);

  String toString() => "Input part is too long: $length";
}

class InvalidCharacter implements Exception {
  final int character;
  final int position;

  InvalidCharacter(this.character, this.position);

  String toString() => "Invalid character $character at position $position";
}

class InvalidChecksum implements Exception {
  String toString() => "Checksum does not validate";
}

class MissingHumanPart implements Exception {
  String toString() => "Missing human-readable part";
}

class TooShortDataPart implements Exception {
  final int length;

  TooShortDataPart(this.length);

  String toString() => "Data part too short: $length";
}
