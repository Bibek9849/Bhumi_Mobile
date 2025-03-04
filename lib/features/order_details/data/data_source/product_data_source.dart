import 'package:bhumi_mobile/features/order_details/domain/entity/detail_entity.dart';

abstract interface class IDetailsDataSource {
  Future<List<DetailEntity>> getDetails();
}
