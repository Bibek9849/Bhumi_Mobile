import 'package:bhumi_mobile/app/usecase/usecase.dart';
import 'package:bhumi_mobile/core/error/failure.dart';
import 'package:bhumi_mobile/features/dashboard/domain/entity/product_entity.dart';
import 'package:bhumi_mobile/features/dashboard/domain/repository/product_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllProductUseCase
    implements UsecaseWithoutParams<List<ProductEntity>> {
  final IProductRepository productRepository;

  GetAllProductUseCase({required this.productRepository});

  @override
  Future<Either<Failure, List<ProductEntity>>> call() async {
    final response = await productRepository.getProducts();

    response.fold(
      (failure) => print("UseCase Error: ${failure.message}"),
      (products) {
        print("UseCase Fetched ${products.length} products");
        for (var product in products) {
          print("Product: ${product.name}, Price: ${product.price}");
        }
      },
    );

    return response;
  }
}
