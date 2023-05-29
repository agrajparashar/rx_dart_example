import 'package:rx_dart_demo_app/example_export.dart';

class HomePagePresenter {

  int initialCount = 0;
  late BehaviorSubject<CounterState> behaviorSubject;

  HomePagePresenter(this.initialCount){
    behaviorSubject = BehaviorSubject<CounterState>.seeded(CounterState(initialCount));
  }

  void increment(){
    initialCount++ ;
    behaviorSubject.sink.add(IncrementState(initialCount, message: 'Value incremented successfully'));

  }

  void decrement(){
    initialCount-- ;
    behaviorSubject.sink.add(DecrementState(initialCount,message: 'Value decremented successfully'));

  }


  void dispose(){
    behaviorSubject.close();
  }
}
