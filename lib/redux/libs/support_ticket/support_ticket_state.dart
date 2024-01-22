import 'package:active_matrimonial_flutter_app/models_response/support/ticket_reply_response.dart';

class SupportTicketState {
  bool? isFetching;
  List? myTickets = [];
  List? ticketCategories = [];
  String? error;

  final TicketReplyResponse? ticketReplyResponse;

  SupportTicketState({
    this.isFetching,
    this.error,
    this.myTickets,
    this.ticketCategories,
    this.ticketReplyResponse,
  });

  SupportTicketState.initialState()
      : myTickets = [],
        ticketCategories = [],
        error = '',
        ticketReplyResponse = TicketReplyResponse.initialState(),
        isFetching = true;
}
