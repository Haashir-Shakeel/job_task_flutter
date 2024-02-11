import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';

class ProductListScreen extends StatelessWidget {
  ProductListScreen({super.key});

  final List<String> categoryImage = [
    '',
    'assets/rectangle8088.png',
    'assets/rectangle8089.png',
    'assets/rectangle8088.png',
  ];
  final List<String> categoryText = [
    'show all',
    'Category 1',
    'Category 2',
    'Category 3',
  ];

  Widget _buildAppBar() {
    return Container(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: IconButton(
              icon: Icon(
                Icons.add,
                size: 20,
              ),
              onPressed: () {},
            ),
          ),
          Expanded(
            child: Text(
              "Add Product",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories(BuildContext context) {
    return Container(
      height: 120,
      width: double.maxFinite,
      child: ListView.builder(
          itemCount: categoryImage.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.only(right: 15, top: 10),
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: categoryImage[index] != ''
                  ? Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 4, bottom: 8),
                          child: Image.asset(
                            categoryImage[index],
                            fit: BoxFit.cover,
                            height: 70,
                          ),
                        ),
                        Text(categoryText[index])
                      ],
                    )
                  : Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 4, bottom: 8,left: 4,right: 4),
                          height: 70,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              color: primaryButtonColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Container(
                            padding: EdgeInsets.all(20),
                              child: SvgPicture.asset(
                            'assets/vector1.svg',
                          )),
                        ),
                        Text(categoryText[index])
                      ],
                    ),
            );
          }),
    );
  }

  Widget _buildChangeDisplayRow(){
    return Row(
      children: [
        IconButton(
          icon: SvgPicture.asset('assets/Vector.svg'),
          onPressed: () {},
        ),

        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Text(
            'Change the display to horizontal',
            style: TextStyle(
              color: Colors.pink
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductList(){
    return Container(
      height: double.maxFinite,
      margin: EdgeInsets.all(8),
      child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.vertical,
          itemBuilder: (_,index){
            return Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  //image container

                  Container(
                    child: Image.asset(
                      categoryImage[1],
                      fit: BoxFit.cover,
                      height: 100,
                    ),
                  ),

                  SizedBox(width: 15,),
                  //product description container
                  Container(
                    child: Column(
                      children: [
                        Text('this is example',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          SizedBox(height: 10,),
                        Row(
                          children: [
                            Text('120',style: TextStyle(color: primaryButtonColor,fontSize: 16),),
                            SizedBox(width: 3,),
                            Text('SAR',style: TextStyle(color: Colors.grey.shade700,fontSize: 14),)
                          ],
                        ),
                        SizedBox(height: 10,),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: greyColor
                          ),
                          child: Text('Store Name',style: TextStyle(color: Colors.grey.shade700),),
                        )
                      ],
                    ),
                  )
                ],


              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryBackgroundColor,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(children: [
              SizedBox(
                height: 10,
              ),
              _buildAppBar(),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'categories',
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              _buildCategories(context),
              SizedBox(height: 10,),
              _buildChangeDisplayRow(),

              _buildProductList(),
            ]),
          ),
        ));
  }
}
