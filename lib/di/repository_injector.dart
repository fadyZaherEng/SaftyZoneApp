import 'package:hatif_mobile/data/repositories/authentication_repository_implementations.dart';
import 'package:hatif_mobile/di/injector.dart';
import 'package:hatif_mobile/domain/repositories/authentication_repository.dart';

Future<void> initializeRepositoryDependencies() async {
  injector.registerFactory<AuthenticationRepository>(
      () => AuthenticationRepositoryImplementations(injector()));
}
