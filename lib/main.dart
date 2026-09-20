import 'package:flutter/material.dart';

void main() {
  runApp(const PunchingManagementApp());
}

class PunchingManagementApp extends StatelessWidget {
  const PunchingManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Punching Management',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: const DashboardPage(),
    );
  }
}

// =====================================================
// EMPLOYEE MODEL
// =====================================================

class Employee {
  String id;
  String name;
  String role;
  String mobile;
  String joiningDate;
  double monthlyRate;
  double dailyRate;
  double otRate;

  Employee({
    required this.id,
    required this.name,
    required this.role,
    required this.mobile,
    required this.joiningDate,
    required this.monthlyRate,
    required this.dailyRate,
    required this.otRate,
  });
}

// =====================================================
// APP DATA
// =====================================================

class AppData {
  static final List<Employee> employees = [];

  static int present = 0;
  static int absent = 0;
  static double otHours = 0;
  static double payment = 0;
}

// =====================================================
// MAIN DASHBOARD
// =====================================================

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              const Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                'Employee Attendance & Payment',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 24),

              // =========================
              // DASHBOARD CARDS
              // =========================

              Row(
                children: [

                  Expanded(
                    child: DashboardCard(
                      icon: Icons.people,
                      title: 'Employees',
                      value:
                          '${AppData.employees.length}',
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: DashboardCard(
                      icon: Icons.check_circle,
                      title: 'Present',
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
                      icon: Icons.access_time,
                      title: 'OT Hours',
                      value:
                          '${AppData.otHours}',
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: DashboardCard(
                      icon: Icons.payments,
                      title: 'Payment',
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
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 14),

              // =========================
              // PUNCH IN
              // =========================

              ActionButton(
                icon: Icons.fingerprint,
                title: 'Punch In',
                onTap: () {

                  setState(() {
                    AppData.present++;
                  });

                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    const SnackBar(
                      content:
                          Text('Punch In recorded'),
                    ),
                  );
                },
              ),

              // =========================
              // PUNCH OUT
              // =========================

              ActionButton(
                icon: Icons.logout,
                title: 'Punch Out',
                onTap: () {

                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    const SnackBar(
                      content:
                          Text('Punch Out recorded'),
                    ),
                  );
                },
              ),

              // =========================
              // ADD EMPLOYEE
              // =========================

              ActionButton(
                icon: Icons.person_add,
                title: 'Add Employee',
                onTap: () {

                  openPage(
                    const EmployeePage(),
                  );
                },
              ),

              // =========================
              // EMPLOYEE LIST
              // =========================

              ActionButton(
                icon: Icons.people,
                title: 'Employee List',
                onTap: () {

                  openPage(
                    const EmployeePage(),
                  );
                },
              ),

              // =========================
              // ATTENDANCE
              // =========================

              ActionButton(
                icon: Icons.calendar_month,
                title: 'Attendance',
                onTap: () {

                  openPage(
                    const AttendancePage(),
                  );
                },
              ),

              // =========================
              // OT
              // =========================

              ActionButton(
                icon: Icons.access_time_filled,
                title: 'Overtime',
                onTap: () {

                  openPage(
                    const OTPage(),
                  );
                },
              ),

              // =========================
              // PAYMENT
              // =========================

              ActionButton(
                icon: Icons.account_balance_wallet,
                title: 'Payment',
                onTap: () {

                  openPage(
                    const PaymentPage(),
                  );
                },
              ),

              // =========================
              // REPORTS
              // =========================

              ActionButton(
                icon: Icons.receipt_long,
                title: 'Payment & Reports',
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

// =====================================================
// DASHBOARD CARD
// =====================================================

class DashboardCard extends StatelessWidget {
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
  Widget build(BuildContext context) {

    return Card(
      elevation: 2,

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Icon(
              icon,
              size: 30,
            ),

            const SizedBox(height: 12),

            Text(title),

            const SizedBox(height: 5),

            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// ACTION BUTTON
// =====================================================

class ActionButton extends StatelessWidget {
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
  Widget build(BuildContext context) {

    return Card(
      margin:
          const EdgeInsets.only(bottom: 10),

      child: ListTile(

        leading: CircleAvatar(
          child: Icon(icon),
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 18,
        ),

        onTap: onTap,
      ),
    );
  }
}

// =====================================================
// EMPLOYEE MANAGEMENT
// =====================================================

class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  State<EmployeePage> createState() =>
      _EmployeePageState();
}

class _EmployeePageState
    extends State<EmployeePage> {

  String searchText = '';

  // ===================================================
  // ADD / EDIT EMPLOYEE
  // ===================================================

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
          : employee.monthlyRate
              .toString(),
    );

    final dailyController =
        TextEditingController(
      text: employee == null
          ? ''
          : employee.dailyRate
              .toString(),
    );

    final otController =
        TextEditingController(
      text: employee == null
          ? ''
          : employee.otRate
              .toString(),
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

                  // ID
                  TextField(
                    controller: idController,
                    decoration:
                        const InputDecoration(
                      labelText:
                          'Employee ID',
                      prefixIcon:
                          Icon(Icons.badge),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // NAME
                  TextField(
                    controller:
                        nameController,
                    decoration:
                        const InputDecoration(
                      labelText:
                          'Employee Name',
                      prefixIcon:
                          Icon(Icons.person),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ROLE
                  TextField(
                    controller:
                        roleController,
                    decoration:
                        const InputDecoration(
                      labelText:
                          'Role / DIG',
                      prefixIcon:
                          Icon(Icons.work),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // MOBILE
                  TextField(
                    controller:
                        mobileController,
                    keyboardType:
                        TextInputType.phone,
                    decoration:
                        const InputDecoration(
                      labelText:
                          'Mobile Number',
                      prefixIcon:
                          Icon(Icons.phone),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // JOINING DATE
                  TextField(
                    controller:
                        dateController,
                    readOnly: true,
                    decoration:
                        const InputDecoration(
                      labelText:
                          'Joining Date',
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

                  // MONTHLY RATE
                  TextField(
                    controller:
                        monthlyController,
                    keyboardType:
                        TextInputType.number,
                    decoration:
                        const InputDecoration(
                      labelText:
                          'Monthly Rate',
                      prefixText: 'Rs ',
                      prefixIcon:
                          Icon(Icons.payments),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // DAILY RATE
                  TextField(
                    controller:
                        dailyController,
                    keyboardType:
                        TextInputType.number,
                    decoration:
                        const InputDecoration(
                      labelText:
                          'Daily Rate',
                      prefixText: 'Rs ',
                      prefixIcon:
                          Icon(Icons.today),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // OT RATE
                  TextField(
                    controller:
                        otController,
                    keyboardType:
                        TextInputType.number,
                    decoration:
                        const InputDecoration(
                      labelText:
                          'OT Rate / Hour',
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
              child: const Text('Cancel'),
            ),

            FilledButton.icon(
              icon: const Icon(Icons.save),

              label: Text(
                employee == null
                    ? 'Add'
                    : 'Save',
              ),

              onPressed: () {

                final name =
                    nameController.text.trim();

                if (name.isEmpty) {

                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    const SnackBar(
                      content:
                          Text('Employee name required'),
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

                    AppData
                            .employees[index] =
                        newEmployee;

                  } else {

                    AppData.employees
                        .add(newEmployee);
                  }
                });

                Navigator.pop(context);

                ScaffoldMessenger.of(context)
                    .showSnackBar(
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

  // ===================================================
  // DELETE
  // ===================================================

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
              child: const Text('Cancel'),
            ),

            FilledButton(
              onPressed: () {

                setState(() {
                  AppData.employees
                      .removeAt(index);
                });

                Navigator.pop(context);

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content:
                        Text('Employee deleted'),
                  ),
                );
              },

              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  // ===================================================
  // EMPLOYEE DETAILS
  // ===================================================

  void showDetails(Employee employee) {

    showDialog(
      context: context,

      builder: (context) {

        return AlertDialog(

          title: Text(
            employee.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
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
              child: const Text('Close'),
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
          const EdgeInsets.only(bottom: 10),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          SizedBox(
            width: 110,
            child: Text(
              title,
              style: const TextStyle(
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

  // ===================================================
  // FILTER
  // ===================================================

  List<Employee> get filteredEmployees {

    if (searchText.trim().isEmpty) {
      return AppData.employees;
    }

    final query =
        searchText.toLowerCase();

    return AppData.employees
        .where(
          (employee) =>
              employee.name
                  .toLowerCase()
                  .contains(query) ||
              employee.id
                  .toLowerCase()
                  .contains(query) ||
              employee.role
                  .toLowerCase()
                  .contains(query) ||
              employee.mobile
                  .contains(query),
        )
        .toList();
  }

  // ===================================================
  // BUILD
  // ===================================================

  @override
  Widget build(BuildContext context) {

    final employees =
        filteredEmployees;

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          'Employee Management',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,
      ),

      floatingActionButton:
          FloatingActionButton.extended(

        onPressed: () =>
            showEmployeeForm(),

        icon: const Icon(
          Icons.person_add,
        ),

        label:
            const Text('Add Employee'),
      ),

      body: Column(

        children: [

          // SEARCH
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
                    const Icon(Icons.search),
                suffixIcon:
                    searchText.isNotEmpty
                        ? IconButton(
                            onPressed: () {

                              setState(() {
                                searchText = '';
                              });
                            },
                            icon: const Icon(
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
                          MainAxisAlignment.center,

                      children: [

                        const Icon(
                          Icons.people_outline,
                          size: 80,
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        Text(
                          AppData.employees.isEmpty
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
                          AppData.employees.isEmpty
                              ? 'Tap Add Employee to get started'
                              : 'Try another search',
                        ),
                      ],
                    ),
                  )

                : ListView.builder(

                    padding:
                        const EdgeInsets.all(12),

                    itemCount:
                        employees.length,

                    itemBuilder:
                        (context, index) {

                      final employee =
                          employees[index];

                      final actualIndex =
                          AppData.employees
                              .indexOf(employee);

                      return Card(

                        margin:
                            const EdgeInsets.only(
                          bottom: 12,
                        ),

                        child: ListTile(

                          leading:
                              CircleAvatar(
                            child: Text(
                              employee.name
                                      .isNotEmpty
                                  ? employee.name[0]
                                      .toUpperCase()
                                  : '?',
                            ),
                          ),

                          title: Text(
                            employee.name,
                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          subtitle: Text(
                            '${employee.role.isEmpty ? 'No Role' : employee.role}\n'
                            'ID: ${employee.id.isEmpty ? '-' : employee.id}  •  '
                            'Rate: Rs ${employee.monthlyRate.toStringAsFixed(0)}',
                          ),

                          isThreeLine: true,

                          onTap: () =>
                              showDetails(
                            employee,
                          ),

                          trailing: PopupMenuButton<
                              String>(

                            onSelected:
                                (value) {

                              if (value ==
                                  'edit') {

                                showEmployeeForm(
                                  employee:
                                      employee,
                                  index:
                                      actualIndex,
                                );

                              } else if (value ==
                                  'delete') {

                                deleteEmployee(
                                  actualIndex,
                                );
                              }
                            },

                            itemBuilder:
                                (context) => [

                              const PopupMenuItem(
                                value: 'edit',
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.edit,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Edit'),
                                  ],
                                ),
                              ),

                              const PopupMenuItem(
                                value: 'delete',
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.delete,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Delete'),
                                  ],
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

// =====================================================
// ATTENDANCE PAGE
// =====================================================

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() =>
      _AttendancePageState();
}

class _AttendancePageState
    extends State<AttendancePage> {

  final Map<String, String> attendance =
      {};

  void markAttendance(
    String employeeId,
    String status,
  ) {

    setState(() {
      attendance[employeeId] =
          status;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
            const Text('Attendance'),
      ),

      body: AppData.employees.isEmpty

          ? const Center(
              child: Text(
                'Add employees first',
                style:
                    TextStyle(fontSize: 18),
              ),
            )

          : ListView.builder(

              padding:
                  const EdgeInsets.all(12),

              itemCount:
                  AppData.employees.length,

              itemBuilder:
                  (context, index) {

                final employee =
                    AppData.employees[index];

                final status =
                    attendance[employee.id] ??
                        'Not Marked';

                return Card(

                  margin:
                      const EdgeInsets.only(
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
                          style:
                              const TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                          height: 4,
                        ),

                        Text(
                          'ID: ${employee.id.isEmpty ? '-' : employee.id}',
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Text(
                          'Status: $status',
                          style:
                              const TextStyle(
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                          height: 8,
                        ),

                        Wrap(
                          spacing: 8,
                          children: [

                            FilledButton(
                              onPressed: () =>
                                  markAttendance(
                                employee.id,
                                'Present',
                              ),
                              child:
                                  const Text(
                                'Present',
                              ),
                            ),

                            OutlinedButton(
                              onPressed: () =>
                                  markAttendance(
                                employee.id,
                                'Absent',
                              ),
                              child:
                                  const Text(
                                'Absent',
                              ),
                            ),

                            OutlinedButton(
                              onPressed: () =>
                                  markAttendance(
                                employee.id,
                                'Half Day',
                              ),
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

// =====================================================
// OT PAGE
// =====================================================

class OTPage extends StatefulWidget {
  const OTPage({super.key});

  @override
  State<OTPage> createState() =>
      _OTPageState();
}

class _OTPageState
    extends State<OTPage> {

  final Map<String, double> otHours =
      {};

  void setOT(
    String employeeId,
    double hours,
  ) {

    setState(() {

      otHours[employeeId] =
          hours;

      AppData.otHours =
          otHours.values.fold(
        0,
        (sum, value) =>
            sum + value,
      );
    });
  }

  void openOTDialog(
    Employee employee,
  ) {

    final controller =
        TextEditingController();

    showDialog(
      context: context,

      builder: (context) {

        return AlertDialog(

          title: Text(
            'OT - ${employee.name}',
          ),

          content: TextField(
            controller: controller,
            keyboardType:
                TextInputType.number,
            decoration:
                const InputDecoration(
              labelText:
                  'OT Hours',
              prefixIcon:
                  Icon(Icons.access_time),
            ),
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

                final hours =
                    double.tryParse(
                          controller.text,
                        ) ??
                        0;

                setOT(
                  employee.id,
                  hours,
                );

                Navigator.pop(context);
              },

              child:
                  const Text('Save'),
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
        title:
            const Text('Overtime'),
      ),

      body: AppData.employees.isEmpty

          ? const Center(
              child: Text(
                'Add employees first',
              ),
            )

          : ListView.builder(

              padding:
                  const EdgeInsets.all(12),

              itemCount:
                  AppData.employees.length,

              itemBuilder:
                  (context, index) {

                final employee =
                    AppData.employees[index];

                final hours =
                    otHours[
                          employee.id] ??
                        0;

                final amount =
                    hours *
                    employee.otRate;

                return Card(

                  margin:
                      const EdgeInsets.only(
                    bottom: 10,
                  ),

                  child: ListTile(

                    leading:
                        const CircleAvatar(
                      child:
                          Icon(Icons.access_time),
                    ),

                    title: Text(
                      employee.name,
                      style:
                          const TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    subtitle: Text(
                      'OT: ${hours}h\n'
                      'OT Amount: Rs ${amount.toStringAsFixed(0)}',
                    ),

                    isThreeLine: true,

                    trailing:
                        IconButton(
                      icon:
                          const Icon(Icons.edit),
                      onPressed: () =>
                          openOTDialog(
                        employee,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// =====================================================
// PAYMENT PAGE
// =====================================================

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {

    double total = 0;

    for (final employee
        in AppData.employees) {

      total += employee.monthlyRate;
    }

    return Scaffold(

      appBar: AppBar(
        title:
            const Text('Payment'),
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(16),

        child: Column(

          children: [

            DashboardCard(
              icon:
                  Icons.people,
              title:
                  'Employees',
              value:
                  '${AppData.employees.length}',
            ),

            const SizedBox(
              height: 12,
            ),

            DashboardCard(
              icon:
                  Icons.payments,
              title:
                  'Total Monthly Rate',
              value:
                  'Rs ${total.toStringAsFixed(0)}',
            ),

            const SizedBox(
              height: 12,
            ),

            DashboardCard(
              icon:
                  Icons.access_time,
              title:
                  'Total OT Hours',
              value:
                  '${AppData.otHours}',
            ),

            const SizedBox(
              height: 12,
            ),

            const Card(
              child: Padding(
                padding:
                    EdgeInsets.all(16),

                child: Text(
                  'Detailed salary calculation, advance, gas cutting and net payment will be connected in the Payment module next.',
                  style:
                      TextStyle(fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// REPORTS PAGE
// =====================================================

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
            const Text(
          'Payment & Reports',
        ),
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(16),

        child: Column(

          children: [

            DashboardCard(
              icon:
                  Icons.people,
              title:
                  'Total Employees',
              value:
                  '${AppData.employees.length}',
            ),

            const SizedBox(
              height: 12,
            ),

            DashboardCard(
              icon:
                  Icons.check_circle,
              title:
                  'Present',
              value:
                  '${AppData.present}',
            ),

            const SizedBox(
              height: 12,
            ),

            DashboardCard(
              icon:
                  Icons.access_time,
              title:
                  'OT Hours',
              value:
                  '${AppData.otHours}',
            ),

            const SizedBox(
              height: 12,
            ),

            DashboardCard(
              icon:
                  Icons.payments,
              title:
                  'Total Payment',
              value:
                  'Rs ${AppData.payment.toStringAsFixed(0)}',
            ),
          ],
        ),
      ),
    );
  }
}
