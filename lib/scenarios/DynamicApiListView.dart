import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

class DynamicApiListView extends StatefulWidget {
  const DynamicApiListView({super.key});

  @override
  State<DynamicApiListView> createState() => _DynamicApiListViewState();
}

class _DynamicApiListViewState extends State<DynamicApiListView> {
  List<dynamic> _products = [];
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final response = await http.get(Uri.parse('https://dummyjson.com/products?limit=500'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _products = data['products'];
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic API ListView with Images'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _hasError
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Something went wrong!', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _fetchProducts,
              child: const Text('Retry'),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return ListTile(
            tileColor: Colors.grey.shade900,
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: product['images'][0],
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.white),
              ),
            ),
            title: Text(
              product['title'],
              style: const TextStyle(color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              product['description'],
              style: TextStyle(color: Colors.grey.shade400),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Tapped Product: ${product['title']}'),
                  showCloseIcon: true,
                  duration: const Duration(milliseconds: 300),
                ),
              );
            },
          );
        },
      ),
    );
  }
}