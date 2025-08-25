// ================= PORT DETAIL SCREEN =================
import 'package:flutter/material.dart';
import 'package:luma/Presentation/energy_consumption_screen.dart';
import 'package:luma/Presentation/schedule_power_screen.dart';

class PortDetailScreen extends StatefulWidget {
  final String portName;
  const PortDetailScreen({super.key, required this.portName});

  @override
  State<PortDetailScreen> createState() => _PortDetailScreenState();
}

class _PortDetailScreenState extends State<PortDetailScreen> {
  bool isOn = true;
  bool dimming = false;
  bool voiceCommand = false;
  double _contrast = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.portName, 
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            SwitchListTile(
              title: const Text("Power"),
              value: isOn,
              activeColor: Colors.blue,
              onChanged: (val) => setState(() => isOn = val),
              secondary: Icon(
                Icons.lightbulb,
                color: isOn ? Colors.amber : Colors.grey,
              ),
            ),
             const Divider(),
            SwitchListTile(
              title: const Text("Voice Mode"),
              value: voiceCommand,
              activeColor: Colors.blue,
              onChanged: (val) => setState(() => voiceCommand = val),
              secondary: const Icon(Icons.mic, color: Colors.deepPurple),
            ),
            const Divider(),
            SwitchListTile(
              title: const Text("Dimming Effect"),
              value: dimming,
              activeColor: Colors.blue,
              onChanged: (val) => setState(() => dimming = val),
              secondary: const Icon(Icons.brightness_6, color: Colors.orange),
            ),
            const Divider(),
            ListTile(
              title: const Text("View Energy Consumption"),
              trailing: const Icon(Icons.chevron_right, color: Colors.blue),
              onTap: () {
                // navigate to consumption screen
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EnergyConsumptionScreen()),
                );
              },
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "Adjust Brightness",
                    style: TextStyle(fontSize: 16)
                  ),
                ),
                Slider(
                  value: _contrast,
                  min: 0,
                  max: 1,
                  divisions: 10, // optional tick marks
                  label: "${(_contrast * 100).toInt()}%",
                  onChanged: (value) {
                    setState(() {
                      _contrast = value;
                    });
                  },
                )
              ],
            ),
            const Divider(),
            ListTile(
              title: const Text("Schedule Power"),
              trailing: const Icon(Icons.schedule, color: Colors.green),
              onTap: () {
                // navigate to scheduling screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SchedulePowerScreen(),
                  ),
                );
              },
            ),
            const Divider(),
            const SizedBox(height: 50),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Status: Not connected",
                style: TextStyle(fontSize: 16)
              )
            ),
          ],
        ),
      ),
    );
  }
}
