import 'package:flutter/material.dart';
import 'package:moneymanagementapp_flutter/Core/Colors.dart';
import 'package:moneymanagementapp_flutter/Screens/Category/Widget/Category_add_popup.dart';
import 'package:moneymanagementapp_flutter/Screens/Category/Widget/ExpenseCategoryList.dart';
import 'package:moneymanagementapp_flutter/Screens/Category/Widget/IncomeCategoryList.dart';
import 'package:moneymanagementapp_flutter/Screens/Home/Widgets/floatingaction_button.dart';
import 'package:moneymanagementapp_flutter/db/Category/Category_db.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDB().refreshUI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: defaultColor,
                toolbarHeight: 100.0,
        title: Text(
          'Categories',
          style: TextStyle(color: whiteText),
        ),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
            topLeft: Radius.circular(5.0),
            topRight: Radius.circular(5.0),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TabBar(
            dividerColor: greyText,
            controller: _tabController,
            indicatorWeight: 3,
            labelColor: defaultColor,
            labelStyle: TextStyle(fontWeight: FontWeight.w600),
            unselectedLabelColor: greyText,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: defaultColor,
            tabs: [
              Tab(text: 'INCOME'),
              Tab(text: 'EXPENSE'),
            ],
          ),
          SizedBox(height: 10,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TabBarView(
                  controller: _tabController,
                  children: [IncomeCategoryList(), ExpenseCategoryList()]),
            ),
          ),
        ],
      ),
      floatingActionButton:FloatingActionButton(onPressed: (){
        showCategoryAddPopup(context);
      },
      child: Icon(Icons.add,color:whiteText ),
        backgroundColor: defaultColor,)
    );
  }
}
