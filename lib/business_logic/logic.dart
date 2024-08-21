import 'package:intl/intl.dart';

int ticketPrice = 525000;
int insurancePrice = 10000;

String calculatePrice(int numberOfPassenger) {
  final formattedPrice = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp. ',
    decimalDigits: 0,
  ).format(numberOfPassenger * ticketPrice);

  return formattedPrice;
}

String calculateInsurance(int numberOfPassenger) {
  final formattedInsurance = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp. ',
    decimalDigits: 0,
  ).format(numberOfPassenger * insurancePrice);

  return formattedInsurance;
}
