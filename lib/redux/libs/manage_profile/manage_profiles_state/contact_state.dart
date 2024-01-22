import '../../../../models_response/manage_profile/get_manage_profile/contact_get_response.dart';

class ContactState {
  bool? cdloading;
  bool? cdsave;
  ContactData? contactData;

  ContactState({
    this.cdloading,
    this.cdsave,
    this.contactData,
  });

  ContactState.initialState()
      : cdloading = false,
        cdsave = false;
}
