import 'package:flutter/foundation.dart';
import 'package:star_wars_fan_app/modules/planets/models/planets_model.dart';
import 'package:star_wars_fan_app/modules/planets/service/planets_api.dart';

class PlanetsStore extends ChangeNotifier {
  late bool _hasNextPage = true;

  bool get hasNextPage => _hasNextPage;

  setNextPage(bool loading) {
    _hasNextPage = loading;
    notifyListeners();
  }

  /// Used to display loading indicators when _initFetch function is running
  late bool _isFirstLoadRunning = false;

  bool get isFirstLoadRunning => _isFirstLoadRunning;

  setFirstLoading(bool loading) {
    _isFirstLoadRunning = loading;
    notifyListeners();
  }

  /// Used to display loading indicators when _fetchMore function is running
  late bool _isLoadMoreRunning = false;

  bool get isLoadMoreRunning => _isLoadMoreRunning;

  setMoreLoading(bool loading) {
    _isLoadMoreRunning = loading;
    notifyListeners();
  }

  List<PlanetsModel>? planetsList = [];

  List<PlanetsModel>? get planetsData => planetsList;

  late int _page = 2;
  int get page => _page;

  set page(int value) {
    _page = value;
    notifyListeners();
  }

  void setPlanets(List<PlanetsModel>? planetsData) {
    planetsList = planetsData;
    notifyListeners();
  }

  PlanetsModel getPlanetsByIndex(int index) => planetsList![index];

  Future<void> fetchMorePlanets() async {
    await PlanetsApi()
        .getMorePlanets(
      _page,
    )
        .then((response) {
      if (response.isSuccessful!) {
        _page = _page + 1;
        print(_page.toString());
        addPlanetsToList(response.data!);
        setNextPage(true);
      } else {
        setNextPage(false);
      }
    });
    notifyListeners();
  }

  void addPlanetsToList(List<PlanetsModel> planetData) {
    planetsList!.addAll(planetData);
    notifyListeners();
  }
}
