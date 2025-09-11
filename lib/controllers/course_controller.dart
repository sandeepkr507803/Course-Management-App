import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/course_model.dart';

class CourseController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var courses = <Course>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCourses();
  }

  // Fetch all courses
  void fetchCourses() {
    _firestore
        .collection('courses')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((querySnapshot) {
      courses.assignAll(
        querySnapshot.docs.map((doc) => Course.fromMap(doc.id, doc.data())).toList(),
      );
    });
  }

  // Add a new course
  Future<void> addCourse(Course course) async {
    try {
      await _firestore.collection('courses').add(course.toMap());
      Get.snackbar('Success', 'Course added successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add course: $e');
    }
  }

  // Update a course
  Future<void> updateCourse(String id, Course course) async {
    try {
      await _firestore.collection('courses').doc(id).update(course.toMap());
      Get.snackbar('Success', 'Course updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update course: $e');
    }
  }

  // Delete a course
  Future<void> deleteCourse(String id) async {
    try {
      await _firestore.collection('courses').doc(id).delete();
      Get.snackbar('Success', 'Course deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete course: $e');
    }
  }
}