import 'package:TrybaeCustomerApp/models/CollectionModel.dart';
import 'package:TrybaeCustomerApp/models/ProductModel.dart';

import 'Components/Humanize_Category.dart';
import 'models/DesignerModel.dart';

List<Designer> getSampleProducts() {
  return [
    Designer(
        verified: true,
        designerImage: 'images/TrybaeSamplephoto.jpg',
        name: 'Lombe Posa',
        collections: [
          Collection(
              collectionName: 'LSK STARTER COLLECTION',
              productsInCollection: [
                Product(
                    'T-Shirt',
                    ['images/TrybaeSamplephoto.jpg'],
                    150,
                    100,
                    4.5,
                    'This is a quality one of the kind t-shirt designed by our very own Lombe Posa',
                    'Mix Kasamwa',
                    humanizeCategory(ProductCategory.Shirts.toString()),
                    ['Black']),
                Product(
                    'T-Shirt',
                    ['images/TrybaeSamplephoto.jpg'],
                    150,
                    100,
                    4.5,
                    'This is a quality one of the kind t-shirt designed by our very own Lombe Posa',
                    'Mix Kasamwa',
                    humanizeCategory(ProductCategory.Shirts.toString()),
                    ['Black']),
              ],
              photo: 'images/TrybaeSamplephoto.jpg'),
          Collection(
              collectionName: 'LSK STARTER COLLECTION',
              productsInCollection: [
                Product(
                    'T-Shirt',
                    ['images/TrybaeSamplephoto.jpg'],
                    150,
                    100,
                    4.5,
                    'This is a quality one of the kind t-shirt designed by our very own Lombe Posa',
                    'Mix Kasamwa',
                    humanizeCategory(ProductCategory.Shirts.toString()),
                    ['Black']),
                Product(
                    'T-Shirt',
                    ['images/TrybaeSamplephoto.jpg'],
                    150,
                    100,
                    4.5,
                    'This is a quality one of the kind t-shirt designed by our very own Lombe Posa',
                    'Mix Kasamwa',
                    humanizeCategory(ProductCategory.Shirts.toString()),
                    ['Black']),
              ],
              photo: 'images/TrybaeSamplephoto.jpg')
        ],
        bio:
            'This is a quality one of the kind t-shirt designed by our very own Lombe Posa'),
    Designer(
        verified: true,
        designerImage: 'images/TrybaeSamplephoto.jpg',
        name: 'Mix Kasamwa',
        collections: [
          Collection(
              collectionName: 'LSK STARTER COLLECTION',
              productsInCollection: [
                Product(
                    'T-Shirt',
                    ['images/TrybaeSamplephoto.jpg'],
                    150,
                    100,
                    4.5,
                    'This is a quality one of the kind t-shirt designed by our very own Lombe Posa',
                    'Mix Kasamwa',
                    humanizeCategory(ProductCategory.Shirts.toString()),
                    ['Black']),
                Product(
                    'T-Shirt',
                    ['images/TrybaeSamplephoto.jpg'],
                    150,
                    100,
                    4.5,
                    'This is a quality one of the kind t-shirt designed by our very own Lombe Posa',
                    'Mix Kasamwa',
                    humanizeCategory(ProductCategory.Shirts.toString()),
                    ['Black']),
              ],
              photo: 'images/TrybaeSamplephoto.jpg'),
          Collection(
              collectionName: 'LSK STARTER COLLECTION',
              productsInCollection: [
                Product(
                    'T-Shirt',
                    ['images/TrybaeSamplephoto.jpg'],
                    150,
                    100,
                    4.5,
                    'This is a quality one of the kind t-shirt designed by our very own Lombe Posa',
                    'Mix Kasamwa',
                    humanizeCategory(ProductCategory.Shirts.toString()),
                    ['Black']),
                Product(
                    'T-Shirt',
                    ['images/TrybaeSamplephoto.jpg'],
                    150,
                    100,
                    4.5,
                    'This is a quality one of the kind t-shirt designed by our very own Lombe Posa',
                    'Mix Kasamwa',
                    humanizeCategory(ProductCategory.Shirts.toString()),
                    ['Black']),
              ],
              photo: 'images/TrybaeSamplephoto.jpg'),
        ],
        bio:
            'This is a quality one of the kind t-shirt designed by our very own Mix kasamwa'),
    Designer(
        verified: true,
        designerImage: 'images/TrybaeSamplephoto.jpg',
        name: 'Kng Lulat',
        collections: [
          Collection(
              collectionName: 'LSK STARTER COLLECTION',
              productsInCollection: [
                Product(
                    'T-Shirt',
                    ['images/TrybaeSamplephoto.jpg'],
                    150,
                    100,
                    4.5,
                    'This is a quality one of the kind t-shirt designed by our very own Kng Lulat',
                    'Mix Kasamwa',
                    humanizeCategory(ProductCategory.Shirts.toString()),
                    ['Black']),
                Product(
                    'T-Shirt',
                    ['images/TrybaeSamplephoto.jpg'],
                    150,
                    100,
                    4.5,
                    'This is a quality one of the kind t-shirt designed by our very own Kng Lulat',
                    'Mix Kasamwa',
                    humanizeCategory(ProductCategory.Shirts.toString()),
                    ['Black']),
              ],
              photo: 'images/TrybaeSamplephoto.jpg'),
          Collection(
              collectionName: 'LSK STARTER COLLECTION',
              productsInCollection: [
                Product(
                    'T-Shirt',
                    ['images/TrybaeSamplephoto.jpg'],
                    150,
                    100,
                    4.5,
                    'This is a quality one of the kind t-shirt designed by our very own Lombe Posa',
                    'Mix Kasamwa',
                    humanizeCategory(ProductCategory.Shirts.toString()),
                    ['Black']),
                Product(
                    'T-Shirt',
                    ['images/TrybaeSamplephoto.jpg'],
                    150,
                    100,
                    4.5,
                    'This is a quality one of the kind t-shirt designed by our very own Lombe Posa',
                    'Mix Kasamwa',
                    humanizeCategory(ProductCategory.Shirts.toString()),
                    ['Black']),
              ],
              photo: 'images/TrybaeSamplephoto.jpg'),
        ],
        bio:
            'This is a quality one of the kind t-shirt designed by our very own Kng Lulat'),
  ];
  /* return <Product>[
    Product(
        'T-Shirt',
        ['images/TrybaeSamplephoto.jpg'],
        150,
        100,
        4.5,
        'This is a quality one of the kind t-shirt designed by our very own Lombe Posa',
        Designer(
                verified: true,
                designerImage: 'images/TrybaeSamplephoto.jpg',
                name: 'Lombe Pose',
                collections: [
                  Collection(
                      collectionName: 'LSK STARTER COLLECTION',
                      photo: 'images/TrybaeSamplephoto.jpg'),
                  Collection(
                      collectionName: 'LSK STARTER COLLECTION',
                      photo: 'images/TrybaeSamplephoto.jpg'),
                  Collection(
                      collectionName: 'LSK STARTER COLLECTION',
                      photo: 'images/TrybaeSamplephoto.jpg'),
                  Collection(
                      collectionName: 'LSK STARTER COLLECTION',
                      photo: 'images/TrybaeSamplephoto.jpg'),
                  Collection(
                      collectionName: 'LSK STARTER COLLECTION',
                      photo: 'images/TrybaeSamplephoto.jpg'),
                  Collection(
                      collectionName: 'LSK STARTER COLLECTION',
                      photo: 'images/TrybaeSamplephoto.jpg'),
                  Collection(
                      collectionName: 'LSK STARTER COLLECTION',
                      photo: 'images/TrybaeSamplephoto.jpg'),
                  Collection(
                      collectionName: 'LSK STARTER COLLECTION',
                      photo: 'images/TrybaeSamplephoto.jpg')
                ],
                bio:
                    'This is a quality one of the kind t-shirt designed by our very own Lombe Posa')
            .name,
        humanizeCategory(ProductCategory.Shirts.toString()),
        ['White']),
    Product(
        'T-Shirt',
        ['images/TrybaeSamplephoto.jpg'],
        150,
        100,
        4.5,
        'This is a quality one of the kind t-shirt designed by our very own Lombe Posa',
        Designer(
                verified: true,
                designerImage: 'images/TrybaeSamplephoto.jpg',
                name: 'Lombe Pose',
                collections: [],
                bio:
                    'This is a quality one of the kind t-shirt designed by our very own Lombe Posa')
            .name,
        humanizeCategory(ProductCategory.Shirts.toString()),
        ['Black']),
    Product(
        'T-Shirt',
        ['images/TrybaeSamplephoto.jpg'],
        150,
        100,
        4.5,
        'This is a quality one of the kind t-shirt designed by our very own Lombe Posa',
        Designer(
                verified: true,
                designerImage: 'images/TrybaeSamplephoto.jpg',
                name: 'Lombe Pose',
                collections: [],
                bio:
                    'This is a quality one of the kind t-shirt designed by our very own Lombe Posa')
            .name,
        humanizeCategory(ProductCategory.Shirts.toString()),
        ['Purple']),
    Product(
        'T-Shirt',
        ['images/TrybaeSamplephoto.jpg'],
        150,
        100,
        4.5,
        'This is a quality one of the kind t-shirt designed by our very own Lombe Posa',
        Designer(
                verified: true,
                designerImage: 'images/TrybaeSamplephoto.jpg',
                name: 'Lombe Pose',
                collections: [],
                bio:
                    'This is a quality one of the kind t-shirt designed by our very own Lombe Posa')
            .name,
        humanizeCategory(ProductCategory.Shirts.toString()),
        ['Green']),
    Product(
        'T-Shirt',
        ['images/TrybaeSamplephoto.jpg'],
        150,
        100,
        4.5,
        'This is a quality one of the kind t-shirt designed by our very own Lombe Posa',
        Designer(
                verified: true,
                designerImage: 'images/TrybaeSamplephoto.jpg',
                name: 'Lombe Pose',
                collections: [],
                bio:
                    'This is a quality one of the kind t-shirt designed by our very own Lombe Posa')
            .name,
        humanizeCategory(ProductCategory.Shirts.toString()),
        ['Yellow'])
  ];*/
}
