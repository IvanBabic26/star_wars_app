import 'package:flutter/foundation.dart';
import 'package:star_wars_fan_app/modules/starships/models/starships_model.dart';
import 'package:star_wars_fan_app/modules/starships/service/starships_api.dart';

class StarshipStore extends ChangeNotifier {
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

  List<StarshipModel>? starshipList = [];

  List<StarshipModel>? get starshipData => starshipList;

  late int _page = 2;
  int get page => _page;

  set page(int value) {
    _page = value;
    notifyListeners();
  }

  void setStarships(List<StarshipModel>? starshipData) {
    starshipList = starshipData;
    notifyListeners();
  }

  StarshipModel getStarshipByIndex(int index) => starshipList![index];

  Future<void> fetchMoreStarships() async {
    await StarshipApi()
        .getMoreStarships(
      _page,
    )
        .then((response) {
      if (response.isSuccessful!) {
        _page = _page + 1;
        print(_page.toString());
        addStarshipsToList(response.data!);
        setNextPage(true);
      } else {
        setNextPage(false);
      }
    });
    notifyListeners();
  }

  void addStarshipsToList(List<StarshipModel> starshipData) {
    starshipList!.addAll(starshipData);
    notifyListeners();
  }
}
