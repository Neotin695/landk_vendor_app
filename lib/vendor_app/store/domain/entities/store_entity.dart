import 'package:equatable/equatable.dart';
import 'package:vendor_app/core/services/form_input/src/address.dart';
import 'package:vendor_app/models/model.dart';
import 'package:vendor_app/models/timing_store.dart';

class StoreEntity extends Equatable {
  final String id;
  final String logoUrl;
  final String coverUrl;
  final String title;
  final String bio;
  final AddressInfo location;
  final List<TimeStore> timeStore;
  final List<String> reviews;
  final List<String> products;
  final double balance;
  final double totalEarning;
  final double totalLoss;
  final int totalSales;
  final int totalRefunds;
  final int orderAccepted;
  final int orderCanceled;
  final int orderOnWay;
  final int orderDelivered;
  final int orderRedy;
  
}
