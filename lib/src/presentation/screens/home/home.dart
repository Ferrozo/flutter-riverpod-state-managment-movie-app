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
          child: formattedMovies.isNotEmpty
              ? Column(
                  children: [
                    isLoading
                        ? const Expanded(
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : Padding(
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
                  ],
                )
              : const Expanded(
                  child: Center(child: Text('There has no movies on list')),
                ),
        ),
      ),
    );
  }
}
