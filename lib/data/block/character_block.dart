import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty/data/models/character.dart';

import '../repositories/character_repo.dart';

part 'character_block.freezed.dart';
//part 'character_block.g.dart';
part 'character_event.dart';
part 'character_state.dart';

class CharacterBlock extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepo characterRepo;
  CharacterBlock({required this.characterRepo})
      : super(const CharacterState.loading()) {
    on<CharacterEventFetch>((event, emit) async {
      emit(const CharacterState.loading());
      try {
        Character _characterLoaded =
            await characterRepo.getCharacter(event.page, event.name);
        emit(CharacterState.loaded(characterLoaded: _characterLoaded));
      } catch (_) {
        emit(const CharacterState.error());
      }
    });
  }
}
