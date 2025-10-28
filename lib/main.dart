import 'dart:ui';
import 'package:flutter/material.dart';
import 'load_painting_info.dart';
import 'painting_info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Gawboy Painting'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// ==========================================================================

class _MyHomePageState extends State<MyHomePage> {
  List<PaintingInfo> gawboyPaintings = [];
  LoadPaintingInfo paintLoader = LoadPaintingInfo();
  final PageController ctrl = PageController();

  @override
  void initState() {
    super.initState();
    gawboyPaintings = paintLoader.InitInCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: PageView.builder(
            controller: ctrl,
            itemCount: gawboyPaintings.length,
            itemBuilder: (BuildContext context, int position) {
              return buildPaintingPage(position);
            },
          ),
        ),
      ),
    );
  }

  Widget buildPaintingPage(int position) {
    final painting = gawboyPaintings[position];

    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            painting.name,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Image.asset(
            'assets/images/' + painting.imageFile,
            height: 300,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 16),
          Text(
            painting.gawboyDescription,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

