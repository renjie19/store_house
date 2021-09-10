import 'package:intl/intl.dart';

String formatDate(final DateTime dateTime, {String format = 'MMM dd, yyyy hh:mm aa'}) =>
    DateFormat(format).format(dateTime);
