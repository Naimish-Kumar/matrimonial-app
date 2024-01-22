import 'dart:io';

import 'package:active_matrimonial_flutter_app/components/common_input.dart';
import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/my_happy_story/get_happy_story_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../components/group_item_with_child.dart';
import '../../redux/libs/my_happy_story/post_happy_story_middleware.dart';

class MyHappyStories extends StatefulWidget {
  const MyHappyStories({Key? key}) : super(key: key);

  @override
  State<MyHappyStories> createState() => _MyHappyStoriesState();
}

class _MyHappyStoriesState extends State<MyHappyStories> {
  WebViewController? controller;

  // country
  var video_provider = ['Youtube', 'Dailymotion', 'Vimeo'];
  String? video_provider_value = 'Youtube';

  @override
  void initState() {
    super.initState();

    if (!store.state.userVerifyState!.isApprove!) {
      OneContext().pop();
      store.dispatch(
        ShowMessageAction(
          msg: "Please verify your account",
          color: MyTheme.failure,
        ),
      );
    } else {
      store.dispatch(happyStoryCheckMiddleware());

      webViewController.loadHtmlString('''
                              <iframe src="${store.state.myHappyStoryState!.src}" style="height:600px; width : 1000px;" frameborder="0" allowfullscreen>></iframe>''');

      if (videoProvider != null) {
        if (videoProvider == 'youtube') {
          var data = store.state.myHappyStoryState!.myHappyStory!.videoLink!
              .split("=");
          var video_link = "";
          // print(data.length);
          if (data.length > 1) {
            video_link = data[1];
          }

          store.state.myHappyStoryState!.src =
              "https://www.youtube.com/embed/$video_link";
        }
        if (videoProvider == 'dailymotion') {
          var video_link = store
              .state.myHappyStoryState!.myHappyStory!.videoLink!
              .split("video/")[1];

          store.state.myHappyStoryState!.src =
              "https://www.dailymotion.com/embed/video/$video_link";
        }
        if (videoProvider == 'vimeo') {
          var video_link = store
              .state.myHappyStoryState!.myHappyStory!.videoLink!
              .split("vimeo.com/")[1];

          store.state.myHappyStoryState!.src =
              "https://player.vimeo.com/video/$video_link";
        }
      }
    }
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController _story_titleController = TextEditingController();
  TextEditingController _story_partnerNameController = TextEditingController();
  TextEditingController _story_videoLinkController = TextEditingController();
  var videoProvider = store.state.myHappyStoryState!.result == false
      ? null
      : store.state.myHappyStoryState!.myHappyStory!.videoProvider;

  //for image uploading
  ImagePicker _picker = ImagePicker();
  File? _image;
  var _img_name;

  WebViewController webViewController = WebViewController();
  GlobalKey<FlutterSummernoteState> descriptionKey = GlobalKey();

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

  send() async {
    if (!_formKey.currentState!.validate()) {
      // store.dispatch(ShowMessageAction(msg: "Form's not validated!"));
    } else {
      // print(_story_titleController.text);
      // print(await descriptionKey.currentState?.getText() ?? '');
      // print(_story_partnerNameController.text);
      // print(_image);
      // print(video_provider_value);
      // print(_story_videoLinkController.text);

      store.dispatch(happystorystoreMiddleware(
        context: context,
        title: _story_titleController.text,
        details: await descriptionKey.currentState?.getText() ?? '',
        partner_name: _story_partnerNameController.text,
        photos: _image,
        video_provider: video_provider_value,
        video_link: _story_videoLinkController.text,
      ));

      store.dispatch(happyStoryCheckMiddleware());
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        appBar: buildAppBar(context),
        body: state.myHappyStoryState!.result!
            ? buildSingleChildScrollViewForData(context, state)
            : buildSingleChildScrollViewForForm(context, state),
      ),
    );
  }

