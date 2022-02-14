import 'package:breakingbad/data/model/character.dart';
import 'package:breakingbad/data/web_services/characters_web_services.dart';
class CharacterRepo{
   final CharactersWebServices charactersWebServices;
  CharacterRepo(this.charactersWebServices);
  Future<List<Character>> getAllCharacters()async{
    final characters = await charactersWebServices.getAllCharacters();
    return characters.map((character) =>
        Character.fromJson(character)).toList();
  }


}