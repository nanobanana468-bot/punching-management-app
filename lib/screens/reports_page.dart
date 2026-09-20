import 'package:flutter/material.dart';
import '../data/app_data.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  double getTotalSalary() {
    double total = 0;

    for (final employee in AppData.employees) {
      if (employee.monthlyRate > 0) {
        total += employee.monthlyRate;
      } else {
        total += employee.dailyRate * 30;
      }
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        centerTitle: true,
      ),
      body: AppData.employees.isEmpty
          ? const Center(
              child: Text(
                'No employee data available',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(12),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Payment Summary',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        _ReportRow(
                          title: 'Total Employees',
                          value:
                              '${AppData.employees.length}',
                        ),
                        _ReportRow(
                          title: 'Present',
                          value: '${AppData.present}',
                        ),
                        _ReportRow(
                          title: 'Absent',
                          value: '${AppData.absent}',
                        ),
                        _ReportRow(
                          title: 'Total OT Hours',
                          value:
                              AppData.otHours.toStringAsFixed(1),
                        ),
                        _ReportRow(
                          title: 'Total Payment',
                          value:
                              'Rs ${getTotalSalary().toStringAsFixed(0)}',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Employee Report',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...AppData.employees.map(
                          (employee) => ListTile(
                            leading: CircleAvatar(
                              child: Text(
                                employee.name.isEmpty
                                    ? '?'
                                    : employee.name[0]
                                        .toUpperCase(),
                              ),
                            ),
                            title: Text(employee.name),
                            subtitle: Text(
                              '${employee.role} • ID: ${employee.id}',
                            ),
                            trailing: Text(
                              'Rs ${employee.monthlyRate.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class _ReportRow extends StatelessWidget {
  final String title;
  final String value;

  const _ReportRow({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
