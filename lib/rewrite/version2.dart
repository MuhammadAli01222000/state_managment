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

class DataController extends ChangeNotifier {
  Data data = const Data(number: 1, value: 0.1, text: "text", check: true);

  void rebuild() {
    data = const Data(number: 2, value: 3.14, text: "Flutter", check: false);
    notifyListeners();
  }
}

class InheritedData extends InheritedWidget {
  final DataController controller;

  const InheritedData({
    super.key,
    required this.controller,
    required super.child,
  });

  static InheritedData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedData>()!;
  }

  @override
  bool updateShouldNotify(InheritedData oldWidget) {
    return controller.data != oldWidget.controller.data;
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InheritedData(
        controller: DataController(),
        child: const Main(),
      ),
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: InheritedData.of(context).controller.rebuild,
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: PageView(
        children: const [
          Home(),
          Favorite(),
          Profile(),
        ],
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
        child: ListenableBuilder(
          listenable: InheritedData.of(context).controller,
          builder: (context, child) {
            return Text("Home data: ${InheritedData.of(context).controller.data}");
          },
        ),
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
        child: ListenableBuilder(
          listenable: InheritedData.of(context).controller,
          builder: (context, child) {
            return Text("Profile data: ${InheritedData.of(context).controller.data}");
          },
        ),
      ),
    );
  }
}