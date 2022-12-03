import 'package:bloc/bloc.dart';
import 'package:daily/model/article.dart';
import 'package:daily/services/newapi_service.dart';
import 'package:meta/meta.dart';

part 'new_article_event.dart';
part 'new_article_state.dart';

class NewArticleBloc extends Bloc<NewArticleEvent, NewArticleState> {
  final NewsApiService apiService;
  NewArticleBloc({required this.apiService}) : super(NewArticleInitial()) {
    on<NewArticleEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<NewArticleLoadEvent>((event, emit) async {
      /// [NewArticleLoading] show Loading ICON
      emit(NewArticleLoading());
      // await Future.delayed(Duration(seconds: 2));
      try {
        // try cái logic gọi API
        // kéo dữ liệu từ API decode [List<Article>]
        final articles = await apiService.fetchArticle();

        /// [NewArticleLoadSusessfully] show list of article:
        emit(NewArticleLoadSusessfully(articles));

        // await Future.delayed(Duration(seconds: 3))
        //     .then((value) => emit(NewArticleLoadFailure()));
      } catch (e) {
        /// [NewArticleLoadFailure] show errors
        emit(NewArticleLoadFailure());
      }

      ///
    });
  }
}
