import 'package:flutter/material.dart';

import '../data/app_data.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() =>
      _AttendancePageState();
}

class _AttendancePageState
    extends State<AttendancePage> {

  final Map<String, String> attendance = {};

  void markAttendance(
    String employeeId,
    String status,
  ) {
    setState(() {
      attendance[employeeId] = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        centerTitle: true,
      ),

      body: AppData.employees.isEmpty
          ? const Center(
              child: Text(
                'Add employees first',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: AppData.employees.length,

              itemBuilder: (context, index) {
                final employee =
                    AppData.employees[index];

                final status =
                    attendance[employee.id] ??
                        'Not Marked';

                return Card(
                  margin: const EdgeInsets.only(
                    bottom: 10,
                  ),

                  child: Padding(
                    padding:
                        const EdgeInsets.all(12),

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [
                        Text(
                          employee.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          'ID: ${employee.id.isEmpty ? '-' : employee.id}',
                        ),

                        const SizedBox(height: 10),

                        Text(
                          'Status: $status',
                          style: const TextStyle(
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Wrap(
                          spacing: 8,
                          runSpacing: 8,

                          children: [
                            FilledButton(
                              onPressed: () {
                                markAttendance(
                                  employee.id,
                                  'Present',
                                );
                              },
                              child:
                                  const Text(
                                'Present',
                              ),
                            ),

                            OutlinedButton(
                              onPressed: () {
                                markAttendance(
                                  employee.id,
                                  'Absent',
                                );
                              },
                              child:
                                  const Text(
                                'Absent',
                              ),
                            ),

                            OutlinedButton(
                              onPressed: () {
                                markAttendance(
                                  employee.id,
                                  'Half Day',
                                );
                              },
                              child:
                                  const Text(
                                'Half Day',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
