part of 'internship_bloc.dart';

@immutable
sealed class InternshipState {}

final class InternshipInitial extends InternshipState {}

final class InternshipLoading extends InternshipState {}

final class InternshipFetched extends InternshipState {
  final List<InternshipEntity> internships;

  InternshipFetched({required this.internships});
}

final class InternshipFailure extends InternshipState {
  final String error;

  InternshipFailure({required this.error});
}
