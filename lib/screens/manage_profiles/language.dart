import 'package:active_matrimonial_flutter_app/components/common_app_bar_manageprofile.dart';
import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/components/toast_component.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/main_helpers.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/language_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/language_state.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multiselect/multiselect.dart';
import 'package:toast/toast.dart';

import '../../helpers/device_info.dart';
import '../../models_response/common_models/ddown.dart';
import '../../redux/libs/manage_profile/manage_profile_middleware/manage_profile_update_middlewares.dart';

class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  final _formKey = GlobalKey<FormState>();

  setInitData(LanguageState data) {
    data.saveChangesLoader = false;
    List<DDown> knownLanguage = [];
    if (data.languageGetResponse!.result != null &&
        data.languageGetResponse!.result!) {
      data.selectedKnowLanguage.clear();
      store.state.manageProfileCombineState!.profiledropdownResponseData!.data!
          .languageList!
          .forEach((element) {
        if (element.id == data.languageGetResponse!.data!.motherTongue?.id) {
          data.selectedMotherTongue = element;
        }
        data.languageGetResponse!.data!.knownLanguages!.forEach((knowL) {
          if (knowL.id == element.id) {
            knownLanguage.add(element);
          }
        });
      });
      if (knownLanguage.isNotEmpty) {
        store.state.manageProfileCombineState!.languageState!
            .selectedKnowLanguage
            .addAll(knownLanguage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LanguageState?>(
      converter: (state) =>
          store.state.manageProfileCombineState?.languageState,
      onInit: (store) => [
        setProfileDropdownValues(),
        setInitData(store.state.manageProfileCombineState!.languageState!),

        // print(store.state.manageProfileCombineState.profiledropdownResponseData==null),
      ],
      builder: (_, state) => Scaffold(
        appBar: CommonAppBarManageProfile(
          text: AppLocalizations.of(context)!.public_profile_Lang,
        ).build(context),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Const.kPaddingHorizontal,
                vertical: Const.kPaddingVertical),
            child: Form(
              key: _formKey,
              child: build_body(context, state),
            ),
          ),
        ),
      ),
    );
  }

  Widget build_mother_tongue(BuildContext context, LanguageState? state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.search_screen_mother_tongue,
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: MyTheme.solitude),
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: CommonWidget().buildDropdownButtonFormField(
              store.state.manageProfileCombineState!
                  .profiledropdownResponseData!.data!.languageList!, (value) {
            state.selectedMotherTongue = value;
          }, value: state!.selectedMotherTongue),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget build_known_language(BuildContext context, LanguageState? state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.public_profile_known_language,
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: MyTheme.solitude),
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DropDownMultiSelect<DDown>(
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: MyTheme.gull_grey,
              size: 20.0,
            ),
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
            options: store.state.manageProfileCombineState!
                .profiledropdownResponseData!.data!.languageList!,
            menuItembuilder: (data) {
              return StatefulBuilder(builder: (context, snapshot) {
                return Row(
                  children: [
                    Checkbox(
                        value: state?.selectedKnowLanguage.contains(data),
                        onChanged: (onChanged) {
                          if (onChanged != null) {
                            if (onChanged) {
                              state?.selectedKnowLanguage.add(data);
                              store.dispatch(UpdateKnowLanguage(
                                  state!.selectedKnowLanguage));
                            } else {
                              state?.selectedKnowLanguage.remove(data);
                            }
                          }
                          store.dispatch(
                              UpdateKnowLanguage(state!.selectedKnowLanguage));
                          snapshot(() {});
                        }),
                    Text(data.name ?? ""),
                  ],
                );
              });
            },
            childBuilder: (list) {
              return Row(
                children: List.generate(
                    list.length, (index) => Text("${list[index].name} " ?? "")),
              );
            },
            selectedValues: state?.selectedKnowLanguage ?? [],
            onChanged: (value) {
              List<DDown> selectedIds = [];
              for (var selectedName in value) {
                var language = store.state.manageProfileCombineState!
                    .profiledropdownResponseData!.data!.languageList!
                    .firstWhere((lang) => lang.id == selectedName.id);
                selectedIds.add(language);
              }

              if (value == null) return;
              state!.selectedKnowLanguage.clear();
              state.update(selectedKnowLanguage: selectedIds);
            },
            whenEmpty: "No data found",
          ),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }

  build_body(BuildContext context, LanguageState? state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.public_profile_your_lang,
          style: Styles.bold_app_accent_14,
        ),
        Const.height25,
        build_mother_tongue(context, state),
        build_known_language(context, state),
        buildSaveChanges(state, context)
      ],
    );
  }

  Widget buildSaveChanges(LanguageState? state, BuildContext context) {
    return InkWell(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        if (!_formKey.currentState!.validate()) {
          // store.dispatch(ShowMessageAction(msg: "Form's not validated!"));
        } else if (!state!.saveChangesLoader!) {
          store.dispatch(
            languageUpdateMiddleware(
              mother_tongue: state.selectedMotherTongue?.id,
              known_language: DDown().getIds(state.selectedKnowLanguage),
            ),
          );
        } else {
          ToastComponent.showDialog(context, "Please Wait...",
              gravity: Toast.center, bgColor: MyTheme.white);
        }
      },
      child: Container(
        height: 45,
        width: DeviceInfo(context).width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: const Alignment(0.8, 1),
            colors: [
              MyTheme.gradient_color_1,
              MyTheme.gradient_color_2,
            ],
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(6.0),
          ),
        ),
        child: state!.saveChangesLoader!
            ? Center(
                child: CircularProgressIndicator(
                  color: MyTheme.storm_grey,
                ),
              )
            : Center(
                child: Text(
                  AppLocalizations.of(context)!.save_change_btn_text,
                  style: Styles.bold_white_14,
                ),
              ),
      ),
    );
  }
}
