import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:flutter/material.dart';

import '../const/style.dart';
import '../helpers/navigator_push.dart';
import '../screens/contact_us.dart';
import 'common_privacy_and_terms_page.dart';

class ContactAndFaq extends StatelessWidget {
  final String? title;
  final String? content;

  const ContactAndFaq({
    Key? key,
    this.title,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            // print('contact -us');

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ContactUs()),
            );
          },
          child: Text(
            'Contact Us',
            style: Styles.regular_gull_grey_12,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "|",
            style: TextStyle(color: MyTheme.gull_grey),
          ),
        ),
        GestureDetector(
            onTap: () {
              NavigatorPush.push(
                  context,
                  CommonPrivacyAndTerms(
                    title: title,
                    content: content,
                  ));
            },
            child: Text(
              'FAQ',
              style: Styles.regular_gull_grey_12,
            )),
      ],
    );
  }
}
