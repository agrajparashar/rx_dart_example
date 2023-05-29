abstract class CounterEvent {
  CounterEvent();
}

class IncrementEvent extends CounterEvent{
  String? message;
  IncrementEvent({this.message});
}

class DecrementEvent extends CounterEvent{
  String? message;
  DecrementEvent({this.message});
}