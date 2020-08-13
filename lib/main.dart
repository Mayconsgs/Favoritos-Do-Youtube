import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:favoritosdoyoutube/blocs/favorite_bloc.dart';
import 'package:favoritosdoyoutube/blocs/videos_bloc.dart';
import 'package:favoritosdoyoutube/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: VideosBloc(),
      child: BlocProvider(
        bloc: FavoriteBloc(),
        child: MaterialApp(
          title: 'Favoritos do YouTube',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            //scaffoldBackgroundColor: Color.fromARGB(255, 18, 18, 18),
            appBarTheme: AppBarTheme(
              color: Color.fromARGB(255, 18, 18, 18),
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        ),
      )
    );
  }
}
