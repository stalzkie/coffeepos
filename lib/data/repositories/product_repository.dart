import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/product_model.dart';

class ProductRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<Product>> getAllProducts() async {
    final response = await _client
        .from('products')
        .select()
        .order('name', ascending: true);

    return (response as List<dynamic>)
        .map((item) => Product.fromMap(item))
        .toList();
  }

  Future<Product?> getProductById(String id) async {
    final response = await _client
        .from('products')
        .select()
        .eq('id', id)
        .single();
    return Product.fromMap(response);
  }

  Future<void> addProduct(Product product) async {
    await _client.from('products').insert(product.toMap());
  }

  Future<void> updateProduct(Product product) async {
    await _client
        .from('products')
        .update(product.toMap())
        .eq('id', product.id);
  }

  Future<void> deleteProduct(String id) async {
    await _client.from('products').delete().eq('id', id);
  }
}
