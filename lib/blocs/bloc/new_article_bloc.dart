import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'new_article_event.dart';
part 'new_article_state.dart';

class NewArticleBloc extends Bloc<NewArticleEvent, NewArticleState> {
  NewArticleBloc() : super(NewArticleInitial()) {
    on<NewArticleEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<NewArticleLoadEvent>((event, emit) async {
      /// [NewArticleLoading] show Loading ICON
      emit(NewArticleLoading());
      await Future.delayed(Duration(seconds: 2));
      try {
        // try cái logic gọi API

        /// [NewArticleLoadSusessfully] show list of article:
        emit(NewArticleLoadSusessfully());
      } catch (e) {
        /// [NewArticleLoadFailure] show errors
        emit(NewArticleLoadFailure());
      }

      ///
    });
  }
}
