import 'package:ace_of_spades/api/api.const.dart';
import 'package:ace_of_spades/api/models/geocoding.model.dart';
import 'package:ace_of_spades/api/providers/api.provider.dart';
import 'package:ace_of_spades/api/repositories/iapi.repository.dart';
import 'package:ace_of_spades/utils/config.helper.dart';

class ApiRepository implements IApiRepository {
  static final ApiRepository instance = ApiRepository._();
  final ApiProvider _provider = ApiProvider(baseURL: MAPBOX_BASE_URL);

  ApiRepository._();

  @override
  Future<GeocodingModel> performGeocoding(
    double latitude,
    double longitude,
  ) async {
    final apiToken = (await loadConfigFile())['mapbox_api_token'] as String;
    final result = await _provider.makeGetRequest(
      'geocoding/v5/mapbox.places/$longitude,$latitude.json',
      queryParams: {
        'types': 'region',
        'access_token': apiToken,
      },
    );

    return result != null ? GeocodingModel.fromJson(result) : GeocodingModel();
  }
}
