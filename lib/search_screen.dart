import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search News', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        // backgroundColor: Colors.black87,
        // iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for news...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(19),
                    ),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (query) {
                    // Perform search logic here (e.g., call API to fetch results)
                  },
                ),
              ),
              // SizedBox(height: 20),
              Expanded(
                child: Center(
                  child: Text(
                    'Search results will appear here.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }
}
