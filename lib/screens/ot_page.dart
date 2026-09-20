import 'package:flutter/material.dart';
import '../data/app_data.dart';

class OtPage extends StatefulWidget {
  const OtPage({super.key});

  @override
  State<OtPage> createState() => _OtPageState();
}

class _OtPageState extends State<OtPage> {
  final Map<String, double> otHours = {};

  void saveOt(String employeeId, double hours) {
    setState(() {
      otHours[employeeId] = hours;
    });
  }

  double getTotalOtHours() {
    double total = 0;

    for (final hours in otHours.values) {
      total += hours;
    }

    return total;
  }

  double getTotalOtAmount() {
    double total = 0;

    for (final employee in AppData.employees) {
      final hours = otHours[employee.id] ?? 0;
      total += hours * employee.otRate;
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Overtime'),
        centerTitle: true,
      ),
      body: AppData.employees.isEmpty
          ? const Center(
              child: Text(
                'Add employees first',
                style: TextStyle(fontSize: 18),
              ),
            )
          : Column(
              children: [
                Card(
                  margin: const EdgeInsets.all(12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text(
                              'Total OT Hours',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              getTotalOtHours().toStringAsFixed(1),
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              'OT Amount',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Rs ${getTotalOtAmount().toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: AppData.employees.length,
                    itemBuilder: (context, index) {
                      final employee =
                          AppData.employees[index];

                      final currentHours =
                          otHours[employee.id] ?? 0;

                      return Card(
                        margin:
                            const EdgeInsets.only(bottom: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                employee.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'ID: ${employee.id.isEmpty ? '-' : employee.id}',
                              ),
                              Text(
                                'OT Rate: Rs ${employee.otRate.toStringAsFixed(0)}/hour',
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      initialValue:
                                          currentHours == 0
                                              ? ''
                                              : currentHours
                                                  .toString(),
                                      keyboardType:
                                          const TextInputType
                                              .numberWithOptions(
                                        decimal: true,
                                      ),
                                      decoration:
                                          const InputDecoration(
                                        labelText: 'OT Hours',
                                        border:
                                            OutlineInputBorder(),
                                      ),
                                      onChanged: (value) {
                                        final hours =
                                            double.tryParse(
                                                  value,
                                                ) ??
                                                0;

                                        saveOt(
                                          employee.id,
                                          hours,
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    children: [
                                      const Text('OT Amount'),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Rs ${(currentHours * employee.otRate).toStringAsFixed(0)}',
                                        style:
                                            const TextStyle(
                                          fontWeight:
                                              FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
