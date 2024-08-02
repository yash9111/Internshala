import 'dart:convert';

import 'package:internshala/core/error/server_exception.dart';
import 'package:internshala/features/internships/data/model/internship_model.dart';
import 'package:http/http.dart' as http;

abstract class InternshipRemoteDataSource {
  Future<List<InternshipModel>> getInternships();
}

class InternshipRemoteDataSourceImpl implements InternshipRemoteDataSource {
  InternshipRemoteDataSourceImpl();

  @override
  Future<List<InternshipModel>> getInternships() async {
    try {
      final response = await http
          .get(Uri.parse('https://internshala.com/flutter_hiring/search'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonMap = json.decode(response.body);
        final List<dynamic> internships =
            jsonMap['internships_meta'].values.toList();

        return internships
            .map((json) => InternshipModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load internships');
      }
    } catch (e) {
      // Return dummy data in case of error
     
      throw ServerException(message: e.toString());
    }
  }
}
