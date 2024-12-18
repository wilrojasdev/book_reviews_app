import 'package:intl/intl.dart';

String formatDate(DateTime dateTime) {
  // Usamos el formato "EEE, dd MMMM yyyy" para el formato deseado
  return DateFormat('EEE, dd MMMM yyyy').format(dateTime);
}
