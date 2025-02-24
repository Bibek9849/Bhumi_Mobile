import 'package:bhumi_mobile/core/error/failure.dart';
import 'package:bhumi_mobile/features/dashboard/data/data_source/remote_datasource/product_remote_datasource.dart';
import 'package:bhumi_mobile/features/dashboard/domain/entity/product_entity.dart';
import 'package:bhumi_mobile/features/dashboard/domain/repository/product_repository.dart';
import 'package:dartz/dartz.dart';

class ProductRemoteRepository implements IProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRemoteRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> createProduct(ProductEntity product) {
    // TODO: implement createProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id, String? token) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      final products = await remoteDataSource.getProducts();
      return Right(products);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }
}
