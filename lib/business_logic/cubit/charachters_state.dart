part of 'charachters_cubit.dart';

@immutable
abstract class CharachtersState {}

class CharachtersInitial extends CharachtersState {}

class CharactersLoaded extends CharachtersState {
  late final List<Character> characters;
  CharactersLoaded(this.characters);
}
