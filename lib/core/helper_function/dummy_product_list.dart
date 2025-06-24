import '../../generated/assets.dart';
import '../models/product_model.dart';

final List<ProductModel> dummyProductList = [
  ProductModel(
    id: '1',
    name: 'Lenovo IdeaPad 3',
    price: 15999.0,
    oldPrice: 17999.0,
    description: 'Lenovo IdeaPad 3 with Intel Core i5, 8GB RAM, 256GB SSD.',
    category: 'Laptops',
    imageUrl: Assets.imagesSupraLogo,
    favoriteProducts: [],
    purchaseTable: [],
  ),
  ProductModel(
    id: '2',
    name: 'HP Pavilion x360',
    price: 19999.0,
    oldPrice: 21999.0,
    description: 'HP Pavilion x360 14" Touchscreen Laptop, Intel i5, 512GB SSD.',
    category: 'Laptops',
    imageUrl: Assets.imagesSupraLogo,
    favoriteProducts: [],
    purchaseTable: [],
  ),
  ProductModel(
    id: '3',
    name: 'Dell Inspiron 15',
    price: 17499.0,
    oldPrice: 0.0,
    description: 'Dell Inspiron 15 3000, 11th Gen Intel Core i3, 256GB SSD.',
    category: 'Laptops',
    imageUrl: Assets.imagesSupraLogo,
    favoriteProducts: [],
    purchaseTable: [],
  ),
];
