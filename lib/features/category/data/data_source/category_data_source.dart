import 'package:bhumi_mobile/features/category/domain/entity/category_entity.dart';

abstract interface class ICategoryDataSource {
  Future<List<CategoryEntity>> getCategories();
}
