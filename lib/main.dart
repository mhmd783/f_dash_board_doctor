import 'package:dash_board/prov/prov.dart';
import 'package:dash_board/view/activ_doctor.dart';
import 'package:dash_board/view/doctor.dart';
import 'package:dash_board/view/not_active_doctor..dart';
import 'package:dash_board/view/pationt.dart';
import 'package:dash_board/view/profile_doctor_visit.dart';
import 'package:dash_board/view/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) {
          return control();
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            'doctor': (context) => doctor(),
            'profile_doctor_visit': (context) => profile_doctor_visit(),
            'search':(context) => search(),
            'active_doctor':(context) => active_doctor(),
            'not_active_doctor':(context) => not_active_doctor(),
            'pationt':(context) => pationt(),
            
            
          },
          home:doctor(),
        ));
  }
}
