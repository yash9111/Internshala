import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internshala/features/internships/domain/entity/internship_entity.dart';
import 'package:internshala/features/internships/presentation/bloc/internship_bloc.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({
    super.key,
  });

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  Set<String> selectedProfiles = {};
  Set<String> selectedCities = {};
  String? selectedDuration;
  List<InternshipEntity> internships = [];

  List<String> profiles = [];
  List<String> cities = [];
  List<String> durations = [];

  @override
  void initState() {
    super.initState();
    context.read<InternshipBloc>().add(FetchInternships());
  }

  void _extractFilterOptions() {
    for (var internship in internships) {
      profiles.add(internship.profileName);
      cities.addAll(internship.locationNames);
      durations.add(internship.duration);
    }
    profiles = profiles.toSet().toList(); // Removing duplicates
    cities = cities.toSet().toList(); // Removing duplicates
    durations = durations.toSet().toList(); // Removing duplicates
  }

  void _toggleProfileSelection(String profile) {
    setState(() {
      if (selectedProfiles.contains(profile)) {
        selectedProfiles.remove(profile);
      } else {
        selectedProfiles.add(profile);
      }
    });
  }

  void _toggleCitySelection(String city) {
    setState(() {
      if (selectedCities.contains(city)) {
        selectedCities.remove(city);
      } else {
        selectedCities.add(city);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: -8,
        title: const Text(
          'Filters',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: BlocConsumer<InternshipBloc, InternshipState>(
        listener: (context, state) {
          if (state is InternshipFetched) {
            internships = state.internships;
            _extractFilterOptions();
          }
        },
        builder: (context, state) {
          if (state is InternshipLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Profile',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                Wrap(
                  spacing: 8.0,
                  children: profiles.map((profile) {
                    return ChoiceChip(
                      backgroundColor: Colors.white,
                      label: Text(profile,
                          style: const TextStyle(
                            fontSize: 12,
                          )),
                      selected: selectedProfiles.contains(profile),
                      selectedColor: Colors.blue.shade50,
                      onSelected: (_) {
                        _toggleProfileSelection(profile);
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                const Text('City',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                Wrap(
                  spacing: 8.0,
                  children: cities.map((city) {
                    return ChoiceChip(
                      backgroundColor: Colors.white,
                      label: Text(city,
                          style: const TextStyle(
                            fontSize: 12,
                          )),
                      selected: selectedCities.contains(city),
                      selectedColor: Colors.blue.shade50,
                      onSelected: (_) {
                        _toggleCitySelection(city);
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                const Text('Max Duration',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                DropdownButton<String>(
                  isExpanded: true,
                  dropdownColor: Colors.white,
                  value: selectedDuration,
                  hint: const Text('Select Duration',
                      style: TextStyle(
                        fontSize: 12,
                      )),
                  items: durations.map((duration) {
                    return DropdownMenuItem<String>(
                      value: duration,
                      child: Text(duration,
                          style: const TextStyle(
                            fontSize: 12,
                          )),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedDuration = value;
                    });
                  },
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.blue,
                              backgroundColor: Colors.white,
                              overlayColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                selectedProfiles.clear();
                                selectedCities.clear();
                                selectedDuration = null;
                                Navigator.pop(context);
                              });
                            },
                            child: const Text('Clear All'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              context
                                  .read<InternshipBloc>()
                                  .add(FilterInternships(
                                    selectedDuration,
                                    selectedProfiles,
                                    selectedCities,
                                  ));

                              Navigator.pop(context);
                            },
                            child: const Text('Apply'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
