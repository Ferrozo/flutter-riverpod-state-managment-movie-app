import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_movie_app/src/data/models/movie_model.dart';
import 'package:riverpod_movie_app/src/presentation/blocs/movies_providers/movies_providers.dart';

class DetailPage extends ConsumerWidget {
  const DetailPage({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Future<MovieModel> movie =
        ref.read(moviesProvider.notifier).loadMovie(id);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        child: FutureBuilder(
          future: movie,
          builder: (BuildContext context, AsyncSnapshot<MovieModel> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              final MovieModel movieInfo = snapshot as MovieModel;

              children = <Widget>[
                Image.network(movieInfo.coverImg.toString()),
                const SizedBox(height: 20),
                Text(
                  '${movieInfo.title} (${movieInfo.year})',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(padding: EdgeInsets.all(30))
              ];
            } else if (snapshot.hasError) {
              children = <Widget>[
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ];
            } else {
              children = const <Widget>[
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...'),
                )
              ];
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ),
            );
          },
        ),
      ),
    );
  }
}
