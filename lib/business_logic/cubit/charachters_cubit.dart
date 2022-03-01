
import 'package:bloc/bloc.dart';
import 'package:breakingbad/data/model/character.dart';
import 'package:breakingbad/data/model/quote.dart';
import 'package:breakingbad/data/repository/characters_repo.dart';
import 'package:meta/meta.dart';
import 'package:breakingbad/data/repository/quote_repo.dart';
part 'charachters_state.dart';

      class CharachtersCubit extends Cubit<CharachtersState> {
        late CharacterRepo characterRepo;
        late QuoteRepo quoteRepo;
         List<Character> characters= [];
        CharachtersCubit( this.characterRepo,this.quoteRepo) : super(CharachtersInitial());



        List<Character> getAllCharacter(){
          characterRepo.getAllCharacters().then((characters) {
            emit(CharachtersLoaded(characters));
                  this.characters = characters;
          });
          return characters;
        }

        void getQuote(String charName){

          quoteRepo.getQuote(charName).then((quote) {
            emit(QuoteLoaded(quote));
            print(quote.toString());

          });

        }




      }

