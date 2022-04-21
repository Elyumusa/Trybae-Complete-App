import 'CollectionModel.dart';

class Designer {
  String name;
  List<dynamic> collections = [];
  String bio;
  String designerImage;
  bool verified;
  Designer({
    this.name,
    this.collections,
    this.bio,
    this.designerImage,
    this.verified,
  });
}
