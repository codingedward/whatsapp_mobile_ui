import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:libphonenumber/libphonenumber.dart';


class PhoneNumberFormatService {
  PhoneNumberFormatService._();
  static final instance = PhoneNumberFormatService._();

  Future<bool> isValid({
    @required phoneNumber,
    @required countryCode,
  }) async {

    try {
      return await PhoneNumberUtil.isValidPhoneNumber(
        phoneNumber: phoneNumber,
        isoCode: countryCode
      );

    } on PlatformException {
      return false;
    }
  }
}