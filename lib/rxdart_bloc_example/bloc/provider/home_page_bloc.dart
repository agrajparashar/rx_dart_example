import 'package:rx_dart_demo_app/example_export.dart';

class HomePageBloc extends Bloc<CounterEvent, CounterState> {

  var initialCount = 0;
  late BehaviorSubject<CounterState> behaviorSubject = BehaviorSubject<CounterState>.seeded(CounterState(0));

  HomePageBloc(this.initialCount) : super(CounterState(0)) {
    on<IncrementEvent>((event, emit) {
     initialCount++;
     emit(IncrementState(initialCount));
     var state = IncrementState(initialCount,message: 'value incremented successfully');
     behaviorSubject.sink.add(state);
    });

    on<DecrementEvent>((event, emit) {
      initialCount--;
      emit(DecrementState(initialCount));
      var state = DecrementState(initialCount,message: 'value decremented successfully');
      behaviorSubject.sink.add(state);
    });
  }
}
