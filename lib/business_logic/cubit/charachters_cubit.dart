import 'package:bloc/bloc.dart';
import 'package:breakingbad/data/model/character.dart';
import 'package:meta/meta.dart';

part 'charachters_state.dart';

class CharachtersCubit extends Cubit<CharachtersState> {
  CharachtersCubit() : super(CharachtersInitial());
}
