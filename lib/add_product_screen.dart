import 'package:flutter/material.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});

  final List<String> productImageUrls = [
    'assets/rectangle8088.png',
    'assets/rectangle8089.png',
    '',
    '',
  ];

  Widget _buildAppBar() {
    return Container(
      height: 120,
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
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageWidget(int index) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.asset(
          productImageUrls[index],
          fit: BoxFit.cover,
        ));
  }

  Widget _buildProductPictures(BuildContext context) {
    return Container(
      height: 120,
      width: double.maxFinite,
      child: ListView.builder(
          itemCount: productImageUrls.length,
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
              child: productImageUrls[index] != ''
                  ? Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(productImageUrls[index]),
                      fit: BoxFit.cover
                    )
                  ),
              )
                  : Container(),
            );
          }),
    );
  }

  Widget _buildButton(IconData? buttonIcon, String buttonText){
    return Container(
      height: 70,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Color(0xFF3EB86F),
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: (){
          print('button pressed');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            _buildAppBar(),
            SizedBox(
              height: 10,
            ),
            Text('product pictures',),
            _buildProductPictures(context),
            SizedBox(
              height: 10,
            ),
            _buildButton(Icons.add, 'press to add picture'),
            SizedBox(
              height: 10,
            ),
            _buildButton( null,'add product')
          ],
        ),
      ),
    );
  }
}
