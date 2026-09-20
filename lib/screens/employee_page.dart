import 'package:flutter/material.dart';

import '../data/app_data.dart';
import '../models/employee.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  State<EmployeePage> createState() =>
      _EmployeePageState();
}

class _EmployeePageState
    extends State<EmployeePage> {

  String searchText = '';

  void showEmployeeForm({
    Employee? employee,
    int? index,
  }) {
    final idController =
        TextEditingController(
      text: employee?.id ?? '',
    );

    final nameController =
        TextEditingController(
      text: employee?.name ?? '',
    );

    final roleController =
        TextEditingController(
      text: employee?.role ?? '',
    );

    final mobileController =
        TextEditingController(
      text: employee?.mobile ?? '',
    );

    final dateController =
        TextEditingController(
      text: employee?.joiningDate ?? '',
    );

    final monthlyController =
        TextEditingController(
      text: employee == null
          ? ''
          : employee.monthlyRate.toString(),
    );

    final dailyController =
        TextEditingController(
      text: employee == null
          ? ''
          : employee.dailyRate.toString(),
    );

    final otController =
        TextEditingController(
      text: employee == null
          ? ''
          : employee.otRate.toString(),
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            employee == null
                ? 'Add Employee'
                : 'Edit Employee',
          ),

          content: SizedBox(
            width: 500,

            child: SingleChildScrollView(
              child: Column(
                children: [

                  TextField(
                    controller: idController,
                    decoration:
                        const InputDecoration(
                      labelText: 'Employee ID',
                      prefixIcon:
                          Icon(Icons.badge),
                    ),
                  ),

                  const SizedBox(height: 12),

                  TextField(
                    controller: nameController,
                    decoration:
                        const InputDecoration(
                      labelText: 'Employee Name',
                      prefixIcon:
                          Icon(Icons.person),
                    ),
                  ),

                  const SizedBox(height: 12),

                  TextField(
                    controller: roleController,
                    decoration:
                        const InputDecoration(
                      labelText: 'Role / DIG',
                      prefixIcon:
                          Icon(Icons.work),
                    ),
                  ),

                  const SizedBox(height: 12),

                  TextField(
                    controller: mobileController,
                    keyboardType:
                        TextInputType.phone,
                    decoration:
                        const InputDecoration(
                      labelText: 'Mobile Number',
                      prefixIcon:
                          Icon(Icons.phone),
                    ),
                  ),

                  const SizedBox(height: 12),

                  TextField(
                    controller: dateController,
                    readOnly: true,
                    decoration:
                        const InputDecoration(
                      labelText: 'Joining Date',
                      prefixIcon:
                          Icon(Icons.calendar_today),
                    ),
                    onTap: () async {
                      final date =
                          await showDatePicker(
                        context: context,
                        firstDate:
                            DateTime(2000),
                        lastDate:
                            DateTime(2100),
                        initialDate:
                            DateTime.now(),
                      );

                      if (date != null) {
                        dateController.text =
                            '${date.day.toString().padLeft(2, '0')}/'
                            '${date.month.toString().padLeft(2, '0')}/'
                            '${date.year}';
                      }
                    },
                  ),

                  const SizedBox(height: 12),

                  TextField(
                    controller:
                        monthlyController,
                    keyboardType:
                        TextInputType.number,
                    decoration:
                        const InputDecoration(
                      labelText: 'Monthly Rate',
                      prefixText: 'Rs ',
                      prefixIcon:
                          Icon(Icons.payments),
                    ),
                  ),

                  const SizedBox(height: 12),

                  TextField(
                    controller:
                        dailyController,
                    keyboardType:
                        TextInputType.number,
                    decoration:
                        const InputDecoration(
                      labelText: 'Daily Rate',
                      prefixText: 'Rs ',
                      prefixIcon:
                          Icon(Icons.today),
                    ),
                  ),

                  const SizedBox(height: 12),

                  TextField(
                    controller:
                        otController,
                    keyboardType:
                        TextInputType.number,
                    decoration:
                        const InputDecoration(
                      labelText: 'OT Rate / Hour',
                      prefixText: 'Rs ',
                      prefixIcon:
                          Icon(Icons.access_time),
                    ),
                  ),
                ],
              ),
            ),
          ),

          actions: [

            TextButton(
              onPressed: () =>
                  Navigator.pop(context),
              child:
                  const Text('Cancel'),
            ),

            FilledButton.icon(
              icon:
                  const Icon(Icons.save),

              label: Text(
                employee == null
                    ? 'Add'
                    : 'Save',
              ),

              onPressed: () {
                final name =
                    nameController.text.trim();

                if (name.isEmpty) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Employee name required',
                      ),
                    ),
                  );
                  return;
                }

                final newEmployee =
                    Employee(
                  id: idController.text.trim(),
                  name: name,
                  role:
                      roleController.text.trim(),
                  mobile:
                      mobileController.text.trim(),
                  joiningDate:
                      dateController.text.trim(),
                  monthlyRate:
                      double.tryParse(
                            monthlyController
                                .text
                                .trim(),
                          ) ??
                          0,
                  dailyRate:
                      double.tryParse(
                            dailyController
                                .text
                                .trim(),
                          ) ??
                          0,
                  otRate:
                      double.tryParse(
                            otController
                                .text
                                .trim(),
                          ) ??
                          0,
                );

                setState(() {
                  if (index != null) {
                    AppData.employees[index] =
                        newEmployee;
                  } else {
                    AppData.employees.add(
                      newEmployee,
                    );
                  }
                });

                Navigator.pop(context);

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(
                  SnackBar(
                    content: Text(
                      employee == null
                          ? 'Employee added'
                          : 'Employee updated',
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void deleteEmployee(int index) {
    final employee =
        AppData.employees[index];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:
              const Text('Delete Employee?'),

          content: Text(
            'Are you sure you want to delete ${employee.name}?',
          ),

          actions: [

            TextButton(
              onPressed: () =>
                  Navigator.pop(context),
              child:
                  const Text('Cancel'),
            ),

            FilledButton(
              onPressed: () {
                setState(() {
                  AppData.employees
                      .removeAt(index);
                });

                Navigator.pop(context);

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(
                  const SnackBar(
                    content:
                        Text('Employee deleted'),
                  ),
                );
              },

              child:
                  const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void showDetails(Employee employee) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            employee.name,
            style:
                const TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          content: Column(
            mainAxisSize:
                MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              detailRow(
                'Employee ID',
                employee.id,
              ),

              detailRow(
                'Role / DIG',
                employee.role,
              ),

              detailRow(
                'Mobile',
                employee.mobile,
              ),

              detailRow(
                'Joining Date',
                employee.joiningDate,
              ),

              detailRow(
                'Monthly Rate',
                'Rs ${employee.monthlyRate}',
              ),

              detailRow(
                'Daily Rate',
                'Rs ${employee.dailyRate}',
              ),

              detailRow(
                'OT Rate',
                'Rs ${employee.otRate}/hour',
              ),
            ],
          ),

          actions: [
            FilledButton(
              onPressed: () =>
                  Navigator.pop(context),
              child:
                  const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget detailRow(
    String title,
    String value,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 10,
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          SizedBox(
            width: 110,
            child: Text(
              title,
              style:
                  const TextStyle(
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),

          Expanded(
            child: Text(
              value.isEmpty
                  ? '-'
                  : value,
            ),
          ),
        ],
      ),
    );
  }

  List<Employee> get filteredEmployees {
    if (searchText.trim().isEmpty) {
      return AppData.employees;
    }

    final query =
        searchText.toLowerCase();

    return AppData.employees.where(
      (employee) {
        return employee.name
                .toLowerCase()
                .contains(query) ||
            employee.id
                .toLowerCase()
                .contains(query) ||
            employee.role
                .toLowerCase()
                .contains(query) ||
            employee.mobile
                .contains(query);
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    final employees =
        filteredEmployees;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Employee Management',
          style:
              TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      floatingActionButton:
          FloatingActionButton.extended(
        onPressed:
            () => showEmployeeForm(),

        icon:
            const Icon(Icons.person_add),

        label:
            const Text('Add Employee'),
      ),

      body: Column(
        children: [

          Padding(
            padding:
                const EdgeInsets.fromLTRB(
              12,
              12,
              12,
              5,
            ),

            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },

              decoration:
                  InputDecoration(
                hintText:
                    'Search employee...',
                prefixIcon:
                    const Icon(
                  Icons.search,
                ),

                suffixIcon:
                    searchText.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                searchText =
                                    '';
                              });
                            },
                            icon:
                                const Icon(
                              Icons.clear,
                            ),
                          )
                        : null,
              ),
            ),
          ),

          Expanded(
            child: employees.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .center,

                      children: [

                        const Icon(
                          Icons.people_outline,
                          size: 80,
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        Text(
                          AppData.employees
                                  .isEmpty
                              ? 'No Employees Added'
                              : 'No Employee Found',

                          style:
                              const TextStyle(
                            fontSize: 22,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                          height: 8,
                        ),

                        Text(
                          AppData.employees
                                  .isEmpty
                              ? 'Tap Add Employee to get started'
                              : 'Try another search',
                        ),
                      ],
                    ),
                 
