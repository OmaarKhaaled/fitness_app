sealed class MealsIntents {
  const MealsIntents();
}

class LoadInitialMealsDataIntent extends MealsIntents {
  const LoadInitialMealsDataIntent();
}

class SelectMealCategoryIntent extends MealsIntents {
  final String category;
  const SelectMealCategoryIntent({required this.category});
}

class RefreshMealsIntent extends MealsIntents {
  const RefreshMealsIntent();
}
