import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // for formatting the date

class TotalEnergyConsumptionScreen extends StatefulWidget {
  const TotalEnergyConsumptionScreen({super.key});

  @override
  State<TotalEnergyConsumptionScreen> createState() =>
      _TotalEnergyConsumptionScreenState();
}

class _TotalEnergyConsumptionScreenState
    extends State<TotalEnergyConsumptionScreen> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        // TODO: fetch new data for this date
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Energy Consumption",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.blue.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top summary card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.lightbulb, size: 60, color: Colors.orange),
                      const SizedBox(height: 12),
                      const Text(
                        "Smart Lamp Usage",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Date Picker Button
                      ElevatedButton.icon(
                        onPressed: _pickDate,
                        icon: const Icon(Icons.calendar_today, size: 18),
                        label: Text(
                          DateFormat('EEE, d MMM yyyy').format(_selectedDate),
                          style: const TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),
              const Divider(thickness: 2),
              const SizedBox(height: 24),

              // Power consumed
              _buildStatCard(
                context,
                icon: Icons.flash_on,
                title: "Power Consumed",
                value: "12 W",
                color: Colors.amber,
              ),
              const SizedBox(height: 16),

              // Duration ON
              _buildStatCard(
                context,
                icon: Icons.timer,
                title: "Duration ON",
                value: "5 hrs 32 min",
                color: Colors.green,
              ),
              const SizedBox(height: 16),

              // Energy consumed
              _buildStatCard(
                context,
                icon: Icons.bolt,
                title: "Energy Consumed",
                value: "0.066 kWh",
                color: Colors.blue,
              ),
              
              Divider(),

              const SizedBox(height: 24),

              Align(
                alignment: Alignment.center,
                child: Text(
                  "Status: Not connected",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Custom stat card widget
  Widget _buildStatCard(BuildContext context,
      {required IconData icon,
      required String title,
      required String value,
      required Color color}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color, size: 28),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        trailing: Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}
