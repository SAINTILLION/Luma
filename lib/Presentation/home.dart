import 'package:flutter/material.dart';
import 'package:luma/Presentation/port_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Create a map to track the state of each port
  Map<String, bool> portStates = {
    "Port 1": true,
    "Port 2": false,
    "Port 3": true,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Smart Lamp",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Images/home_automation.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            // Add childAspectRatio to give more height to cards
            childAspectRatio: 0.85, // Adjust this value as needed (lower = taller cards)
            children: [
              _buildPortCard(context, "Port 1", portStates["Port 1"]!),
              _buildPortCard(context, "Port 2", portStates["Port 2"]!),
              _buildPortCard(context, "Port 3", portStates["Port 3"]!),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPortCard(BuildContext context, String portName, bool isOn) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => PortDetailScreen(portName: portName)),
        );
      },
      child: Card(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: isOn
                  ? [Colors.amber.shade200, Colors.orange.shade300]
                  : [Colors.grey.shade300, Colors.grey.shade500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          // Add padding to prevent content from touching edges
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Changed from center
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.lightbulb,
                size: 50, // Reduced size from 70
                color: isOn ? Colors.yellow.shade900: Colors.white,
              ),
              const SizedBox(height: 8), // Reduced from 12
              Text(
                portName,
                style: TextStyle(
                  fontSize: 16, // Reduced from 18
                  fontWeight: FontWeight.bold,
                  color: isOn ? Colors.white : Colors.black87,
                ),
              ),
              Switch(
                value: isOn,
                onChanged: (value) {
                  setState(() {
                    portStates[portName] = value;
                  });
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              Text(
                isOn ? "ON" : "OFF",
                style: TextStyle(
                  fontSize: 12, // Reduced from 14
                  fontWeight: FontWeight.w500,
                  color: isOn ? Colors.white70 : Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}