import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final iconStateProvider = StateProvider((ref) => false);

final buttonStateProvider = StateProvider((ref) => false);

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool favoriteIconState = ref.watch(iconStateProvider);
    bool buttonState = ref.watch(buttonStateProvider);

    Icon favoriteIcon;
    Container button;

    if(favoriteIconState){
      favoriteIcon = const Icon(
        Icons.favorite,
        color: Colors.pink,
        size: 48,
      );
    } else {
      favoriteIcon = const Icon(
        Icons.favorite_outline,
        size: 48,
      );
    }

    if(buttonState){
      button = Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        width: MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
          color: Colors.blue,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(10)
        ),
        child: const Center(
          child: Text(
            "活性",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28
            ),
          ),
        ),
      );
    } else {
      button = Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        width: MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10)
        ),
        child: const Center(
          child: Text(
            "非活性",
            style: TextStyle(
              fontSize: 28
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                ref.read(iconStateProvider.notifier).state = !favoriteIconState;
              },
              child: favoriteIcon,
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.1,),
            InkWell(
              onTap: () {
                ref.read(buttonStateProvider.notifier).state = !buttonState;
              },
              child: button
            ),
          ],
        )
      ),
    );
  }
}
