import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:live_reflective_visualizer/visualizer_provider.dart';
import 'package:music_visualizer/music_visualizer.dart';
import 'package:provider/provider.dart';
import 'package:reflective_visual/reflective.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

const Key reflectiveKey = Key('reflectivePage');

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => VisualizerProvider(),
        builder: (context, child) {
          return ReflectivePage(
            key: reflectiveKey,
            bgColor: const Color.fromARGB(255, 52, 52, 52),
            body: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Selector<VisualizerProvider, double>(
                        selector: (context, provider) => provider.volume ?? 0,
                        builder: (context, value, child) {
                          value = value * 3;
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  gradient: RadialGradient(
                                    colors: [
                                      Colors.amber,
                                      Colors.amber.withOpacity(0)
                                    ],
                                    stops: const [-2, 2.5],
                                  ),
                                ),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 150),
                                width: 600 - value,
                                height: 600 - value,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(1000),
                                    color: Colors.amber),
                              ),
                            ],
                          );
                        }),
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: MusicVisualizer(
                      barCount: 30,
                      colors: [
                        Colors.red[900]!,
                        Colors.green[900]!,
                        Colors.blue[900]!,
                        Colors.brown[900]!
                      ],
                      duration: const [900, 700, 600, 800, 500],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
