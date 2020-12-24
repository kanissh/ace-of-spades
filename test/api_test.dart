import 'dart:io';

import 'package:ace_of_spades/api/repositories/api.repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() => HttpOverrides.global = null);

  group('mapbox api', () {
    test('geocoding response', () async {
      final repository = ApiRepository.instance;
      final result = await repository.performForwardGeocoding('university of peradeniya');

      print(result.toString());
      expect(result.placeName.isNotEmpty, true);
    });
  });
}
