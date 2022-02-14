import 'package:breakingbad/data/model/character.dart';
import 'package:breakingbad/data/web_services/characters_web_services.dart';

class CharacterRepo{
   final CharactersWebServices charactersWebServices;
  CharacterRepo(this.charactersWebServices);

    Future<List<Character>> getAllCharacters()async{
    final charachters= await charactersWebServices.getAllCharacters();
    return charachters.map((c) => Character.fromJson(c)).toList();

    final  characters = await charactersWebServices.getAllCharacters();
    return characters.map((character)=>Character.fromJson(character)).toList();
  }
}
