import 'package:safety_zone/src/core/resources/data_state.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/auth/request/request_create_employee.dart';
import 'package:safety_zone/src/domain/entities/auth/create_employee.dart';
import 'package:safety_zone/src/domain/repositories/authentication_repository.dart';

class GetFirstEmployeeUseCase {
  final AuthenticationRepository _authenticationRepository;

  GetFirstEmployeeUseCase(this._authenticationRepository);

  Future<DataState<Employee>> call({
    required RequestCreateEmployee request,
  }) async {
    return await _authenticationRepository.getFirstEmployee(request: request);
  }
}
