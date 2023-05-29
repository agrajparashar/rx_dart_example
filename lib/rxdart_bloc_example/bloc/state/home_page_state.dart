class CounterState {
  int counterNumber;

  CounterState(this.counterNumber);
}

class IncrementState extends CounterState{
  String? message;
  IncrementState(counterNumber,{this.message}) : super(counterNumber);
}

class DecrementState extends CounterState{
  String? message;
  DecrementState(counterNumber,{this.message}) : super(counterNumber);
}