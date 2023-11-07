import 'dart:convert';

List<Employee> empFromJson(String str) =>
    List<Employee>.from(json.decode(str).map((x) => Employee.fromJson(x)));

String employeeToJson(List<Employee> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Employee {
  Employee({
    this.id,
    required this.employeeName,
    required this.employeeRole,
    required this.start,
    required this.last
  });

  int? id;
  String employeeName;
  String employeeRole;
  String start;
  String last;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        employeeName: json["employeeName"],
        employeeRole: json["employeeRole"],
        start: json["start"],
        last: json["last"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employeeName": employeeName,
        "employeeRole": employeeRole,
        "start": start,
        "last": last
      };

  Employee copy({
    int? id,
    String? employeeName,
    String? employeeRole,
    String? start,
    String? last
  }) =>
      Employee(
        id: id ?? this.id,
        employeeName: employeeName ?? this.employeeName,
        employeeRole: employeeRole ?? this.employeeRole,
        start: start ?? this.start,
        last: last ?? this.last
      );
}
