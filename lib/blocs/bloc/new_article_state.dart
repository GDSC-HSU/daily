part of 'new_article_bloc.dart';

@immutable
abstract class NewArticleState {}

class NewArticleInitial extends NewArticleState {}

class NewArticleLoading extends NewArticleState {}

class NewArticleLoadSusessfully extends NewArticleState {}

class NewArticleLoadFailure extends NewArticleState {}
