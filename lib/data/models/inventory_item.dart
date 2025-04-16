class InventoryItem{
  int ?id;
  String name;
  String description;
  double price;
  String? imagePath;
  String? date; // Local path to the image
  int quantity;

  InventoryItem({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    this.imagePath,
    required this.quantity,
    this.date
  });

  factory InventoryItem.fromMap(Map<String, dynamic> map){
    return InventoryItem(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: map['price'].toDouble(),
      imagePath: map['image_url'],
      quantity: map['quantity'],
      date: map['created_at']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'name' : name,
      'description' : description,
      'price' : price,
      'image_url' : imagePath,
      'created_at' : date!,
      'quantity' : quantity
    };
  }

  Map<String, dynamic> noDateMap(){
    return {
      'name' : name,
      'description' : description,
      'price' : price,
      'image_url' : imagePath,
      'quantity' : quantity
    };
  }
}
