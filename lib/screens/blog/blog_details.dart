import 'package:active_matrimonial_flutter_app/components/common_app_bar.dart';
import 'package:active_matrimonial_flutter_app/components/my_images.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogDetails extends StatefulWidget {
  final blog;

  const BlogDetails({this.blog, Key? key}) : super(key: key);

  @override
  State<BlogDetails> createState() => _BlogDetailsState();
}

class _BlogDetailsState extends State<BlogDetails> {
  @override
  Widget build(BuildContext context) {
    final blog = widget.blog;

    return Scaffold(
      appBar: CommonAppBar(
              text: AppLocalizations.of(context)!
                  .blog_details_screen_appbar_title)
          .build(context),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Const.kPaddingHorizontal, vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: DeviceInfo(context).width,
                height: 170,

                /// image
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                  child: MyImages.normalImage(blog.banner),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                blog.title,
                style: Styles.bold_arsenic_14,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(blog.categoryName, style: Styles.regular_gull_grey_10),
              const SizedBox(
                height: 10,
              ),
              Html(
                  shrinkWrap: true,
                  data: widget.blog.description,
                  onLinkTap: (url, _, __) async {
                    // print(url);
                    if (await canLaunchUrl(Uri.parse(url!))) {
                      await launchUrl(Uri.parse(url!));
                    } else {
                      throw 'Could not launch $url';
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
