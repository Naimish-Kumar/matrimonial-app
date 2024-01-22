import 'package:active_matrimonial_flutter_app/enums/enums.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/public_profile/public_profile_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/public_profile/public_profile_state.dart';

class PublicProfileLoader {}

PublicProfileState? public_profile_reducer(
    PublicProfileState? state, dynamic action) {
  if (action is PublicProfileStoreAction) {
    return store(state!, action);
  }
  if (action is PublicProfileFailureAction) {
    state!.error = action.error;
    return state;
  }
  if (action == Reset.publicProfile) {
    state = PublicProfileState.initialState();
    return state;
  }
  return state;
}

store(PublicProfileState state, PublicProfileStoreAction action) {
  print(action);
  state.isFetching = false;
  state.intro = action.data.intoduction;
  state.basic = action.data.basicInfo;
  state.contact = action.data.contactDetails;
  state.presentaddress = action.data.presentAddress;
  state.permanentaddress = action.data.permanentAddress;
  state.education = action.data.education;
  state.career = action.data.career;
  state.physical = action.data.physicalAttributes;
  state.language = action.data.knownLanguages;
  state.mothertongue = action.data.motherTongue;
  state.hobbies = action.data.hobbiesInterest;
  state.attitude = action.data.attitudeBehavior;
  state.resi = action.data.residenceInfo;
  state.spiritual = action.data.spiritualBackgrounds;
  state.lifestyle = action.data.lifestyles;
  state.astrologies = action.data.astrologies;
  state.partner = action.data.partnerExpectation;
  state.photogallery = action.data.photoGallery;
  state.profilematch = action.data.profileMatch;
  state.families = action.data.familiesInformation;
  state.viewContactCheck = action.data.viewContactCheck;
  state.profilePicRequest=action.data.profilePicRequest;
  return state;
}
