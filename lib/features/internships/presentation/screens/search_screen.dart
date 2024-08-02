import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internshala/features/internships/domain/entity/internship_entity.dart';
import 'package:internshala/features/internships/presentation/bloc/internship_bloc.dart';
import 'package:internshala/features/internships/presentation/screens/filter_screen.dart';
import 'package:internshala/features/internships/presentation/screens/widgets/internship_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<InternshipEntity> internships;
  @override
  void initState() {
    context.read<InternshipBloc>().add(FetchInternships());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Icon(Icons.menu),
        titleSpacing: -8,
        title: const Text(
          'Internships',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: BlocConsumer<InternshipBloc, InternshipState>(
        listener: (context, state) {
          if (state is InternshipFetched) {
            internships = (state.internships);
          }
          setState(() {});
        },
        builder: (context, state) {
          if (state is InternshipLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return state is InternshipFetched
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 10),
                          OutlinedButton.icon(
                              style: const ButtonStyle(
                                  foregroundColor:
                                      WidgetStatePropertyAll(Colors.blue),
                                  surfaceTintColor:
                                      WidgetStatePropertyAll(Colors.blue)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const FilterScreen()));
                              },
                              label: const Text(
                                "Filter",
                                style: TextStyle(color: Colors.blue),
                              ),
                              icon: const Icon(
                                Icons.filter_alt_outlined,
                                color: Colors.blue,
                              )),
                          const SizedBox(height: 10),
                          Text(
                            '${internships.length} total internships',
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider()
                        ],
                      ),
                      state.internships.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: internships.length,
                                itemBuilder: (context, index) {
                                  return InternshipCard(
                                      internship: internships[index]);
                                },
                              ),
                            )
                          : const Center(
                              child: Text(
                                "No Internships Available",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                    ],
                  ),
                )
              : const Center(
                  child: Text(
                    "Unable to fetch internships,\nCheck you network",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                );
        },
      ),
    );
  }
}
