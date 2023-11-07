part of 'employee_provider.dart';

abstract class EmployeesState extends Equatable {
  const EmployeesState();
}

class EmployeeInitial extends EmployeesState {
  const EmployeeInitial();

  @override
  List<Object?> get props => [];
}

class DataLoading extends EmployeesState {
  const DataLoading();

  @override
  List<Object?> get props => [];
}


class EmployeesLoaded extends EmployeesState {
  const EmployeesLoaded({
    this.employees,
  });

  final List<Employee>? employees;

  EmployeesLoaded copyWith({
    List<Employee>? employess,
  }) {
    return EmployeesLoaded(
      employees: employess ?? employees,
    );
  }

  @override
  List<Object?> get props => [employees];
}

class DataFailure extends EmployeesState {
  const DataFailure();

  @override
  List<Object?> get props => [];
}


class EmployeeSuccess extends EmployeesState {
  const EmployeeSuccess();

  @override
  List<Object?> get props => [];
}
