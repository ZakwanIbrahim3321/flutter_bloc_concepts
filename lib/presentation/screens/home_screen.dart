import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/enums.dart';
import '../../logic/cubit/counter_cubit.dart';
import '../../logic/cubit/counter_state.dart';
import '../../logic/cubit/internet_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.title,
    required this.color,
  });
  final String title;
  final Color color;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.color,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<InternetCubit, InternetState>(
                builder: (context, state) {
              if (state is InternetConnected &&
                  state.connectionType == ConnectionType.wifi) {
                return Text(
                  'Wifi',
                  style: Theme.of(context).textTheme.headlineLarge,
                );
              } else if (state is InternetConnected &&
                  state.connectionType == ConnectionType.mobile) {
                return Text(
                  'Mobile',
                  style: Theme.of(context).textTheme.headlineLarge,
                );
              } else if (state is InternetnetDisconnected) {
                return Text(
                  'Disconnected',
                  style: Theme.of(context).textTheme.headlineLarge,
                );
              }
              return const CircularProgressIndicator();
            }),
            const SizedBox(
              height: 25,
            ),
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                if (state.wasIncremented!) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Incremented!'),
                    duration: Duration(microseconds: 300),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Decremented!'),
                    duration: Duration(milliseconds: 300),
                  ));
                }
              },
              builder: (context, state) {
                if (state.counterValue < 0) {
                  return Text(
                    'Negative Value ${state.counterValue}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                } else if (state.counterValue.isEven) {
                  return Text(
                    'Even Value ${state.counterValue}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                } else if (state.counterValue.isOdd) {
                  return Text(
                    'Odd Value ${state.counterValue}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                } else {
                  return Text(
                    state.counterValue.toString(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                }
              },
            ),
            const SizedBox(
              height: 25,
            ),
            Builder(builder: (context) {
              final counterState = context.watch<CounterCubit>().state;
              final internetState = context.watch<InternetCubit>().state;
              if (internetState is InternetConnected &&
                  internetState.connectionType == ConnectionType.wifi) {
                return Text(
                  'Counter: ${counterState.counterValue.toString()} Internet: Wifi',
                  style: Theme.of(context).textTheme.headlineLarge,
                );
              } else if (internetState is InternetConnected &&
                  internetState.connectionType == ConnectionType.mobile) {
                return Text(
                  'Counter: ${counterState.counterValue.toString()} Internet: Mobile',
                  style: Theme.of(context).textTheme.headlineLarge,
                );
              } else {
                return Text(
                  'Counter: ${counterState.counterValue.toString()} Internet: Disconnected',
                  style: Theme.of(context).textTheme.headlineLarge,
                );
              }
            }),
            const SizedBox(
              height: 25,
            ),
            Builder(builder: (context) {
              final counterValue = context
                  .select((CounterCubit cubit) => cubit.state.counterValue);
              return Text(
                'Counter: ${counterValue.toString()}',
                style: Theme.of(context).textTheme.headlineLarge,
              );
            }),
            const SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  backgroundColor: widget.color,
                  heroTag: "btn1",
                  onPressed: () {
                    //BlocProvider.of<CounterCubit>(context).decrement();
                    context.read<CounterCubit>().decrement();
                  },
                  tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
                ),
                FloatingActionButton(
                  backgroundColor: widget.color,
                  heroTag: "btn2",
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).increment();
                  },
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/second');
              },
              color: Colors.redAccent,
              child: const Text(
                'Go to Second Screen',
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/third');
              },
              color: Colors.greenAccent,
              child: const Text(
                'Go to Third Screen',
              ),
            )
          ],
        ),
      ),
    );
  }
}
