import 'package:flutter/material.dart';
import 'dart:core';

void main() {
  runApp(const CounterApp());
} 
class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title:'Counter With History',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
      home: const CounterScreen(),
    );
  }
}
class CounterScreen extends StatefulWidget{
  const CounterScreen ({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();

}

class _CounterScreenState extends State<CounterScreen>{
  int _count = 0;
  final List<int> _history = [];
  void _increment () {
    setState((){
      _count++;
      _history.add(_count);
    });
  }
  void _setZero () {
    setState( () {
      _count = 0 ;
      _history.clear();
    });
  }
  void _goToHistory(){
    Navigator.push( 
      context,
      MaterialPageRoute(
      builder: (context) => HistoryScreen(history: _history) 
        ),
    );
  }

  @override
  Widget build(BuildContext context){  
    final Text myText = Text('count : $_count', style: TextStyle(fontSize: 32));
    return Scaffold(
      appBar: AppBar (title: const Text('Counter App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            myText,
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _increment,
              child: const Text ('Increment'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _goToHistory,
              child: const Text ('View History'),
            ),
                ElevatedButton(
              onPressed: () {_setZero();},
              child: const Text ('Reload'),
            ),
          ]
          
        )
        
      )
    );
  }
}

class HistoryScreen extends StatelessWidget {
  final List<int> history;
  
  const HistoryScreen ({super.key, required this.history});
  
  void _returnToCounter(BuildContext context){
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar :AppBar (title: const Text('History Screen')),
      body: Center (
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Expanded(
            child: ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index){
                final value = history[index];
                return ListTile(
                  leading: Text ('Count rank $index'),
                 title: Text ('count value $value') 
                );
              }
            ),),
            const SizedBox(height: 30),            ElevatedButton(
              onPressed: () => _returnToCounter(context) ,
              child: const Text('Return to count Screen'),
            )
            
          ]
        ) 
      )
    );

  }
}
