import 'dart:async';
import 'dart:convert';
import 'package:star_wars_fan_app/modules/common/utilities/http_enum.dart';
import 'package:star_wars_fan_app/modules/common/utilities/http_provider.dart';
import 'package:star_wars_fan_app/modules/planets/models/planets_model.dart';

class PlanetsApi {
  Future<HTTPResponse<List<PlanetsModel>>> getPlanets() async {
    final response = await (SWHttpProvider.apiRequest(Method.GET, 'planets'));
    dynamic body = jsonDecode(utf8.decode(response!.bodyBytes));
    if (response.statusCode == 200) {
      List<dynamic>? data = body['results'];
      List<PlanetsModel> planets = [];
      if (data != null) {
        planets = data.map((item) => PlanetsModel.fromJson(item)).toList();
      }
      return HTTPResponse<List<PlanetsModel>>(
        isSuccessful: true,
        data: planets,
        message: HTTPResponse.successMessage,
        statusCode: response.statusCode,
      );
    } else {
      return HTTPResponse<List<PlanetsModel>>(
        isSuccessful: false,
        data: null,
        message: body['message'] ?? HTTPResponse.errorMessage,
        statusCode: response.statusCode,
      );
    }
  }

  Future<HTTPResponse<List<PlanetsModel>>> getMorePlanets(int? page) async {
    final response =
        await (SWHttpProvider.apiRequest(Method.GET, 'planets/?page=$page'));
    dynamic body = jsonDecode(utf8.decode(response!.bodyBytes));
    if (response.statusCode == 200) {
      List<dynamic>? data = body['results'];
      List<PlanetsModel> planets = [];
      if (data != null) {
        planets = data.map((item) => PlanetsModel.fromJson(item)).toList();
      }
      return HTTPResponse<List<PlanetsModel>>(
        isSuccessful: true,
        data: planets,
        message: HTTPResponse.successMessage,
        statusCode: response.statusCode,
      );
    } else {
      return HTTPResponse<List<PlanetsModel>>(
        isSuccessful: false,
        data: null,
        message: body['message'] ?? HTTPResponse.errorMessage,
        statusCode: response.statusCode,
      );
    }
  }
}
