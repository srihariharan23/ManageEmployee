import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'employee_validation_state.dart';

class EmployeeValidationProvider extends Cubit<EmployeeValidationState> {
  EmployeeValidationProvider() : super(const EmployeeValidating());

  void validaForm(String employeeName, String employeeRole, String start , String last) {
    String cubitNameMessage = '';
    String cubitRoleMessage = '';
    String cubitStartMessage = '';
    String cubitLastMessage = '';
    bool formInvalid;

    formInvalid = false;
    if (employeeName == '') {
      formInvalid = true;
      cubitNameMessage = 'Name is Required';
    } else {
      cubitNameMessage = '';
    }
    if (employeeRole == '') {
      formInvalid = true;
      cubitRoleMessage = 'Role is Required';
    } else {
      cubitRoleMessage = '';
    }
    if (start == '') {
      formInvalid = true;
      cubitStartMessage = 'Start date is Required';
    } else {
      cubitStartMessage = '';
    }
    if (last == '') {
      formInvalid = true;
      cubitLastMessage = 'Last date is Required';
    } else {
      cubitLastMessage = '';
    }


    if (formInvalid == true) {
      emit(EmployeeValidating(
        employeeNameMessage: cubitNameMessage,
        employeeRoleMessage: cubitRoleMessage,
        startMessage: cubitStartMessage,
        lastMessage: cubitLastMessage

      ));
    } else {
      emit(const EmployeeValidated());
    }
  }
}
