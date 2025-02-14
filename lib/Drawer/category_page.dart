import 'package:flutter/material.dart';
import 'package:flutter_application_1/API_Service/api_service.dart';
import 'package:flutter_application_1/bottom_items/staff_page.dart';
import 'package:flutter_application_1/dashboard/persistent_bottom_nav_bar.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

final ApiService apiService = ApiService();

class _CategoryPageState extends State<CategoryPage> {
  List<Map<String, String>> categorylist = [];
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  List<Map<String, String>> categories = [];
  List<Map<String, String>> filteredCategories = [];
  TextEditingController searchController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  bool _isFetchingMore = false;
  final int _limit = 10; // Number of items per page
  bool _hasMore = true; // Track if there are more pages

  bool _isSearching = false;
  bool isScrolled = false;
  bool _isLoading = true;

  // @override
  // void initState() {
  //   super.initState();
  //   filteredCategories = List.from(categories);
  // }


  
  Future<void> fetchAndDisplayCategory({bool isLoadMore = false}) async {
    if (_isFetchingMore) return;

    setState(() {
      _isFetchingMore = true;
    });

    try {
      final fetchedCategory =
          await apiService.fetchcategory(page: _currentPage, limit: _limit);

      setState(() {
        if (isLoadMore) {
          categorylist.addAll(fetchedCategory);
        } else {
          categorylist = fetchedCategory;
        }

        _isFetchingMore = false;
        _hasMore =
            _currentPage < apiService.totalPages; // Ensure this is updated
      });
    } catch (e) {
      print('Error fetching categories: $e');
      setState(() {
        _isFetchingMore = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAndDisplayCategory();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        if (_hasMore && !_isFetchingMore) {
          setState(() {
            _currentPage++;
          });
          fetchAndDisplayCategory(isLoadMore: true);
        }
      }
    });
  }

