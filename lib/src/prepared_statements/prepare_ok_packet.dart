class PrepareOkPacket {
  final int statementId;
  final int numColumns;
  final int numParams;
  final int warnings;

  PrepareOkPacket(Uint8List data) :
        statementId = _readStatementId(data),
        numColumns = _readNumColumns(data),
        numParams = _readNumParams(data),
        warnings = _readWarnings(data);

  static int _readStatementId(Uint8List data) {
    final buffer = Buffer(data);
    // Assume the statement ID starts at offset 0 for this example.
    return buffer.readUint32(Endian.little);
  }

  static int _readNumColumns(Uint8List data) {
    final buffer = Buffer(data);
    // Assume numColumns is at offset 4.
    return buffer.readUint16(Endian.little);
  }

  static int _readNumParams(Uint8List data) {
    final buffer = Buffer(data);
    // Assume numParams is at offset 6.
    return buffer.readUint16(Endian.little);
  }

  static int _readWarnings(Uint8List data) {
    // After reading statementId (4 bytes), numColumns (2 bytes),
    // numParams (2 bytes), and skipping one filler byte, the expected offset is 9.
    // However, your packet might only be 7 bytes long.
    const expectedOffset = 4 + 2 + 2 + 1; // = 9
    if (data.lengthInBytes >= expectedOffset + 2) {
      final buffer = Buffer(data);
      return buffer.readUint16(expectedOffset, Endian.little);
    }
    // If there aren’t enough bytes, default to 0 warnings.
    return 0;
  }
}