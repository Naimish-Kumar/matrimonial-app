import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/support_ticket/support_ticket_action.dart';
import 'package:active_matrimonial_flutter_app/repository/support_ticket_repository.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../../const/my_theme.dart';
import '../helpers/show_message_state.dart';

ThunkAction<AppState> getSupportTicketMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data = await SupportTicketRepository().fetchTickets();
      store.dispatch(SupportTicketStoreAction(payload: data));
    } catch (e) {
      //debugPrint(e);
      store.dispatch(SupportTicketFailureAction(error: e.toString()));
      return;
    }
  };
}

ThunkAction<AppState> getSupportTicketCategoriesMiddleware() {
  return (Store<AppState> store) async {
    try {
      var response = await SupportTicketRepository().fetchTicketsCategories();
      store.dispatch(SupportTicketCategoriesStoreAction(payload: response));
    } catch (e) {
      //debugPrint(e);
      return;
    }
  };
}

ThunkAction<AppState> storeSupportTicketReplyMiddleware(
    {ticket_id, reply, attachment}) {
  return (Store<AppState> store) async {
    var response = await SupportTicketRepository().replySupportTicket(
      ticket_id: ticket_id,
      reply: reply,
      attachment: attachment,
    );

    print(response.result);
    if (response.result!) {
      store.dispatch(getSupportTicketMiddleware());
      store.dispatch(
          ShowMessageAction(msg: response.message, color: MyTheme.success));
    } else {
      store.dispatch(
          ShowMessageAction(msg: "Something is wrong", color: MyTheme.failure));
    }
  };
}
