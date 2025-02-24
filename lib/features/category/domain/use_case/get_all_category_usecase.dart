import 'package:bhumi_mobile/app/usecase/usecase.dart';
import 'package:bhumi_mobile/core/error/failure.dart';
import 'package:bhumi_mobile/features/category/domain/entity/category_entity.dart';
import 'package:bhumi_mobile/features/category/domain/repository/category_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllCategoryUsecase
    implements UsecaseWithoutParams<List<CategoryEntity>> {
  final ICategoryRepository categoryRepository;

  GetAllCategoryUsecase({required this.categoryRepository});

  @override
  Future<Either<Failure, List<CategoryEntity>>> call() {
    return categoryRepository.getCategories();
  }
}
