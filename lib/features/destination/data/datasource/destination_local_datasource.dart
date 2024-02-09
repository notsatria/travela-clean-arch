import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:travela/core/error/exceptions.dart';
import 'package:travela/features/destination/data/models/destination_model.dart';

const String cacheAllDestinationsKey = 'ALL_DESTINATIONS';

abstract class DestinationLocalDataSource {
  Future<List<DestinationModel>> getAllDestinations();
  Future<bool> cacheAllDestinations(List<DestinationModel> destinations);
}

class DestinationLocalDataSourceImpl implements DestinationLocalDataSource {
  final SharedPreferences pref;

  DestinationLocalDataSourceImpl(this.pref);

  @override
  Future<bool> cacheAllDestinations(List<DestinationModel> destinations) async {
    List<Map<String, dynamic>> listMap =
        destinations.map((e) => e.toJson()).toList();
    String allDestinations = jsonEncode(listMap);
    return await pref.setString(cacheAllDestinationsKey, allDestinations);
  }

  @override
  Future<List<DestinationModel>> getAllDestinations() async {
    String? allDestinations = pref.getString(cacheAllDestinationsKey);
    if (allDestinations != null) {
      List listMap =
          List<Map<String, dynamic>>.from(jsonDecode(allDestinations));
      return listMap.map((e) => DestinationModel.fromJson(e)).toList();
    } else {
      throw CacheException();
    }
  }
}
