import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor_app/core/services/image_helper/image_picker_mixin.dart';

import '../repository/product_repository.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, Productstate>
    with PickMediaMixin {
  ProductsBloc(this.productRepository) : super(Productstate.initial) {
    on<_FetchAllProducts>(_fetchAllProducts);
    on<FetchOneProduct>(_fetchOneProduct);
    on<DeleteProduct>(_deleteProduct);
    on<UpdateProduct>(_updateProduct);
    on<InsertProduct>(_insertProduct);
    on<ToggleActiveProduct>(_toggleActiveProduct);
    on<PickCover>(_pickCover);
    on<PickImages>(_pickImages);
    add(_FetchAllProducts());
  }

  FutureOr<void> _pickImages(event, emit) async {
    emit(Productstate.loading);
    final result = await pickMultiImage();
    imagesPaths = result;
    emit(Productstate.success);
  }

  FutureOr<void> _pickCover(event, emit) async {
    emit(Productstate.loading);
    final result = await pickSingleImage(ImageSource.gallery);
    coverPath = result;
    emit(Productstate.success);
  }

  final ProductRepository productRepository;
  List<Product> products = [];
  Product product = Product.empty();
  String coverPath = '';
  List<String> imagesPaths = [];
  String selectedCategory = '';
  final TextEditingController titleAr = TextEditingController();
  final TextEditingController titleEn = TextEditingController();
  final TextEditingController descriptionAr = TextEditingController();
  final TextEditingController descriptionEn = TextEditingController();
  final TextEditingController quantity = TextEditingController();
  final TextEditingController price = TextEditingController();

  FutureOr<void> _fetchAllProducts(
      _FetchAllProducts event, Emitter<Productstate> emit) async {
    emit(Productstate.loadingData);
    await emit.forEach(productRepository.fetchAllProducts(), onData: (data) {
      products = data;
      return Productstate.successData;
    }, onError: (eer, err) {
      return Productstate.failure;
    });
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

  FutureOr<void> _insertProduct(InsertProduct event, emit) async {
    if (titleAr.text.isNotEmpty &&
        titleEn.text.isNotEmpty &&
        descriptionAr.text.isNotEmpty &&
        descriptionEn.text.isNotEmpty &&
        price.text.isNotEmpty &&
        quantity.text.isNotEmpty) {
      emit(Productstate.loading);
      await productRepository
          .insertProduct(
            _initProduct(),
          )
          .then(
            (value) => emit(Productstate.success),
          );
    } else {
      emit(Productstate.failure);
    }
  }

  Product _initProduct() {
    return Product(
      id: '',
      titleAr: titleAr.text,
      descriptionAr: descriptionAr.text,
      titleEn: titleEn.text,
      storeId: FirebaseAuth.instance.currentUser!.uid,
      descriptionEn: descriptionEn.text,
      coverUrl: coverPath,
      images: imagesPaths,
      active: true,
      soldOut: false,
      category: selectedCategory,
      price: double.parse(price.text),
      quantity: int.parse(quantity.text),
      discount: 0,
      reviews: const [],
    );
  }

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
