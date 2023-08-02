import 'package:intl/intl.dart';

class DateFormatter {
  static eMMMMyyyy(DateTime value) {
    return DateFormat.yMMMEd('pt-BR').format(value);
  }

  static ddMMyyyy(DateTime value) {
    return DateFormat.yMMMd('pt-BR').format(value);
  }
}
