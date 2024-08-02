import 'package:fpdart/fpdart.dart';
import 'package:internshala/core/error/failure.dart';
import 'package:internshala/features/internships/domain/entity/internship_entity.dart';
import 'package:internshala/features/internships/domain/repo/internship_repo.dart';

class GetAllInternshipUsecase {
  final InternshipRepo internshipRepo;

  GetAllInternshipUsecase({required this.internshipRepo});

  Future<Either<Failure, List<InternshipEntity>>> call() async {
    return await internshipRepo.getAllInternships();
  }
}
