import 'package:flutter/material.dart';

import '../const/my_theme.dart';
import '../const/style.dart';
import '../helpers/device_info.dart';
import 'common_widget.dart';
import 'my_images.dart';

class MyInterestCard extends StatelessWidget {
  final String? photo;
  final String? name;
  final String? status;

  final int? age;
  final String? country;
  final String? religion;
  final String? motherTongue;
  const MyInterestCard({
    Key? key,
    this.photo,
    this.name,
    this.status,
    this.age,
    this.country,
    this.religion,
    this.motherTongue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 3),
      height: 139,
      // box decoration
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0),
        ),
        boxShadow: [CommonWidget.box_shadow()],
      ),
      // child0

      child: Row(
        children: [
          SizedBox(
            height: DeviceInfo(context).height,
            width: 84.0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  bottomLeft: Radius.circular(12.0)),
              child: MyImages.normalImage(photo),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 14.0, top: 16.0, right: 10.0, bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name!,
                        style: Styles.bold_arsenic_14,
                      ),
                      Container(
                        // width: 60,
                        decoration: BoxDecoration(
                            color: status! == "Approved"
                                ? MyTheme.medium_sea_green
                                : MyTheme.very_light_grey,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4.0))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Text(
                            status!,
                            style: Styles.bold_white_10,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "${age.toString()} years",
                          style: Styles.regular_arsenic_14,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          country!,
                          style: Styles.regular_arsenic_14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          religion!,
                          style: Styles.regular_arsenic_14,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          motherTongue!,
                          style: Styles.regular_arsenic_14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
