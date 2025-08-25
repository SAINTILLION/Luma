import 'package:flutter/material.dart';

class EnergyConsumptionScreen extends StatelessWidget {
  const EnergyConsumptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Energy Consumption",
           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
        ),
        centerTitle: true,
          leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
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
                    children: const [
                      Icon(Icons.lightbulb, size: 60, color: Colors.orange),
                      SizedBox(height: 12),
                      Text(
                        "Smart Lamp Usage",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 50),
              
              Divider(thickness: 2,),

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
              const SizedBox(height: 24),

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
