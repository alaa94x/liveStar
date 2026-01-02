class Gift {
  final String id;
  final String emoji;
  final String name;
  final int price;
  final String category; // 'popular', 'premium', or 'all'

  Gift({
    required this.id,
    required this.emoji,
    required this.name,
    required this.price,
    this.category = 'all',
  });

  factory Gift.fromJson(Map<String, dynamic> json) {
    return Gift(
      id: json['id'] ?? '',
      emoji: json['emoji'] ?? '',
      name: json['name'] ?? '',
      price: json['price'] ?? 0,
      category: json['category'] ?? 'all',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'emoji': emoji,
      'name': name,
      'price': price,
      'category': category,
    };
  }
}

class AvailableGifts {
  static List<Gift> get allGifts => [
    Gift(id: '1', emoji: '🌹', name: 'Rose', price: 50, category: 'popular'),
    Gift(id: '2', emoji: '💎', name: 'Diamond', price: 200, category: 'popular'),
    Gift(id: '3', emoji: '🚗', name: 'Sports Car', price: 500, category: 'premium'),
    Gift(id: '4', emoji: '🚀', name: 'Rocket', price: 1000, category: 'premium'),
    Gift(id: '5', emoji: '👑', name: 'Crown', price: 2000, category: 'premium'),
    Gift(id: '6', emoji: '🎁', name: 'Gift Box', price: 100, category: 'popular'),
    Gift(id: '7', emoji: '💰', name: 'Money Bag', price: 800, category: 'premium'),
    Gift(id: '8', emoji: '⭐', name: 'Star', price: 150, category: 'popular'),
    Gift(id: '9', emoji: '🔥', name: 'Fire', price: 300, category: 'popular'),
    Gift(id: '10', emoji: '💖', name: 'Heart', price: 80, category: 'popular'),
    Gift(id: '11', emoji: '🎉', name: 'Party', price: 120, category: 'popular'),
    Gift(id: '12', emoji: '🌈', name: 'Rainbow', price: 400, category: 'premium'),
  ];

  static List<Gift> get popularGifts => allGifts.where((g) => g.price <= 500).toList();
  static List<Gift> get premiumGifts => allGifts.where((g) => g.price > 500).toList();
  static List<Gift> get quickGifts => [allGifts[0], allGifts[9], allGifts[1], allGifts[7], allGifts[8], allGifts[10]];
}

