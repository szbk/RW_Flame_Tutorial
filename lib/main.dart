import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import './service/connect_request.dart';
import 'controller/socket_controller.dart';
import 'main_game_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await dotenv.load();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SocketController _socketController = Get.put(SocketController());

    return GetMaterialApp(
      home: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RayWorld',
        home: FutureBuilder(
          future: connectServer(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(_socketController.connected.value);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Connecting...');
            } else {
              return const MainGamePage();
            }
          },
        ),
      ),
    );
  }
}
