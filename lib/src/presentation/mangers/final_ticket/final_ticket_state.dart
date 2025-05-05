sealed class FinalTicketState {
  const FinalTicketState();
}

final class FinalTicketInitial extends FinalTicketState {
  const FinalTicketInitial();
}

final class FinalTicketLoading extends FinalTicketState {
  const FinalTicketLoading();
}

final class FinalTicketSuccess extends FinalTicketState {
  const FinalTicketSuccess();
}

final class FinalTicketError extends FinalTicketState {
  final String error;
  const FinalTicketError(this.error);
}
