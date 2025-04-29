import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:zamzam/core/config/service_locator.dart';

import 'package:zamzam/core/constant/constant_word.dart';
import 'package:zamzam/core/exceptions/service_exception.dart';

class HeaderConfig {
  static Options getHeader({bool useToken = true}) {
    if (sl.get<SharedPreferences>().getString(TOKEN) == null) {
      throw NoTokenFound();
    } else {
      if (useToken) {
        return Options(
          headers: {
            'Content-Type': 'application/json',
            "Authorization":
                "Bearer ${sl.get<SharedPreferences>().getString(TOKEN)}",
          },
        );
      } else {
        return Options(headers: {'Content-Type': 'application/json'});
      }
    }
  }
}