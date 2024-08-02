part of 'internship_bloc.dart';

@immutable
sealed class InternshipEvent {}

class FetchInternships extends InternshipEvent {}

class FilterInternships extends InternshipEvent {
  final Set<String> selectedProfiles;
  final Set<String> selectedCities;
  final String? selectedDuration;


  FilterInternships(
    this.selectedDuration,
    this.selectedProfiles,
    this.selectedCities, );
}