  Widget buildSingleChildScrollViewForForm(
      BuildContext context, AppState state) {
    return SingleChildScrollView(
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
                    buildHappyStoriesFormContainer(context, _formKey, state)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSingleChildScrollViewForData(
      BuildContext context, AppState state) {
    return SingleChildScrollView(
      child: Padding(
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
                  child: Image.network(
                    state.myHappyStoryState!.myHappyStory!.photos!.first,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                state.myHappyStoryState!.myHappyStory!.title!,
                style: Styles.bold_arsenic_14,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(state.myHappyStoryState!.myHappyStory!.date!,
                  style: Styles.regular_gull_grey_10),
              const SizedBox(
                height: 10,
              ),
              Text(
                state.myHappyStoryState!.myHappyStory!.details!,
                style: Styles.regular_arsenic_14,
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: SizedBox(
                  height: 400,
                  width: DeviceInfo(context).width,
                  child: WebViewWidget(
                    controller: webViewController,
                  ),
                ),
              ),
            ],
          ),
        ),
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

        buildGroupItem(
          title: AppLocalizations.of(context)!.happy_stories_form_story_title,
          controller: _story_titleController,
          hint: "Title",
          requiredText: "Title required",
        ),

        GroupItemWithChild(
          title: AppLocalizations.of(context)!.happy_stories_form_story_details,
          child: summerNote(),
        ),

        /// partner name
        buildGroupItem(
          title: AppLocalizations.of(context)!.happy_stories_form_partner_name,
          controller: _story_partnerNameController,
          hint: "Partner Name",
          requiredText: "Partner Name required",
        ),

        /// photos upload
        GroupItemWithChild(
          title: AppLocalizations.of(context)!.happy_stories_form_photos,
          child: InkWell(
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
        ),
        Const.height20,

        /// video provider
        GroupItemWithChild(
          title:
              AppLocalizations.of(context)!.happy_stories_form_video_provider,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: MyTheme.solitude),
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButtonFormField(
                validator: (dynamic val) {
                  if (val == null || val.isEmpty) {
                    return "Required field";
                  }
                  return null;
                },
                iconSize: 0.0,
                decoration: InputDecoration(
                  hintText: "Select One",
                  isDense: true,
                  hintStyle: Styles.regular_gull_grey_12,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: Icon(
                    Icons.keyboard_arrow_down,
                    color: MyTheme.gull_grey,
                  ),
                  // helperText: 'Helper text',
                ),
                value: video_provider_value,
                items: video_provider.map<DropdownMenuItem<dynamic>>((e) {
                  return DropdownMenuItem<dynamic>(
                    value: e,
                    child: Text(
                      e,
                    ),
                  );
                }).toList(),
                onChanged: (dynamic newValue) {
                  setState(() {
                    video_provider_value = newValue;
                  });
                }),
          ),
        ),
        Const.height10,

        ///video link

        buildGroupItem(
            title: AppLocalizations.of(context)!.happy_stories_form_video_link,
            hint: "Video link",
            controller: _story_videoLinkController,
            isMandatory: false),

        Const.height20,

        state.myHappyStoryState!.happyloader == false
            ? InkWell(
                onTap: send,
                child: CommonWidget.manage_profile_update_box(context: context),
              )
            : CommonWidget.circularIndicator,
      ],
    );
  }

  Widget summerNote() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 250,
          width: DeviceInfo(context).width,
          child: FlutterSummernote(
            showBottomToolbar: false,
            customToolbar: """
                  [
                    ['style', ['bold', 'italic', 'underline', 'clear']],
                    ['font', ['fontsize', 'fontname']],
                    ['color', ['forecolor', 'backcolor']],
                    ['para', ['ul', 'ol', 'paragraph']],
                    ['height', ['height']],
                  ]
                  """,
            // value: description,
            key: descriptionKey,
          ),
        ),
      ],
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
        AppLocalizations.of(context)!.my_happy_stories_appbar_title,
        style: Styles.bold_arsenic_16,
      ),
    );
  }

  buildGroupItem({
    String? title,
    TextEditingController? controller,
    String? hint,
    String? requiredText,
    bool? isMandatory = true,
    Widget? child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 15,
        ),
        Text(
          "$title ${isMandatory! ? "*" : ""}",
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: controller,
          decoration: InputStyle.inputDecoration_text_field(hint: hint),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return requiredText;
            }
            return null;
          },
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
