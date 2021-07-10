import 'package:ake_car_tracker/localization/translate_helper.dart';
import '/controllers/controller.dart';
import 'package:get/get.dart';
import '/widgets/widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends GetView<HomeScreenController> {
  HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      builder: (_) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Background(
            child: Stack(
              children: [
                _buildSearchButton(),
                _buildHeaderText(),
                _buildLeftSideCarImage(),
                _buildInfoCardList(),
                _buildLockButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildSearchButton() {
    return Positioned(
      top: Get.height * .055,
      right: Get.width * .05,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          InputSearch(
            width: 300.0,
            backgroundColor: Colors.white38,
            searchController: controller.searchAnimController,
            onChanged: (input) => controller.onSearchChange(input),
            onSaved: (input) {},
            hint: TranslateHelper.search,
          ),
          CircleConcavButton(
            onPressed: () => controller.onSearch(),
            child: Icon(Icons.search, color: Colors.grey),
            animController: controller.concavAnimController,
            animChild: Icon(Icons.close, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  _buildHeaderText() {
    return Positioned(
      top: Get.height * .18,
      right: Get.width * .08,
      child: Column(children: [
        Text(
          'Ake',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
        ),
        SizedBox(height: 7.0),
        Text(
          'Car Tracking',
          style: TextStyle(
            color: Colors.white,
            fontSize: 34.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ]),
    );
  }

  _buildLeftSideCarImage() {
    return Positioned(
      right: 10.0,
      top: Get.height * .24,
      child: Hero(
        tag: 'car',
        child: Image.asset('assets/images/left_side_car.png'),
      ),
    );
  }

  _buildInfoCardList() {
    return Positioned(
      bottom: Get.height * .25,
      left: 0.0,
      right: 0.0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6.0),
        height: Get.height * .22,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.0, bottom: 4.0),
              child: Text(
                TranslateHelper.information,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 7.0),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) => InfoCard(
                  onPressed: controller.onCardInfo,
                  width: Get.width * .35,
                  index: index,
                  header: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.infoCardHeader[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        controller.infoCardHeaderIcon[index],
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildLockButton() {
    return Positioned(
      bottom: Get.height * .03,
      left: 0.0,
      right: 0.0,
      child: Column(
        children: [
          CircleConvexButton(
            onPressed: () => print('hey'),
            padding: 45.0,
            color: Color(0xff10a1f5),
            child: Icon(
              Icons.lock,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            "Let's Start",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
