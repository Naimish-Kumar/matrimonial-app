import 'package:flutter/material.dart';

import '../const/const.dart';
import '../const/my_theme.dart';
import '../const/style.dart';
import 'common_widget.dart';

class TrustedUserCard extends StatelessWidget {
  final bool isFetching;
  final List cardList;

  const TrustedUserCard({
    super.key,
    required this.isFetching,
    required this.cardList,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: isFetching
          ? CommonWidget.circularIndicator
          : cardList.isNotEmpty
              ? ListView.separated(
                  padding: EdgeInsets.symmetric(
                      horizontal: Const.kPaddingHorizontal),
                  scrollDirection: Axis.horizontal,
                  itemCount: cardList.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    width: 20,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 130,
                      decoration: BoxDecoration(
                        color: MyTheme.arsenic,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          children: [
                            SizedBox(
                              width: 44,
                              height: 38,
                              child: cardList[index].icon != null
                                  ? Image.network(cardList[index].icon)
                                  : const Icon(
                                      Icons.error,
                                      color: Colors.white,
                                    ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              cardList[index].title,
                              style: Styles.medium_zircon_14,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              : CommonWidget.noData,
    );
  }
}
