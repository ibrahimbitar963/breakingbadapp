import 'package:bloc/bloc.dart';
import 'package:breakingbad/data/model/character.dart';
import 'package:breakingbad/data/repository/characters_repo.dart';
import 'package:meta/meta.dart';

part 'charachters_state.dart';

class CharachtersCubit extends Cubit<CharachtersState> {
  final CharacterRepo characterRepo ;
   late List<Character> characters;


  CharachtersCubit(this.characterRepo) : super(CharachtersInitial());
  List<Character> getAllCharacters(){
    characterRepo.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters));
      this.characters=characters;
    });
    return characters;
  }


}
