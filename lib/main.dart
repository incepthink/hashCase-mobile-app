import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hash_case/HiveDB/NFT/Catalogue.dart';
import 'package:hash_case/HiveDB/NFT/Merchandise.dart';
import 'package:hash_case/HiveDB/NFT/NFT.dart';
import 'package:hash_case/pages/Onboarding/Onboarding1.dart';
import 'package:hash_case/pages/Landing/landing.dart';
import 'package:hash_case/services/api.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:device_preview/device_preview.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'GlobalWidgets/custom_snackbar.dart';
import 'HiveDB/UserData/UserData.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserDataAdapter());
  Hive.registerAdapter(NFTAdapter());
  Hive.registerAdapter(CatalogueAdapter());
  Hive.registerAdapter(MerchandiseAdapter());
  await Hive.openBox('globalBox');
  await Hive.openBox<Catalogue>('catalogueNFT');

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(
      DevicePreview(
        // enabled: !kReleaseMode,
        enabled: false,
        builder: (context) => MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final globalBox = Hive.box('globalBox');
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => API()),
      ],
      child: ValueListenableBuilder(
          valueListenable: globalBox.listenable(),
          builder: (context, Box<dynamic> box, _) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              scaffoldMessengerKey: snackbarKey,
              home: box.containsKey('userData')
                  ? const LandingPage()
                  : const OnboardingPage1(),
            );
          }),
    );
  }
}
