import 'package:flutter/foundation.dart';
import 'package:star_wars_fan_app/modules/films/models/films_model.dart';
import 'package:star_wars_fan_app/modules/films/service/films_api.dart';

class FilmsStore extends ChangeNotifier {
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

  List<FilmsModel>? filmsList = [];

  List<FilmsModel>? get filmsData => filmsList;

  late int _page = 2;
  int get page => _page;

  set page(int value) {
    _page = value;
    notifyListeners();
  }

  void setFilms(List<FilmsModel>? filmData) {
    filmsList = filmData;
    notifyListeners();
  }

  FilmsModel getFilmsByIndex(int index) => filmsList![index];

  Future<void> fetchMoreFilms() async {
    await FilmsApi()
        .getMoreFilms(
      _page,
    )
        .then((response) {
      if (response.isSuccessful!) {
        _page = _page + 1;
        print(_page.toString());
        addFilmsToList(response.data!);
        setNextPage(true);
        setMoreLoading(true);
      } else {
        setNextPage(false);
      }
    });
    notifyListeners();
  }

  void addFilmsToList(List<FilmsModel> filmData) {
    filmsList!.addAll(filmData);
    notifyListeners();
  }
}
