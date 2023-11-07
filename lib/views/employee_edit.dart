import 'package:ManageEmployee/provider/employee_validation_provider.dart';
import 'package:ManageEmployee/provider/employee_provider.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ManageEmployee/models/employee.dart';
import 'package:intl/intl.dart';

class EmployeeEditPage extends StatelessWidget {
  const EmployeeEditPage({Key? key, this.employee}) : super(key: key);
  final Employee? employee;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: BlocProvider.of<EmployeeCubit>(context),
        ),
        BlocProvider(
          create: (context) => EmployeeValidationProvider(),
        ),
      ],
      child: EmployeeEditView(employee: employee),
    );
  }
}

class EmployeeEditView extends StatelessWidget {
  EmployeeEditView({
    Key? key,
    this.employee,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _employeeNameController = TextEditingController();
  final TextEditingController _employeeRoleController = TextEditingController();
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _lastController = TextEditingController();
  final FocusNode _employeeNameFocusNode = FocusNode();
  final FocusNode _employeeRoleFocusNode = FocusNode();
  final FocusNode _startFocusNode = FocusNode();
  final FocusNode _lastFocusNode = FocusNode();
  final Employee? employee;



  @override
  Widget build(BuildContext context) {
    double localHeight = MediaQuery.of(context).size.height;
    double localWidth = MediaQuery.of(context).size.width;
    final _dateFormat = DateFormat('yyyy-MM-dd');

    if (employee == null) {
      _employeeNameController.text = '';
      _employeeRoleController.text = '';
      _startController.text = '';
      _lastController.text = '';
    } else {
      _employeeNameController.text = employee!.employeeName;
      _employeeRoleController.text = employee!.employeeRole;
      _startController.text = employee!.start;
      _lastController.text = employee!.last;
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(29, 161, 242,1),
        title: const Text('Add Employee Details'),
      ),
      body: BlocListener<EmployeeCubit, EmployeesState>(
          listener: (context, state) {
            if (state is EmployeeInitial) {
              const SizedBox();
            } else if (state is DataLoading) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  });
            } else if (state is EmployeeSuccess) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(const SnackBar(
                  content: Text('Employee added successfully'),
                ));
              Navigator.pop(context);
              context.read<EmployeeCubit>().searchEmployee();
            } else if (state is EmployeesLoaded) {
              Navigator.pop(context);
            } else if (state is DataFailure) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(const SnackBar(
                  content: Text('Error occurring'),
                ));
            }
          },
          child: Form(
            key: _formKey,
            child:
            Column(
              children: <Widget>[
                SizedBox(height: localHeight * 0.025),
                BlocBuilder<EmployeeValidationProvider, EmployeeValidationState>(
                  builder: (context, state) {
                    return
                      Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              width: localWidth * 0.9,
                              child:TextFormField(
                                decoration:  const InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  prefixIcon: Icon(Icons.person_outline,
                                    color: Color.fromRGBO(29, 161, 242,1),),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      )),
                                  labelText: 'Employee name',
                                ),
                                controller: _employeeNameController,
                                focusNode: _employeeNameFocusNode,
                                textInputAction: TextInputAction.done,
                                onEditingComplete: _employeeRoleFocusNode.requestFocus,
                                onChanged: (text) {
                                  context.read<EmployeeValidationProvider>().validaForm(
                                      _employeeNameController.text, _employeeRoleController.text, _startController.text, _lastController.text);
                                },
                                onFieldSubmitted: (String value) {},
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (state is EmployeeValidating) {
                                    if (state.employeeNameMessage == '') {
                                      return null;
                                    } else {
                                      return state.employeeNameMessage;
                                    }
                                  }
                                  return null;
                                },
                              )));
                  },
                ),
                SizedBox(height: localHeight * 0.025),
                BlocBuilder<EmployeeValidationProvider, EmployeeValidationState>(
                  builder: (context, state) {
                    return
                      Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              width: localWidth * 0.9,
                              child:
                              TextFormField(
                                decoration:  const InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  prefixIcon: Icon(Icons.cases_outlined,
                                    color: Color.fromRGBO(29, 161, 242,1),),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      )),
                                  labelText: 'Select Role',
                                ),
                                controller: _employeeRoleController,
                                focusNode: _employeeRoleFocusNode,
                                textInputAction: TextInputAction.done,
                                onChanged: (text) {
                                  context.read<EmployeeValidationProvider>().validaForm(
                                      _employeeNameController.text, _employeeRoleController.text, _startController.text , _lastController.text);
                                },
                                // onFieldSubmitted: (String value) {},
                                onFieldSubmitted: (String value) {
                                  if (_formKey.currentState!.validate()) {
                                    FocusScope.of(context).unfocus();
                                    context.read<EmployeeCubit>().save(employee?.id,
                                        _employeeNameController.text, _employeeRoleController.text, _startController.text , _lastController.text);
                                  }},
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (state is EmployeeValidating) {
                                    if (state.employeeRoleMessage == '') {
                                      return null;
                                    } else {
                                      return state.employeeRoleMessage;
                                    }
                                  }
                                  return null;
                                },
                              )));
                  },
                ),
                SizedBox(height: localHeight * 0.025),
                Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                        width: localWidth * 0.95,
                        child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children:[
                            SizedBox(
                                width: localWidth * 0.4,
                                child:
                                BlocBuilder<EmployeeValidationProvider, EmployeeValidationState>(
                                    builder: (context, state) {
                                      return
                                        SizedBox(
                                          width: localWidth * 0.4,
                                          child:
                                        TextFormField(
                                        controller: _startController,
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.all(10.0),
                                            hintText: "No date",
                                            prefixIcon: Icon(Icons.calendar_today,
                                              color: Color.fromRGBO(29, 161, 242,1),),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                )),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                )),
                                            labelText: 'Start',
                                          ),
                                        onTap: () async {
                                          final date = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime(2100),
                                          );
                                          if (date != null) {
                                            final formattedDate = _dateFormat.format(date);
                                            _startController.text = formattedDate;
                                            context.read<EmployeeCubit>().save(employee?.id,
                                                _employeeNameController.text, _employeeRoleController.text, _startController.text , _lastController.text);
                                          }
                                        },
                                      ));
                                    })),
                            const Icon(Icons.arrow_forward,
                              color: Color.fromRGBO(29, 161, 242,1),),
                            BlocBuilder<EmployeeValidationProvider, EmployeeValidationState>(
                              builder: (context, state) {
                                return
                                  SizedBox(
                                      width: localWidth * 0.4,
                                      child:
                                      TextFormField(
                                        controller: _lastController,
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(10.0),
                                          hintText: "No date",
                                          prefixIcon: Icon(Icons.calendar_today,
                                            color: Color.fromRGBO(29, 161, 242,1),),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                              borderSide: BorderSide(
                                                color: Colors.grey,
                                              )),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                              borderSide: BorderSide(
                                                color: Colors.grey,
                                              )),
                                          labelText: 'Last',
                                        ),
                                        onTap: () async {
                                          final date = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime(2100),
                                          );
                                          if (date != null) {
                                            final formattedDate = _dateFormat.format(date);
                                            _lastController.text = formattedDate;
                                            context.read<EmployeeCubit>().save(employee?.id,
                                                _employeeNameController.text, _employeeRoleController.text, _startController.text , _lastController.text);
                                          }
                                        },
                                      ));
                              },
                            ),
                          ],
                        ))),
                SizedBox(height: localHeight * 0.5),
                const Divider(),
                SizedBox(height: localHeight * 0.015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:[
                    SizedBox(
                        width: localWidth * 0.25,
                        child:
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(239,248,255,1)),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel',style: TextStyle(
                              color: Color.fromRGBO(29,161,242,1)
                          ),),
                        )),
                    SizedBox(width: localWidth * 0.07),
                    SizedBox(
                      width: localWidth * 0.25,
                      child:
                      BlocBuilder<EmployeeValidationProvider, EmployeeValidationState>(
                        builder: (context, state) {
                          return ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(29,161,242,1)),
                            ),
                            onPressed: state is EmployeeValidated
                                ? () {
                              if (_formKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();
                                context.read<EmployeeCubit>().save(
                                    employee?.id,
                                    _employeeNameController.text,
                                    _employeeRoleController.text,
                                    _startController.text,
                                    _lastController.text
                                );
                              }
                            }
                                : null,
                            child: const Text('Save',style: TextStyle(
                                color: Colors.white
                            )),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: localWidth * 0.03),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
