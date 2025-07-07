import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'working_progress_event.dart';
part 'working_progress_state.dart';

class WorkingProgressBloc extends Bloc<WorkingProgressEvent, WorkingProgressState> {
  WorkingProgressBloc() : super(WorkingProgressInitial()) {
    on<WorkingProgressEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
