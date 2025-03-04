import 'package:bhumi_mobile/app/usecase/usecase.dart';
import 'package:bhumi_mobile/core/error/failure.dart';
import 'package:bhumi_mobile/features/order_details/domain/entity/detail_entity.dart';
import 'package:bhumi_mobile/features/order_details/domain/repository/detail_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllDetailsUsecase implements UsecaseWithoutParams<List<DetailEntity>> {
  final IDetailsRepository detailsRepository;

  GetAllDetailsUsecase({required this.detailsRepository});

  @override
  Future<Either<Failure, List<DetailEntity>>> call() async {
    final response = await detailsRepository.getDetails();

    response.fold(
      (failure) => print("UseCase Error: ${failure.message}"),
      (details) {
        print("UseCase Fetched ${details.length} products");
        for (var detail in details) {
          print(
              "Order: ${detail.orderId},Product: ${detail.productID}, Price: ${detail.sub_total} Quantity: ${detail.total_quantity}");
        }
      },
    );

    return response;
  }
}
