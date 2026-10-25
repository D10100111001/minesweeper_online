class ParserUtility {
  static bool toBoolean(String val) {
    return val.toLowerCase() == 'true';
  }

  static T toEnum<T>(List<T> values, String val) {
    final typeName = values.first.toString().split('.')[0];
    return values.firstWhere((e) => e.toString() == "$typeName.$val");
  }

  static String getEnumValue<T>(T value) {
    return value.toString().split('.').last;
  }
}
