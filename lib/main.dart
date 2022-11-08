import 'package:flutter/material.dart';
import 'details.dart';

void main() {
  runApp(const MyApp());
}

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hero Animation Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/home': (context) => const HomePage(),
        '/details': (context) => const DetailsPage(),
      },
      home: const HomePage(),
      navigatorObservers: [routeObserver],
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {
  @override
  void initState() {
    // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
    //   routeObserver.subscribe(this, ModalRoute.of(context)!);
    // });
    super.initState();
    print('#initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
    print('#didChangeDependencies');
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
    print('#dispose');
  }

  @override
  void didPush() {
    final route = ModalRoute.of(context);
    print('#didPush route: $route');
  }

  @override
  void didPopNext() {
    final route = ModalRoute.of(context);
    print('#didPopNext route: $route');
  }

  @override
  void didPushNext() {
    final route = ModalRoute.of(context);
    print('#didPushNext route: $route');
  }

  @override
  void didPop() {
    final route = ModalRoute.of(context);
    print('#didPop route: $route');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Wrap(
          spacing: 18.0, // gap between adjacent chips
          runSpacing: 14.0, // gap between lines
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              child: const Text(
                'Hero Animation',
                style: TextStyle(
                  fontFamily: 'Allison',
                  fontSize: 55,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              // onTap: () => Navigator.pushNamed(context, '/details'),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      settings: const RouteSettings(
                          name: 'blabla', arguments: {'bar', 'foo'}),
                      builder: (context) => const DetailsPage())),
              child: Hero(
                tag: 'blabala',
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: 100,
                  height: 100,
                  child: Image.asset('images/keep_green_code.jpg'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
