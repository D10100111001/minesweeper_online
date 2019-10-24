class ParserUtility {
  static bool toBoolean(String val) {
    return val?.toLowerCase() == 'true' ?? null;
  }

  static T toEnum<T>(List<T> values, String val) {
    if (val == null) return null;
    final typeName = values[0]?.toString()?.split('.')[0];
    return values.firstWhere((e) => e.toString() == "$typeName.$val");
  }

  static String getEnumValue<T>(T value) {
    return value.toString().split('.').last;
  }
}
