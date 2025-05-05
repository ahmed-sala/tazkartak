sealed class HistoryState {
  const HistoryState();
}

final class HistoryInitial extends HistoryState {
  const HistoryInitial();
}

final class HistoryLoading extends HistoryState {
  const HistoryLoading();
}

final class HistoryLoaded extends HistoryState {
  const HistoryLoaded();
}

final class HistoryError extends HistoryState {
  final String message;
  const HistoryError(this.message);
}

final class HistoryEmpty extends HistoryState {
  const HistoryEmpty();
}
