import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const SettingsPage({
    Key? key,
    required this.isDarkMode,
    required this.onThemeChanged,
  }) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: Icon(
              Icons.dark_mode,
              color: widget.isDarkMode ? Colors.white : Colors.black,
            ),
            title: Text(
              'Dark Mode',
              style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),
            ),
            trailing: Switch(
              activeColor: Colors.grey,
              value: widget.isDarkMode, // Use widget.isDarkMode
              onChanged: (value) {
                widget.onThemeChanged(value); // Pass the new theme state to the parent
                setState(() {}); // Trigger a rebuild to update the UI
              },
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.text_fields),
            title: Text('Font Size'),
            onTap: () {
              // Add font size adjustment functionality or navigation
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Adjust Font Size'),
                  content: Text('Font size adjustment functionality coming soon!'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Close'),
                    ),
                  ],
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help & Support'),
            onTap: () {
              // Navigate to a Help page (placeholder)
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HelpPage(),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'News App',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2025 Vidhika Anjne',
              );
            },
          ),
        ],
      ),
      backgroundColor: widget.isDarkMode ? Colors.black87 : Colors.white, // Use widget.isDarkMode
    );
  }
}

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Support'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(102, 154, 177, 100),
      ),
      body: Center(
        child: Text(
          'Help & support content coming soon!',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),
    );
  }
}
