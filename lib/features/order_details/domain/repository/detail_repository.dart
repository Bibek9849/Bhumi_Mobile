import 'package:bhumi_mobile/core/error/failure.dart';
import 'package:bhumi_mobile/features/order_details/domain/entity/detail_entity.dart';
import 'package:dartz/dartz.dart';

abstract interface class IDetailsRepository {
  Future<Either<Failure, List<DetailEntity>>> getDetails();
  Future<Either<Failure, void>> createDetail(DetailEntity detail);
  Future<Either<Failure, void>> deleteDetail(String id, String? token);
}
