import 'package:active_matrimonial_flutter_app/components/basic_form_widget.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/drop_down/profile_dropdown_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/search/search_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/search_screens/advanced_search.dart';
import 'package:active_matrimonial_flutter_app/screens/search_screens/show_basic_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../redux/libs/search/search_action.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _formKey = GlobalKey<FormState>();

  var religion_value;

  TextEditingController _ageFromController = TextEditingController();
  TextEditingController _ageToController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      onInit: (store) => store.dispatch(profiledropdownMiddleware()),
      builder: (_, state) => Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Const.kPaddingHorizontal, vertical: 0.0),
              child: SizedBox(
                width: DeviceInfo(context).width,
                child: Column(
                  children: [
                    // height from the notification bar
                    const SizedBox(
                      height: 15,
                    ),

                    Center(
                      child: SizedBox(
                        height: 28,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/icon/icon_search__.png'),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              AppLocalizations.of(context)!.search_screen_title,
                              style: Styles.bold_app_accent_16,
                            )
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),
                    // this block is used for main search fields
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          /// first two field
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// age from field
                              Expanded(
                                child: BasicFormWidget(
                                  keyboard_type: TextInputType.number,
                                  text: AppLocalizations.of(context)!
                                      .search_secreen_age_from,
                                  controller: _ageFromController,
                                  style: Styles.bold_app_accent_12,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),

                              /// age to field
                              Expanded(
                                child: BasicFormWidget(
                                  keyboard_type: TextInputType.number,
                                  text: AppLocalizations.of(context)!
                                      .search_screen_to,
                                  controller: _ageToController,
                                  style: Styles.bold_app_accent_12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          /// second religion field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!
                                    .search_screen_religion,
                                style: Styles.bold_app_accent_12,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: MyTheme.solitude),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 50,
                                child: DropdownButtonFormField<dynamic>(
                                  isExpanded: true,
                                  iconSize: 0.0,
                                  value: state.basicSearchState!.religion_value,
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
                                  items: state
                                      .manageProfileCombineState!
                                      .profiledropdownResponseData!
                                      .data!
                                      .religionList!
                                      .map<DropdownMenuItem<dynamic>>((e) {
                                    return DropdownMenuItem<dynamic>(
                                      value: e.id,
                                      child: Text(
                                        e.name!,
                                        style: Styles.regular_gull_grey_12,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (dynamic newValue) {
                                    store.dispatch(BasicSearchReligionAdd(
                                        value: newValue));
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          /// third mother tounge field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!
                                    .search_screen_mother_tongue,
                                style: Styles.bold_app_accent_12,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: MyTheme.solitude),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 50,
                                child: DropdownButtonFormField<dynamic>(
                                  isExpanded: true,
                                  iconSize: 0.0,
                                  value: state.basicSearchState!.mother_tongue,
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
                                  items: state
                                      .manageProfileCombineState!
                                      .profiledropdownResponseData!
                                      .data!
                                      .languageList!
                                      .map<DropdownMenuItem<dynamic>>((e) {
                                    return DropdownMenuItem<dynamic>(
                                      value: e.id,
                                      child: Text(
                                        e.name!,
                                        style: Styles.regular_gull_grey_12,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (dynamic newValue) {
                                    store.dispatch(BasicSearchMotherTongueAdd(
                                        value: newValue));
                                  },
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 35,
                          ),

                          /// search button
                          InkWell(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (!_formKey.currentState!.validate()) {
                                // store.dispatch(ShowMessageAction(
                                //   msg: "Form's not validated!",
                                // ));
                              } else {
                                store.dispatch(Reset.search);
                                store.dispatch(searchMiddleware(
                                    age: _ageFromController.text,
                                    to: _ageToController.text,
                                    religion:
                                        state.basicSearchState!.religion_value,
                                    motherTongue:
                                        state.basicSearchState!.mother_tongue));

                                NavigatorPush.push(
                                    context, const ShowBasicSearch());
                              }
                            },
                            child: Container(
                              height: 50,
                              width: DeviceInfo(context).width,
                              decoration: BoxDecoration(
                                gradient: Styles.buildLinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .advanced_search_screen_btn_text,
                                  style: Styles.bold_white_14,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 25,
                          ),

                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AdvancedSearch()),
                              );
                              store.dispatch(
                                  BasicSearchRemove.motherTongueClear);
                              store.dispatch(BasicSearchRemove.religionClear);
                            },
                            child: Text(
                              AppLocalizations.of(context)!
                                  .common_advanced_search_switch,
                              style: Styles.bold_app_accent_12,
                            ),
                          ),

                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
