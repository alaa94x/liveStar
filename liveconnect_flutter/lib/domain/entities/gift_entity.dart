/// Gift Entity (Domain Layer)
/// 
/// This is the domain entity representing a gift.
/// It's independent of data sources and API implementations.
class GiftEntity {
  final String id;
  final String name;
  final String emoji;
  final int price;
  final String category;
  final String? animationType;
  final bool isPopular;

  GiftEntity({
    required this.id,
    required this.name,
    required this.emoji,
    required this.price,
    required this.category,
    this.animationType,
    this.isPopular = false,
  });
}




