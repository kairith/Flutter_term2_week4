import 'package:week_3_blabla_project/model/ride/ride.dart';


import '../model/filter/ride_filter.dart';
import '../model/ride_pref/ride_pref.dart';

abstract class RidesRepository {
  List<Ride> getRides(RidePreference preference, RidesFilter? filter);
}
