import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'package:favoritosdoyoutube/blocs/favorite_bloc.dart';
import 'package:favoritosdoyoutube/blocs/videos_bloc.dart';
import 'package:favoritosdoyoutube/delegates/data_search.dart';
import 'package:favoritosdoyoutube/models/video.dart';
import 'package:favoritosdoyoutube/screens/favorites_screen.dart';
import 'package:favoritosdoyoutube/widgets/video_tile.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _favBloc = BlocProvider.of<FavoriteBloc>(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 18, 18, 18),
      appBar: AppBar(
        title: Container(
          height: 25,
          child: Image.asset("images/logo_youtube.png"),
        ),
        elevation: 0,
        actions: [
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, Video>>(
              stream: _favBloc.outFav,
              builder: (context, snapshot) {
                return Text(
                  snapshot.hasData ? snapshot.data.length.toString() : "0",
                  style: TextStyle(fontSize: 18),
                );
              },
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.star,
            ),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => FavoritesScreen()));
            },
          ),
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () async {
              String result =
                  await showSearch(context: context, delegate: DataSearch());
              if (result != null)
                BlocProvider.of<VideosBloc>(context).inSearch.add(result);
            },
          ),
        ],
      ),
      body: StreamBuilder(
        initialData: [],
        stream: BlocProvider.of<VideosBloc>(context).outVideos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Quando há dados
            return ListView.builder(
              itemCount: snapshot.data.length + 1,
              itemBuilder: (context, index) {
                if (index < snapshot.data.length) {
                  return VideoTile(snapshot.data[index]);
                } else if (index > 1) {
                  BlocProvider.of<VideosBloc>(context).inSearch.add(null);
                  return Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  );
                } else {
                  // Quando não há dados
                  return Container();
                }
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red),),
            );
          }
        },
      ),
    );
  }
}
