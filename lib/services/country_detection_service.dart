import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';

typedef void CountryDetectionFailCallback(String error);
typedef void CountryDetectionSuccessCallback(String countryCode);

class CountryDetectionService {
  CountryDetectionService._();
  static final instance = CountryDetectionService._();

  Future<void> detect({
    @required CountryDetectionFailCallback onFail,
    @required CountryDetectionSuccessCallback onSuccess,
  }) async {
    try {
      final String countryCode = await FlutterSimCountryCode.simCountryCode;
      onSuccess(countryCode);
    } on PlatformException catch (e) {
      onFail(e.message);
    }
  }
}
