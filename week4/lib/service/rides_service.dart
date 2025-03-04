import '../repository/rides_repository.dart';
import '../model/ride/ride.dart';
import '../model/filter/ride_filter.dart';
import '../model/ride_pref/ride_pref.dart';

class RidesService {
  static final RidesService _instance = RidesService._internal();
  late RidesRepository _repository;

  RidesService._internal();

  /// Returns the singleton instance of `RidesService`
  static RidesService get instance => _instance;

  /// Initializes the service with a specific repository.
  void initialize(RidesRepository repository) {
    _repository = repository;
  }

  /// Fetch rides based on user preference and optional filter.
  List<Ride> getRides(RidePreference preference, RidesFilter? filter) {
    return _repository.getRides(preference, filter);
  }
}
