import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breakingbad/business_logic/cubit/charachters_cubit.dart';
import 'package:breakingbad/constans/mycolors.dart';
import 'package:breakingbad/data/model/character.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakingbad/presentation/screen/characters_screen.dart';

class CharactersDetailsScreen extends StatelessWidget {
  late Character character;
  CharactersDetailsScreen({required this.character});

  Widget buildSliverAppBar() {
    return SliverAppBar(
      backgroundColor: MyColors.myGrey,
      expandedHeight: 570,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.none,
        centerTitle: true,
        title: Text(
          character.actorName,
          textAlign: TextAlign.center,
          style: TextStyle(color: MyColors.myWhite),
        ),
        background: Hero(
          tag: character.char_Id,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo({required String title, required String value}) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
              text: title,
              style: TextStyle(
                color: MyColors.myWhite,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
          TextSpan(
            text: value,
            style: TextStyle(
              color: MyColors.myWhite,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider({required double endIndent}) {
    return Divider(
      endIndent: endIndent,
      color: MyColors.myYellow,
      height: 30,
      thickness: 4,
    );
  }

  Widget checkIfQuotesAreLoaded(CharachtersState state) {
    if (state is QuoteLoaded) {
      print('qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq');
      return displayRandomQuoteOrEmptySpace(state);
    } else {
      return showLoadingIndicator() ;
    }
  }
  Widget showLoadingIndicator() {
    return Center(
      child: Container(
        child: CircularProgressIndicator(
          color: MyColors.myYellow,
        ),
      ),
    );
  }


  Widget displayRandomQuoteOrEmptySpace(state) {
    var quotes = (state).quote;
    if (quotes.length != 0) {
      print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
      int randomQuoteIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: MyColors.myWhite,
            shadows: [
              Shadow(
                color: MyColors.myYellow,
                blurRadius: 7,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuoteIndex].quote),

            ],
          ),
        ),
      );
    }else {
      print('saasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasass');
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharachtersCubit>(context).getQuote(character.nickName);
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsetsDirectional.fromSTEB(14, 14, 14, 0),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo(
                          title: 'Job :', value: character.jobs.join('/')),
                      buildDivider(endIndent: 275),
                      characterInfo(
                          title: 'Appeared In: ', value: character.category),
                      buildDivider(endIndent: 215),
                      characterInfo(
                        title: 'Seasons: ',
                        value: character.appearance.join(
                          '/',
                        ),
                      ),
                      buildDivider(endIndent: 240),
                      characterInfo(
                          title: 'Status: ',
                          value: character.StatusIfDeadOrAlive),
                      buildDivider(endIndent: 260),
                      character.better_call_saul_appearance.isEmpty
                          ? Container()
                          : characterInfo(
                              title: 'better call saul appearance: ',
                              value: character.better_call_saul_appearance
                                  .join('/')),
                      character.better_call_saul_appearance.isEmpty
                          ? Container()
                          : buildDivider(endIndent: 92),
                      BlocBuilder<CharachtersCubit, CharachtersState>(
                          builder: (context, state) {
                            return checkIfQuotesAreLoaded(state);
                          }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 300,
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
