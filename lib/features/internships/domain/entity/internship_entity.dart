class InternshipEntity {
  final String title;
  final String companyName;
  final bool workFromHome;
  final String postedByLabel;
  final String? salary;
  final List<String>? labelMobile;
  final bool isActive;
  final String profileName;
  final String duration;
  final List<String> locationNames;

  InternshipEntity({
    required this.title,
    required this.companyName,
    required this.workFromHome,
    required this.postedByLabel,
    this.salary,
    this.labelMobile,
    required this.isActive,
    required this.profileName,
    required this.duration,
    required this.locationNames,
  });
}
