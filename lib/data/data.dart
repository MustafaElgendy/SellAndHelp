import "package:flutter/material.dart";

class Product {
  final String productName;
  final String productImageUrl;
  final String currentPrice;
  final String oldPrice;
  final bool isLiked;

  const Product({
    required this.productName,
    required this.productImageUrl,
    required this.currentPrice,
    required this.oldPrice,
    required this.isLiked,
    });
}

class Category{
  final String categoryName;
  final String productCount;
  final String thumbnailIamge;

  const Category({
    required this.categoryName,
    required this.productCount,
    required this.thumbnailIamge
    });
}

final products = [
  const Product(
    productName: "Home Made",
    productImageUrl: "https://thecraftsmanblog.com/wp-content/uploads/2015/02/Why-America-Needs-Skilled-Craftsmen.jpg",
    currentPrice: "200",
    oldPrice: "500",
    isLiked: true,
  ),
   const Product(
    productName: "Home Made",
    productImageUrl: "https://images.pexels.com/photos/5711883/pexels-photo-5711883.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    currentPrice: "200",
    oldPrice: "500",
    isLiked: true,
  ),
   const Product(
    productName: "Home Made",
    productImageUrl: "https://images.unsplash.com/photo-1608483306449-f7adaf379e59?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE0fHx8ZW58MHx8fHx8&w=1000&q=80",
    currentPrice: "200",
    oldPrice: "500",
    isLiked: true,
  ),
   const Product(
    productName: "Home Made",
    productImageUrl: "https://media-cdn.tripadvisor.com/media/photo-s/10/cb/9e/39/handmade-food-from-our.jpg",
    currentPrice: "200",
    oldPrice: "500",
    isLiked: true,
  ),
   const Product(
    productName: "Home Made",
    productImageUrl: "https://images.pexels.com/photos/5089178/pexels-photo-5089178.jpeg?cs=srgb&dl=pexels-cottonbro-studio-5089178.jpg&fm=jpg",
    currentPrice: "200",
    oldPrice: "500",
    isLiked: true,
  ),
   const Product(
    productName: "Home Made",
    productImageUrl: "https://media.tacdn.com/media/attractions-splice-spp-674x446/07/99/a0/5e.jpg",
    currentPrice: "200",
    oldPrice: "500",
    isLiked: true,
  ),
   const Product(
    productName: "Home Made",
    productImageUrl: "https://hfnlife.com/cdn/shop/products/9db6ec12f41769b07d2b0939c9bc9853.jpg?v=1663820206",
    currentPrice: "200",
    oldPrice: "500",
    isLiked: true,
  ),
];