import 'package:active_matrimonial_flutter_app/components/common_app_bar.dart';
import 'package:active_matrimonial_flutter_app/components/my_images.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/blog/blog_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/blog/blog_details.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({Key? key}) : super(key: key);

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      onInit: (store) =>
          [store.dispatch(Reset.blogList), store.dispatch(blogMiddleware())],
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        appBar: CommonAppBar(
                text: AppLocalizations.of(context)!.blogs_screen_appbar_title)
            .build(context),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Const.kPaddingHorizontal, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.common_screen_blogs,
                style: Styles.bold_app_accent_14,
              ),
              const SizedBox(
                height: 10,
              ),

              /// main blog section
              state.blogState!.isFetching!
                  ? Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: MyTheme.storm_grey,
                        ),
                      ),
                    )
                  : buildBlogCards(state)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBlogCards(AppState state) {
    return Expanded(
      child: state.blogState!.blogList!.isNotEmpty
          ? MasonryGridView.count(
              shrinkWrap: true,
              itemCount: state.blogState!.blogList!.length,
              crossAxisCount: 2,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
              itemBuilder: (context, index) {
                return Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyImages.normalImage(
                          state.blogState!.blogList![index].banner),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, top: 10, right: 10, bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              state.blogState!.blogList![index].title,
                              style: Styles.bold_arsenic_12,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              state.blogState!.blogList![index].categoryName,
                              style: Styles.regular_gull_grey_10,
                              maxLines: 1,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BlogDetails(
                                        blog:
                                            state.blogState!.blogList![index]),
                                  ),
                                );
                              },
                              child: Text(
                                AppLocalizations.of(context)!
                                    .blogs_screen_read_full_blogs,
                                style: Styles.bold_app_accent_12,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            )
          : Center(
              child: Text(AppLocalizations.of(context)!.common_no_data),
            ),
    );
  }
}
