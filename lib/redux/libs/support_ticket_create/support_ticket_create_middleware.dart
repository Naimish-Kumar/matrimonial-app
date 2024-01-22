import '../../../const/my_theme.dart';
import '../../../repository/support_ticket_repository.dart';
import '../../../screens/core.dart';
import '../../app/app_state.dart';
import '../helpers/show_message_state.dart';
import '../support_ticket/support_ticket_middleware.dart';
import '../support_ticket/support_ticket_reducer.dart';

ThunkAction<AppState> supportTicketCreateMiddleware({
  dynamic subject,
  dynamic category,
  dynamic details,
  dynamic image,
}) {
  return (Store<AppState> store) async {
    store.dispatch(SupportLoader());

    var response = await SupportTicketRepository().createSupportTicket(
      subject: subject,
      category: category,
      details: details,
      image: image,
    );

    if (response.result!) {
      store.dispatch(getSupportTicketMiddleware());
      store.dispatch(ShowMessageAction(
          msg: "Information Successfully saved!", color: MyTheme.success));
    } else {
      store.dispatch(
          ShowMessageAction(msg: "Something is wrong", color: MyTheme.failure));
    }
    store.dispatch(SupportLoader());
  };
}
