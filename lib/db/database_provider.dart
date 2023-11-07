import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/employee.dart';

class DatabaseProvider {
  static final DatabaseProvider instance = DatabaseProvider._init();
  static Database? _db;

  DatabaseProvider._init();

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _useDatabase('employees.db');
    return _db!;
  }

  Future<Database> _useDatabase(String filePath) async {
    final dbPath = await getDatabasesPath();
    return await openDatabase(
      join(dbPath, 'employees.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE employees (id INTEGER PRIMARY KEY, employeeName TEXT, employeeRole TEXT, start TEXT, last TEXT)');
      },
      version: 1,
    );
  }

  Future<List<Employee>> searchData() async {
    final db = await instance.db;
    final result = await db.rawQuery('SELECT * FROM employees ORDER BY id');
    return result.map((json) => Employee.fromJson(json)).toList();
  }


  Future<Employee> save(Employee employee) async {
    final db = await instance.db;
    final id = await db.rawInsert(
        'INSERT INTO employees (employeeName, employeeRole, start, last) VALUES (?,?,?,?)',
        [employee.employeeName, employee.employeeRole, employee.start, employee.last]);

    return employee.copy(id: id);
  }


  Future<Employee> update(Employee employee) async {
    final db = await instance.db;
    await db.rawUpdate('UPDATE employees SET employeeName = ?, employeeRole = ?, start = ?, last = ? WHERE id = ?',
        [employee.employeeName, employee.employeeRole, employee.start, employee.last, employee.id]);
    return employee;
  }


  Future<int> deleteAll() async {
    final db = await instance.db;
    final result = await db.rawDelete('DELETE FROM employees');
    return result;
  }


  Future<int> delete(int employeeId) async {
    final db = await instance.db;
    final result =
        await db.rawDelete('DELETE FROM employees WHERE id = ?', [employeeId]);
    return result;
  }


  Future close() async {
    final db = await instance.db;
    db.close();
  }
}
