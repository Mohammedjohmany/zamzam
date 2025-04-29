import 'package:flutter/material.dart';
import 'package:zamzam/features/company_feature/favourite/favourite_manager.dart';


class ProductDetailsPage extends StatefulWidget {
  final String title;
  final double price;
  final String description;

  const ProductDetailsPage({
    Key? key,
    required this.title,
    required this.price,
    required this.description,
  }) : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int quantity = 1;
  String selectedSize = '50ml';
  List<String> sizes = ['50ml', '100ml', '200ml'];
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = FavoriteManager.isFavorite(widget.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SafeArea(
        child: Column(
          children: [
            buildImageSection(),
            Expanded(child: buildDetailsSection()),
          ],
        ),
      ),
    );
  }

  Widget buildImageSection() {
    return Stack(
      children: [
        Container(
          height: 280,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
            image: DecorationImage(
              image: AssetImage('images/zamzam.jpg'), // قم بتغيير الصورة حسب الحاجة
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 16,
          left: 16,
          child: CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.8),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.blue.shade700),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.8),
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.blue.shade700,
                  ),
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                      if (isFavorite) {
                        FavoriteManager.addFavorite({
                          'title': widget.title,
                          'price': widget.price,
                          'description': widget.description,
                        });
                      } else {
                        FavoriteManager.removeFavorite(widget.title);
                      }
                    });
                  },
                ),
              ),
              const SizedBox(width: 10),
              CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.8),
                child: IconButton(
                  icon: Icon(Icons.shopping_cart_outlined, color: Colors.blue.shade700),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildDetailsSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100,
            spreadRadius: 5,
            blurRadius: 20,
          ),
        ],
      ),
      child: ListView(
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                '\$${widget.price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Available',
                  style: TextStyle(
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            widget.description,
            style: TextStyle(color: Colors.grey[700], fontSize: 15, height: 1.5),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Icon(Icons.star, color: Colors.orange, size: 20),
              const SizedBox(width: 4),
              Text(
                '4.5 (128 reviews)',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: buildDropdown()),
              const SizedBox(width: 20),
              Expanded(child: buildQuantitySelector()),
            ],
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {},
              child: const Text(
                'BUY NOW',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Bottle Size', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue.shade100),
          ),
          child: DropdownButton<String>(
            isExpanded: true,
            underline: SizedBox(),
            value: selectedSize,
            items: sizes.map((size) {
              return DropdownMenuItem(
                value: size,
                child: Text(size),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedSize = value!;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget buildQuantitySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quantity', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue.shade100),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: quantity > 1 ? () => setState(() => quantity--) : null,
                icon: Icon(Icons.remove, size: 20),
              ),
              Text(quantity.toString(), style: TextStyle(fontSize: 18)),
              IconButton(
                onPressed: () => setState(() => quantity++),
                icon: Icon(Icons.add, size: 20),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
