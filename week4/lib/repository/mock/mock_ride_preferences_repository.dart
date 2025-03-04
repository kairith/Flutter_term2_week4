import 'package:week_3_blabla_project/dummy_data/dummy_data.dart';
import 'package:week_3_blabla_project/repository/ride_preferences_repository.dart';
import 'package:week_3_blabla_project/repository/rides_repository.dart';
import 'package:week_3_blabla_project/model/ride/ride.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/model/filter/ride_filter.dart';

import '../../dummy_data/dummy_data.dart';


class MockRidePreferencesRepository extends RidePreferencesRepository {
  final List<RidePreference> _pastPreferences = fakeRidePrefs;

  @override
  List<RidePreference> getPastPreferences() {
    return _pastPreferences;
  }

  @override

  void addPreference(RidePreference preference) {
    _pastPreferences.add(preference);
  }
}

class MockRidesRepository extends RidesRepository {
  final List<Ride> _rides = fakeRides; // ✅ Your predefined rides

  @override
  List<Ride> getRides(RidePreference preference, RidesFilter? filter) {
    List<Ride> matchingRides = _rides.where((ride) {
      return ride.departureLocation == preference.departure &&
          ride.arrivalLocation == preference.arrival;
    }).toList();

    if (filter != null) {
      matchingRides = matchingRides
          .where((ride) => filter.petAccepted ? ride.petAccepted : true)
          .toList();
    }

    return matchingRides;
  }
}

