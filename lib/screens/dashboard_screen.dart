import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'ticket_list_screen.dart';
import 'create_ticket_screen.dart';

class DashboardScreen extends StatelessWidget {
  final String role;

  const DashboardScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard (${role.toUpperCase()})"),
        actions: [
          IconButton(
            icon: const Icon(Icons.dark_mode),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(child: statCard(context, "Total", "12")),
                const SizedBox(width: 10),
                Expanded(child: statCard(context, "Open", "5")),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(child: statCard(context, "Progress", "4")),
                const SizedBox(width: 10),
                Expanded(child: statCard(context, "Done", "3")),
              ],
            ),

            const SizedBox(height: 25),

            Text(
              "Menu",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),

            const SizedBox(height: 15),

            if (role == "admin") ...[
              menuButton(context, "Manage Tiket", () {}),
              const SizedBox(height: 10),
              menuButton(context, "Assign Tiket", () {}),
            ] else ...[
              menuButton(context, "List Tiket", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TicketListScreen(role: role),
                  ),
                );
              }),

              const SizedBox(height: 10),

              menuButton(context, "Create Tiket", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateTicketScreen(),
                  ),
                );
              }),
            ],
          ],
        ),
      ),
    );
  }

  Widget statCard(BuildContext context, String title, String value) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget menuButton(BuildContext context, String title, VoidCallback onTap) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isDark
              ? Colors.white.withOpacity(0.85)
              : Colors.black.withOpacity(0.85),
          foregroundColor: isDark ? Colors.black : Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        onPressed: onTap,
        child: Text(title),
      ),
    );
  }
}
