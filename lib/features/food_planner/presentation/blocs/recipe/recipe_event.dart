part of 'recipe_bloc.dart';

abstract class RecipeEvent extends Equatable {
  const RecipeEvent();

  @override
  List<Object> get props => [];
}

class RecipeModelListFetched extends RecipeEvent {}

class RecipeModelListFilter extends RecipeEvent {
  final String? query;
  final List<Ingredient>? ingredients;

  const RecipeModelListFilter({this.query, this.ingredients});
}
