import 'package:breakingbad/constans/strings.dart';
import 'package:flutter/material.dart';
import 'presentation/widgets/screen/characters_screen.dart';
class AppRouter{
  Route? generateRoute(RouteSettings settings){
    switch(settings.name){
        case charactersScreen:

        return MaterialPageRoute(builder: (_)=>CharactersScreen());
    }
  }
}