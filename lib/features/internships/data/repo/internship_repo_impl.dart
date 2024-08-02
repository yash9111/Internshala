import 'package:fpdart/src/either.dart';
import 'package:internshala/core/error/failure.dart';
import 'package:internshala/core/error/server_exception.dart';
import 'package:internshala/features/internships/data/sources/internship_remote_datasource.dart';
import 'package:internshala/features/internships/domain/entity/internship_entity.dart';
import 'package:internshala/features/internships/domain/repo/internship_repo.dart';

class InternshipRepoImpl implements InternshipRepo {
  final InternshipRemoteDataSource internshipRemoteDataSource;

  InternshipRepoImpl({required this.internshipRemoteDataSource});
  @override
  Future<Either<Failure, List<InternshipEntity>>> getAllInternships() async {
    try {
     
      final internships =
          await internshipRemoteDataSource.getInternships();
      return right(internships);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
