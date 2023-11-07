import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../db/database_provider.dart';
import '../models/employee.dart';
part 'employees_state.dart';

class EmployeeCubit extends Cubit<EmployeesState> {
  EmployeeCubit({required DatabaseProvider databaseProvider})
      : _databaseProvider = databaseProvider,
        super(const EmployeeInitial());

  final DatabaseProvider _databaseProvider;

  Future<void> searchEmployee() async {
    emit(const DataLoading());
    try {
      final employees = await _databaseProvider.searchData();
      emit(EmployeesLoaded(
        employees: employees,
      ));
    } on Exception {
      emit(const DataFailure());
    }
  }

  Future<void> deleteEmployee(id) async {
    emit(const DataLoading());
    await Future.delayed(const Duration(seconds: 2));
    try {
      await _databaseProvider.delete(id);
      searchEmployee();
    } on Exception {
      emit(const DataFailure());
    }
  }


  Future<void> save(int? id, String employeeName, String employeeRole, String start, String last) async {
    Employee editEmployee = Employee(id: id, employeeName: employeeName, employeeRole: employeeRole, start: start, last: last);
    emit(const DataLoading());
    await Future.delayed(const Duration(seconds: 2));
    try {
      if (id == null) {
        editEmployee = await _databaseProvider.save(editEmployee);
      } else {
        editEmployee = await _databaseProvider.update(editEmployee);
      }
      emit(const EmployeeSuccess());
    } on Exception {
      emit(const DataFailure());
    }
  }
}