  void filterCategories(String query) {
    setState(() {
      filteredCategories = categories
          .where((category) =>
              category['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void addCategory(String name, String description) async {
    setState(() {});
    Map<String, dynamic> categorydata = {
      "id": _idController.text,
      "category_name": name,
      "description": description,
    };

    bool success = await apiService.createCategory(categorydata);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('User created successfully!'),
            backgroundColor: Colors.green),
      );
      Navigator.pop(context); // Close modal
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Failed to create user.'),
            backgroundColor: Colors.red),
      );
    }
  }

  void editCategory(int index, String newName, String newDescription) async {
    String categoryId = categorylist[index]['id'] ?? '';

    if (categoryId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Category ID not found.'),
            backgroundColor: Colors.red),
      );
      return;
    }

    Map<String, dynamic> updatedCategory = {
      "category_name": newName,
      "description": newDescription,
    };

    bool success = await apiService.updateCategory(categoryId, updatedCategory);

    if (success) {
      setState(() {
        categorylist[index]['category_name'] = newName;
        categorylist[index]['description'] = newDescription;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Category updated successfully!'),
            backgroundColor: Colors.green),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Failed to update category.'),
            backgroundColor: Colors.red),
      );
    }
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, String categoryId, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this category?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context); // Close the dialog

                try {
                  await apiService.deleteCatgeoryFromApi(categoryId, () {
                    setState(() {
                      categorylist.removeAt(index);
                    });
                  });
                } catch (e) {
                  print("Error deleting category: $e");
                }
              },
              child: Text('Delete'),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF028090),
        title: _isSearching
            ? Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white, // Background color
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                  border:
                      Border.all(color: Colors.grey, width: 1), // Border color
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: filterCategories,
                  decoration: InputDecoration(
                    hintText: 'Search Category...',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                  ),
                  style: TextStyle(color: Colors.black),
                  cursorColor: Color(0xFF028090),
                ),
              )
            : Text(
                'Category Details',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => PersistentBottomNavBar()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.cancel : Icons.search,
                color: Colors.black),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  searchController.clear();
                  filterCategories('');
                }
              });
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    border: TableBorder.all(color: Colors.black, width: 1),
                    columnSpacing: 20.0,
                    columns: [
                      DataColumn(
                          label: Text('S.No',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Category Name',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Description',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Action',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                    ],
                    rows: categorylist.asMap().entries.map((entry) {
                      int index = entry.key + 1;
                      Map<String, String> category = entry.value;
                      return DataRow(cells: [
                        DataCell(Text(index.toString())),
                        DataCell(Text(category['category_name'] ?? 'N/A')),
                        DataCell(SizedBox(
                          width: 150,
                          child: Text(category['description'] ?? 'N/A',
                              overflow: TextOverflow.ellipsis, maxLines: 2),
                        )),
                        DataCell(Row(children: [
                          IconButton(
                            icon: Icon(Icons.edit_square, color: Colors.orange),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  TextEditingController nameController =
                                      TextEditingController(
                                          text: category['category_name']);
                                  TextEditingController descController =
                                      TextEditingController(
                                          text: category['description']);
                                  return AlertDialog(
                                    backgroundColor: Colors.white,
                                    title: Text('Edit Category',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          controller: nameController,
                                          decoration: InputDecoration(
                                            hintText: 'Category Name',
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              borderSide: const BorderSide(
                                                  color: Color.fromRGBO(
                                                      2, 116, 131, 1),
                                                  width:
                                                      2.0), // Focused border color
                                            ),
                                          ),
                                          cursorColor:
                                              Color.fromRGBO(2, 116, 131, 1),
                                        ),
                                        SizedBox(height: 10),
                                        TextField(
                                          controller: descController,
                                          maxLines: 5,
                                          decoration: InputDecoration(
                                            hintText: 'Description',
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              borderSide: const BorderSide(
                                                  color: Color.fromRGBO(
                                                      2, 116, 131, 1),
                                                  width:
                                                      2.0), // Focused border color
                                            ),
                                          ),
                                          cursorColor:
                                              Color.fromRGBO(2, 116, 131, 1),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text('Cancel')),
                                      ElevatedButton(
                                        onPressed: () {
                                          editCategory(
                                              index - 1,
                                              nameController.text,
                                              descController.text);
                                          Navigator.pop(context);
                                        },
                                        child: Text('Save'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _showDeleteConfirmationDialog(
                                context, category['id']!, index - 1),
                          ),
                        ])),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back,
                      color: _currentPage > 1 ? Colors.blue : Colors.grey),
                  onPressed: _currentPage > 1
                      ? () {
                          setState(() {
                            _currentPage--;
                          });
                          fetchAndDisplayCategory();
                        }
                      : null,
                ),
                Text("Page $_currentPage",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: Icon(Icons.arrow_forward,
                      color: _hasMore ? Colors.blue : Colors.grey),
                  onPressed: _hasMore
                      ? () {
                          setState(() {
                            _currentPage++;
                          });
                          fetchAndDisplayCategory(isLoadMore: true);
                        }
                      : null,
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, // Ensures full view
            builder: (BuildContext context) {
              return AddCategoryBottomSheet(
                nameController: _nameController,
                descController: _descController,
                onAddCategory: (name, description) =>
                    addCategory(name, description),
              );
            },
          );
        },
        child: const Icon(Icons.add, color: Colors.white, size: 30),
        elevation: 30.0,
        backgroundColor: Color(0xFF028090),
        tooltip: 'Add Category',
      ),
       floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}

class AddCategoryBottomSheet extends StatelessWidget {
  final Function(String, String) onAddCategory;
  final TextEditingController nameController;
  final TextEditingController descController;

  AddCategoryBottomSheet({
    required this.onAddCategory,
    required this.nameController,
    required this.descController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Create Category',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          SizedBox(height: 10),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: 'Category Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                    color: Color.fromRGBO(2, 116, 131, 1),
                    width: 2.0), // Focused border color
              ),
            ),
            cursorColor: Color.fromRGBO(2, 116, 131, 1),
          ),
          SizedBox(height: 10),
          TextField(
            controller: descController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Description',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                    color: Color.fromRGBO(2, 116, 131, 1),
                    width: 2.0), // Focused border color
              ),
            ),
            cursorColor: Color.fromRGBO(2, 116, 131, 1),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              onAddCategory(nameController.text, descController.text);
              // DO NOT clear the controllers here
            },
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF028090)),
            child: Text('Submit', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
