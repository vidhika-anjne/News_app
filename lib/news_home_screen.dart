import 'package:flutter/material.dart';
import 'package:news_app/search_screen.dart';
import 'package:news_app/settings_page.dart';
import 'news_api_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'bottom_nav_bar.dart';

class NewsHomeScreen extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const NewsHomeScreen({
    Key? key,
    required this.isDarkMode,
    required this.onThemeChanged,
  }) : super(key: key);
  @override
  _NewsHomeScreenState createState() => _NewsHomeScreenState();
}

class _NewsHomeScreenState extends State<NewsHomeScreen> {
  final NewsApiService apiService = NewsApiService();
  String selectedCategory = 'general';

  bool isDarkMode = false;

  void _toggleTheme(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  Future<void> _openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  int _currentIndex = 1;

  late final List<Widget> _screens;
  @override
  void initState() {
    super.initState();
    _screens = [
      NewsHomeScreen(
        isDarkMode: widget.isDarkMode, // Correct access within a State class
        onThemeChanged: _toggleTheme,
      ),
      SearchScreen(),
      SettingsPage(
        isDarkMode: widget.isDarkMode,
        onThemeChanged: _toggleTheme,
      ),
    ];
  }

  void _onNavBarTap(int index) {
    if (index == 0) {
      // Navigate to Search screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SearchScreen()),
      );
    } else if (index == 2) {
      // Navigate to Settings screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SettingsPage(
            isDarkMode: widget.isDarkMode,
            onThemeChanged: widget.onThemeChanged,
          ),
        ),
      );
    } else {
      // Update currentIndex for Home
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App',),// style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        // actions: [
        //   Switch(
        //     value: widget.isDarkMode,
        //     onChanged: widget.onThemeChanged,
        //     activeColor: Colors.blue,
        //   ),
        // ],
      ),
      body:Column(
              children: [
                SizedBox(height: 10),
                _buildCategoryChips(),
                SizedBox(height: 10),
                Expanded(
                  child: FutureBuilder<List<dynamic>>(
                    future: apiService.fetchNews(category: selectedCategory),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        final articles = snapshot.data!;
                        return ListView.builder(
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            final article = articles[index];
                            return _buildNewsCard(article);
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
        bottomNavigationBar: BottomNavBar(
          currentIndex: _currentIndex,
          onTap: _onNavBarTap,
        )
    );
  }

  Widget _buildCategoryChips() {
    const categories = ['general', 'technology', 'business', 'sports', 'entertainment', 'health'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          final isSelected = selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ChoiceChip(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
              label: Text(
                category.toUpperCase(),
                // style: TextStyle(
                //   color: isSelected ? Colors.white : Colors.black87,
                //   fontWeight: FontWeight.bold,
                // ),
              ),
              selected: isSelected,
              selectedColor: widget.isDarkMode ?  Colors.black87: Colors.white,
              backgroundColor: Color.fromRGBO(102, 154, 177, 100),
              onSelected: (bool selected) {
                setState(() {
                  selectedCategory = category;
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNewsCard(dynamic article) {
    return Card(
      // color: Colors.black12,
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _openUrl(article['url']),
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: article['urlToImage'] != null
                  ? Image.network(
                article['urlToImage'],
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              )
                  : Container(height: 200,), //color: Colors.grey[300]
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article['title'] ?? 'No Title',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      // color: Color.fromRGBO(102, 154, 177, 100),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    article['description'] ?? 'No Description',
                    // style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    article['source']['name'] ?? 'Unknown Source',
                    // style: TextStyle(fontSize: 12, color : Color.fromRGBO(102, 154, 177, 100)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
