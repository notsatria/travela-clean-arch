import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:travela/core/api/urls.dart';
import 'package:travela/core/error/exceptions.dart';
import 'package:travela/features/destination/data/models/destination_model.dart';

abstract class DestinationRemoteDataSource {
  Future<List<DestinationModel>> getDestinations();
  Future<List<DestinationModel>> getTops();
  Future<List<DestinationModel>> searchDestinations(String query);
}

class DestinationRemoteDataSourceImpl implements DestinationRemoteDataSource {
  final http.Client client;

  DestinationRemoteDataSourceImpl(this.client);

  @override
  Future<List<DestinationModel>> getDestinations() async {
    Uri url = Uri.parse('${URLs.base}/destination/all.php');
    final response = await client.get(url).timeout(
          const Duration(seconds: 3),
        );

    if (response.statusCode == 200) {
      List list = jsonDecode(response.body);
      return list.map((e) => DestinationModel.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<DestinationModel>> getTops() async {
    Uri url = Uri.parse('${URLs.base}/destination/top.php');
    final response = await client.get(url).timeout(
          const Duration(seconds: 3),
        );

    if (response.statusCode == 200) {
      List list = jsonDecode(response.body);
      return list.map((e) => DestinationModel.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<DestinationModel>> searchDestinations(String query) async {
    Uri url = Uri.parse('${URLs.base}/destination/search.php');
    final body = {'query': query};

    final response = await client.post(url, body: body).timeout(
          const Duration(seconds: 3),
        );

    if (response.statusCode == 200) {
      List list = jsonDecode(response.body);
      return list.map((e) => DestinationModel.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else {
      throw ServerException();
    }
  }
}
