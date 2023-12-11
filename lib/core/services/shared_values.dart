import 'package:shared_value/shared_value.dart';
import 'package:vendor_app/core/constances/key_shared_value.dart';
import 'package:vendor_app/vendor_app/auth/data/model/user_model.dart';
import 'package:vendor_app/vendor_app/auth/domain/entities/user_entity.dart';

// UserModel:
final SharedValue<Map<String, dynamic>> userData = SharedValue(
  key: KeySharedValue.currentUser,
  autosave: true,
  value: UserModel.empty.toMap(),
);

UserEntity get usrData => UserModel.fromMap(userData.$);
