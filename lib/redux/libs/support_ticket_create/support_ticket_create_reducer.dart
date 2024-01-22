import 'package:active_matrimonial_flutter_app/redux/libs/support_ticket_create/support_ticket_create_state.dart';

class StoreImageAction {
  var image;
  var image_name;

  StoreImageAction({this.image, this.image_name});
}

class StoreSubjectAction {
  var payload;

  StoreSubjectAction({this.payload});
}

class ResetAction {}

SupportTicketCreateState? support_ticket_create_reducer(
    SupportTicketCreateState? state, dynamic action) {
  if (action is StoreImageAction) {
    state!.image = action.image;
    state.img_name = action.image_name;
    return state;
  }
  if (action is StoreSubjectAction) {
    state!.subject_category = action.payload;
    return state;
  }
  if (action is ResetAction) {
    state!.subjectController.clear();
    state.img_name = '';
    state.controller.clear();
    return state;
  }

  return state;
}
