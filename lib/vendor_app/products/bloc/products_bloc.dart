import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../repository/product_repository.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, Productstate> {
  ProductsBloc(this.productRepository) : super(Productstate.initial) {
    on<_FetchAllProducts>(_fetchAllProducts);
    on<FetchOneProduct>(_fetchOneProduct);
    on<DeleteProduct>(_deleteProduct);
    on<UpdateProduct>(_updateProduct);
    on<InsertProduct>(_insertProduct);
    on<ToggleActiveProduct>(_toggleActiveProduct);

    _subscription = productRepository.fetchAllProducts().listen((event) {
      add(_FetchAllProducts(products: event));
    });
  }
  late final StreamSubscription<List<Product>> _subscription;
  final ProductRepository productRepository;
  List<Product> products = [];
  Product product = Product.empty();

  FutureOr<void> _fetchAllProducts(_FetchAllProducts event, emit) {
    emit(Productstate.loadingData);
    products = event.products;
    if (products.isNotEmpty) {
      emit(Productstate.successData);
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }

  FutureOr<void> _fetchOneProduct(FetchOneProduct event, emit) async {
    emit(Productstate.loadingData);
    product = await productRepository.fetchOneProduct(event.id).then((value) {
      emit(Productstate.successData);
      return value;
    });
  }

  FutureOr<void> _deleteProduct(DeleteProduct event, emit) async {
    emit(Productstate.loading);
    await productRepository.deleteProduct(event.id).then((value) {
      emit(Productstate.success);
      return;
    });
  }

  FutureOr<void> _insertProduct(InsertProduct event, emit) async {}

  FutureOr<void> _updateProduct(UpdateProduct event, emit) async {
    emit(Productstate.loading);
    await productRepository
        .updateProduct(product.copyWith(id: event.id))
        .then((value) {
      emit(Productstate.success);
      return;
    });
  }

  FutureOr<void> _toggleActiveProduct(ToggleActiveProduct event, emit) async {
    emit(Productstate.loading);
    await productRepository
        .toggleActiveProduct(event.id, event.state)
        .then((value) {
      emit(Productstate.successData);
      return;
    });
  }
}
