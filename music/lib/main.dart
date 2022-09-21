import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music/model/musicdb.dart';
import 'package:music/view/splashscreen/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SongsAdapter());
  await Hive.openBox<List>(boxname);
  List<dynamic> favKey = box.keys.toList();
  if (!(favKey.contains("favourites"))) {
    List<dynamic> favouritesSongs = [];
    await box.put("favourites", favouritesSongs);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: false,
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      designSize: const Size(
        360,
        800,
      ),
      builder: (
        BuildContext context,
        Widget? child,
      ) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Music',
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
          ),
          home: SplashScreen(),
        );
      },
    );
  }
}
