import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_fan_app/modules/planets/models/planets_model.dart';
import 'package:star_wars_fan_app/modules/planets/service/planets_api.dart';
import 'package:star_wars_fan_app/modules/planets/store/planets_store.dart';

class PlanetsActions {
  late PlanetsApi planetsApi;

  late PlanetsStore planetsStore;

  late BuildContext context;

  PlanetsActions(BuildContext context) {
    context = context;
    planetsApi = PlanetsApi();
    planetsStore = Provider.of<PlanetsStore>(context, listen: false);
  }

  Future<List<PlanetsModel>> fetchPlanets() async {
    final planetsRes = await planetsApi.getPlanets();

    if (planetsRes.isSuccessful!) {
      planetsStore.setPlanets(planetsRes.data!);
      return planetsRes.data!;
    } else {
      return [];
    }
  }

  Future<List<PlanetsModel>> fetchMorePlanets(int? page) async {
    final peopleRes = await planetsApi.getMorePlanets(page).then((response) {
      planetsStore.page = planetsStore.page + 1;
    });

    if (peopleRes.isSuccessful!) {
      planetsStore.addPlanetsToList(peopleRes.data!);
      return peopleRes.data!;
    } else {
      return [];
    }
  }
}
