import 'dart:io';

import 'package:active_matrimonial_flutter_app/components/common_input.dart';
import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/my_happy_story/post_happy_story_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:image_picker/image_picker.dart';

class HappyStoriesForm extends StatefulWidget {
  const HappyStoriesForm({Key? key}) : super(key: key);

  @override
  State<HappyStoriesForm> createState() => _HappyStoriesFormState();
}

class _HappyStoriesFormState extends State<HappyStoriesForm> {
  final _formKey = GlobalKey<FormState>();

  quill.QuillController _controller = quill.QuillController.basic();

  TextEditingController _story_titleController = TextEditingController();
  TextEditingController _story_partnerNameController = TextEditingController();
  TextEditingController _story_videoProviderController =
      TextEditingController();
  TextEditingController _story_videoLinkController = TextEditingController();

  //for image uploading
  ImagePicker _picker = ImagePicker();
  File? _image;
  var _img_name;

  Future getImage() async {
    try {
      final image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporay = File(image.path);

      setState(() {
        _image = imageTemporay;
        _img_name = imageTemporay.path.split('/').last;
      });
    } on PlatformException catch (e) {
      print("Failed to pick Image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        appBar: buildAppBar(context),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Const.kPaddingHorizontal, vertical: 11),
              child: Column(
                children: [
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          buildHappyStoriesFormContainer(
                              context, _formKey, state)
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        icon: Image.asset(
          'assets/icon/icon_pop.png',
          height: 16,
          width: 23,
        ),
      ),
      titleSpacing: 0,
      elevation: 0.0,
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      title: Text(
        AppLocalizations.of(context)!.happy_stories_form_appbar_title,
        style: Styles.bold_arsenic_16,
      ),
    );
  }

  Widget buildHappyStoriesFormContainer(
      BuildContext context, _f_key, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.happy_stories_form_sub_title,
          style: Styles.bold_app_accent_14,
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          "${AppLocalizations.of(context)!.happy_stories_form_story_title} *",
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: _story_titleController,
          decoration: InputStyle.inputDecoration_text_field(hint: "Title"),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Title required";
            }
          },
        ),
        const SizedBox(
          height: 20,
        ),

        Text(AppLocalizations.of(context)!.happy_stories_form_story_details,
            style: Styles.bold_arsenic_12),
        const SizedBox(
          height: 5,
        ),
        // quill.QuillToolbar.basic(
        //   controller: _controller,
        //   showFontFamily: false,
        //   showSearchButton: false,
        //   showIndent: false,
        //   showHeaderStyle: false,
        //   showListBullets: true,
        //   showColorButton: false,
        //   showFontSize: false,
        //   showQuote: false,
        //   showInlineCode: false,
        //   showLink: false,
        //   showCodeBlock: false,
        //   showListCheck: false,
        //   showDividers: true,
        //   showClearFormat: false,
        //   showStrikeThrough: false,
        //   toolbarSectionSpacing: 0,
        //   showBackgroundColorButton: false,
        //   showUnderLineButton: false,
        //   // showImageButton: false,
        //   // showVideoButton: false,
        // ),
        // Container(
        //   height: 100,
        //   decoration: BoxDecoration(
        //       color: MyTheme.solitude, borderRadius: BorderRadius.circular(12)),
        //   child: quill.QuillEditor.basic(
        //     controller: _controller,
        //     readOnly: false, // true for view only mode
        //   ),
        // ),

        /// partner name
        const SizedBox(
          height: 15,
        ),
        Text(
          AppLocalizations.of(context)!.happy_stories_form_partner_name + " *",
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: _story_partnerNameController,
          decoration:
              InputStyle.inputDecoration_text_field(hint: "Partner Name"),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Partner Name required";
            }
          },
        ),

        /// photos upload
        const SizedBox(
          height: 15,
        ),
        Text(
          AppLocalizations.of(context)!.happy_stories_form_photos + " *",
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        InkWell(
          onTap: () {
            getImage();
          },
          child: Stack(children: [
            TextFormField(
              readOnly: true,
              decoration: InputStyle.inputDecoration_text_field(
                  hint: _img_name != null ? _img_name : "Choose file"),
            ),
            Positioned(
              top: 5,
              bottom: 5,
              right: 5,
              child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(MyTheme.zircon),
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    getImage();
                  },
                  child: Text(
                    'Browse',
                    style: TextStyle(color: MyTheme.gull_grey),
                  )),
            )
          ]),
        ),

        /// video provider
        const SizedBox(
          height: 15,
        ),
        Text(
          AppLocalizations.of(context)!.happy_stories_form_video_provider,
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: _story_videoProviderController,
          decoration: InputStyle.inputDecoration_text_field(hint: "Youtube"),
        ),

        ///video link
        const SizedBox(
          height: 15,
        ),
        Text(
          AppLocalizations.of(context)!.happy_stories_form_video_link,
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: _story_videoLinkController,
          decoration: InputStyle.inputDecoration_text_field(hint: "Video link"),
        ),
        const SizedBox(
          height: 40,
        ),

        state.myHappyStoryState!.happyloader == false
            ? InkWell(
                onTap: () {
                  if (!_formKey.currentState!.validate()) {
                    store.dispatch(
                        ShowMessageAction(msg: "Form's not validated!"));
                  } else {
                    store.dispatch(happystorystoreMiddleware(
                      context: context,
                      title: _story_titleController.text,
                      details: _controller.document.toPlainText(),
                      partner_name: _story_partnerNameController.text,
                      photos: _image,
                      video_provider: _story_videoProviderController.text,
                      video_link: _story_videoLinkController.text,
                    ));

                    // store.dispatch(getHappyStoryMiddleware());
                  }
                },
                child: CommonWidget.manage_profile_update_box(context: context))
            : Center(
                child: CircularProgressIndicator(
                  color: MyTheme.storm_grey,
                ),
              ),
      ],
    );
  }
}
