import 'package:ManageEmployee/provider/employee_provider.dart';
import 'package:ManageEmployee/models/employee.dart';
import 'package:ManageEmployee/views/employee_edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeListPage extends StatelessWidget {
  const EmployeeListPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<EmployeeCubit>(context)..searchEmployee(),
      child: const EmployeeView(),
    );
  }
}

class EmployeeView extends StatelessWidget {
  const EmployeeView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(242, 242, 242,1),
      appBar: AppBar(
        title: const Text('Employee List'),
        backgroundColor: const Color.fromRGBO(29, 161, 242,1),
      ),
      body: const _EmployeeData(),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        backgroundColor: const Color.fromRGBO(29, 161, 242,1),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const EmployeeEditPage(employee: null)),
          );
        },
      ),
    );
  }
}

class _EmployeeData extends StatelessWidget {
  const _EmployeeData({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    double localHeight = MediaQuery.of(context).size.height;

    final state = context.watch<EmployeeCubit>().state;
    if (state is EmployeeInitial) {
      return const SizedBox();
    } else if (state is DataLoading) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    } else if (state is EmployeesLoaded) {
      if (state.employees!.isEmpty) {
        return  Center(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('assets/images/not_found.png')),
              SizedBox(height: localHeight * 0.013),
              Text('No Employee records found',
              style: TextStyle(
                fontSize: localHeight * 0.022
              ),),
            ],
          )
        );
      } else {
        return _EmployeesList(state.employees);
      }
    } else {
      return const Center(
        child: Text('Error occurring'),
      );
    }
  }
}

class _EmployeesList extends StatelessWidget {
  const _EmployeesList(this.employees, {Key? key}) : super(key: key);
  final List<Employee>? employees;


  @override
  Widget build(BuildContext context) {
    double localHeight = MediaQuery.of(context).size.height;

    return ListView(
      children: [

        Text("Current employees",
        style: TextStyle(
          color: const Color.fromRGBO(29,161,242,1),
          fontSize: localHeight * 0.025,
        ),),
        for (final employee in employees!) ...[
          Padding(
            padding: const EdgeInsets.all(2.5),
            child: ListTile(
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              title: Text(employee.employeeName),
              subtitle:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
    children:[
              Text(
                employee.employeeRole,
              ),
      Text(
        "${employee.start} - ${employee.last}",
      ),
    ]),
              trailing: Wrap(children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EmployeeEditPage(employee: employee)),
                    );
                  },
                ),
                IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Alert'),
                          content: const Text('Are you sure you want to delete this employee ?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('No'),
                            ),
                            TextButton(
                              onPressed: () {
                                context.read<EmployeeCubit>().deleteEmployee(employee.id);
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(const SnackBar(
                                    content: Text('Employee Deleted successfully'),
                                  ));
                              },
                              child: const Text('Yes'),
                            ),
                          ],
                        ),
                      );
                    }),
              ]),
            ),
          ),
        ],
      ],
    );
  }
}
