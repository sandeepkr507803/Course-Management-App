import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/course_controller.dart';
import '../models/course_model.dart';

class AddCourseScreen extends StatefulWidget {
  final Course? course;

  AddCourseScreen({this.course});

  @override
  _AddCourseScreenState createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  final _formKey = GlobalKey<FormState>();
  final CourseController courseController = Get.find();

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _instructorController;
  late TextEditingController _durationController;
  String _level = 'Beginner';
  double _rating = 0.0;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.course?.title ?? '');
    _descriptionController = TextEditingController(text: widget.course?.description ?? '');
    _instructorController = TextEditingController(text: widget.course?.instructor ?? '');
    _durationController = TextEditingController(text: widget.course?.duration.toString() ?? '');
    _level = widget.course?.level ?? 'Beginner';
    _rating = widget.course?.rating ?? 0.0;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _instructorController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course == null ? 'Add Course' : 'Edit Course'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Course Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _instructorController,
                decoration: InputDecoration(labelText: 'Instructor'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter instructor name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _durationController,
                decoration: InputDecoration(labelText: 'Duration (hours)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter duration';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _level,
                decoration: InputDecoration(labelText: 'Level'),
                items: ['Beginner', 'Intermediate', 'Advanced']
                    .map((level) => DropdownMenuItem(
                  value: level,
                  child: Text(level),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _level = value!;
                  });
                },
              ),
              SizedBox(height: 16),
              Text('Rating: $_rating'),
              Slider(
                value: _rating,
                min: 0,
                max: 5,
                divisions: 10,
                onChanged: (value) {
                  setState(() {
                    _rating = value;
                  });
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Course course = Course(
                      id: widget.course?.id,
                      title: _titleController.text,
                      description: _descriptionController.text,
                      instructor: _instructorController.text,
                      duration: int.parse(_durationController.text),
                      level: _level,
                      rating: _rating,
                      createdAt: widget.course?.createdAt ?? DateTime.now(),
                    );

                    if (widget.course == null) {
                      courseController.addCourse(course);
                    } else {
                      courseController.updateCourse(widget.course!.id!, course);
                    }
                    Get.back();
                  }
                },
                child: Text(widget.course == null ? 'Add Course' : 'Update Course'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}