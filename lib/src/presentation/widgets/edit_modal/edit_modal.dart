import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_movie_app/src/data/models/movie_model.dart';
import 'package:riverpod_movie_app/src/presentation/blocs/movies_providers/movies_providers.dart';

class EditModal extends ConsumerStatefulWidget {
  const EditModal({Key? key, required this.movie}) : super(key: key);
  final MovieModel movie;

  @override
  // ignore: library_private_types_in_public_api
  _EditModalState createState() => _EditModalState();
}

class _EditModalState extends ConsumerState<EditModal> {
  late MovieModel movie;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    movie = widget.movie;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter the title',
                ),
                initialValue: movie.title,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a title';
                  }
                  return null;
                },
                onChanged: (value) {
                  movie.title = value;
                },
              ),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter the year',
                ),
                initialValue: movie.year,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Enter a year';
                  }
                  return null;
                },
                onChanged: (v) {
                  movie.year = v;
                },
              ),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter the description',
                ),
                initialValue: movie.plot,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Please enter the description';
                  }
                  return null;
                },
                onChanged: (v) {
                  movie.plot = v;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(context);
                      ref
                          .read(moviesProvider.notifier)
                          .updateMovie(movie.id, movie.toJson());
                    }
                  },
                  child: const Text('Save'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
