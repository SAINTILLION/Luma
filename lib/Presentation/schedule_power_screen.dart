import 'package:flutter/material.dart';

class SchedulePowerScreen extends StatefulWidget {
  const SchedulePowerScreen({super.key});

  @override
  State<SchedulePowerScreen> createState() => _SchedulePowerScreenState();
}

class _SchedulePowerScreenState extends State<SchedulePowerScreen> {
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  Future<void> _pickTime(bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  String _formatTime(TimeOfDay? time) {
    if (time == null) return "--:--";
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final period = time.period == DayPeriod.am ? "AM" : "PM";
    return "$hour:${time.minute.toString().padLeft(2, '0')} $period";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Schedule Power"),
        backgroundColor: Colors.blue.shade700,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Set Power Schedule",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 25),

            // Start Time Card
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                leading: const Icon(Icons.access_time, color: Colors.blue),
                title: const Text("Start Time"),
                trailing: Text(
                  _formatTime(startTime),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                onTap: () => _pickTime(true),
              ),
            ),
            const SizedBox(height: 15),

            // End Time Card
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                leading:
                    const Icon(Icons.access_time_filled, color: Colors.red),
                title: const Text("End Time"),
                trailing: Text(
                  _formatTime(endTime),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                onTap: () => _pickTime(false),
              ),
            ),

            const Spacer(),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.blue.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // TODO: Handle save action
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Schedule Saved")),
                  );
                },
                icon: const Icon(Icons.save),
                label: const Text(
                  "Save Schedule",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
