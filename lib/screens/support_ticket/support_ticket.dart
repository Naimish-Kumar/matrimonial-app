import 'dart:io';

import 'package:active_matrimonial_flutter_app/components/common_app_bar.dart';
import 'package:active_matrimonial_flutter_app/components/common_input.dart';
import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/components/my_images.dart';
import 'package:active_matrimonial_flutter_app/components/name_date_row.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/support_ticket/support_ticket_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/support_ticket_create/support_ticket_create_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:one_context/one_context.dart';

import '../../redux/libs/support_ticket_create/support_ticket_create_middleware.dart';

class SupportTicket extends StatefulWidget {
  const SupportTicket({Key? key}) : super(key: key);

  @override
  State<SupportTicket> createState() => _SupportTicketState();
}

class _SupportTicketState extends State<SupportTicket> {
  final _formKey = GlobalKey<FormState>();

  quill.QuillController _reply_controller = quill.QuillController.basic();

  Future getImage() async {
    try {
      final image = await store.state.supportTicketCreateState!.picker
          .pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporay = File(image.path);

      store.dispatch(StoreImageAction(
          image: imageTemporay,
          image_name: imageTemporay.path.split('/').last));
    } on PlatformException catch (e) {
      print("Failed to pick Image: $e");
    }
  }

  Future getReplyImage() async {
    try {
      final image = await store.state.supportTicketReplyState!.replyImagePicker!
          .pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporay = File(image.path);

      store.dispatch(StoreReplyImageAction(
          image: imageTemporay,
          image_name: imageTemporay.path.split('/').last));
    } on PlatformException catch (e) {
      print("Failed to pick Image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      onInit: (store) => [
        store.dispatch(getSupportTicketMiddleware()),
        store.dispatch(getSupportTicketCategoriesMiddleware())
      ],
      builder: (_, state) => Scaffold(
        appBar: CommonAppBar(
          text: AppLocalizations.of(context)!.support_ticket,
        ).build(context),
        body: Column(
          children: [
            buildCreateTicket(state, context),
            Const.height20,
            state.supportTicketState!.isFetching == false
                ? buildListViewSeparated(state)
                : Expanded(
                    child: CommonWidget.circularIndicator,
                  ),
          ],
        ),
      ),
    );
  }

