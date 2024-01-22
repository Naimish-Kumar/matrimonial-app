import 'package:active_matrimonial_flutter_app/models_response/common_models/ddown.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/language_get_response.dart';

class LanguageState {
  bool? isloading;
  bool? saveChangesLoader;
  final LanguageGetResponse? languageGetResponse;
  DDown? selectedMotherTongue;
  List<DDown> selectedKnowLanguage = [];

  dynamic selectedKnowLanguageMap(List<DDown> list) {
    return list.map((e) => {"name": e.name, "id": e.id}).toList();
  }

  update({
  bool? isloading,
  bool? saveChangesLoader,
  final LanguageGetResponse? languageGetResponse,
  DDown? selectedMotherTongue,
  List<DDown>? selectedKnowLanguage
}){
    return  LanguageState(
      isloading: isloading??this.isloading,
      languageGetResponse: languageGetResponse??this.languageGetResponse,
      saveChangesLoader: saveChangesLoader??this.saveChangesLoader,
      selectedKnowLanguage: selectedKnowLanguage??this.selectedKnowLanguage,
      selectedMotherTongue: selectedMotherTongue??this.selectedMotherTongue
    );
  }

  /*
  List<int>getSelectedKnowLanguageIds(){
    List<int> ids=[];
    this.selectedKnowLanguage.forEach((element) {
      ids.add(element.id);
    });
     return ids;
  }*/

  LanguageState(
      {this.languageGetResponse, this.isloading, this.saveChangesLoader,this.selectedKnowLanguage=const [],this.selectedMotherTongue});

  LanguageState.initialState()
      : isloading = false,
        languageGetResponse = LanguageGetResponse.initialState(),
        saveChangesLoader = false;
}
