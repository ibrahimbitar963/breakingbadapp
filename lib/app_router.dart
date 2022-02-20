import 'package:breakingbad/constans/strings.dart';
import 'package:breakingbad/presentation/screen/characters_details.dart';
import 'package:breakingbad/presentation/screen/characters_screen.dart';
import 'package:flutter/material.dart';
class AppRouter{
  Route? generateRoute(RouteSettings settings){
    switch(settings.name){
        case charactersScreen:
        return MaterialPageRoute(builder: (_)=>CharactersScreen());
      case charactersDetailsScreen:
        return MaterialPageRoute(builder: (_)=>CharactersDetailsScreen());
    }
  }
}