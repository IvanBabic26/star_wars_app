import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_fan_app/modules/species/models/species_model.dart';
import 'package:star_wars_fan_app/modules/species/service/species_api.dart';
import 'package:star_wars_fan_app/modules/species/store/species_store.dart';

class SpeciesActions {
  late SpeciesApi speciesApi;

  late SpeciesStore speciesStore;

  late BuildContext context;

  SpeciesActions(BuildContext context) {
    context = context;
    speciesApi = SpeciesApi();
    speciesStore = Provider.of<SpeciesStore>(context, listen: false);
  }

  Future<List<SpeciesModel>> fetchSpecies() async {
    final peopleRes = await speciesApi.getSpecies();

    if (peopleRes.isSuccessful!) {
      speciesStore.setSpecies(peopleRes.data!);
      return peopleRes.data!;
    } else {
      return [];
    }
  }

  Future<List<SpeciesModel>> fetchMoreSpecies(int? page) async {
    final peopleRes = await speciesApi.getMoreSpecies(page).then((response) {
      speciesStore.page = speciesStore.page + 1;
    });

    if (peopleRes.isSuccessful!) {
      speciesStore.addSpeciesToList(peopleRes.data!);
      return peopleRes.data!;
    } else {
      return [];
    }
  }
}
