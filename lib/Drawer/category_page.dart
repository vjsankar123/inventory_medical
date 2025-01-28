import 'package:flutter/material.dart';
import 'package:flutter_application_1/dashboard/persistent_bottom_nav_bar.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<Map<String, String>> categories = [
    {'id': '1', 'name': 'Medicines'},
    {'id': '2', 'name': 'Health Supplements'},
  ];

  void addCategory(String name) {
    setState(() {
      categories.add({'id': (categories.length + 1).toString(), 'name': name});
    });
  }

  void editCategory(int index, String newName) {
    setState(() {
      categories[index]['name'] = newName;
    });
  }

  void deleteCategory(int index) {
    setState(() {
      categories.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PersistentBottomNavBar(),
        ));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF028090),
          title: Text(
            'Category Details',
            style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => PersistentBottomNavBar(),
              ));
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors
                                      .black), // Outer border for the entire table
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: DataTable(
                              border: TableBorder.all(
                                color:
                                    Colors.black, // Border color for the table
                                width: 1, // Border width
                              ),
                              columns: [
                                DataColumn(
                                    label: Text('S.No',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: Text('Category Name',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: Text('Action',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold))),
                              ],
                              rows: categories.asMap().entries.map((entry) {
                                int index = entry.key;
                                Map<String, String> category = entry.value;
                                return DataRow(cells: [
                                  DataCell(Text(category['id']!)),
                                  DataCell(Text(category['name']!)),
                                  DataCell(
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            Icons.edit_square,
                                            color: Colors.orange,
                                          ),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                TextEditingController
                                                    editController =
                                                    TextEditingController(
                                                        text: category['name']);
                                                return AlertDialog(
                                                  backgroundColor: Colors.white,
                                                  title: Text('Edit Category', style: TextStyle(fontSize: 20, color: Colors.black,fontWeight: FontWeight.bold),),
                                                  content: TextField(
                                                    controller: editController,
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0xFF028090),
                                                          width: 2.0,
                                                        ),
                                                      ),
                                                    ),
                                                    cursorColor:
                                                        Color(0xFF028090),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.grey,
                                                        // padding:
                                                        //     EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                                      ),
                                                      child: Text(
                                                        'Cancel',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        if (editController
                                                            .text.isNotEmpty) {
                                                          editCategory(
                                                              index,
                                                              editController
                                                                  .text);
                                                          Navigator.pop(
                                                              context);
                                                        }
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Color(0xFF028090),
                                                        // padding: EdgeInsets
                                                        //     .symmetric(
                                                        //         horizontal: 20,
                                                        //         vertical: 10),
                                                      ),
                                                      child: Text(
                                                        'Save',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.auto_delete,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  backgroundColor: Colors.white,
                                                  title:
                                                      Text('Confirm Deletion'),
                                                  content: Text(
                                                      'Are you sure you want to delete this category?'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('Cancel',style: TextStyle(color: Colors.grey),),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        deleteCategory(index);
                                                        Navigator.pop(context);
                                                      },
                                                      
                                                      child: Text('Delete',style: TextStyle(color: Colors.red),),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ]);
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: Colors.white,
              context: context,
              builder: (BuildContext context) {
                return AddCategoryBottomSheet(
                  onAddCategory: (name) {
                    addCategory(name);
                  },
                );
              },
            );
          },
          child: const Icon(Icons.add, color: Colors.white, size: 30),
          elevation: 30.0,
          backgroundColor: Color(0xFF028090),
          tooltip: 'Add Category',
        ),
      ),
    );
  }
}

class AddCategoryBottomSheet extends StatefulWidget {
  final Function(String) onAddCategory;

  AddCategoryBottomSheet({required this.onAddCategory});

  @override
  _AddCategoryBottomSheetState createState() => _AddCategoryBottomSheetState();
}

class _AddCategoryBottomSheetState extends State<AddCategoryBottomSheet> {
  final _categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        // color: Colors.white, // Set the desired background color here

        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Category Name',
              style: TextStyle(fontSize: 20, color: Colors.black,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: Color(0xFF028090),
                    width: 2.0,
                  ),
                ),
              ),
              cursorColor: Color(0xFF028090),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      String categoryName = _categoryController.text;
                      if (categoryName.isNotEmpty) {
                        widget.onAddCategory(categoryName);
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Category name cannot be empty')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF028090),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
