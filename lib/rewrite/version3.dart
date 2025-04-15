import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
void main ()=>runApp(MaterialApp(
  home: InheritedCounter(counterState: CounterState(), child: Center(child: CounterApp())),
));

class Version3 extends StatelessWidget {
  const Version3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
class CounterState extends ChangeNotifier{
  int _increment=0;
  int _decrement=0;
  int get incrementCounter =>_increment;
  int get decrementCounter =>_decrement;
  void increase(){
    _increment++;
    notifyListeners();
  }
  void decrease(){
    _decrement++;
    notifyListeners();
  }

}

class InheritedCounter extends InheritedWidget {
  final CounterState counterState;
  const InheritedCounter( {
    super.key,
    required this.counterState,
    required Widget child,
  }) : super(child: child);

  static InheritedCounter of(BuildContext context) {
    final iw=context.dependOnInheritedWidgetOfExactType <InheritedCounter>();
    final InheritedCounter? result = context.dependOnInheritedWidgetOfExactType<InheritedCounter>();
    assert(result != null, 'No InheritedCounter found in context');
    return iw!;
  }

  @override
  bool updateShouldNotify(covariant InheritedCounter old) {
    return counterState !=old.counterState;
  }
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: AppTittle(),),
      body: AppBody(),
    );
  }
}

class AppTittle extends StatelessWidget {
  const AppTittle({super.key});

  @override
  Widget build(BuildContext context) {
    final state =InheritedCounter.of(context).counterState;

    return ListenableBuilder(listenable: state, builder: (context,_){
      final totalChanges=state.incrementCounter+state.decrementCounter;

      return Text("Counter changes : $totalChanges");

    });
  }
}
class AppBody extends StatelessWidget {
  const AppBody({super.key});

  @override
  Widget build(BuildContext context) {
    final  state =InheritedCounter.of(context ).counterState;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BodyText(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: state.increase, child: const Text("Increment")),
              const SizedBox(height: 20,),
              ElevatedButton(onPressed: state.decrease, child: const Text("Decrement")),


            ],
          )

        ],
      ),
    );
  }
}

class BodyText extends StatelessWidget {
  const BodyText({super.key});

  @override
  Widget build(BuildContext context) {
    context.counterState;
    final state=InheritedCounter.of(context).counterState;
    return ListenableBuilder(listenable: state, builder: (context,_){
      final diff=state.incrementCounter-state.decrementCounter;
      return Text("The count is $diff");
    });
  }
}


extension BuildContextExt on BuildContext{
  CounterState get counterState=>InheritedCounter.of(this).counterState;
}
