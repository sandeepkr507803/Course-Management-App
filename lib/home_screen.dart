import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/course_controller.dart';
import 'add_course_screen.dart';
import 'chatbot_screen.dart';
import '../models/course_model.dart';

class HomeScreen extends StatelessWidget {
  final CourseController courseController = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Course Management'),
          actions: [
            IconButton(
              icon: Icon(Icons.chat),
              onPressed: () {
                Get.to(() => ChatbotScreen());
              },
            ),
          ],
        ),
        body: Obx(() {
          if (courseController.courses.isEmpty) {
            return Center(
              child: Text(
                'No courses available.\nAdd a new course to get started.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            );
          }
          return ListView.builder(
            itemCount: courseController.courses.length,
            itemBuilder: (context, index) {
              Course course = courseController.courses[index];
              return CourseCard(course: course);
            },
          );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => AddCourseScreen());
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final Course course;
  final CourseController courseController = Get.find();

  CourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Instructor: ${course.instructor}'),
            Text('Duration: ${course.duration} hours'),
            Text('Level: ${course.level}'),
            SizedBox(height: 8),
            Text(
              course.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    Get.to(() => AddCourseScreen(course: course));
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Confirm Delete'),
                          content: Text('Are you sure you want to delete this course?'),
                          actions: [
                            TextButton(
                              onPressed: () => Get.back(),
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                courseController.deleteCourse(course.id!);
                                Get.back();
                              },
                              child: Text('Delete'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}