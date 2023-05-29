import 'package:flutter/material.dart';
import 'package:rx_dart_demo_app/example_export.dart';


class MyHomePageStream extends StatefulWidget {
  const MyHomePageStream({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePageStream> createState() => _MyHomePageStreamState();
}

class _MyHomePageStreamState extends State<MyHomePageStream> {

  HomePagePresenter? homePagePresenter;
  final ValueNotifier<int> _counterValue = ValueNotifier(0);
  @override
  void initState() {
    homePagePresenter = HomePagePresenter(0);
    listenToStream();
    super.initState();
  }

  @override
  void dispose() {
    homePagePresenter?.dispose();
    super.dispose();
  }

  void listenToStream(){
    homePagePresenter?.behaviorSubject.listen((value) {
      _counterValue.value = value.counterNumber;
      if (value is IncrementState){
        _showToast('${value.message}');
      }else if (value is DecrementState){
        _showToast('${value.message}');
      }
    });
  }

  void _showToast(String message){
     Fluttertoast.showToast(msg: message);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            ValueListenableBuilder(
                valueListenable: _counterValue,
                builder: (context, int value, child){
                    return Text(
                      '${_counterValue.value}',
                      style: Theme.of(context).textTheme.headline4,
                    );
                }
            ),
            const SizedBox(height: 32),
            FloatingActionButton(
              onPressed: homePagePresenter!.increment,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 8),
            FloatingActionButton(
              onPressed: homePagePresenter!.decrement,
              tooltip: 'Decrement',
              child: const Icon(Icons.remove),
            ),

          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}