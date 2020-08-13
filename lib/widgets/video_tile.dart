import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:favoritosdoyoutube/blocs/favorite_bloc.dart';
import 'package:favoritosdoyoutube/models/video.dart';

import 'package:favoritosdoyoutube/keys.dart';

class VideoTile extends StatelessWidget {
  final Video video;

  VideoTile(this.video);

  @override
  Widget build(BuildContext context) {
    final blocFavorites = BlocProvider.of<FavoriteBloc>(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // linha horizontal de uma coluna
        children: [
          GestureDetector(
            onTap: () {
              FlutterYoutube.playYoutubeVideoById(
                  apiKey: API_KEY, videoId: video.id);
            },
            child: AspectRatio(
              aspectRatio: 16 / 9,
              // Proporção da imagem de cada video. horizontal x vertical
              child: Image.network(
                video.thumb,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Text(
                        video.title,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        video.channel,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder<Map<String, Video>>(
                stream: blocFavorites.outFav,
                builder: (context, snapshot) {
                  // O snapshot, contém toda a lista de favoritos

                  var icon = Icons.star_border;
                  if (snapshot.hasData) if (snapshot.data.containsKey(video.id))
                    icon = Icons.star;
                  return IconButton(
                      icon: Icon(
                        icon,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        blocFavorites.toggleFavorite(video);
                      });
                },
              ),
            ],
          ),
          Divider(color: Colors.white12)
        ],
      ),
    );
  }
}
