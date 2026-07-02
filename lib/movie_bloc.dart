import 'package:flutter_bloc/flutter_bloc.dart';
import 'movie_model.dart';
import 'movie_service.dart';

// Events
abstract class MovieEvent {}

class FetchMovies extends MovieEvent {}

// States
abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<Movie> movies;
  final bool isOffline;

  MovieLoaded(this.movies, {required this.isOffline});
}

class MovieError extends MovieState {
  final String message;

  MovieError(this.message);
}

// Bloc
class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieService _movieService;

  MovieBloc(this._movieService) : super(MovieInitial()) {
    on<FetchMovies>((event, emit) async {
      emit(MovieLoading());
      try {
        final (movies, isOffline) = await _movieService.fetchMovies();
        emit(MovieLoaded(movies, isOffline: isOffline));
      } catch (e) {
        emit(MovieError(e.toString()));
      }
    });
  }
}
