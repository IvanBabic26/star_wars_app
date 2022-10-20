import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_fan_app/modules/people/models/people_model.dart';
import 'package:star_wars_fan_app/modules/people/service/start_wars_api.dart';
import 'package:star_wars_fan_app/modules/people/store/people_store.dart';

class PeopleActions {
  late StarWarsApi clientApi;

  late PeopleStore clientStore;

  late BuildContext context;

  PeopleActions(BuildContext context) {
    context = context;
    clientApi = StarWarsApi();
    clientStore = Provider.of<PeopleStore>(context, listen: false);
  }

  Future<List<PeopleModel>> fetchPeople() async {
    final peopleRes = await clientApi.getClients();

    if (peopleRes.isSuccessful!) {
      clientStore.setPeople(peopleRes.data!);
      return peopleRes.data!;
    } else {
      return [];
    }
  }

  Future<List<PeopleModel>> fetchMore(int? page) async {
    final peopleRes = await clientApi.getMore(page).then((response) {
      clientStore.page = clientStore.page + 1;
    });

    if (peopleRes.isSuccessful!) {
      clientStore.addPhotosToList(peopleRes.data!);
      return peopleRes.data!;
    } else {
      return [];
    }
  }
}
