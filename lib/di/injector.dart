import 'package:get_it/get_it.dart';
import 'package:hatif_mobile/di/bloc_injector.dart';
import 'package:hatif_mobile/di/data_layer_injector.dart';
import 'package:hatif_mobile/di/repository_injector.dart';
import 'package:hatif_mobile/di/use_case_injector.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  await initializeDataDependencies();
  await initializeRepositoryDependencies();
  await initializeUseCaseDependencies();
  await initializeBlocDependencies();
}
