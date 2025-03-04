import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/repository/mock/mock_locations_repository.dart';

import '../dummy_data/dummy_data.dart';

////
///   This service handles:
///   - The list of available rides
///
import '../repository/locations_repository.dart';
class LocationsService {
  static final LocationsService _instance =
      LocationsService(MockLocationsRepository());

  static LocationsService get instance => _instance;

  final LocationsRepository _repository;

  LocationsService(this._repository);

  List<Location> get availableLocations => _repository.getLocations();
}


