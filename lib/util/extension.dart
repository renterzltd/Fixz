import 'package:intl/intl.dart';

extension StringExtension on int {
  formateNumber() {
    NumberFormat formatter = NumberFormat("00");
    return formatter.format(this);
  }
}
