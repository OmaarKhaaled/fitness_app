import 'dart:async';

import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/meals/domain/use_cases/get_meals_by_category_use_case.dart';
import 'package:fitness_app/features/meals/domain/use_cases/get_meals_categories_use_case.dart';
import 'package:fitness_app/features/meals/presentation/view_model/meals_intents.dart';
import 'package:fitness_app/features/meals/presentation/view_model/meals_states.dart';
import 'package:fitness_app/features/meals/presentation/view_model/meals_ui_intents.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class MealsCubit extends Cubit<MealsStates> {
  final GetMealsCategoriesUseCase _getMealsCategoriesUseCase;
  final GetMealsByCategoryUseCase _getMealsByCategoryUseCase;
  final StreamController<MealsUiIntents> _streamController =
      StreamController<MealsUiIntents>.broadcast();

  Stream<MealsUiIntents> get uiIntents => _streamController.stream;

  MealsCubit({
    required GetMealsCategoriesUseCase getMealsCategoriesUseCase,
    required GetMealsByCategoryUseCase getMealsByCategoryUseCase,
  }) : _getMealsCategoriesUseCase = getMealsCategoriesUseCase,
       _getMealsByCategoryUseCase = getMealsByCategoryUseCase,
       super(const MealsStates());

  void doIntent(MealsIntents intent) {
    switch (intent) {
      case LoadInitialMealsDataIntent():
        _loadInitialData();
        break;
      case SelectMealCategoryIntent(category: final cat):
        _selectCategory(cat);
        break;
      case RefreshMealsIntent():
        _loadInitialData();
        break;
    }
  }

  Future<void> _loadInitialData() async {
    emit(state.copyWith(isCategoriesLoading: true, isMealsLoading: true));

    final response = await _getMealsCategoriesUseCase();
    response.when(
      initial: () => null,
      loading: () => null,
      success: (data) {
        final cats = data.categories ?? [];
        emit(state.copyWith(isCategoriesLoading: false, categories: cats));

        if (cats.isNotEmpty && state.selectedCategory == null) {
          _loadMealsByCategory(cats.first.strCategory!);
        } else if (state.selectedCategory != null) {
          _loadMealsByCategory(state.selectedCategory!);
        } else {
          emit(state.copyWith(isMealsLoading: false));
        }
      },
      failure: (error) {
        emit(state.copyWith(isCategoriesLoading: false, isMealsLoading: false));
        _streamController.add(ShowErrorMealsIntent(error: error.message));
      },
    );
  }

  Future<void> _selectCategory(String category) async {
    if (category == state.selectedCategory) return;

    emit(state.copyWith(selectedCategory: category, isMealsLoading: true));

    _loadMealsByCategory(category);
  }

  Future<void> _loadMealsByCategory(String category) async {
    emit(state.copyWith(isMealsLoading: true, selectedCategory: category));

    final response = await _getMealsByCategoryUseCase(category);
    response.when(
      initial: () => null,
      loading: () => null,
      success: (data) {
        emit(state.copyWith(isMealsLoading: false, meals: data.meals ?? []));
      },
      failure: (error) {
        emit(state.copyWith(isMealsLoading: false));
        _streamController.add(ShowErrorMealsIntent(error: error.message));
      },
    );
  }

  @override
  Future<void> close() {
    _streamController.close();
    return super.close();
  }
}
