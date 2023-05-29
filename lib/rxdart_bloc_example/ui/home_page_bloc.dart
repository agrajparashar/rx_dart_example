import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rx_dart_demo_app/example_export.dart';

class HomePageBlocView extends StatefulWidget {
  const HomePageBlocView({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<HomePageBlocView> createState() => _HomePageBlocViewState();
}

class _HomePageBlocViewState extends State<HomePageBlocView> {

  HomePageBloc? homeBloc;

  @override
  void initState() {
    homeBloc = HomePageBloc(0);
    listenToStream();
    super.initState();
  }

  @override
  void dispose() {
    homeBloc?.close();
    super.dispose();
  }

  void listenToStream(){
    homeBloc?.behaviorSubject.listen((state) {
      if (state is IncrementState){
        Fluttertoast.showToast(msg: state.message ?? '');
      }else if (state is DecrementState){
        Fluttertoast.showToast(msg: state.message ?? '');
      }
    });


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
            BlocBuilder<HomePageBloc,CounterState>(
                bloc: homeBloc,
                buildWhen: (previous, current) {
                  return previous != current;
                },
                builder: (context, state){
                  if (state is IncrementState){
                    print('message returned ${state.message}');
                    return Text(
                      '${state.counterNumber}',
                      style: Theme.of(context).textTheme.headline4,
                    );
                  }else if (state is DecrementState){
                    print('message returned ${state.message}');
                    return Text(
                      '${state.counterNumber}',
                      style: Theme.of(context).textTheme.headline4,
                    );
                  }else{
                    return const Text(
                      'No Bloc State Listened',
                    );
                  }
                }),
            const SizedBox(height: 32),
            FloatingActionButton(
              onPressed: (){
                homeBloc?.add(IncrementEvent());
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 8),
            FloatingActionButton(
              onPressed: (){
                homeBloc?.add(DecrementEvent());
              },
              tooltip: 'Decrement',
              child: const Icon(Icons.remove),
            ),

          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
