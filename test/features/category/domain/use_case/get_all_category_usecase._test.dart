import 'package:bhumi_mobile/core/error/failure.dart';
import 'package:bhumi_mobile/features/category/domain/entity/category_entity.dart';
import 'package:bhumi_mobile/features/category/domain/repository/category_repository.dart';
import 'package:bhumi_mobile/features/category/domain/use_case/get_all_category_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Creating a mock repository by extending Mock from mocktail.
class MockCategoryRepository extends Mock implements ICategoryRepository {}

// Define a concrete subclass of Failure for testing purposes.
class TestFailure extends Failure {
  const TestFailure({required super.message});
}

void main() {
  late ICategoryRepository mockCategoryRepository;
  late GetAllCategoryUsecase getAllCategoryUsecase;

  setUp(() {
    mockCategoryRepository = MockCategoryRepository();
    getAllCategoryUsecase =
        GetAllCategoryUsecase(categoryRepository: mockCategoryRepository);
  });

  group('GetAllCategoryUsecase', () {
    test('should get a list of categories from the repository', () async {
      // Arrange: Create a list of sample CategoryEntity instances.
      final tCategories = [
        const CategoryEntity(
          product_categoryId: '1',
          categoryName: 'Electronics',
          categoryDescription: 'Electronic items',
        ),
        const CategoryEntity(
          product_categoryId: '2',
          categoryName: 'Books',
          categoryDescription: 'Various books',
        ),
      ];

      // When getCategories() is called, return a Right containing the list.
      when(() => mockCategoryRepository.getCategories())
          .thenAnswer((_) async => Right(tCategories));

      // Act: Call the usecase.
      final result = await getAllCategoryUsecase();

      // Assert: Verify that the result matches our expected list.
      expect(result, Right(tCategories));
      verify(() => mockCategoryRepository.getCategories()).called(1);
    });

    test('should return a Failure when repository call fails', () async {
      // Arrange: Create a sample TestFailure instance.
      const tFailure = TestFailure(message: 'Error occurred');

      // When getCategories() is called, return a Left containing the failure.
      when(() => mockCategoryRepository.getCategories())
          .thenAnswer((_) async => const Left(tFailure));

      // Act: Call the usecase.
      final result = await getAllCategoryUsecase();

      // Assert: Verify that the result matches the expected failure.
      expect(result, const Left(tFailure));
      verify(() => mockCategoryRepository.getCategories()).called(1);
    });
  });
}
