import 'package:flutter/material.dart';
import 'package:riverpod_movie_app/src/data/models/movie_model.dart';
import 'package:riverpod_movie_app/src/presentation/widgets/movie_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> listOfmovies = [
      {
        "title": "Dog",
        "year": "2022",
        "genre": ["Comedy, Drama"],
        "plot":
            "Two former Army Rangers are paired against their will on the road trip of a lifetime. Briggs (Channing Tatum) and Lulu (a Belgian Malinois) race down the Pacific Coast to get to a fellow soldier's funeral on time.",
        "coverImg":
            "https://m.media-amazon.com/images/M/MV5BYjA2MDM2YjctYzNhNC00NGEzLWFmYWEtODExODFkNmUyOGE2XkEyXkFqcGdeQXVyODk2NDQ3MTA@._V1_SX300.jpg",
        "imdbRating": "6.5",
        "type": "movie",
      }
    ];

    List<MovieModel> formattedMovies =
        listOfmovies.map((movie) => MovieModel.fromJson(movie)).toList();
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(top: 10),
              child: ListView.builder(
                  itemCount: formattedMovies.length,
                  itemBuilder: (BuildContext context, int i) {
                    MovieModel movie = formattedMovies[i];
                    return MovieCard(
                      movie: movie,
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
