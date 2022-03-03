import 'package:breakingbad/constans/mycolors.dart';
import 'package:breakingbad/data/model/character.dart';
import 'package:breakingbad/presentation/business_logic/cubit/charachters_cubit.dart';
import 'package:breakingbad/presentation/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

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
      autofocus: true,
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
            _stopSearching();
            Navigator.pop(context);
          },
          icon: Icon(Icons.clear),
          color: MyColors.myGrey,
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: () {
            _startSearch();
          },
          icon: Icon(
            Icons.search,
            color: MyColors.myGrey,
          ),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _searchTextController.clear();
    setState(() {
      _isSearching = false;
    });
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
          character: _searchTextController.text.isEmpty
              ? allCharacters[index]
              : searchedCharacterList[index],
        );
      },
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: _searchTextController.text.isEmpty
          ? allCharacters.length
          : searchedCharacterList.length,
    );
  }

  Widget _buildAppBarTitle() {
    return Text(
      'Characters',
      style: TextStyle(color: MyColors.myGrey),
    );
  }

  Widget buildAlertWidget() {
    return Center(

      child: Container(
        color: Colors.white70,
        child:SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Please check your internet connection'
              ,style: TextStyle(
                  color: MyColors.myYellow,
                  fontSize: 18,
                    fontWeight: FontWeight.bold

                ),),
              SizedBox(height: 20,),
              Image.asset('assets/images/notify.png',

              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.myYellow,
          title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
          actions: _buildAppBarActions(),
          leading: _isSearching
              ? BackButton(
                  color: MyColors.myGrey,
                )
              : Container(),
        ),
        body: OfflineBuilder(connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {

            return  buildBlocWidget();
          } else   {

            return buildAlertWidget();
          }

        },
        child: showLoadingIndicator(),
        ),

        );
  }
}
