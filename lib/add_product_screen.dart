import 'package:flutter/material.dart';
class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  Widget _buildAppBar(){
    return Container(
      child: Row(
        children: [
          Expanded(child: Text(
            "Add Product",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_forward_ios,size: 20,),
              onPressed: () {

              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF9F9F9),
        body: Container(
        margin: EdgeInsets.all(20),
          child: Column(
            children: [
              _buildAppBar(),
            ],
          ),
      ),
    );
  }
}
