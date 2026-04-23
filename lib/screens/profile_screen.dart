import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  final String role;
  final String? email;

  const ProfileScreen({
    super.key,
    required this.role,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // ✅ ambil provider (WAJIB)
    final themeProvider = Provider.of<ThemeProvider>(context);

    // ✅ anti null crash
    final displayEmail =
        (email == null || email!.isEmpty) ? "user@mail.com" : email!;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              child: Icon(Icons.person, size: 40),
            ),

            const SizedBox(height: 15),

            Text(
              role == "admin" ? "Admin User" : "User",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              displayEmail,
              style: TextStyle(
                color: isDark
                    ? Colors.grey.shade400
                    : Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 30),

            // 🔥 SETTINGS CARD
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // 🌙 DARK MODE SWITCH
                  ListTile(
                    leading: const Icon(Icons.dark_mode),
                    title: const Text("Dark Mode"),
                    trailing: Switch(
                      value: themeProvider.isDarkMode,
                      onChanged: (value) {
                        themeProvider.toggleTheme(value);
                      },
                    ),
                  ),

                  const Divider(),

                  const ListTile(
                    leading: Icon(Icons.lock),
                    title: Text("Change Password"),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // 🔓 LOGOUT BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isDark ? Colors.white : Colors.black,
                  foregroundColor:
                      isDark ? Colors.black : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const LoginScreen(),
                    ),
                    (route) => false,
                  );
                },
                child: const Text("Logout"),
              ),
            )
          ],
        ),
      ),
    );
  }
}