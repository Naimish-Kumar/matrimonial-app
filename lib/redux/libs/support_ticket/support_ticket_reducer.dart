import 'package:active_matrimonial_flutter_app/redux/libs/support_ticket/support_ticket_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/support_ticket/support_ticket_state.dart';

import '../../../enums/enums.dart';

class SupportLoader {}

SupportTicketState? support_ticket_reducer(
    SupportTicketState? state, dynamic action) {
  if (action is SupportTicketStoreAction) {
    state!.isFetching = false;
    state.myTickets = action.payload!.data;
    return state;
  }

  if (action is SupportTicketFailureAction) {
    state!.error = action.error;
    return state;
  }
  if (action == Reset.supportTickets) {
    state = SupportTicketState.initialState();
    return state;
  }

  if (action is SupportTicketCategoriesStoreAction) {
    state!.ticketCategories = action.payload!.data;
    return state;
  }

  return state;
}
