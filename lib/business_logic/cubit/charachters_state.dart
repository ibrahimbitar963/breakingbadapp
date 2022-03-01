part of 'charachters_cubit.dart';

@immutable
abstract class CharachtersState {}

class CharachtersInitial extends CharachtersState {}

class CharachtersLoaded extends CharachtersState {

 late final List<Character> character;
 CharachtersLoaded(this.character);
}


class QuoteLoaded extends CharachtersState{
 late final List <Quote> quote;
 QuoteLoaded(this.quote);

}

