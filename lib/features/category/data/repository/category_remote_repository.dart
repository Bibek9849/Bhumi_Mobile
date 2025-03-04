import 'package:bhumi_mobile/core/error/failure.dart';
import 'package:bhumi_mobile/features/category/data/data_source/remote_datasource/category_remote_data_source.dart';
import 'package:bhumi_mobile/features/category/domain/entity/category_entity.dart';
import 'package:bhumi_mobile/features/category/domain/repository/category_repository.dart';
import 'package:dartz/dartz.dart';

class CategoryRemoteRepository implements ICategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  CategoryRemoteRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final categories = await remoteDataSource.getCategories();
      return Right(categories);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }
}
