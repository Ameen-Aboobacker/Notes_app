
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes/provider.dart';
import 'package:notes/view/home.dart';
import 'package:provider/provider.dart';

//import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
      create: (context) => HomeController(),),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(   
        primarySwatch: Colors.amber,
        cardTheme: CardTheme(color: Colors.yellow.shade600,),      
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black)
        ),
        home: const NotesScreen() ,
    )
    );
  }
}
