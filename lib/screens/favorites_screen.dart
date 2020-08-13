import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

import 'package:favoritosdoyoutube/blocs/favorite_bloc.dart';
import 'package:favoritosdoyoutube/models/video.dart';
import 'package:favoritosdoyoutube/keys.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _favBloc = BlocProvider.of<FavoriteBloc>(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 18, 18, 18),
      appBar: AppBar(
        title: Text("Favoritos"),
      ),
      body: StreamBuilder<Map<String, Video>>(
        initialData: {
        },
        stream: _favBloc.outFav,
        builder: (context, snapshot) {
          return ListView(
            children: snapshot.data.values.map((v) {
              return Column(
                children: [
                  Container(
                    child: InkWell(
                      onTap: () {
                        // Dar play no video
                        FlutterYoutube.playYoutubeVideoById(apiKey: API_KEY, videoId: v.id);
                      },
                      onLongPress: () {
                        _favBloc.toggleFavorite(v);
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            height: 50,
                            child: Image.network(
                              v.thumb,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 4, right: 8),
                              child: Text(
                                v.title,
                                maxLines: 2,
                                style: TextStyle(color: Colors.white70),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.white12,)
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
