import 'package:active_matrimonial_flutter_app/components/shades.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../const/const.dart';
import '../const/my_theme.dart';
import '../const/style.dart';
import '../helpers/device_info.dart';
import '../helpers/navigator_push.dart';
import '../screens/blog/blog_details.dart';
import 'common_widget.dart';

class BlogCard extends StatelessWidget {
  final bool? isFetching;
  final List? blogList;

  const BlogCard({
    this.isFetching,
    this.blogList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      child: isFetching!
          ? CommonWidget.circularIndicator
          : blogList!.isNotEmpty
              ? ListView.separated(
                  padding: EdgeInsets.symmetric(
                      horizontal: Const.kPaddingHorizontal),
                  scrollDirection: Axis.horizontal,
                  itemCount: blogList!.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    width: 15,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        NavigatorPush.push(
                          context,
                          BlogDetails(
                            blog: blogList![index],
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 360,
                            width: 220,
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16.0)),
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/220x320.png',
                                image: blogList![index].banner,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Shades.transparent_dark(),
                          Positioned(
                            bottom: 20,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 14.0, right: 14.0),
                              child: SizedBox(
                                width: DeviceInfo(context).width! * .5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      blogList![index].title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Styles.bold_white_12,
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      blogList![index].categoryName,
                                      style: Styles.italic_light_grey_12,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => BlogDetails(
                                              blog: blogList![index],
                                            ),
                                          ),
                                        );
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                MyTheme.app_accent_color),
                                        fixedSize: MaterialStateProperty.all(
                                            const Size(90.0, 30.0)),
                                        overlayColor: MaterialStateProperty.all(
                                            MyTheme.app_accent_color),
                                        shape: MaterialStateProperty.all(
                                          const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8.0)),
                                              side: BorderSide(
                                                  color: MyTheme
                                                      .app_accent_color)),
                                        ),
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context)!.view_more,
                                        style: Styles.medium_white_12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : CommonWidget.noData,
    );
  }
}
