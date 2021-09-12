toSnakeCase(String? text) {
  if(text == null || text.isEmpty) {
    return;
  }
  return text
      .replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((e) => '${e[0].toUpperCase()}${e.substring(1)}')
      .join(' ');
}
