import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobtask/constants.dart';
import 'package:jobtask/screens/product_list_screen.dart';
import 'package:jobtask/widgets/_add_product_form.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddProductScreen extends StatefulWidget {
  AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  List<File> _productImages = [];

  final List<String> productImageUrls = [
    'assets/rectangle8088.png',
    'assets/rectangle8089.png',
    '',
    '',
  ];

  Future<void> _addPicture() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _productImages.add(File(pickedImage.path));
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _productImages.removeAt(index);
    });
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Add Product",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductListScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildImageWidget(int index) {
  Widget _buildProductPictures(BuildContext context) {
    return Container(
        height: 120,
        width: double.maxFinite,
        child: ListView.builder(
                itemCount: _productImages.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin: const EdgeInsets.only(right: 15, top: 10),
                      height: 80,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            child: Image.file(
                              _productImages[index],
                              fit: BoxFit.cover,
                              height: 100,
                              width: 100,
                            ),
                          ),
                          Positioned(
                            top: -5,
                            left: -10,
                            child: IconButton(
                              icon: SvgPicture.asset('assets/forbidden2.svg'),
                              onPressed: () => _removeImage(index),
                            ),
                          ),
                        ],
                      ));
                })
             ,);
  }

  Widget _buildButton(IconData? buttonIcon, String buttonText) {
    return Container(
      height: 70,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: primaryButtonColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: () {
          _addPicture();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //icon of button
            buttonIcon != null
                ? Container(
                    height: 35,
                    width: 35,
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: IconButton(
                      icon: Icon(
                        buttonIcon,
                        size: 20,
                      ),
                      onPressed: () {},
                    ),
                  )
                : Container(),

            //button text
            Text(
              buttonText,
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              _buildAppBar(context),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'product pictures',
                  ),
                ],
              ),
              _buildProductPictures(context),
              SizedBox(
                height: 10,
              ),
              _buildButton(Icons.add, 'press to add picture'),
              SizedBox(
                height: 10,
              ),
              ProductAddForm(productImages: _productImages,),
            ],
          ),
        ),
      ),
    );
  }
}
