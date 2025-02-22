import 'dart:typed_data';

import 'package:mysql1/src/buffer.dart';

class PrepareOkPacket {
  final int statementId;
  final int columnCount;
  final int parameterCount;
  late final int warnings;

  PrepareOkPacket(Buffer buffer)
      : statementId = buffer.readUint32(),
        columnCount = buffer.readUint16(),
        parameterCount = buffer.readUint16() {
    // Skip filler byte.
    buffer.skip(1);
    // Check if at least 2 bytes remain; if so, read warnings, otherwise default to 0.
    if (buffer.remaining >= 2) {
      warnings = buffer.readUint16();
    } else {
      warnings = 0;
    }
  }
}
