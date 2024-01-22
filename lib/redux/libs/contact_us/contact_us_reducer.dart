import 'package:active_matrimonial_flutter_app/enums/enums.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/contact_us/contact_us_state.dart';

import 'contact_us_action.dart';

ContactUsState? contact_us_reducer(ContactUsState? state, dynamic action) {
  if (action == SaveChanges.contactUs) {
    state!.isSubmit = !state.isSubmit;
    return state;
  }
  if (action is SetContactUsKeyValueAction) {
    print(action.keyValuePayload);
    state!.googleRecaptchaKey = action.keyValuePayload;
    return state;
  }
  if (action is SetContactUsIsCaptchaShowingAction) {
    print(action.payload);

    state!.isCaptchaShowing = action.payload;
    return state;
  }

  return state;
}
