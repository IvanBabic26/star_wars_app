import 'package:flutter/foundation.dart';
import 'package:star_wars_fan_app/modules/species/models/species_model.dart';
import 'package:star_wars_fan_app/modules/species/service/species_api.dart';

class SpeciesStore extends ChangeNotifier {
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

  List<SpeciesModel>? speciesList = [];

  List<SpeciesModel>? get speciesData => speciesList;

  late int _page = 2;
  int get page => _page;

  set page(int value) {
    _page = value;
    notifyListeners();
  }

  void setSpecies(List<SpeciesModel>? speciesData) {
    speciesList = speciesData;
    notifyListeners();
  }

  SpeciesModel getSpeciesByIndex(int index) => speciesList![index];

  Future<void> fetchMoreSpecies() async {
    await SpeciesApi()
        .getMoreSpecies(
      _page,
    )
        .then((response) {
      if (response.isSuccessful!) {
        _page = _page + 1;
        print(_page.toString());
        addSpeciesToList(response.data!);
        setNextPage(true);
      } else {
        setNextPage(false);
      }
    });
    notifyListeners();
  }

  void addSpeciesToList(List<SpeciesModel> speciesData) {
    speciesList!.addAll(speciesData);
    notifyListeners();
  }
}
