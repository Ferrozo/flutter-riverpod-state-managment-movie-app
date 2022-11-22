import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_movie_app/src/data/models/movie_model.dart';
import 'package:riverpod_movie_app/src/presentation/blocs/movies_providers/movies_providers.dart';
import 'package:riverpod_movie_app/src/presentation/widgets/export_widget.dart';
import 'package:go_router/go_router.dart';

class MovieCard extends ConsumerWidget {
  const MovieCard({Key? key, required this.movie}) : super(key: key);
  final MovieModel movie;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          height: 150,
          color: const Color(0xfff7f7f7),
          padding: const EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Container(
                width: 100,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.network(
                  movie.coverImg.toString(),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => context.push('/${movie.id}'),
                        child: Text(
                          '${movie.title} (${movie.year})',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        movie.plot.toString(),
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        maxLines: 3,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                              ),
                              onPressed: () => showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return EditModal(movie: movie);
                                  }),
                              child: const Text('Edit')),
                          const Padding(padding: EdgeInsets.all(15)),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                            ),
                            onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: Text('Delete ${movie.title.toString()}'),
                                content: const Text('Are you sure?'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        deleteMovie(movie.id, ref, context),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            ),
                            child: const Text('Yes'),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  deleteMovie(movieId, WidgetRef ref, BuildContext context) {
    ref.read(moviesProvider.notifier).deleteMovie(movieId);
    Navigator.pop(context);
  }
}
