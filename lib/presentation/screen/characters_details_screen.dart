import 'package:breakingbad/constans/mycolors.dart';
import 'package:breakingbad/data/model/character.dart';
import 'package:flutter/material.dart';

class CharactersDetailsScreen extends StatelessWidget {
  late Character character;
  CharactersDetailsScreen({required this.character});

  Widget buildSliverAppBar() {
    return SliverAppBar(
      backgroundColor: MyColors.myGrey,
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
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

  Widget buildDivider({required double endIndent}){
    return Divider(
      endIndent:endIndent ,
      color: MyColors.myYellow,
      height: 30,
      thickness: 4,

    );
  }

  @override
  Widget build(BuildContext context) {
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
                      characterInfo(title:'Job :' ,value:character.jobs.join('/') ),
                      buildDivider(endIndent: 285),
                      SizedBox(height: 15),
                      buildDivider(endIndent: 500),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
