import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_fan_app/modules/people/models/people_model.dart';
import 'package:star_wars_fan_app/modules/starships/models/starships_model.dart';
import 'package:star_wars_fan_app/modules/starships/service/starships_api.dart';
import 'package:star_wars_fan_app/modules/starships/store/starships_store.dart';

class StarshipActions {
  late StarshipApi starshipApi;

  late StarshipStore starshipStore;

  late BuildContext context;

  StarshipActions(BuildContext context) {
    context = context;
    starshipApi = StarshipApi();
    starshipStore = Provider.of<StarshipStore>(context, listen: false);
  }

  Future<List<StarshipModel>> fetchStarships() async {
    final peopleRes = await starshipApi.getStarships();

    if (peopleRes.isSuccessful!) {
      starshipStore.setStarships(peopleRes.data!);
      return peopleRes.data!;
    } else {
      return [];
    }
  }

  Future<List<PeopleModel>> fetchMoreStarships(int? page) async {
    final peopleRes = await starshipApi.getMoreStarships(page).then((response) {
      starshipStore.page = starshipStore.page + 1;
    });

    if (peopleRes.isSuccessful!) {
      starshipStore.addStarshipsToList(peopleRes.data!);
      return peopleRes.data!;
    } else {
      return [];
    }
  }
}
