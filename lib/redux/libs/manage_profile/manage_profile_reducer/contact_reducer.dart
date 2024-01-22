import 'package:active_matrimonial_flutter_app/enums/enums.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/contact_get_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/contact_state.dart';

import '../../../../const/const.dart';
import '../../../../screens/startup_pages/splash_screen.dart';

class ContactStoreAction {
  ContactGetResponse? payload;

  ContactStoreAction({this.payload});

  @override
  String toString() {
    return 'ContactStoreAction{payload: $payload}';
  }
}

ContactState? contact_reducer(ContactState? state, dynamic action) {
  if (action is ContactStoreAction) {
    state!.contactData = action.payload!.data;
    // set new name to prefs
    prefs.setString(Const.userEmail, state.contactData!.email!);
    return state;
  }

  if (action == SaveChanges.contact) {
    state!.cdsave = !state.cdsave!;
    return state;
  }

  return state;
}
