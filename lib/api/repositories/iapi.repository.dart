import 'package:ace_of_spades/api/models/geocoding.model.dart';

abstract class IApiRepository {
  Future<GeocodingModel> performGeocoding(
    double latitude,
    double longitude,
  );
}
