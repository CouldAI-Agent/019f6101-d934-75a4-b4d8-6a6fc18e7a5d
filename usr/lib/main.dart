import 'package:flutter/material.dart';

void main() {
  runApp(const NobiORasulApp());
}

class NobiORasulApp extends StatelessWidget {
  const NobiORasulApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'নবী ও রাসূল (আঃ) - ইসলামিক গল্প',
      debugShowCheckedModeBanner: false,
      theme: _buildIslamicTheme(Brightness.light),
      darkTheme: _buildIslamicTheme(Brightness.dark),
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => const MainDashboard(),
        '/home': (context) => const MainDashboard(),
        '/prophets': (context) => const AllProphetsScreen(),
        '/timeline': (context) => const TimelineScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }

  ThemeData _buildIslamicTheme(Brightness brightness) {
    const Color emeraldGreen = Color(0xFF047857);
    const Color darkGreen = Color(0xFF064E3B);
    const Color gold = Color(0xFFD97706);
    const Color softBeige = Color(0xFFFEF3C7);

    return ThemeData(
      brightness: brightness,
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: emeraldGreen,
        brightness: brightness,
        primary: emeraldGreen,
        secondary: gold,
        surface: brightness == Brightness.light ? softBeige : const Color(0xFF1F2937),
        onPrimary: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: brightness == Brightness.light ? emeraldGreen : darkGreen,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
      ),
    );
  }
}

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    AllProphetsScreen(),
    TimelineScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      body: Row(
        children: [
          if (isDesktop)
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(icon: Icon(Icons.home), label: Text('হোম')),
                NavigationRailDestination(icon: Icon(Icons.menu_book), label: Text('নবীগণ')),
                NavigationRailDestination(icon: Icon(Icons.timeline), label: Text('টাইমলাইন')),
                NavigationRailDestination(icon: Icon(Icons.settings), label: Text('সেটিংস')),
              ],
            ),
          if (isDesktop) const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: _screens[_selectedIndex]),
        ],
      ),
      bottomNavigationBar: isDesktop
          ? null
          : NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home), label: 'হোম'),
                NavigationDestination(icon: Icon(Icons.menu_book), label: 'নবীগণ'),
                NavigationDestination(icon: Icon(Icons.timeline), label: 'টাইমলাইন'),
                NavigationDestination(icon: Icon(Icons.settings), label: 'সেটিংস'),
              ],
            ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('নবী ও রাসূল (আঃ)')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBanner(context),
              const SizedBox(height: 24),
              Text('দৈনন্দিন অনুপ্রেরণা', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _buildDailyCard(context, 'দৈনন্দিন হাদিস', 'তোমাদের মধ্যে সেই উত্তম যার চরিত্র সবচেয়ে সুন্দর। (সহীহ বুখারী)', Icons.format_quote),
              const SizedBox(height: 16),
              _buildDailyCard(context, 'দৈনন্দিন দোয়া', 'হে আল্লাহ, আমি আপনার কাছে উপকারী জ্ঞান, হালাল রিজিক এবং গ্রহণযোগ্য আমল চাই।', Icons.back_hand),
              const SizedBox(height: 24),
              Text('প্রধান নবী', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _buildFeaturedProphetCard(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1572889670275-385d0d4f2913?auto=format&fit=crop&q=80'),
          fit: BoxFit.cover,
          opacity: 0.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('স্বাগতম', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white70)),
          const SizedBox(height: 8),
          Text('ইসলামিক গল্প', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.play_arrow),
            label: const Text('পড়তে থাকুন'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyCard(BuildContext context, String title, String content, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Theme.of(context).colorScheme.secondary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(content, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedProphetCard(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                image: const DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1597931326362-e6e23db9c6d3?auto=format&fit=crop&q=80'),
                  fit: BoxFit.cover,
                  opacity: 0.5,
                ),
              ),
              child: Center(
                child: Text('مُحَمَّد', style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('মুহাম্মদ ﷺ', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('সর্বশেষ নবী ও রাসূল, মানবতার জন্য রহমত।', style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AllProphetsScreen extends StatelessWidget {
  const AllProphetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> prophets = [
      {'name': 'আদম (আঃ)', 'arabic': 'آدَم', 'desc': 'প্রথম মানব ও নবী।'},
      {'name': 'নূহ (আঃ)', 'arabic': 'نُوح', 'desc': 'মহা প্লাবন এবং নৌকার নির্মাতা।'},
      {'name': 'ইব্রাহিম (আঃ)', 'arabic': 'إِبْرَاهِيم', 'desc': 'আল্লাহর বন্ধু (খলিলুল্লাহ)।'},
      {'name': 'মুসা (আঃ)', 'arabic': 'مُوسَىٰ', 'desc': 'যিনি আল্লাহর সাথে কথা বলেছেন (কালিমুল্লাহ)।'},
      {'name': 'ঈসা (আঃ)', 'arabic': 'عِيسَىٰ', 'desc': 'মরিয়মের পুত্র, আল্লাহর রুহ।'},
      {'name': 'মুহাম্মদ ﷺ', 'arabic': 'مُحَمَّد', 'desc': 'সর্বশেষ নবী ও রাসূল।'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('সকল নবীগণ')),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: prophets.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  child: Text(
                    prophets[index]['arabic']!.substring(0, 1),
                    style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer),
                  ),
                ),
                title: Text(prophets[index]['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(prophets[index]['desc']!),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
            );
          },
        ),
      ),
    );
  }
}

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('টাইমলাইন')),
      body: const Center(child: Text('নবীগণের ঐতিহাসিক টাইমলাইন এখানে প্রদর্শিত হবে।')),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('সেটিংস')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('ভাষা'),
            subtitle: const Text('বাংলা'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text('ডার্ক মোড'),
            trailing: Switch(value: false, onChanged: (val) {}),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('আমাদের সম্পর্কে'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
