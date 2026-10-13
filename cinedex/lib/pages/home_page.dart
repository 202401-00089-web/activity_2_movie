import 'package:flutter/material.dart';
import 'film_list_page.dart';
import 'now_showing_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  final _pages = const [FilmListPage(), NowShowingPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.video_library), label: 'Library'),
          NavigationDestination(icon: Icon(Icons.live_tv), label: 'Now Showing'),
        ],
      ),
    );
  }
}
