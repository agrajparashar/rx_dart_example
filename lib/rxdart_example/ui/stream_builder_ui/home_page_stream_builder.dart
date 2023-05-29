import 'package:flutter/material.dart';
import 'package:rx_dart_demo_app/example_export.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePagePresenter? homePagePresenter;

  @override
  void initState() {
    homePagePresenter = HomePagePresenter(0);
    super.initState();
  }

  @override
  void dispose() {
    homePagePresenter?.dispose();
    super.dispose();
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
            StreamBuilder(
              stream: homePagePresenter!.behaviorSubject.stream,
              builder: (context,snapshot){
                if (snapshot.data is CounterState){
                  if ((snapshot.data is IncrementState ) || (snapshot.data is DecrementState )) {
                    var message = (snapshot.data is IncrementState) ? (snapshot
                        .data as IncrementState).message : (snapshot
                        .data as DecrementState).message;
                    _showToast(message ?? 'no text found');
                  }
                  return Text(
                    '${(snapshot.data as CounterState).counterNumber}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                }else{
                  return Text(
                    'No state found',
                    style: Theme.of(context).textTheme.headline4,
                  );
                }

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
