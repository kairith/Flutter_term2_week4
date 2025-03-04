import '../../model/ride/ride.dart';
import '../../model/filter/ride_filter.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../../model/ride/locations.dart';
import '../../model/user/user.dart';

class MockRidesRepository {
  final List<Map<String, dynamic>> _rides = [
    {
      "departure": "Battambang",
      "arrival": "Siem Reap",
      "departureTime": DateTime.now().add(Duration(hours: 5, minutes: 30)),
      "duration": Duration(hours: 2),
      "user": "Kannika",
      "petAccepted": false,
      "seatsAvailable": 2,
    },
    {
      "departure": "Battambang",
      "arrival": "Siem Reap",
      "departureTime": DateTime.now().add(Duration(hours: 20)),
      "duration": Duration(hours: 2),
      "user": "Chaylim",
      "petAccepted": false,
      "seatsAvailable": 0,
    },
    {
      "departure": "Battambang",
      "arrival": "Siem Reap",
      "departureTime": DateTime.now().add(Duration(hours: 5)),
      "duration": Duration(hours: 3),
      "user": "Mengtech",
      "petAccepted": false,
      "seatsAvailable": 1,
    },
    {
      "departure": "Battambang",
      "arrival": "Siem Reap",
      "departureTime": DateTime.now().add(Duration(hours: 20)),
      "duration": Duration(hours: 2),
      "user": "Limhao",
      "petAccepted": true,
      "seatsAvailable": 2,
    },
    {
      "departure": "Battambang",
      "arrival": "Siem Reap",
      "departureTime": DateTime.now().add(Duration(hours: 5)),
      "duration": Duration(hours: 3),
      "user": "Sovanda",
      "petAccepted": false,
      "seatsAvailable": 1,
    },
  ];

  List<Map<String, dynamic>> getRides() {
    return _rides;
  }
}
