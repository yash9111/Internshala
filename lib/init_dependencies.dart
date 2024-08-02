import 'package:get_it/get_it.dart';
import 'package:internshala/features/internships/data/repo/internship_repo_impl.dart';
import 'package:internshala/features/internships/data/sources/internship_remote_datasource.dart';
import 'package:internshala/features/internships/domain/repo/internship_repo.dart';
import 'package:internshala/features/internships/domain/usecases/get_all_internship_usecase.dart';
import 'package:internshala/features/internships/presentation/bloc/internship_bloc.dart';

final servicelocator = GetIt.instance;

void initDependencies() {
  servicelocator.registerFactory<InternshipRemoteDataSource>(
      () => InternshipRemoteDataSourceImpl());
  servicelocator.registerFactory<InternshipRepo>(
      () => InternshipRepoImpl(internshipRemoteDataSource: servicelocator()));
  servicelocator.registerFactory(
      () => GetAllInternshipUsecase(internshipRepo: servicelocator()));
  servicelocator.registerFactory<InternshipBloc>(
      () => InternshipBloc(servicelocator()));

  
}
