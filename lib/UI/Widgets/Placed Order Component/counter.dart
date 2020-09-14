import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_farm_app/Blocs/CartItem_Counter/cartitem_counter_bloc.dart';

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int counter = 0;
  CartitemCounterBloc _counterBloc;

  @override
  void initState() {
    _counterBloc = BlocProvider.of<CartitemCounterBloc>(context);
    _counterBloc.add(IncreamentCounter(counter));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartitemCounterBloc, CartItemCounterState>(
      listener: (context, state) {},
      child: BlocBuilder<CartitemCounterBloc, CartItemCounterState>(
        builder: (context, state) {
          if (state is CartItemCounterInitial) {
            return Container();
          }
          if (state is CartItemCounterLoaded) {
            return Row(
              children: [
                Container(
                  child: IconButton(
                    splashRadius: 10,
                    color: Colors.orangeAccent,
                    iconSize: 60,
                    icon: Icon(Icons.add),
                    onPressed: () {
                      _counterBloc.add(IncreamentCounter(state.counter));
                    },
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  child: Text(
                    "${state.counter}",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  padding: EdgeInsets.only(bottom: 30),
                  child: state.counter <= 0
                      ? IconButton(icon: Icon(Icons.nature), onPressed: null)
                      : IconButton(
                          highlightColor: Colors.black45,
                          iconSize: 60,
                          color: Colors.cyan,
                          icon: Icon(Icons.minimize),
                          onPressed: () {
                            _counterBloc.add(
                              DecreamentCounter(state.counter),
                            );
                          },
                        ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
