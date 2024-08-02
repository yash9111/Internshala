import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internshala/features/internships/domain/entity/internship_entity.dart';
import 'package:internshala/features/internships/domain/usecases/get_all_internship_usecase.dart';

part 'internship_event.dart';
part 'internship_state.dart';

class InternshipBloc extends Bloc<InternshipEvent, InternshipState> {
  final GetAllInternshipUsecase getAllInternshipUsecase;
  InternshipBloc(this.getAllInternshipUsecase) : super(InternshipInitial()) {
    on<InternshipEvent>((event, emit) {
      emit(InternshipLoading());
    });
    on<FetchInternships>(
      (event, emit) async {
        final res = await getAllInternshipUsecase();
        res.fold(
          (l) => emit(InternshipFailure(error: l.message)),
          (r) => emit(
            InternshipFetched(internships: r),
          ),
        );
      },
    );
    on<FilterInternships>(
      (event, emit) async {
        final res = await getAllInternshipUsecase();
        List<InternshipEntity> internships = [];
        res.fold(
          (l) => {},
          (r) => {internships=r},
        );

        List<InternshipEntity> filteredInternships =
            internships.where((internship) {
          bool matchesProfile = event.selectedProfiles.isEmpty ||
              event.selectedProfiles.contains(internship.profileName);

          bool matchesCity = event.selectedCities.isEmpty ||
              internship.locationNames
                  .any((location) => event.selectedCities.contains(location));

          bool matchesDuration = event.selectedDuration == null ||
              internship.duration == event.selectedDuration;

          return matchesProfile && matchesCity && matchesDuration;
        }).toList();

        emit(InternshipFetched(internships: filteredInternships));
      },
    );
  }
}
