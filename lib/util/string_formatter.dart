import 'package:intl/intl.dart';

toSnakeCase(String? text) {
  if(text == null || text.isEmpty) {
    return '';
  }
  return text.trim()
      .replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((e) => '${e[0].toUpperCase()}${e.substring(1)}')
      .join(' ');
}

toNumberFormat(String? number) {
  if(number == null || number.isEmpty) {
    return '';
  }
  final numberFormatter = NumberFormat('##0.00', 'en_US');

  return numberFormatter.format(double.parse(number.replaceAll(',', '')));
}

toCommaSeparatedNumber(String? number) {
  if(number == null || number.isEmpty) {
    return;
  }
  final numberFormatter = NumberFormat('#,##0.00', 'en_US');

  return numberFormatter.format(double.parse(number.replaceAll(',', '')));
}


