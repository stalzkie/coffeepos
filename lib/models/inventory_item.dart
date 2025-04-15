class InventoryItem{
  int ?id;
  String name;
  String description;
  double price;
  String imagePath; // Local path to the image

  InventoryItem({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
  });

  factory InventoryItem.fromMap(Map<String, dynamic> map){
    return InventoryItem(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: map['price'].toDouble(),
      imagePath: (map['imagePath'] ?? '')
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'name' : name,
      'description' : description,
      'price' : price,
      'imagePath' : imagePath
    };
  }
}
