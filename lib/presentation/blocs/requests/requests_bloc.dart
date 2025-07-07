import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'requests_event.dart';
part 'requests_state.dart';

class RequestsBloc extends Bloc<RequestsEvent, RequestsState> {
  RequestsBloc() : super(RequestsInitial()) {
    on<RequestsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
