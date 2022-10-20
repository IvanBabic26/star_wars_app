import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_fan_app/modules/common/components/pagination_bottom_output.dart';
import 'package:star_wars_fan_app/modules/common/constants/common_styles.dart';
import 'package:star_wars_fan_app/modules/people/components/people_data_card.dart';
import 'package:star_wars_fan_app/modules/people/constants/people_strings.dart';
import 'package:star_wars_fan_app/modules/people/models/people_model.dart';
import 'package:star_wars_fan_app/modules/people/store/people_store.dart';

class PeopleDataTile extends StatelessWidget {
  PeopleDataTile({Key? key, this.search}) : super(key: key);
  final String? search;
  List<PeopleModel> filteredList = [];
  @override
  Widget build(BuildContext context) {
    filteredList = Provider.of<PeopleStore>(context, listen: true).peopleList!;

    if ((search!.isNotEmpty)) {
      List<PeopleModel> tmpList = [];
      for (int i = 0; i < filteredList.length; i++) {
        if (filteredList[i]
                .name!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .height!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .mass!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .hairColor!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .skinColor!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .eyeColor!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .birthYear!
                .toLowerCase()
                .contains(search!.toLowerCase()) ||
            filteredList[i]
                .gender!
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
                        PeopleStrings.expansionTileTitle,
                        style: kExpansionTileTitle,
                      ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: Provider.of<PeopleStore>(context, listen: true)
                              .peopleList ==
                          null
                      ? 0
                      : filteredList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PeopleDataCard(index: index);
                  },
                )
              ],
            ),
          )
        : ExpansionTile(
      iconColor: kExpansionPanelButton,
      collapsedIconColor: kExpansionPanelButton,
            title: const Text(
              PeopleStrings.expansionTileTitle,
              style: kExpansionTileTitle,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: Provider.of<PeopleStore>(context, listen: true)
                      .peopleList!
                      .length,
                  itemBuilder: (BuildContext context, int index) {
                    return PeopleDataCard(index: index);
                  },
                ),
              ),
              PaginationBottomOutput(
                name: PeopleStrings.expansionTileTitle,
                loadMore: Provider.of<PeopleStore>(context, listen: true)
                    .isLoadMoreRunning,
                hasNextPage:
                    Provider.of<PeopleStore>(context, listen: true).hasNextPage,
              ),
            ],
          );
  }
}