  Widget buildListViewSeparated(AppState state) {
    return Expanded(
      child: state.supportTicketState!.myTickets!.isEmpty
          ? CommonWidget.noData
          : ListView.separated(
              itemCount: state.supportTicketState!.myTickets!.length,
              separatorBuilder: (BuildContext context, int index) =>
                  Const.height15,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  /// box decoration
                  margin: EdgeInsets.symmetric(
                      horizontal: Const.kPaddingHorizontal),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                      boxShadow: [CommonWidget.box_shadow()]),
                  // child0

                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 14, bottom: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.supportTicketState!.myTickets![index].ticketId,
                          style: Styles.bold_arsenic_14,
                        ),
                        const SizedBox(height: 9),
                        NameDataRow(
                          name: AppLocalizations.of(context)!
                              .support_ticket_status,
                          data: state.supportTicketState!.myTickets![index]
                                      .status ==
                                  0
                              ? "Pending"
                              : "Approved",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: state.supportTicketState!
                                            .myTickets![index].status ==
                                        1
                                    ? MyTheme.green
                                    : MyTheme.app_accent_color,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Const.height5,
                        NameDataRow(
                            name: AppLocalizations.of(context)!
                                .support_ticket_subject,
                            data: state
                                .supportTicketState!.myTickets![index].subject),
                        Const.height5,
                        NameDataRow(
                            name: AppLocalizations.of(context)!
                                .support_ticket_category,
                            data: state.supportTicketState!.myTickets![index]
                                .supportCategoryName),
                        Const.height5,
                        NameDataRow(
                            name: AppLocalizations.of(context)!
                                .support_ticket_new_reply,
                            data: DateFormat('yyyy-MM-dd').format(state
                                .supportTicketState!
                                .myTickets![index]
                                .createdAt)),
                        Const.height20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            /// view ticket
                            /// view ticket
                            buildViewOfTicket(
                                state.supportTicketState!.myTickets![index],
                                state),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget buildViewOfTicket(detail, AppState state) {
    return InkWell(
      onTap: () {
        OneContext().showDialog(
          builder: (context) => AlertDialog(
            scrollable: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            // title of the dialog box
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.support_ticket_details,
                  style: Styles.bold_arsenic_14,
                ),
                IconButton(
                  onPressed: () {
                    state.supportTicketReplyState!.img_name = '';

                    Navigator.pop(context, true);
                  },
                  icon: Image.asset(
                    'assets/icon/icon_cross.png',
                    height: 20,
                    width: 15,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                )
              ],
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  detail.subject,
                  style: Styles.regular_arsenic_12,
                ),
                const Divider(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Container(
                    //   width: DeviceInfo(context).width,
                    //   decoration: BoxDecoration(
                    //       border: Border.all(color: MyTheme.zircon)),
                    //   child: quill.QuillToolbar.basic(
                    //     toolbarIconAlignment: WrapAlignment.start,
                    //     controller: _reply_controller,
                    //     showFontFamily: false,
                    //     showSearchButton: false,
                    //     showIndent: false,
                    //     showHeaderStyle: false,
                    //     showListBullets: false,
                    //     showColorButton: false,
                    //     showFontSize: true,
                    //     showQuote: false,
                    //     showInlineCode: false,
                    //     showLink: false,
                    //     showCodeBlock: false,
                    //     showListCheck: false,
                    //     showDividers: false,
                    //     showClearFormat: false,
                    //     showStrikeThrough: false,
                    //     toolbarSectionSpacing: -2,
                    //     showBackgroundColorButton: false,
                    //     showUnderLineButton: false,
                    //     // showImageButton: false,
                    //     // showVideoButton: false,
                    //   ),
                    // ),
                    Column(
                      children: [
                        // Container(
                        //   height: 100,
                        //   width: DeviceInfo(context).width,
                        //   decoration: BoxDecoration(
                        //       color: MyTheme.solitude,
                        //       border: Border.all(color: MyTheme.zircon)),
                        //   child: quill.QuillEditor.basic(
                        //     sc: _reply_controller,
                        //     readOnly: false, // true for view only mode
                        //   ),
                        // ),
                        Container(
                          width: DeviceInfo(context).width,
                          // height: 50,
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  getReplyImage();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      gradient: Styles.buildLinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Icon(
                                      Icons.attachment,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  final delta =
                                      _reply_controller.document.toPlainText();
                                  store.dispatch(
                                    storeSupportTicketReplyMiddleware(
                                      ticket_id: detail.id,
                                      reply: delta,
                                      attachment:
                                          state.supportTicketReplyState!.image,
                                    ),
                                  );

                                  FocusManager.instance.primaryFocus?.unfocus();
                                  _reply_controller.clear();
                                  state.supportTicketReplyState!.img_name = '';
                                  Navigator.pop(context, true);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      gradient: Styles.buildLinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Icon(
                                      Icons.send,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),

                StoreConnector<AppState, AppState>(
                  converter: (store) => store.state,
                  builder: (_, state3) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '${state3.supportTicketReplyState!.img_name != '' ? state3.supportTicketReplyState!.img_name : "Choose file"}'),
                    ],
                  ),
                ),

                /// reply section

                Container(
                  width: DeviceInfo(context).width,
                  // height: 250,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      detail.reply.length,
                      (index) => ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: MyImages.normalImage(
                                detail.reply[index].repliedUserImage ?? ''),
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(detail.reply[index].reply),
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: MyImages.normalImage(
                                  detail.reply[index].replyAttachment ?? ''),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      foregroundImage: (state
                                  .accountState!.profileData!.memberPhoto ==
                              null
                          ? const AssetImage('assets/images/default_avater.png')
                          : NetworkImage(state.accountState!.profileData!
                              .memberPhoto!)) as ImageProvider<Object>?,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            detail.description,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 100,
                            height: 100,
                            child:
                                MyImages.normalImage(detail.attachments ?? ''),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 7),
        decoration: BoxDecoration(
          gradient: Styles.buildLinearGradient(
              begin: Alignment.topCenter, end: Alignment.bottomCenter),
          borderRadius: const BorderRadius.all(
            Radius.circular(6.0),
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            AppLocalizations.of(context)!.support_ticket_view,
            style: Styles.bold_white_14,
          ),
        ),
      ),
    );
  }

  Widget buildNameDateRow({required var name, required var data}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            name,
            style: Styles.regular_arsenic_12,
          ),
        ),
        Expanded(
          child: Text(
            data,
            style: Styles.bold_arsenic_12,
          ),
        )
      ],
    );
  }

  Widget buildCreateTicket(AppState state, BuildContext context) {
    return InkWell(
      onTap: () => buildCreateTicketShowDialog(state),
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: Const.kPaddingHorizontal, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(16.0),
          ),
          color: MyTheme.zircon,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 22),
          child: Center(
            child: Column(
              children: [
                IconButton(
                  icon: Image.asset(
                    'assets/icon/icon_plus.png',
                    height: 20,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: null,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(AppLocalizations.of(context)!.support_ticket_create_ticket,
                    style: Styles.regular_storm_grey_12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> buildCreateTicketShowDialog(AppState state) {
    return OneContext().showDialog(
      builder: (context) => StatefulBuilder(builder: (context, snapshot) {
        return AlertDialog(
          scrollable: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Create Ticket",
                style: Styles.bold_arsenic_14,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                icon: Image.asset(
                  'assets/icon/icon_cross.png',
                  height: 15,
                  width: 10,
                  color: MyTheme.arsenic,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              )
            ],
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          content: buildCreateTicketForm(context, state),
        );
      }),
    );
  }

  Widget buildCreateTicketForm(BuildContext context, AppState state) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          /// subject
          Text(
            AppLocalizations.of(context)!.support_ticket_subject,
            style: Styles.bold_arsenic_12,
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: store.state.supportTicketCreateState!.subjectController,
            decoration: InputStyle.inputDecoration_text_field(
                hint: "Enter Ticket Subject"),
          ),
          const SizedBox(
            height: 15,
          ),

          /// subject  category
          Text(
            AppLocalizations.of(context)!.support_ticket_sub_category,
            style: Styles.bold_arsenic_12,
          ),
          const SizedBox(
            height: 8,
          ),

          SizedBox(
            height: 50,
            child: DropdownButtonFormField(
              hint: Text(
                'Select One',
                style: Styles.regular_gull_grey_12,
              ),
              iconSize: 0.0,
              decoration: InputStyle.inputDecoration_text_field(
                  suffixIcon: const Icon(Icons.keyboard_arrow_down)),
              items: state.supportTicketState!.ticketCategories!
                  .map<DropdownMenuItem<dynamic>>((e) {
                return DropdownMenuItem<dynamic>(
                  value: e.id,
                  child: Text(
                    e.name,
                    style: Styles.regular_gull_grey_12,
                  ),
                );
              }).toList(),
              onChanged: (dynamic newValue) {
                store.dispatch(StoreSubjectAction(payload: newValue));
              },
            ),
          ),

          const SizedBox(
            height: 15,
          ),
          Text(
            AppLocalizations.of(context)!.support_ticket_details,
            style: Styles.bold_arsenic_12,
          ),
          const SizedBox(
            height: 8,
          ),
          // Container(
          //   width: DeviceInfo(context).width,
          //   decoration:
          //       BoxDecoration(border: Border.all(color: MyTheme.zircon)),
          //   child: quill.QuillToolbar.basic(
          //     toolbarIconAlignment: WrapAlignment.start,
          //     controller: store.state.supportTicketCreateState!.controller,
          //     showFontFamily: false,
          //     showSearchButton: false,
          //     showIndent: false,
          //     showHeaderStyle: false,
          //     showListBullets: false,
          //     showColorButton: false,
          //     showFontSize: true,
          //     showQuote: false,
          //     showInlineCode: false,
          //     showLink: false,
          //     showCodeBlock: false,
          //     showListCheck: true,
          //     showDividers: false,
          //     showClearFormat: false,
          //     showStrikeThrough: false,
          //     toolbarSectionSpacing: -2,
          //     showBackgroundColorButton: false,
          //     showUnderLineButton: false,
          //   ),
          // ),
          // Container(
          //   height: 100,
          //   width: DeviceInfo(context).width,
          //   decoration: BoxDecoration(
          //       color: MyTheme.solitude,
          //       border: Border.all(color: MyTheme.zircon)),
          //   child: quill.QuillEditor.basic(
          //     controller: store.state.supportTicketCreateState!.controller,
          //     readOnly: false, // true for view only mode
          //   ),
          // ),

          const SizedBox(
            height: 15,
          ),

          StoreConnector<AppState, AppState>(
            converter: (store) => store.state,
            builder: (context, state2) => Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                TextFormField(
                  readOnly: true,
                  decoration: InputStyle.inputDecoration_text_field(
                      hint: state2.supportTicketCreateState!.img_name != ''
                          ? state2.supportTicketCreateState!.img_name
                          : "Choose file"),
                ),
                Positioned(
                  right: 5,
                  child: SizedBox(
                    width: 100,
                    child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(MyTheme.white),
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          getImage();
                        },
                        child: const Text('Browse')),
                  ),
                )
              ],
            ),
          ),

          const SizedBox(
            height: 15,
          ),

          InkWell(
            onTap: () {
              final delta = store
                  .state.supportTicketCreateState!.controller.document
                  .toPlainText();

              store.dispatch(supportTicketCreateMiddleware(
                  subject: store
                      .state.supportTicketCreateState!.subjectController.text,
                  category: store
                      .state.supportTicketCreateState!.subject_category
                      .toString(),
                  details: delta,
                  image: store.state.supportTicketCreateState!.image));

              FocusManager.instance.primaryFocus?.unfocus();
              store.dispatch(ResetAction());

              Navigator.of(context).pop();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 7),
              decoration: BoxDecoration(
                gradient: Styles.buildLinearGradient(
                    begin: Alignment.topCenter, end: Alignment.bottomCenter),
                borderRadius: const BorderRadius.all(
                  Radius.circular(6.0),
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!.support_ticket_send,
                  style: Styles.bold_white_14,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SupportTicketReplyState {
  ImagePicker? replyImagePicker = ImagePicker();
  File? image;
  var img_name;

  SupportTicketReplyState({this.image, this.img_name, this.replyImagePicker});

  SupportTicketReplyState.initialState() : img_name = '';
}

class StoreReplyImageAction {
  var image;
  var image_name;

  StoreReplyImageAction({this.image, this.image_name});
}

SupportTicketReplyState? support_ticket_reply_reducer(
    SupportTicketReplyState? state, dynamic action) {
  if (action is StoreReplyImageAction) {
    state!.image = action.image;
    state.img_name = action.image_name;
    return state;
  }

  return state;
}
