import 'package:bhumi_mobile/core/error/failure.dart';
import 'package:bhumi_mobile/features/category/domain/entity/category_entity.dart';
import 'package:bhumi_mobile/features/dashboard/domain/entity/product_entity.dart';
import 'package:bhumi_mobile/features/dashboard/domain/repository/product_repository.dart';
import 'package:bhumi_mobile/features/dashboard/domain/use_case/get_all_product_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Create a mock repository using mocktail.
class MockProductRepository extends Mock implements IProductRepository {}

// Define a concrete subclass of Failure for testing.
class TestFailure extends Failure {
  const TestFailure({required super.message});
}

void main() {
  late IProductRepository mockProductRepository;
  late GetAllProductUseCase getAllProductUseCase;

  setUp(() {
    mockProductRepository = MockProductRepository();
    getAllProductUseCase =
        GetAllProductUseCase(productRepository: mockProductRepository);
  });

  group('GetAllProductUseCase', () {
    test('should get a list of products from the repository', () async {
      // Arrange: create a sample category and product list.
      const tCategory = CategoryEntity(
        product_categoryId: '1',
        categoryName: 'Test Category',
        categoryDescription: 'Test Description',
      );
      final tProducts = [
        const ProductEntity(
          productId: 'p1',
          product_categoryId: tCategory,
          name: 'Product 1',
          image: 'image1.png',
          price: '100',
          quantity: '10',
          description: 'Description 1',
        ),
        const ProductEntity(
          productId: 'p2',
          product_categoryId: tCategory,
          name: 'Product 2',
          image: 'image2.png',
          price: '200',
          quantity: '20',
          description: 'Description 2',
        ),
      ];

      // When getProducts() is called, return a Right containing the product list.
      when(() => mockProductRepository.getProducts())
          .thenAnswer((_) async => Right(tProducts));

      // Act: Call the usecase.
      final result = await getAllProductUseCase();

      // Assert: Verify the usecase returns the expected product list.
      expect(result, Right(tProducts));
      verify(() => mockProductRepository.getProducts()).called(1);
    });

    test('should return a Failure when repository call fails', () async {
      // Arrange: create a sample failure.
      const tFailure = TestFailure(message: 'Error occurred');

      // When getProducts() is called, return a Left containing the failure.
      when(() => mockProductRepository.getProducts())
          .thenAnswer((_) async => const Left(tFailure));

      // Act: Call the usecase.
      final result = await getAllProductUseCase();

      // Assert: Verify the usecase returns the expected failure.
      expect(result, const Left(tFailure));
      verify(() => mockProductRepository.getProducts()).called(1);
    });
  });
}
