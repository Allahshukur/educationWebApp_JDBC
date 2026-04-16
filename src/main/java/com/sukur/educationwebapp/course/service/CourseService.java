package com.sukur.educationwebapp.course.service;

import com.sukur.educationwebapp.course.entity.Course;
import com.sukur.educationwebapp.course.repository.CourseRepository;

import java.util.List;

public class CourseService {

    private final CourseRepository courseRepository = new CourseRepository();

    public Course create(String courseTitle, String courseDescription, String coursePrice, String courseIcon) {
        return courseRepository.create(courseTitle, courseDescription, coursePrice, courseIcon);
    }

    public List<Course> findAll() {
        return courseRepository.findAll();
    }

    public Course findById(int id) {
        return courseRepository.findById(id);
    }
}
