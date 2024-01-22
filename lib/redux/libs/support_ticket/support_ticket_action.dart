import '../../../models_response/support/my_support_categories_response.dart';
import '../../../models_response/support/my_ticket_response.dart';

class SupportTicketStoreAction {
  MyTicketResponse? payload;

  SupportTicketStoreAction({this.payload});

  @override
  String toString() {
    return 'SupportTicketStoreAction{payload: $payload}';
  }
}

class SupportTicketFailureAction {
  String? error;

  SupportTicketFailureAction({this.error});

  @override
  String toString() {
    return 'SupportTicketFailureAction{error: $error}';
  }
}

class SupportTicketCategoriesStoreAction {
  MyTicketCategoriesResponse? payload;

  SupportTicketCategoriesStoreAction({this.payload});

  @override
  String toString() {
    return 'SupportTicketCategoriesStoreAction{payload: $payload}';
  }
}
