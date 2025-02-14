part of 'line_metro_cubit.dart';

@immutable
sealed class LineMetroState {}

final class LineMetroStateInitial extends LineMetroState {}
class LineMetroUpdateSelectionState extends LineMetroState {}