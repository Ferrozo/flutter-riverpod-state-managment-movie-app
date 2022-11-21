import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_movie_app/src/data/models/movie_model.dart';
import 'package:riverpod_movie_app/src/presentation/blocs/movies_providers/movies_providers.dart';

class DeleteModalConfirmation extends StatelessWidget {
  DeleteModalConfirmation({Key? key, required this.movie}) : super(key: key);
  late MovieModel movie;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
      ),
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Delete ${movie.title.toString()}'),
          content: const Text('Are you sure?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => deleteMovie(movie.id, ref, context),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: const Text('Yes'),
    );
  }

  deleteMovie(movieId, WidgetRef ref, BuildContext context) {
    ref.read(moviesProvider.notifier).deleteMovie(movieId);
    Navigator.pop(context);
  }
}
