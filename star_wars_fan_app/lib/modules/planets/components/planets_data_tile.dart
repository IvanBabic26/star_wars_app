import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_fan_app/modules/common/components/pagination_bottom_output.dart';
import 'package:star_wars_fan_app/modules/common/constants/common_styles.dart';
import 'package:star_wars_fan_app/modules/common/utilities/star_wars_data_field.dart';
import 'package:star_wars_fan_app/modules/films/store/films_store.dart';
import 'package:star_wars_fan_app/modules/planets/components/planets_data_card.dart';
import 'package:star_wars_fan_app/modules/planets/constants/planets_strings.dart';
import 'package:star_wars_fan_app/modules/planets/models/planets_model.dart';
import 'package:star_wars_fan_app/modules/planets/store/planets_store.dart';
import 'package:star_wars_fan_app/modules/common/screens/start_wars_data_details.dart';
import 'package:star_wars_fan_app/modules/people/store/people_store.dart';

class PlanetsDataTile extends StatelessWidget {
  PlanetsDataTile({Key? key, this.search}) : super(key: key);
  final String? search;
  List<PlanetsModel> filteredList = [];
  @override
  Widget build(BuildContext context) {
    filteredList =
        Provider.of<PlanetsStore>(context, listen: true).planetsList!;

    if ((search!.isNotEmpty)) {
      List<PlanetsModel> tmpList = [];
      for (int i = 0; i < filteredList.length; i++) {
        if (filteredList[i]
                .name!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .rotationPeriod!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .orbitalPeriod!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .diameter!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .climate!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .gravity!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .terrain!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .surfaceWater!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .population!
                .toLowerCase()
                .contains(search!.toLowerCase())) {
          tmpList.add(filteredList[i]);
        }
      }
      filteredList = tmpList;
    }

    return search!.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                filteredList.isEmpty
                    ? Container()
                    : const Text(
                        PlanetsStrings.expansionTileTitle,
                        style: kExpansionTileTitle,
                      ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: Provider.of<PlanetsStore>(context, listen: true)
                              .planetsList ==
                          null
                      ? 0
                      : filteredList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PlanetsDataCard(index: index);
                  },
                ),
              ],
            ),
          )
        : ExpansionTile(
            iconColor: kExpansionPanelButton,
            collapsedIconColor: kExpansionPanelButton,
            title: const Text(
              PlanetsStrings.expansionTileTitle,
              style: kExpansionTileTitle,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: Provider.of<FilmsStore>(context, listen: true)
                      .filmsList!
                      .length,
                  itemBuilder: (BuildContext context, int index) {
                    return PlanetsDataCard(index: index);
                  },
                ),
              ),
              PaginationBottomOutput(
                name: PlanetsStrings.expansionTileTitle,
                loadMore: Provider.of<PlanetsStore>(context, listen: true)
                    .isLoadMoreRunning,
                hasNextPage: Provider.of<PlanetsStore>(context, listen: true)
                    .hasNextPage,
              ),
            ],
          );
  }
}
