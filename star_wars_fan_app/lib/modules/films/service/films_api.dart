import 'dart:async';
import 'dart:convert';
import 'package:star_wars_fan_app/modules/common/utilities/http_enum.dart';
import 'package:star_wars_fan_app/modules/common/utilities/http_provider.dart';
import 'package:star_wars_fan_app/modules/films/models/films_model.dart';

class FilmsApi {
  Future<HTTPResponse<List<FilmsModel>>> getFilms() async {
    final response = await (SWHttpProvider.apiRequest(Method.GET, 'films'));
    dynamic body = jsonDecode(utf8.decode(response!.bodyBytes));
    if (response.statusCode == 200) {
      List<dynamic>? data = body['results'];
      List<FilmsModel> films = [];
      if (data != null) {
        films = data.map((item) => FilmsModel.fromJson(item)).toList();
      }
      return HTTPResponse<List<FilmsModel>>(
        isSuccessful: true,
        data: films,
        message: HTTPResponse.successMessage,
        statusCode: response.statusCode,
      );
    } else {
      return HTTPResponse<List<FilmsModel>>(
        isSuccessful: false,
        data: null,
        message: body['message'] ?? HTTPResponse.errorMessage,
        statusCode: response.statusCode,
      );
    }
  }

  Future<HTTPResponse<List<FilmsModel>>> getMoreFilms(int? page) async {
    final response =
        await (SWHttpProvider.apiRequest(Method.GET, 'films/?page=$page'));
    dynamic body = jsonDecode(utf8.decode(response!.bodyBytes));
    if (response.statusCode == 200) {
      List<dynamic>? data = body['results'];
      List<FilmsModel> films = [];
      if (data != null) {
        films = data.map((item) => FilmsModel.fromJson(item)).toList();
      }
      return HTTPResponse<List<FilmsModel>>(
        isSuccessful: true,
        data: films,
        message: HTTPResponse.successMessage,
        statusCode: response.statusCode,
      );
    } else {
      return HTTPResponse<List<FilmsModel>>(
        isSuccessful: false,
        data: null,
        message: body['message'] ?? HTTPResponse.errorMessage,
        statusCode: response.statusCode,
      );
    }
  }
}
