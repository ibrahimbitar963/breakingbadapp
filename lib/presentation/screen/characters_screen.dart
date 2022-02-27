import 'package:breakingbad/business_logic/cubit/charachters_cubit.dart';
import 'package:breakingbad/constans/mycolors.dart';
import 'package:breakingbad/data/model/character.dart';
import 'package:breakingbad/presentation/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersScreen extends StatefulWidget {
  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;
  late List<Character> searchedCharacterList;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.myGrey,
      decoration: InputDecoration(
        hintStyle: TextStyle(fontSize: 18, color: MyColors.myGrey),
        hintText: 'Find a character',
        border: InputBorder.none,
      ),
      style: TextStyle(fontSize: 18, color: MyColors.myGrey),
      onChanged: (searchedCharacter) {
        addSearchedItemToCharacterList(searchedCharacter);
      },
    );
  }

  void addSearchedItemToCharacterList(String searchedCharacter) {
    searchedCharacterList = allCharacters
        .where((character) =>
            character.nickName.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            //TODO:sad
          },
          icon: Icon(Icons.clear),
          color: MyColors.myGrey,
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.search),
        ),
      ];
    }
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharachtersCubit>(context).getAllCharacter();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharachtersCubit, CharachtersState>(
      builder: (context, state) {
        if (state is CharachtersLoaded) {
          allCharacters = (state).character;
          return buildLoadedListWidgets();
        } else {
          return showLoadingIndicator();
        }
      },
    );
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

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      itemBuilder: (context, index) {
        return CharactersItem(
          character: allCharacters[index],
        );
      },
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: allCharacters.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        title: Text(
          'Characters',
          style: TextStyle(color: MyColors.myGrey),
        ),
      ),
      body: buildBlocWidget(),
    );
  }
}
