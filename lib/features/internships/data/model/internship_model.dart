import 'package:internshala/features/internships/domain/entity/internship_entity.dart';

class InternshipModel extends InternshipEntity {
  InternshipModel({
    required super.title,
    required super.companyName,
    required super.workFromHome,
    required super.postedByLabel,
    super.salary,
    super.labelMobile,
    required super.isActive,
    required super.profileName,
    required super.duration,
    required super.locationNames,
  });

  factory InternshipModel.fromJson(Map<String, dynamic> json) {
    return InternshipModel(
      title: json['title'],
      companyName: json['company_name'],
      workFromHome: json['work_from_home'],
      postedByLabel: json['posted_by_label'],
      salary: json['stipend']['salary'],
      labelMobile: json['label_mobile'] != null
          ? List<String>.from(json['label_mobile'])
          : null,
      isActive: json['is_active'],
      profileName: json['profile_name'],
      duration: json['duration'],
      locationNames: List<String>.from(json['location_names']),
    );
  }
}
