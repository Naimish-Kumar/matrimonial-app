import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../components/common_app_bar.dart';
import '../const/my_theme.dart';
import '../models_response/common_response.dart';
import '../redux/libs/verify/verify_action.dart';
import '../redux/libs/verify/verify_state.dart';
import 'core.dart';
import 'startup_pages/splash_screen.dart';

class VerifyPage extends StatelessWidget {
  VerifyPage({Key? key}) : super(key: key);

  onVerify(BuildContext context) async {
    Map<String, String> data = {};

    Uri url = Uri.parse("${AppConfig.BASE_URL}/member/verification-info-store");

    Map<String, String> header = {
      "Authorization": "Bearer ${prefs.getString(Const.accessToken)}",
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    final httpReq = http.MultipartRequest("POST", url);
    httpReq.headers.addAll(header);

    for (VerificationModel element in store.state.userVerifyState!.formList!) {
      if (element.type == "text") {
        if (element.data.text.trim().toString().isEmpty) {
          store.dispatch(ShowMessageAction(msg: "${element.title} is Empty"));

          return;
        }
        data.addAll({element.key!: element.data.text.trim().toString()});
      } else if (element.type == "select") {
        if (element.data == null || element.data.toString().isEmpty) {
          store.dispatch(ShowMessageAction(msg: "${element.title} is Empty"));
          return;
        }
        data.addAll({element.key!: element.data.toString()});
      } else if (element.type == "multi_select") {
        if (element.data == null || element.data.isEmpty) {
          store.dispatch(ShowMessageAction(msg: "${element.title} is Empty"));
          return;
        }
        data.addAll({element.key!: element.data.join(",").toString()});
      } else if (element.type == "radio") {
        if (element.data == null || element.data.toString().isEmpty) {
          store.dispatch(ShowMessageAction(msg: "${element.title} is Empty"));
          return;
        }
        data.addAll({element.key!: element.data.toString()});
      } else if (element.type == "file") {
        if (element.data == null || element.data.toString().isEmpty) {
          store.dispatch(ShowMessageAction(msg: "${element.title} is Empty"));
          return;
        }

        final image =
            await http.MultipartFile.fromPath(element.key!, element.data.path);

        httpReq.files.add(image);
      }
    }
    httpReq.fields.addAll(data);
    // print(data);
    var response = await httpReq.send();
    response.stream.bytesToString().then((value) {
      var res = commonResponseFromJson(value);

      store.dispatch(ShowMessageAction(msg: res.message));
      if (res.result) {
        store.dispatch(getUserIsApproveAction());

        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      onInit: (store) => [
        // prefs.remove(Const.isVerificationSent),
        if (store.state.userVerifyState!.verificationInfo!)
          {
            OneContext().pop(),
            store.dispatch(
              ShowMessageAction(
                msg: "Sorry!. you have sent verification request already.",
                color: MyTheme.failure,
              ),
            )
          }
        else
          {
            // print('in else block'),
            store.dispatch(getFormDataAction()),
          }
      ],
      builder: (_, state) => Scaffold(
        appBar: CommonAppBar(
          text: "Verification Form",
        ).build(context),
        body: !state.userVerifyState!.isFetching!
            ? ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                itemBuilder: (context, index) => Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildTitle(
                            state.userVerifyState!.formList![index].title
                                .toString(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (state.userVerifyState!.formList![index].type ==
                              "text")
                            buildEditTextField(
                                state.userVerifyState!.formList![index].title,
                                state.userVerifyState!.formList![index].data)
                          else if (state
                                  .userVerifyState!.formList![index].type ==
                              "select")
                            buildDropDown(
                                index,
                                state.userVerifyState!.formList![index]
                                    as VerificationModel<String?>)
                          else if (state
                                  .userVerifyState!.formList![index].type ==
                              "multi_select")
                            buildMultiSelect(index)
                          else if (state
                                  .userVerifyState!.formList![index].type ==
                              "file")
                            buildFile(index)
                          else if (state
                                  .userVerifyState!.formList![index].type ==
                              "radio")
                            buildRadio(index),
                        ],
                      ),
                    ),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemCount: state.userVerifyState!.formList!.length)
            : CommonWidget.circularIndicator,
        bottomNavigationBar: TextButton(
          onPressed: () => onVerify(context),
          style: TextButton.styleFrom(
              shape: const RoundedRectangleBorder(),
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: MyTheme.app_accent_color,
              alignment: Alignment.center,
              padding: EdgeInsets.zero,
              elevation: 0.0,
              primary: MyTheme.black),
          child: const Text(
            'Submit',
            style: TextStyle(fontSize: 14, color: MyTheme.white),
          ),
        ),
      ),
    );
  }

  Text buildTitle(title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildEditTextField(
      String? hint, TextEditingController? textEditingController) {
    return Container(
      height: 46,
      width: double.infinity,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: MyTheme.white,
        boxShadow: [
          BoxShadow(
            color: MyTheme.black.withOpacity(0.15),
            blurRadius: 20,
            spreadRadius: 0.0,
            offset: const Offset(0.0, 10.0), // shadow direction: bottom right
          )
        ],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: MyTheme.white, width: 1),
      ),
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
            fillColor: MyTheme.light_grey,
            hintText: "hint text",
            hintStyle: TextStyle(fontSize: 12.0, color: MyTheme.light_grey),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyTheme.solitude, width: 1),
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: MyTheme.white.withOpacity(0.5), width: 1),
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            contentPadding: const EdgeInsets.only(left: 16.0)),
      ),
    );
  }

  Widget buildDropDown(int index, VerificationModel<String?> model) {
    return Container(
      height: 46,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: MyTheme.white,
        boxShadow: [
          true
              ? BoxShadow(
                  color: MyTheme.black.withOpacity(0.15),
                  blurRadius: 20,
                  spreadRadius: 0.0,
                  offset:
                      const Offset(0.0, 10.0), // shadow direction: bottom right
                )
              : const BoxShadow()
        ],
      ),
      child: DropdownButton<String>(
        menuMaxHeight: 300,
        isDense: true,
        underline: Container(),
        isExpanded: true,
        onChanged: (String? value) {
          store.dispatch(SetSelectValueAction(payload: value, index: index));
          // store.state.userVerifyState!.formList![index].data = value;
        },
        icon: const Icon(Icons.arrow_drop_down),
        value: model.data,
        items: store.state.userVerifyState!.formList![index].options!
            .map(
              (value) => DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget buildMultiSelect(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 46,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: MyTheme.white,
            boxShadow: [
              true
                  ? BoxShadow(
                      color: MyTheme.black.withOpacity(0.15),
                      blurRadius: 20,
                      spreadRadius: 0.0,
                      offset: const Offset(
                          0.0, 10.0), // shadow direction: bottom right
                    )
                  : const BoxShadow()
            ],
          ),
          child: DropdownButton<String>(
            menuMaxHeight: 300,
            isDense: true,
            underline: Container(),
            isExpanded: true,
            onChanged: (String? value) {
              if (!store.state.userVerifyState!.formList![index].data
                  .contains(value)) {
                // store.state.userVerifyState!.formList![index].data.add(value);
                store.dispatch(
                    SetMultipleSelectValueAction(index: index, payload: value));
              }
            },
            icon: const Icon(Icons.arrow_drop_down),
            items: store.state.userVerifyState!.formList![index].options!
                .map(
                  (value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        Wrap(
          children: List.generate(
            store.state.userVerifyState!.formList![index].data.length,
            (subIndex) => SizedBox(
              width: 110,
              child: Row(
                children: [
                  SizedBox(
                    width: 46,
                    child: Text(
                      store.state.userVerifyState!.formList![index]
                          .data[subIndex],
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      store.dispatch(SetMultipleSelectRemoveAction(
                          index: index, payload: subIndex));
                      // store.state.userVerifyState!.formList![index].data
                      //     .removeAt(subIndex);
                    },
                    child: const Icon(
                      Icons.close,
                      size: 12,
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget radio(index, subIndex) {
    return Radio<String>(
      value: store.state.userVerifyState!.formList![index].options![subIndex],
      groupValue: store.state.userVerifyState!.formList![index].data,
      onChanged: (String? value) {
        store.dispatch(SetSelectValueAction(index: index, payload: value));
        // store.state.userVerifyState!.formList![index].data = value;
      },
    );
  }

  buildRadio(index) {
    return Column(
      children: List.generate(
        store.state.userVerifyState!.formList![index].options!.length,
        (subIndex) => Row(
          children: [
            radio(index, subIndex),
            Text(
              store.state.userVerifyState!.formList![index].options![subIndex],
              style: const TextStyle(fontSize: 14, color: MyTheme.black),
            )
          ],
        ),
      ),
    );
  }

  Widget buildFile(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
          onPressed: () async {
            store.dispatch(getVerifyImageAction(index));
          },
          child: Container(
              decoration: BoxDecoration(
                  color: MyTheme.white,
                  boxShadow: [
                    BoxShadow(
                      color: MyTheme.black.withOpacity(0.15),
                      blurRadius: 20,
                      spreadRadius: 0.0,
                      offset: const Offset(
                          0.0, 10.0), // shadow direction: bottom right
                    )
                  ],
                  borderRadius: BorderRadius.circular(6.0)),
              width: double.infinity,
              height: 46,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Choose file",
                      style: TextStyle(fontSize: 12, color: MyTheme.gull_grey),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: MyTheme.light_grey,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(6.0),
                          bottomRight: Radius.circular(6.0)),
                    ),
                    alignment: Alignment.center,
                    height: 46,
                    width: 80,
                    child: Text(
                      'Browser',
                      style: TextStyle(fontSize: 12, color: MyTheme.gull_grey),
                    ),
                  ),
                ],
              )),
        ),
        const SizedBox(
          height: 8,
        ),
        store.state.userVerifyState!.formList![index].data != null
            ? Image.file(
                store.state.userVerifyState!.formList![index].data,
                height: 80,
                width: 100,
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
