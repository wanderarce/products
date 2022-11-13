import 'package:intl/intl.dart';

class FormatService {
  FormatService() {
    Intl.defaultLocale = 'pt_BR';
  }
  currency(value) {
    var currencyFormatter = NumberFormat.simpleCurrency(locale: "pt_BR");
    return currencyFormatter.format(value);
  }
}
