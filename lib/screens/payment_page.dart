import 'package:flutter/material.dart';
import '../data/app_data.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final Map<String, double> advances = {};

  double calculateSalary(dynamic employee) {
    if (employee.dailyRate > 0) {
      return employee.dailyRate * 30;
    }

    return employee.monthlyRate;
  }

  double calculateNet(dynamic employee) {
    final salary = calculateSalary(employee);
    final advance = advances[employee.id] ?? 0;

    return salary - advance;
  }

  double getTotalPayment() {
    double total = 0;

    for (final employee in AppData.employees) {
      total += calculateNet(employee);
    }

    return total;
  }

  void showAdvanceDialog(dynamic employee) {
    final controller = TextEditingController(
      text: (advances[employee.id] ?? 0).toString(),
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Advance - ${employee.name}'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Advance Amount',
              prefixText: 'Rs ',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                final amount =
                    double.tryParse(controller.text) ?? 0;

                setState(() {
                  advances[employee.id] = amount;
                });

                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
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
                              'Employees',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${AppData.employees.length}',
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
                              'Total Payment',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Rs ${getTotalPayment().toStringAsFixed(0)}',
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

                      final salary =
                          calculateSalary(employee);

                      final advance =
                          advances[employee.id] ?? 0;

                      final net =
                          calculateNet(employee);

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
                              const SizedBox(height: 8),
                              Text(
                                'Salary: Rs ${salary.toStringAsFixed(0)}',
                              ),
                              Text(
                                'Advance: Rs ${advance.toStringAsFixed(0)}',
                              ),
                              const Divider(),
                              Text(
                                'Net Payment: Rs ${net.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    showAdvanceDialog(
                                      employee,
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.payments,
                                  ),
                                  label: const Text(
                                    'Add / Edit Advance',
                                  ),
                                ),
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
