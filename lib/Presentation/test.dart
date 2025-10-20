import 'package:flutter/material.dart';
import 'package:luma/ESP32_CONNECTOR/esp32_connector.dart';

class PortControlPage extends StatefulWidget {
  final ESP32ApiClient client;

  PortControlPage({required this.client});

  @override
  _PortControlPageState createState() => _PortControlPageState();
}

class _PortControlPageState extends State<PortControlPage> {
  Map<String, dynamic>? statusData;
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    refreshStatus();
  }

  Future<void> refreshStatus() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final data = await widget.client.getStatus();
      setState(() {
        statusData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> togglePort(int portId, bool currentState) async {
    try {
      if (currentState) {
        await widget.client.turnOff(portId);
      } else {
        await widget.client.turnOn(portId);
      }
      await refreshStatus();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> changeDim(int portId, double value) async {
    try {
      await widget.client.setDim(portId, value.round());
      await refreshStatus();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading && statusData == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Smart Lighting')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        appBar: AppBar(title: Text('Smart Lighting')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, size: 64, color: Colors.red),
              SizedBox(height: 16),
              Text('Error: $errorMessage'),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: refreshStatus,
                child: Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    final ports = statusData?['ports'] as List? ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Lighting'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: refreshStatus,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshStatus,
        child: ListView.builder(
          itemCount: ports.length,
          itemBuilder: (context, index) {
            final port = ports[index];
            final portId = port['id'];
            final isOn = port['isOn'] ?? false;
            final dim = (port['dim'] ?? 0).toDouble();
            final power = port['power'] ?? 0.0;

            return Card(
              margin: EdgeInsets.all(8),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Port $portId',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Switch(
                          value: isOn,
                          onChanged: (value) => togglePort(portId, isOn),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text('Power: ${power.toStringAsFixed(1)} W'),
                    SizedBox(height: 16),
                    Text('Brightness: ${dim.round()}%'),
                    Slider(
                      value: dim,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: '${dim.round()}%',
                      onChanged: isOn ? (value) {
                        setState(() {
                          ports[index]['dim'] = value;
                        });
                      } : null,
                      onChangeEnd: (value) => changeDim(portId, value),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Schedule: ${port['scheduleOn']}:00 - ${port['scheduleOff']}:00',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
