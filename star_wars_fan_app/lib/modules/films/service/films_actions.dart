import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_fan_app/modules/films/models/films_model.dart';
import 'package:star_wars_fan_app/modules/films/service/films_api.dart';
import 'package:star_wars_fan_app/modules/films/store/films_store.dart';

class FilmsActions {
  late FilmsApi filmsApi;

  late FilmsStore filmsStore;

  late BuildContext context;

  FilmsActions(BuildContext context) {
    context = context;
    filmsApi = FilmsApi();
    filmsStore = Provider.of<FilmsStore>(context, listen: false);
  }

  Future<List<FilmsModel>> fetchFilms() async {
    final filmsRes = await filmsApi.getFilms();

    if (filmsRes.isSuccessful!) {
      filmsStore.setFilms(filmsRes.data!);
      return filmsRes.data!;
    } else {
      return [];
    }
  }

  Future<List<FilmsModel>> fetchMoreFilms(int? page) async {
    final filmsRes = await filmsApi.getMoreFilms(page).then((response) {
      filmsStore.page = filmsStore.page + 1;
    });

    if (filmsRes.isSuccessful!) {
      filmsStore.addFilmsToList(filmsRes.data!);
      return filmsRes.data!;
    } else {
      return [];
    }
  }
}
