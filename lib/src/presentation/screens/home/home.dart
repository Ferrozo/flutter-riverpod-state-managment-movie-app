import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_movie_app/src/data/models/movie_model.dart';
import 'package:riverpod_movie_app/src/presentation/blocs/movies_providers/movies_providers.dart';
import 'package:riverpod_movie_app/src/presentation/widgets/movie_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<MovieModel> formattedMovies = ref.watch(moviesProvider).movies;
    bool isLoading = ref.watch(moviesProvider).isLoading;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Search movie',
                  ),
                  onChanged: (search) async {
                    await ref
                        .read(moviesProvider.notifier)
                        .filterMovies(search);
                  },
                ),
              ),
              isLoading
                  ? const Expanded(
                      child: Center(child: CircularProgressIndicator()))
                  : Expanded(
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.only(top: 10),
                        child: ListView.builder(
                          itemCount: formattedMovies.length,
                          itemBuilder: (BuildContext context, int i) {
                            MovieModel movie = formattedMovies[i];
                            return MovieCard(
                              movie: movie,
                            );
                          },
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
