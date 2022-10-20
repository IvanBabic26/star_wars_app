import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_fan_app/modules/common/components/pagination_bottom_output.dart';
import 'package:star_wars_fan_app/modules/common/constants/common_styles.dart';
import 'package:star_wars_fan_app/modules/starships/components/starship_data_card.dart';
import 'package:star_wars_fan_app/modules/starships/constants/starships_strings.dart';
import 'package:star_wars_fan_app/modules/starships/models/starships_model.dart';
import 'package:star_wars_fan_app/modules/starships/store/starships_store.dart';

class StarshipDataTile extends StatelessWidget {
  StarshipDataTile({Key? key, this.search}) : super(key: key);
  final String? search;
  List<StarshipModel> filteredList = [];
  @override
  Widget build(BuildContext context) {
    filteredList =
        Provider.of<StarshipStore>(context, listen: true).starshipList!;

    if ((search!.isNotEmpty)) {
      List<StarshipModel> tmpList = [];
      for (int i = 0; i < filteredList.length; i++) {
        if (filteredList[i]
                .name!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .model!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .manufacturer!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .costInCredits!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .length!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .maxAtmospheringSpeed!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .crew!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .passengers!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .cargoCapacity!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .consumables!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .hyperdriveRating!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .mGLT!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .starshipClass!
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
                        StarshipsStrings.expansionTileTitle,
                        style: kExpansionTileTitle,
                      ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: Provider.of<StarshipStore>(context, listen: true)
                              .starshipList ==
                          null
                      ? 0
                      : filteredList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return StarshipDataCard(index: index);
                  },
                ),
              ],
            ),
          )
        : ExpansionTile(
            iconColor: kExpansionPanelButton,
            collapsedIconColor: kExpansionPanelButton,
            title: const Text(
              StarshipsStrings.expansionTileTitle,
              style: kExpansionTileTitle,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: Provider.of<StarshipStore>(context, listen: true)
                        .starshipList!
                        .length,
                    itemBuilder: (BuildContext context, int index) {
                      return StarshipDataCard(index: index);
                    }),
              ),
              PaginationBottomOutput(
                name: StarshipsStrings.expansionTileTitle,
                loadMore: Provider.of<StarshipStore>(context, listen: true)
                    .isLoadMoreRunning,
                hasNextPage: Provider.of<StarshipStore>(context, listen: true)
                    .hasNextPage,
              ),
            ],
          );
  }
}
