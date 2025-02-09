import 'package:bloc/bloc.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final List<String> categories = ["All", "Vegetables", "Fruits", "Spice"];

  final List<Map<String, String>> _allProducts = [
    {
      "name": "Broccoli",
      "price": "NPR: 16.00/kg",
      "image": "assets/images/bro.jpeg", // Add actual image paths
    },
    {
      "name": "Tomato",
      "price": "NPR: 8.00/kg",
      "image": "assets/images/tom.jpeg",
    },
    {
      "name": "Broccoli",
      "price": "NPR: 16.00/kg",
      "image": "assets/images/bro.jpeg",
    },
  ];

  DashboardBloc() : super(HomeInitialState());

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is LoadProductsEvent) {
      yield ProductsLoadingState();
      await Future.delayed(const Duration(seconds: 1)); // Simulating delay
      yield ProductsLoadedState(_allProducts);
    } else if (event is SearchProductEvent) {
      yield ProductsLoadingState();
      await Future.delayed(const Duration(seconds: 1));
      final filteredProducts = _allProducts
          .where((product) => product['name']!
              .toLowerCase()
              .contains(event.query.toLowerCase()))
          .toList();
      yield ProductsLoadedState(filteredProducts);
    } else if (event is SelectCategoryEvent) {
      yield ProductsLoadingState();
      await Future.delayed(const Duration(seconds: 1)); // Simulating delay
      // For simplicity, we're not actually filtering by category here
      yield ProductsLoadedState(_allProducts);
    }
  }
}
