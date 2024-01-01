import 'package:flutter/material.dart';
import 'package:project/repositories/like_respositories.dart';
import 'package:project/view/screen/detail_screen.dart';
import 'package:project/view/screen/widget/home_screen.dart';
import 'package:project/view/screen/widget/photo_view_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LikeRespositories.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // showPerformanceOverlay: true,
      theme: Theme.of(context).copyWith(
          scaffoldBackgroundColor: Color.fromRGBO(255, 255, 255, 0.8)),
      home: HomeScreen(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case "/view":
            return MaterialPageRoute(
                builder: (context) => PhotoView(), settings: settings);
            break;
          case "/details":
            return MaterialPageRoute(
                builder: (context) => DetailScreen(), settings: settings);

            break;
          default:
            return MaterialPageRoute(builder: (context) => HomeScreen());
        }
      },
    );
  }
}
