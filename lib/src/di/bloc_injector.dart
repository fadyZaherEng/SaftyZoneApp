import 'package:safety_zone/src/core/utils/app_config.dart';
import 'package:safety_zone/src/di/injector.dart';
import 'package:safety_zone/src/presentation/blocs/main/main_cubit.dart';
import 'package:safety_zone/src/presentation/blocs/requests/requests_bloc.dart';
import 'package:safety_zone/src/presentation/blocs/term_conditions/term_conditions_bloc.dart';
import 'package:safety_zone/src/presentation/blocs/theme/theme_cubit.dart';
import 'package:safety_zone/src/presentation/blocs/upload_doc/upload_doc_bloc.dart';
import 'package:safety_zone/src/presentation/blocs/working_progress/working_progress_bloc.dart';

Future<void> initializeBlocDependencies() async {
  injector.registerFactory<MainCubit>(() => MainCubit(
        injector(),
        injector(),
      ));
  injector.registerFactory<AppConfig>(() => AppConfig());
  injector.registerFactory<TermConditionsBloc>(() => TermConditionsBloc(
        injector(),
      ));
  injector.registerFactory<WorkingProgressBloc>(() => WorkingProgressBloc());
  injector.registerFactory<UploadDocBloc>(() => UploadDocBloc(
        injector(),
        injector(),
      ));
  injector.registerFactory<RequestsBloc>(() => RequestsBloc(
        injector(),
        injector(),
      ));
  injector.registerFactory<ThemeCubit>(() => ThemeCubit(
        injector(),
        injector(),
      ));
}
