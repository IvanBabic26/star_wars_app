import 'dart:async';
import 'dart:convert';
import 'package:star_wars_fan_app/modules/common/utilities/http_enum.dart';
import 'package:star_wars_fan_app/modules/common/utilities/http_provider.dart';
import 'package:star_wars_fan_app/modules/people/models/people_model.dart';

class StarWarsApi {
  Future<HTTPResponse<List<PeopleModel>>> getClients() async {
    final response = await (SWHttpProvider.apiRequest(Method.GET, 'people'));
    dynamic body = jsonDecode(utf8.decode(response!.bodyBytes));
    if (response.statusCode == 200) {
      List<dynamic>? data = body['results'];
      List<PeopleModel> vehicles = [];
      if (data != null) {
        vehicles = data.map((item) => PeopleModel.fromJson(item)).toList();
      }
      // Map<String?, PeopleModel> peopleMap = {};
      // data.forEach((peopleData) {
      //   PeopleModel people = PeopleModel.fromJson(peopleData);
      //   peopleMap[people.name] = people;
      // });
      return HTTPResponse<List<PeopleModel>>(
        isSuccessful: true,
        data: vehicles,
        message: HTTPResponse.successMessage,
        statusCode: response.statusCode,
      );
    } else {
      return HTTPResponse<List<PeopleModel>>(
        isSuccessful: false,
        data: null,
        message: body['message'] ?? HTTPResponse.errorMessage,
        statusCode: response.statusCode,
      );
    }
  }

  Future<HTTPResponse<List<PeopleModel>>> getMore(int? page) async {
    final response =
        await (SWHttpProvider.apiRequest(Method.GET, 'people/?page=$page'));
    dynamic body = jsonDecode(utf8.decode(response!.bodyBytes));
    if (response.statusCode == 200) {
      List<dynamic>? data = body['results'];
      List<PeopleModel> vehicles = [];
      if (data != null) {
        vehicles = data.map((item) => PeopleModel.fromJson(item)).toList();
      }
      // Map<String?, PeopleModel> peopleMap = {};
      // data.forEach((peopleData) {
      //   PeopleModel people = PeopleModel.fromJson(peopleData);
      //   peopleMap[people.name] = people;
      // });
      return HTTPResponse<List<PeopleModel>>(
        isSuccessful: true,
        data: vehicles,
        message: HTTPResponse.successMessage,
        statusCode: response.statusCode,
      );
    } else {
      return HTTPResponse<List<PeopleModel>>(
        isSuccessful: false,
        data: null,
        message: body['message'] ?? HTTPResponse.errorMessage,
        statusCode: response.statusCode,
      );
    }
  }
}
