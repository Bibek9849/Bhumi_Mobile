import 'package:bhumi_mobile/core/error/failure.dart';
import 'package:bhumi_mobile/features/category/domain/entity/category_entity.dart';
import 'package:dartz/dartz.dart';

abstract interface class ICategoryRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
}
