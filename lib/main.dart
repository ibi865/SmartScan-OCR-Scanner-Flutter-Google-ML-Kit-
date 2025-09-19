import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const ScannerApp());
}

class ScannerApp extends StatelessWidget {
  const ScannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Document Scanner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late ImagePicker _imagePicker;


  @override
  void initState() {
    super.initState();
    _imagePicker=ImagePicker();
  }

  static const List<Widget> _widgetOptions = <Widget>[
    ScanScreen(),
    Text('Recognition Screen'),
    Text('Enhance Screen'),
    Text('History Screen'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Document Scanner"),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Handle settings
            },
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.document_scanner),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.text_snippet),
            label: 'Recognize',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome),
            label: 'Enhance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[700],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Welcome message - now with different color and separated from app bar
        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(16), // Added margin for separation
          decoration: BoxDecoration(
            color: Colors.blue[50], // Different color from app bar
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.3),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi User,",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue, // Different text color
                ),
              ),
              SizedBox(height: 8),
              Text(
                "How can I help you today?",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey,
                ),
              ),
            ],
          ),
        ),

        // Main functionality cards
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // First row of cards
                Row(
                  children: [
                    Expanded(
                      child: _FeatureCard(
                        icon: Icons.document_scanner,
                        title: "Scan",
                        subtitle: "Documents, ID cards...",
                        color: Colors.blue,
                        onTap: () {
                          // Handle scan functionality
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _FeatureCard(
                        icon: Icons.auto_awesome, // Changed icon for Enhance
                        title: "Enhance", // Changed from Edit to Enhance
                        subtitle: "Improve quality, adjust...", // Updated subtitle
                        color: Colors.green,
                        onTap: () {
                          // Handle enhance functionality
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Second row of cards
                Row(
                  children: [
                    Expanded(
                      child: _FeatureCard(
                        icon: Icons.text_snippet, // Changed icon for Recognize
                        title: "Recognize", // Changed from Convert to Recognize
                        subtitle: "Extract text, OCR...", // Updated subtitle
                        color: Colors.orange,
                        onTap: () {
                          // Handle recognize functionality
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _FeatureCard(
                        icon: Icons.smart_toy,
                        title: "Ask AI",
                        subtitle: "Summarize, finish writing...",
                        color: Colors.purple,
                        onTap: () {
                          // Handle AI functionality
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Search card
                _FeatureCard(
                  icon: Icons.search,
                  title: "Search",
                  subtitle: "Find documents quickly",
                  color: Colors.red,
                  onTap: () {
                    // Handle search functionality
                  },
                ),
                const SizedBox(height: 24),

                // Recent scans section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Recent Scans",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Placeholder for recent scans
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.folder_open, size: 48, color: Colors.grey),
                            SizedBox(height: 16),
                            Text(
                              "Your scanned documents will appear here",
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32,
                color: color,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}