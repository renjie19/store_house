import 'package:intl/intl.dart';

String formatDate(final DateTime dateTime, {String format = 'MMM dd, yyyy HH:mm aa'}) =>
    DateFormat(format).format(dateTime);
