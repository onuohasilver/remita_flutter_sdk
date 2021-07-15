class CustomField {
  final String value, name, type;

  const CustomField({
    required this.value,
    required this.name,
    required this.type,
  });
  Map<String, String> get toMap => {'value': value, 'name': name, 'type': type};

  static List<Map>? castList([List<CustomField>? customFieldList]) {
    List<Map> mappedList = [];
    customFieldList?.forEach((element) {
      mappedList.add(element.toMap);
    });
    return mappedList.isEmpty ? null : mappedList;
  }
}
