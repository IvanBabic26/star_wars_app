import 'package:flutter/foundation.dart';
import 'package:star_wars_fan_app/modules/people/models/people_model.dart';
import 'package:star_wars_fan_app/modules/people/service/start_wars_api.dart';

class PeopleStore extends ChangeNotifier {
  final bool _loading = false;

  // Map<String?, PeopleModel> people = {};
  //
  // bool getLoading() => _loading;
  //
  // void setLoading(bool loading) {
  //   _loading = loading;
  //   notifyListeners();
  // }
  //
  // void setPeople(Map<String?, PeopleModel> peopleData) {
  //   people = peopleData;
  //   notifyListeners();
  // }
  //
  // Map<String?, PeopleModel>? getPeople() => people;

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

  List<PeopleModel>? peopleList = [];

  List<PeopleModel>? get peopleData => peopleList;

  late int _page = 2;
  int get page => _page;

  set page(int value) {
    _page = value;
    notifyListeners();
  }

  void setPeople(List<PeopleModel>? peopleData) {
    peopleList = peopleData;
    notifyListeners();
  }

  PeopleModel getPeopleByIndex(int index) => peopleList![index];

  Future<void> fetchMorePeople() async {
    setMoreLoading(true);
    await StarWarsApi()
        .getMore(
      _page,
    )
        .then((response) {
      if (response.isSuccessful!) {
        _page = _page + 1;
        print(_page.toString());
        addPhotosToList(response.data!);
        setNextPage(true);
      } else {
        setNextPage(false);
      }
    });
    setMoreLoading(false);
    notifyListeners();
  }

  void addPhotosToList(List<PeopleModel> photoData) {
    peopleList!.addAll(photoData);
    notifyListeners();
  }
}
