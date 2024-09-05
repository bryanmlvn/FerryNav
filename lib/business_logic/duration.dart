// Map for storing durations in hours and minutes
Map<String, String> routeDurations = {
  'batam-moro': '1h 5m',
  'batam-durai': '2h 10m',
  'batam-sei guntung': '3h 15m',
  'batam-pulau burung': '4h 20m',
  'batam-tembilahan': '5h 25m',

  'moro-batam': '1h 5m',
  'moro-durai': '1h 5m',
  'moro-sei guntung': '2h 10m',
  'moro-pulau burung': '3h 15m',
  'moro-tembilahan': '3h 20m',

  'durai-batam': '2h 10m',
  'durai-moro': '1h 5m',
  'durai-sei guntung': '1h 5m',
  'durai-pulauburung': '2h 10m',
  'durai-tembilahan': '3h 15m',

  'sei guntung-batam': '3h 15m',
  'sei guntung-moro': '2h 10m',
  'sei guntung-durai': '1h 5m',
  'sei guntung-pulau burung': '1h 5m',
  'sei guntung-tembilahan': '3h 15m',

  'pulau burung-batam': '4h 20m',
  'pulau burung-moro': '3h 15m',
  'pulau burung-durai': '2h 10m',
  'pulau burung-guntung': '1h 5m',
  'pulau burung-tembilahan': '1h 5m',

  'tembilahan-batam': '5h 25m',
  'tembilahan-moro': '4h 20m',
  'tembilahan-durai': '3h 15m',
  'tembilahan-sei guntung': '2h 10m',
  'tembilahan-pulau burung': '1h 5m',
};

// Function to get the duration based on cities
String getRouteDuration(String cityFrom, String cityDestination) {
  String key = '${cityFrom.toLowerCase()}-${cityDestination.toLowerCase()}';
  return routeDurations[key] ?? 'Duration not available'; // Default message if route is not found
}