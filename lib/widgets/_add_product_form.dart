import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../data/product.dart';
import 'dart:io';

import '../screens/product_list_screen.dart';

class ProductAddForm extends StatefulWidget {
  final List<File> productImages;

  ProductAddForm({required this.productImages});
  @override
  ProductAddFormState createState() => ProductAddFormState();
}

class ProductAddFormState extends State<ProductAddForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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



  void _saveProduct() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();


      List<String>? productList = prefs.getStringList('products');


      List products = productList?.map((jsonString) => jsonDecode(jsonString))
          .toList() ?? [];


      Product product = Product(
        productName: _productNameController.text.trim(),
        storeName: _storeNameController.text.trim(),
        price: double.parse(_priceController.text.trim()),
        category: _selectedCategory,
        images: widget.productImages,
      );


      Map<String, dynamic> productMap = product.toMap();


      products.add(productMap);


      List<String> serializedProducts = products.map((product) =>
          jsonEncode(product)).toList();


      await prefs.setStringList('products', serializedProducts);


      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product added successfully')),
      );

      _priceController.clear();
      _productNameController.clear();
      _storeNameController.clear();
      _selectedCategory = 'all';

      print(prefs.getStringList('products'));
      _formKey.currentState!.reset();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductListScreen()));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInputField(
            label: 'Product Name',
            hintText: 'Enter product name',
            controller: _productNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter product name';
              }
              return null;
            },
          ),
          SizedBox(height: 20.0),
          _buildInputField(
            label: 'Store Name',
            hintText: 'Enter store name',
            controller: _storeNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter store name';
              }
              return null;
            },
          ),
          SizedBox(height: 20.0),
          _buildInputField(
            label: 'Price',
            hintText: 'Enter price',
            controller: _priceController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter price';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),

          SizedBox(height: 20.0),
          _buildDropdownField(),
        ],
      ),
    );
  }
  Widget _buildButton(IconData? buttonIcon, String buttonText,){
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
    required String? Function(String?) validator,
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
          child: TextFormField(
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
            validator: validator,
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

