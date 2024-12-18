import 'package:intl/intl.dart';

String formatDate(DateTime dateTime) {
  return DateFormat('EEE, dd MMMM yyyy').format(dateTime);
}
