import 'package:breakingbad/business_logic/cubit/charachters_cubit.dart';
import 'package:breakingbad/constans/strings.dart';
import 'package:breakingbad/data/repository/characters_repo.dart';
import 'package:breakingbad/presentation/screen/characters_details_screen.dart';
import 'package:breakingbad/presentation/screen/characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/model/character.dart';
import 'data/web_services/characters_web_services.dart';

class AppRouter {
  late CharacterRepo characterRepo;
  late CharachtersCubit charactersCubit;
  AppRouter(){
    characterRepo = CharacterRepo(CharactersWebServices());
    charactersCubit = CharachtersCubit(characterRepo);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(builder: (_) =>
            BlocProvider(
              create: (context) => charactersCubit,
              child: CharactersScreen(),
            ));
      case charactersDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(builder: (_) => CharactersDetailsScreen(character: character,),);
    }
  }
}