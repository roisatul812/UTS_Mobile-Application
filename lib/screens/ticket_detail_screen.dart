import 'package:flutter/material.dart';

class TicketDetailScreen extends StatefulWidget {
  final Map<String, String> ticket;
  final String role;

  const TicketDetailScreen({
    super.key,
    required this.ticket,
    required this.role,
  });

  @override
  State<TicketDetailScreen> createState() => _TicketDetailScreenState();
}

class _TicketDetailScreenState extends State<TicketDetailScreen> {
  late String status;

  @override
  void initState() {
    super.initState();
    status = widget.ticket["status"] ?? "Open";
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Open":
        return Colors.red.shade300;
      case "Progress":
        return Colors.orange.shade300;
      case "Done":
        return Colors.green.shade300;
      default:
        return Colors.grey;
    }
  }

  void updateStatus() {
    final updatedTicket = {
      ...widget.ticket,
      "status": status,
    };

    Navigator.pop(context, updatedTicket);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Tiket"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TITLE
            Text(
              widget.ticket["title"] ?? "-",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // DATE + PRIORITY
            Text(
              "${widget.ticket["date"]} • ${widget.ticket["priority"]}",
              style: TextStyle(
                color: isDark
                    ? Colors.grey.shade400
                    : Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 15),

            // STATUS BADGE
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: getStatusColor(status)
                    .withOpacity(isDark ? 0.25 : 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: getStatusColor(status),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // DESKRIPSI
            const Text(
              "Deskripsi",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                widget.ticket["description"] ??
                    "Tidak ada deskripsi",
                style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.color,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // ADMIN ONLY
            if (widget.role == "admin") ...[
              const Text(
                "Update Status",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              DropdownButtonFormField<String>(
                value: status,
                items: ["Open", "Progress", "Done"]
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    status = value!;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: updateStatus,
                  child: const Text("Update Status"),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}