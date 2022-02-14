import 'package:breakingbad/business_logic/cubit/charachters_cubit.dart';
import 'package:breakingbad/constans/strings.dart';
import 'package:breakingbad/data/model/character.dart';
import 'package:breakingbad/data/repository/characters_repo.dart';
import 'package:breakingbad/presentation/widgets/screen/characters_details.dart';
import 'package:flutter/material.dart';
import 'data/web_services/characters_web_services.dart';
import 'presentation/widgets/screen/characters_screen.dart';
class AppRouter{
  late CharacterRepo characterRepo;
  late CharachtersCubit charachtersCubit;

  AppRouter(){

    characterRepo = CharacterRepo(CharactersWebServices());
    charachtersCubit = CharachtersCubit(characterRepo);
   }

  Route? generateRoute(RouteSettings settings){
    switch(settings.name){
        case charactersScreen:
        return MaterialPageRoute(builder: (_)=>CharactersScreen());
      case charactersDetailsScreen:
        return MaterialPageRoute(builder: (_)=>CharactersDetailsScreen());
    }
  }
}