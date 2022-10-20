import 'dart:async';
import 'dart:convert';
import 'package:star_wars_fan_app/modules/common/utilities/http_enum.dart';
import 'package:star_wars_fan_app/modules/common/utilities/http_provider.dart';
import 'package:star_wars_fan_app/modules/starships/models/starships_model.dart';

class StarshipApi {
  Future<HTTPResponse<List<StarshipModel>>> getStarships() async {
    final response = await (SWHttpProvider.apiRequest(Method.GET, 'starships'));
    dynamic body = jsonDecode(utf8.decode(response!.bodyBytes));
    if (response.statusCode == 200) {
      List<dynamic>? data = body['results'];
      List<StarshipModel> starships = [];
      if (data != null) {
        starships = data.map((item) => StarshipModel.fromJson(item)).toList();
      }
      return HTTPResponse<List<StarshipModel>>(
        isSuccessful: true,
        data: starships,
        message: HTTPResponse.successMessage,
        statusCode: response.statusCode,
      );
    } else {
      return HTTPResponse<List<StarshipModel>>(
        isSuccessful: false,
        data: null,
        message: body['message'] ?? HTTPResponse.errorMessage,
        statusCode: response.statusCode,
      );
    }
  }

  Future<HTTPResponse<List<StarshipModel>>> getMoreStarships(int? page) async {
    final response =
        await (SWHttpProvider.apiRequest(Method.GET, 'starships/?page=$page'));
    dynamic body = jsonDecode(utf8.decode(response!.bodyBytes));
    if (response.statusCode == 200) {
      List<dynamic>? data = body['results'];
      List<StarshipModel> starships = [];
      if (data != null) {
        starships = data.map((item) => StarshipModel.fromJson(item)).toList();
      }
      return HTTPResponse<List<StarshipModel>>(
        isSuccessful: true,
        data: starships,
        message: HTTPResponse.successMessage,
        statusCode: response.statusCode,
      );
    } else {
      return HTTPResponse<List<StarshipModel>>(
        isSuccessful: false,
        data: null,
        message: body['message'] ?? HTTPResponse.errorMessage,
        statusCode: response.statusCode,
      );
    }
  }
}
