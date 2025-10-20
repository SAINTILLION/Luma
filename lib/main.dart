import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:luma/ESP32_CONNECTOR/esp32_connector.dart';
import 'package:luma/Presentation/test.dart';
import 'package:luma/Presentation/total_energy_consumption_screen.dart';
import 'package:luma/Presentation/home.dart';
import 'package:luma/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const SmartLampApp());
}

class SmartLampApp extends StatelessWidget {
  const SmartLampApp({super.key});

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Lamp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey.shade100,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 124, 184, 233),
          elevation: 0,
        ),
      ),
      home: const BottomNavigator(),//PortDetailScreen(portName: "Port 1")//const BottomNavigator(), // ⬅️ wraps bottom navigation
    );
  }
}

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  final PageController _pageController = PageController();

  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const TotalEnergyConsumptionScreen(),
    PortControlPage(client: ESP32ApiClient('baseUrl')) //Replace and use the real baseUrl letter
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Energy Consumption",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessible_sharp),
            label: "Testing"
          )
        ],
      ),
    );
  }
}
