import 'package:intl/intl.dart';

String formatDate(DateTime datetime) {
  return DateFormat("d MMM yyyy").format(datetime);
}
