import 'package:flutter/material.dart';
import 'package:star_wars_fan_app/modules/common/constants/common_styles.dart';

class StarWardsDataField {
  String capitalize(String? string) {
    return "${string![0].toUpperCase()}${string.substring(1).toLowerCase()}";
  }

  Widget filledData(String? data, String title) {
    switch (data) {
      case null:
        return Container();
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 8.0, 0.0, 8.0),
      child: Row(
        children: [
          Text(
            title,
            style: kCardDataTitle,
          ),
          Expanded(
              child: Text(
            capitalize(data!),
            style: kCardDataValue,
          )),
        ],
      ),
    );
  }
}
