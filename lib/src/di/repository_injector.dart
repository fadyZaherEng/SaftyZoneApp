import 'package:safety_zone/src/data/repositories/authentication_repository_implementations.dart';
import 'package:safety_zone/src/data/repositories/home_repository_implementations.dart';
import 'package:safety_zone/src/di/injector.dart';
import 'package:safety_zone/src/domain/repositories/authentication_repository.dart';
import 'package:safety_zone/src/domain/repositories/home_repository.dart';

Future<void> initializeRepositoryDependencies() async {
  injector.registerFactory<AuthenticationRepository>(
      () => AuthenticationRepositoryImplementations(injector()));
  injector.registerFactory<HomeRepository>(
      () => HomeRepositoryImplementations(injector()));
}
