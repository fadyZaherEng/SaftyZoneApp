import 'package:hatif_mobile/core/utils/app_config.dart';
import 'package:hatif_mobile/di/injector.dart';
import 'package:hatif_mobile/presentation/blocs/main/main_cubit.dart';
import 'package:hatif_mobile/presentation/blocs/requests/requests_bloc.dart';
import 'package:hatif_mobile/presentation/blocs/term_conditions/term_conditions_bloc.dart';
import 'package:hatif_mobile/presentation/blocs/theme/theme_cubit.dart';
import 'package:hatif_mobile/presentation/blocs/upload_doc/upload_doc_bloc.dart';
 import 'package:hatif_mobile/presentation/blocs/working_progress/working_progress_bloc.dart';

Future<void> initializeBlocDependencies() async {
  injector.registerFactory<MainCubit>(() => MainCubit(injector(), injector()));
  injector.registerFactory<AppConfig>(() => AppConfig());
  injector.registerFactory<TermConditionsBloc>(() => TermConditionsBloc(injector()));
  injector.registerFactory<WorkingProgressBloc>(() => WorkingProgressBloc());
  injector.registerFactory<UploadDocBloc>(() => UploadDocBloc(
    injector(),
    injector(),
  ));
  injector.registerFactory<RequestsBloc>(() => RequestsBloc());
   injector
      .registerFactory<ThemeCubit>(() => ThemeCubit(injector(), injector()));
}
