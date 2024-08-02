import 'package:fpdart/fpdart.dart';
import 'package:internshala/core/error/failure.dart';
import 'package:internshala/features/internships/domain/entity/internship_entity.dart';

abstract interface class InternshipRepo {
  Future<Either<Failure, List<InternshipEntity>>> getAllInternships();
}
