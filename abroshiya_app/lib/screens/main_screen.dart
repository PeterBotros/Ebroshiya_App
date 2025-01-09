import 'package:flutter/material.dart';
import '../localization/custom_localizations.dart';
import '../widgets/church_news_page.dart';
import '../widgets/churches_page.dart';
import 'profile_page.dart';
import 'settings_page.dart';
import 'about_us_page.dart';
import 'year_page.dart'; // Import the YearPage widget

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    ChurchNewsPage(),
    const ChurchesPage(),
  ];

  final List<int> years = List<int>.generate(25, (index) => 2000 + index);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToPage(Widget page) {
    Navigator.of(context).pop(); // Close the drawer
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  void _navigateToYearPage(BuildContext context, int year) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => YearPage(year: year),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localization = CustomLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text(localization.translate('ايبارشية القوصية و مير')),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 150, // Adjust height as needed
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/seamless.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: years.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _navigateToYearPage(context, years[index]),
                  child: Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: const DecorationImage(
                          image: AssetImage('lib/images/Screenshot.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      width: 200, // Adjust width as needed
                      alignment: Alignment.center,
                      child: Text(
                        years[index].toString(),
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(
                              255, 255, 255, 255), // Ensuring text is visible
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.notifications),
            label: localization.translate('الايبارشية'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.place),
            label: localization.translate('كنيستي'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/images/seamless.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Text(
                localization.translate(''),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(localization.translate('Profile')),
              onTap: () => _navigateToPage(const ProfilePage()),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(localization.translate('Settings')),
              onTap: () => _navigateToPage(const SettingsPage()),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: Text(localization.translate('About Us')),
              onTap: () => _navigateToPage(const AboutUsPage()),
            ),
          ],
        ),
      ),
    );
  }
}
