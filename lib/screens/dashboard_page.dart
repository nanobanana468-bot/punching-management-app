import 'package:flutter/material.dart';

import '../data/app_data.dart';
import 'employee_page.dart';
import 'attendance_page.dart';
import 'ot_page.dart';
import 'payment_page.dart';
import 'reports_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() =>
      _DashboardPageState();
}

class _DashboardPageState
    extends State<DashboardPage> {

  void refresh() {
    setState(() {});
  }

  Future<void> openPage(Widget page) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );

    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Punching Management',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: RefreshIndicator(
        onRefresh: () async {
          refresh();
        },

        child: SingleChildScrollView(
          physics:
              const AlwaysScrollableScrollPhysics(),

          padding:
              const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              const Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                'Employee Attendance & Payment',
                style: TextStyle(
                  fontSize: 15,
                  color:
                      Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 24),

              Row(
                children: [

                  Expanded(
                    child: DashboardCard(
                      icon:
                          Icons.people,
                      title:
                          'Employees',
                      value:
                          '${AppData.employees.length}',
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: DashboardCard(
                      icon:
                          Icons.check_circle,
                      title:
                          'Present',
                      value:
                          '${AppData.present}',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [

                  Expanded(
                    child: DashboardCard(
                      icon:
                          Icons.access_time,
                      title:
                          'OT Hours',
                      value:
                          '${AppData.otHours}',
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: DashboardCard(
                      icon:
                          Icons.payments,
                      title:
                          'Payment',
                      value:
                          'Rs ${AppData.payment.toStringAsFixed(0)}',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              const Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 14),

              ActionButton(
                icon:
                    Icons.fingerprint,
                title:
                    'Punch In',
                onTap: () {

                  setState(() {
                    AppData.present++;
                  });

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(
                    const SnackBar(
                      content:
                          Text(
                        'Punch In recorded',
                      ),
                    ),
                  );
                },
              ),

              ActionButton(
                icon:
                    Icons.logout,
                title:
                    'Punch Out',
                onTap: () {

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(
                    const SnackBar(
                      content:
                          Text(
                        'Punch Out recorded',
                      ),
                    ),
                  );
                },
              ),

              ActionButton(
                icon:
                    Icons.person_add,
                title:
                    'Add Employee',
                onTap: () {
                  openPage(
                    const EmployeePage(),
                  );
                },
              ),

              ActionButton(
                icon:
                    Icons.people,
                title:
                    'Employee List',
                onTap: () {
                  openPage(
                    const EmployeePage(),
                  );
                },
              ),

              ActionButton(
                icon:
                    Icons.calendar_month,
                title:
                    'Attendance',
                onTap: () {
                  openPage(
                    const AttendancePage(),
                  );
                },
              ),

              ActionButton(
                icon:
                    Icons.access_time_filled,
                title:
                    'Overtime',
                onTap: () {
                  openPage(
                    const OTPage(),
                  );
                },
              ),

              ActionButton(
                icon:
                    Icons.account_balance_wallet,
                title:
                    'Payment',
                onTap: () {
                  openPage(
                    const PaymentPage(),
                  );
                },
              ),

              ActionButton(
                icon:
                    Icons.receipt_long,
                title:
                    'Payment & Reports',
                onTap: () {
                  openPage(
                    const ReportsPage(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardCard
    extends StatelessWidget {

  final IconData icon;
  final String title;
  final String value;

  const DashboardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(
      BuildContext context) {

    return Card(
      elevation: 2,

      child: Padding(
        padding:
            const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Icon(
              icon,
              size: 30,
            ),

            const SizedBox(
              height: 12,
            ),

            Text(title),

            const SizedBox(
              height: 5,
            ),

            Text(
              value,
              style:
                  const TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionButton
    extends StatelessWidget {

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ActionButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(
      BuildContext context) {

    return Card(
      margin:
          const EdgeInsets.only(
        bottom: 10,
      ),

      child: ListTile(

        leading:
            CircleAvatar(
          child: Icon(icon),
        ),

        title: Text(
          title,
          style:
              const TextStyle(
            fontWeight:
                FontWeight.w600,
          ),
        ),

        trailing:
            const Icon(
          Icons.arrow_forward_ios,
          size: 18,
        ),

        onTap: onTap,
      ),
    );
  }
}
