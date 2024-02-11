import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../data/product.dart';

class ProductAddForm extends StatefulWidget {
  @override
  ProductAddFormState createState() => ProductAddFormState();
}

class ProductAddFormState extends State<ProductAddForm> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _storeNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  String _selectedCategory = 'All';

  @override
  void dispose() {
    _productNameController.dispose();
    _storeNameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  // void _saveProduct() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   // Create a Product object
  //   Product product = Product(
  //     productName: _productNameController.text,
  //     storeName: _storeNameController.text,
  //     price: double.parse(_priceController.text),
  //     category: _selectedCategory,
  //   );
  //
  //   // Convert product to a map
  //   Map<String, dynamic> productMap = product.toMap();
  //
  //   // Save product data to shared preferences
  //   await prefs.setString('product', productMap.toString());
  //
  //   // Show a message indicating the product has been saved
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text('product added')),
  //   );
  // }

  void _saveProduct() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve existing product list from shared preferences
    List<String>? productList = prefs.getStringList('products');

    // Parse existing product list if available, otherwise initialize an empty list
    List products = productList?.map((jsonString) => jsonDecode(jsonString)).toList() ?? [];

    // Create a Product object
    Product product = Product(
      productName: _productNameController.text.trim(),
      storeName: _storeNameController.text.trim(),
      price: double.parse(_priceController.text.trim()),
      category: _selectedCategory,
    );

    // Convert product to a map
    Map<String, dynamic> productMap = product.toMap();

    // Add new product to the list
    products.add(productMap);

    // Serialize product list to JSON
    List<String> serializedProducts = products.map((product) => jsonEncode(product)).toList();

    // Save product list to shared preferences
    await prefs.setStringList('products', serializedProducts);

    // Show a message indicating the product has been saved
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Product added successfully')),
    );

    print(prefs.getStringList('products'));
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInputField(
          label: 'Product Name',
          hintText: 'Enter product name',
          controller: _productNameController,
        ),
        SizedBox(height: 20.0),
        _buildInputField(
          label: 'Store Name',
          hintText: 'Enter store name',
          controller: _storeNameController,
        ),
        SizedBox(height: 20.0),
        _buildInputField(
          label: 'Price',
          hintText: 'Enter price',
          controller: _priceController,
        ),

        SizedBox(height: 20.0),
        _buildDropdownField(),
      ],
    );
  }
  Widget _buildButton(IconData? buttonIcon, String buttonText){
    return Container(
      height: 70,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: primaryButtonColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: (){
          print('add product clicked');
          _saveProduct();
          print('add product done');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //icon of button
            buttonIcon != null ? Container(
              height: 35,
              width: 35,
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                icon: Icon(
                  buttonIcon,
                  size: 20,
                ),
                onPressed: () {},
              ),
            ):
            Container(),

            //button text
            Text(buttonText,style: TextStyle(color: Colors.white),)
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hintText,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        SizedBox(height: 5.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 20.0,
              ),
              border: InputBorder.none,
            ),
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ],
    );
  }


  Widget _buildDropdownField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        SizedBox(height: 5.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: DropdownButtonFormField<String>(
            value: _selectedCategory,
            icon: Icon(Icons.arrow_drop_down, color: Colors.blue), // Blue dropdown icon
            iconSize: 24,
            elevation: 16,
            onChanged: (String? newValue) {
              setState(() {
                _selectedCategory = newValue!;
              });
            },
            items: <String>['All', 'Category 1', 'Category 2', 'Category 3']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 20.0,
              ),
            ),
          ),
        ),

        SizedBox(
          height: 10,
        ),
        _buildButton( null,'add product')
      ],
    );
  }


}

