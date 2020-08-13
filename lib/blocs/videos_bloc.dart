import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import '../api.dart';
import '../models/video.dart';

class VideosBloc implements BlocBase {
  Api api;

  List<Video> videos;

  final _videosController = StreamController<List<Video>>();
  Stream get outVideos => _videosController.stream; // Para extrair dados do Bloc

  final _searchController = StreamController<String>();
  Sink get inSearch => _searchController.sink; // Para inserir dados ao Bloc

  VideosBloc() {
    api = Api();
    _searchController.stream.listen(_search);
  }

  void _search(String search) async {
    if(search != null){
      _videosController.sink.add([]);
      videos = await api.search(search);
    } else {
      videos += await api.nextPage();
    }
    _videosController.sink.add(videos);
  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }
}