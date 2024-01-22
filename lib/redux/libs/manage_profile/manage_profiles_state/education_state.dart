import 'package:active_matrimonial_flutter_app/components/basic_form_widget.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/education_get_response.dart';

class EducationState {
  bool? isLoading;
  bool? saveChanges;
  final EducationGetResponse? educationGetResponse;
  bool? update_changes;
  int? index;
  int? delIndex;
  bool? isDelete;

  var list = <EducationViewModel>[];

  EducationState(
      {this.delIndex,
      this.isDelete,
      this.index,
      this.isLoading,
      this.saveChanges,
      this.educationGetResponse,
      this.update_changes});

  EducationState.initialState()
      : educationGetResponse = EducationGetResponse.initialState(),
        update_changes = false,
        isLoading = false,
        isDelete = false,
        saveChanges = false;
}
