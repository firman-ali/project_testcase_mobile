import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/routes/app_pages.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.route});

  final String route;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Testcase App",
      initialRoute: route,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      theme: ThemeData.light(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.plusJakartaSansTextTheme(),
        appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.blueGrey,
          ),
          centerTitle: true,
          color: Colors.white,
          shadowColor: Colors.grey,
          elevation: 0.0,
          scrolledUnderElevation: 0.3,
          shape: const ContinuousRectangleBorder(
            side: BorderSide(color: Colors.lightBlueAccent),
          ),
        ),
        dialogBackgroundColor: Colors.white,
        dividerColor: Colors.lightBlueAccent,
        dividerTheme: const DividerThemeData(color: Colors.lightBlueAccent),
      ),
    );
  }
}
