import 'package:intl/intl.dart';

int getTicketPrice(String cityFrom, String cityDestination) {
  String key = '${cityFrom.toLowerCase()}-${cityDestination.toLowerCase()}';
  return ticketPrices[key] ?? 525000; // Default price if city pair is not found
}

Map<String, int> ticketPrices = {
  'batam-moro': 110000,
  'batam-durai': 220000,
  'batam-sei guntung': 330000,
  'batam-pulau burung': 440000,
  'batam-tembilahan': 550000,
  'moro-batam': 110000,
  'moro-durai': 110000,
  'moro-sei guntung': 220000,
  'moro-pulau burung': 330000,
  'moro-tembilahan': 440000,
  'durai-batam': 220000,
  'durai-moro': 110000,
  'durai-sei guntung': 110000,
  'durai-pulauburung': 220000,
  'durai-tembilahan': 330000,
  'sei guntung-batam': 330000,
  'sei guntung-moro': 220000,
  'sei guntung-durai': 110000,
  'sei guntung-pulau burung': 110000,
  'sei guntung-tembilahan': 330000,
  'pulau burung-batam': 440000,
  'pulau burung-moro': 330000,
  'pulau burung-durai': 220000,
  'pulau burung-guntung': 110000,
  'pulau burung-tembilahan': 110000,
  'tembilahan-batam': 550000,
  'tembilahan-moro': 440000,
  'tembilahan-durai': 330000,
  'tembilahan-sei guntung': 220000,
  'tembilahan-pulau burung': 110000,
};

int insurancePrice = 10000;

String calculatePrice(
    String cityFrom, String cityDestination, int numberOfPassenger) {
  int ticketPrice = getTicketPrice(cityFrom, cityDestination);
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

//change the calculateTotalPrice into Int, because payment methode need Int
int calculateTotalPriceInt(
    String cityFrom, String cityDestination, int numberOfPassenger) {
  // Calculate the ticket price using the existing method
  int ticketPrice = getTicketPrice(cityFrom, cityDestination) * numberOfPassenger;

  // Calculate the insurance price using the existing method
  int totalInsurancePrice = insurancePrice * numberOfPassenger;

  // Calculate the total price
  int totalPrice = ticketPrice + totalInsurancePrice;

  return totalPrice; // Return the total price as an integer
}

  // Format the total price as currency
String calculateTotalPriceFormatted(
    String cityFrom, String cityDestination, int numberOfPassenger) {
  int totalPrice = calculateTotalPriceInt(cityFrom, cityDestination, numberOfPassenger);

  // Format the total price as currency for display purposes
  final formattedTotalPrice = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp. ',
    decimalDigits: 0,
  ).format(totalPrice);

  return formattedTotalPrice; // Return the formatted total price as a string
}
