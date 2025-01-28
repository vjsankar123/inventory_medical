import 'package:flutter/material.dart';
import 'package:flutter_application_1/bottom_items/edit_staff.dart';

class StaffCard extends StatefulWidget {
  final Map<String, String> staff;
  final VoidCallback onDelete; // Callback for deletion

  StaffCard({required this.staff, required this.onDelete});

  @override
  _StaffCardState createState() => _StaffCardState();
}

class _StaffCardState extends State<StaffCard> {
  double _scale = 1.0;
  double _rotation = 0.0;

  @override
  Widget build(BuildContext context) {
    Color innerRoleColor =
        widget.staff['role'] == 'Admin' ? Colors.red : Colors.blue;

    return GestureDetector(
      onTap: () {
        setState(() {
          _scale = 1.1;
          _rotation = 0.05;
        });

        Future.delayed(Duration(milliseconds: 200), () {
          setState(() {
            _scale = 1.0;
            _rotation = 0.0;
          });
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        transform: Matrix4.rotationZ(_rotation),
        transformAlignment: Alignment.center,
        curve: Curves.easeInOut,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border(
                    top: BorderSide(color: Colors.black, width: 2.0),
                    left: BorderSide(color: Colors.black, width: 2.0),
                    right: BorderSide(color: Colors.black, width: 2.0),
                    bottom: BorderSide(color: Colors.black, width: 5.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6.0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
          child: Card(
            elevation: 5,
            color: Colors.white,
            shadowColor: Colors.black.withOpacity(0.2),
          child: Transform.scale(
            scale: _scale,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(0xFF028090),
                    child: Text(
                      widget.staff['name']!.substring(0, 1),
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name: ${widget.staff['name']}',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.email,
                                color: Colors.grey[600], size: 20),
                            SizedBox(width: 8),
                            Text(
                              '${widget.staff['email']}',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.phone,
                                color: Colors.grey[600], size: 20),
                            SizedBox(width: 8),
                            Text(
                              '${widget.staff['contact']}',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              'Role:',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            SizedBox(width: 8),
                            Text(
                              '${widget.staff['role']}',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: innerRoleColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit_note,
                            color: Colors.orange, size: 28),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditStaffPage(
                                staffData: widget.staff,
                                onSave: (updatedData) {
                                  setState(() {
                                    widget.staff.addAll(updatedData.map(
                                        (key, value) =>
                                            MapEntry(key, value.toString())));
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete_sweep,
                            color: Colors.red, size: 28),
                        onPressed: () => _showDeleteConfirmationDialog(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    )
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Confirm Deletion'),
          content:
              Text('Are you sure you want to delete ${widget.staff['name']}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Close dialog
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                widget.onDelete(); // Trigger delete callback
              },
              child: Text('Delete'),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
            ),
          ],
        );
      },
    );
  }
}
