import 'package:flutter/material.dart';
void main () {
 // runApp(const  CounterApp());
 // runApp(const Task1());
//  runApp(const HideAndShowState());
//runApp(WidgetA(widget:const WidgetB()));
//runApp(WidgetWithData(data:""));
//runApp(const  WidgetWithData1(data:"Salom"));
}
class CounterApp extends StatefulWidget {
  const CounterApp({super.key});

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int _counter=0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Press the button"),
              ElevatedButton(onPressed: (){setState(() {
                _counter++;
              });}, child: Text("$_counter"))
            ],

        ),
      ),
    );
  }
}


class Task1 extends StatefulWidget {
  const Task1({super.key});

  @override
  State<Task1> createState() => _Task1State();
}

class _Task1State extends State<Task1> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: BottomAppBar(),
      ),

    );
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _index=0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex:_index ,
        onTap: (newIndex){
          setState(() {
            _index=newIndex;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.search),label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person_2_rounded),label: ""),

    ]);
  }
}
class HideAndShowState extends StatefulWidget {
  const HideAndShowState({super.key});

  @override
  State<HideAndShowState> createState() => _HideAndShowStateState();
}

class _HideAndShowStateState extends State<HideAndShowState> {
  bool visible=false;
  @override
  Widget build(BuildContext context) {
    final text=visible? 'Set to invisible':'set to visible';
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
          const  Spacer(),
            Text("Visible = $visible"),
            const SizedBox(height: 10,),
            Center(
              child: ElevatedButton(onPressed: (){
                setState(() {
                  visible=!visible;
                });

              }, child: Text(text)),
            ),
            const  Spacer(),

          ],
        ),
      ),
    );
  }
}

class WidgetA extends StatefulWidget {
  final Widget widget;
  const WidgetA({super.key, required this.widget});

  @override
  State<WidgetA> createState() => _WidgetAState();
}

class _WidgetAState extends State<WidgetA> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
             const Spacer(),
              Card(
                color: Colors.red,
                child: Center(
                  child: ElevatedButton(onPressed: (){setState(() {

                  });}, child:const  Text("Press me")),
                ),
              ),
              widget.widget,
              const Spacer(),

            ],
          ),
        ),
      ),
    );
  }
}

class WidgetB extends StatefulWidget {
  const WidgetB({super.key});

  @override
  State<WidgetB> createState() => _WidgetBState();
}

class _WidgetBState extends State<WidgetB> {
  @override
  Widget build(BuildContext context) {
    debugPrint("WidgetB rebuild");
    return Container();
  }
}

class WidgetWithData extends StatelessWidget {
  final String data;
  const WidgetWithData({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child:WidgetC(data: Data(),),
        ),
      ),
    );
  }
}
/// inherited
class WidgetC extends StatelessWidget {
  final Data data;
  const WidgetC({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return WidgetD(data: data);
  }
}
class WidgetD extends StatelessWidget {
  final Data data;

  const WidgetD({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return WidgetE(data: data);
  }
}

class WidgetE extends StatelessWidget {
  final Data data;

  const WidgetE({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
class Data{

}

///inHeritedData
class InheritedData extends InheritedWidget{
  final Data data;
  const InheritedData( { super.key,required this.data, required super.child,});

  static InheritedData of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<InheritedData>()!;
  }
  @override
  bool updateShouldNotify(covariant InheritedData oldWidget) {
    return data!= oldWidget.data;
  }
}

///>>>>>>>>

class WidgetWithData1 extends StatelessWidget {
  final String data;
  const WidgetWithData1({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: InheritedData(
          data:Data(),
          child: Center(
            child:WidgetC(data: Data(),),
          ),
        ),
      ),
    );
  }
}
/// inherited
class WidgetC1 extends StatelessWidget {
  final WidgetD1 widgetD1;
  const WidgetC1({super.key, required this.widgetD1});

  @override
  Widget build(BuildContext context) {
    return WidgetD1( widgetE1: WidgetE1(useData: UseData(data: Data())),);
  }
}
class WidgetD1 extends StatelessWidget {
  final WidgetE1 widgetE1;

  const WidgetD1({super.key, required this.widgetE1});

  @override
  Widget build(BuildContext context) {
    return WidgetE1(useData: UseData(data: Data()),);
  }
}

class WidgetE1 extends StatelessWidget {
  final UseData useData;

  const WidgetE1({super.key, required this.useData});

  @override
  Widget build(BuildContext context) {
    return UseData(data: Data(),);
  }
}
class UseData extends StatelessWidget {
  final Data data;
  const UseData({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("$data"),);
  }
}
