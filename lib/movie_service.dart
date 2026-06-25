import 'movie_model.dart';

class MovieService {
  // Simulasi data film yang diambil dari API atau Database
  static const List<Movie> _movies = [
    Movie(
      title: 'Inception',
      date: '2010-07-15',
      rating: 8.4,
      imageUrl: 'https://image.tmdb.org/t/p/w92/bvYjhsbxOBwpm8xLE5BhdA3a8CZ.jpg',
      genre: 'Sci-Fi / Action',
      duration: '148 min',
      synopsis: 'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O. as redemption for his past crimes.',
    ),
    Movie(
      title: 'Interstellar',
      date: '2014-11-07',
      rating: 8.6,
      imageUrl: 'https://image.tmdb.org/t/p/w185/ngl2FKBlU4fhbdsrtdom9LVLBXw.jpg',
      genre: 'Sci-Fi / Adventure',
      duration: '169 min',
      synopsis: 'In Earth\'s future, a global crop blight and second Dust Bowl are slowly rendering the planet uninhabitable. A team of explorers travels through a wormhole in space in an attempt to ensure humanity\'s survival.',
    ),
    Movie(
      title: 'Tenet',
      date: '2020-08-22',
      rating: 7.3,
      imageUrl: 'https://image.tmdb.org/t/p/w500/laMM4lpQSh5z6KIBPwWogkjzBVQ.jpg',
      genre: 'Action / Sci-Fi',
      duration: '150 min',
      synopsis: 'Armed with only one word, Tenet, and fighting for the survival of the entire world, a protagonist journeys through a twilight world of international espionage on a mission that will unfold in something beyond real time.',
    ),
    Movie(
      title: 'The Dark Knight Rises',
      date: '2012-07-16',
      rating: 7.8,
      imageUrl: 'https://image.tmdb.org/t/p/w500/1E5baAaEse26fej7uHcjOgEE2t2.jpg',
      genre: 'Action / Thriller',
      duration: '164 min',
      synopsis: 'Eight years after the Joker\'s reign of anarchy, Batman, with the help of the enigmatic Catwoman, is forced from his exile to save Gotham City from the brutal guerrilla terrorist Bane.',
    ),
    Movie(
      title: 'Avatar: The Way of Water',
      date: '2022-12-14',
      rating: 7.6,
      imageUrl: 'https://image.tmdb.org/t/p/original/oDKbJFvnPyCk7pDX2xttSxXEWXW.jpg',
      genre: 'Sci-Fi / Action',
      duration: '192 min',
      synopsis: 'Jake Sully lives with his newfound family formed on the extraterrestrial planet of Pandora. Once a familiar threat returns to finish what was previously started, Jake must work with Neytiri and the army of the Na\'vi race to protect their home.',
    ),
  ];

  // Mengambil daftar film secara asinkron dengan simulasi delay internet 1.5 detik
  Future<List<Movie>> fetchMovies() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    return _movies;
  }
}
