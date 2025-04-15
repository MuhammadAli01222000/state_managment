import 'package:flutter/material.dart';

class Data {
  final int number;
  final double value;
  final String text;
  final bool check;

  const Data({
    required this.number,
    required this.value,
    required this.text,
    required this.check,
  });

  @override
  int get hashCode => Object.hash(number, value, text, check);

  @override
  bool operator ==(Object other) {
    return other is Data && identical(this, other) && number == other.number && value == other.value && text == other.text && check == other.check;
  }

  @override
  String toString() {
    return "$number $value $text $check";
  }
}

class InheritedData extends InheritedWidget {
  final Data data;

  const InheritedData({
    super.key,
    required this.data,
    required super.child,
  });

  static InheritedData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedData>()!;
  }

  @override
  bool updateShouldNotify(InheritedData oldWidget) {
    return data != oldWidget.data;
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  Data data = const Data(number: 1, value: 0.1, text: "text", check: true);
  void rebuild() {
    setState(() {
      data = const Data(number: 2, value: 3.14, text: "Flutter", check: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: rebuild,
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: InheritedData(
        data: data,
        child: PageView(
          children: const [
            Home(),
            Favorite(),
            Profile(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("UI ni qayta qurish uchun kamanda berildi!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Home data: ${InheritedData.of(context).data}"),
      ),
    );
  }
}

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Favorite"),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Profile Data: ${InheritedData.of(context).data}"),
      ),
    );
  }
}