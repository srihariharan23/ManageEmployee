part of 'employee_validation_provider.dart';

abstract class EmployeeValidationState extends Equatable {
  const EmployeeValidationState();
}

class EmployeeValidating extends EmployeeValidationState {
  const EmployeeValidating({
    this.employeeNameMessage,
    this.employeeRoleMessage,
    this.startMessage,
    this.lastMessage
  });

  final String? employeeNameMessage;
  final String? employeeRoleMessage;
  final String? startMessage;
  final String? lastMessage;

  EmployeeValidating copyWith({
    String? nameMessage,
    String? roleMessage,
    String? start,
    String? last
  }) {
    return EmployeeValidating(
      employeeNameMessage: nameMessage ?? employeeNameMessage,
      employeeRoleMessage: roleMessage ?? employeeRoleMessage,
      startMessage: start ?? startMessage,
      lastMessage: last ?? lastMessage,
    );
  }

  @override
  List<Object?> get props => [employeeNameMessage, employeeRoleMessage, startMessage, lastMessage];
}


class EmployeeValidated extends EmployeeValidationState {
  const EmployeeValidated();

  @override
  List<Object> get props => [];
}
