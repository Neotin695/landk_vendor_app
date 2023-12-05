import 'package:equatable/equatable.dart';

class ImgModel extends Equatable {
  final String url;
  final String id;
  const ImgModel({
    required this.url,
    required this.id,
  });

  @override
  List<Object> get props => [url, id];

  static ImgModel empty() => const ImgModel(id: '', url: '');

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
      'id': id,
    };
  }

  factory ImgModel.fromMap(Map<String, dynamic> map) {
    return ImgModel(
      url: map['url'] as String,
      id: map['id'] as String,
    );
  }
}
