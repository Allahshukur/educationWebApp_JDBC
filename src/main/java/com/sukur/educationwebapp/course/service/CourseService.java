package com.sukur.educationwebapp.course.service;

import com.sukur.educationwebapp.comman.MyService;
import com.sukur.educationwebapp.course.entity.Course;
import com.sukur.educationwebapp.course.repository.CourseRepository;

import java.util.List;

public class CourseService implements MyService<Course> {

    private final CourseRepository courseRepository = new CourseRepository();

    /** Web API: yeni kurs yarat */
    public Course create(String name, String description, int teacherId) {
        return courseRepository.create(name, description, teacherId);
    }

    @Override
    public Course create() {
        throw new UnsupportedOperationException("Parametrli create() istifadə edin.");
    }

    @Override
    public List<Course> findAll() {
        return courseRepository.findAll();
    }

    @Override
    public Course findById() {
        throw new UnsupportedOperationException("findById(int id) istifadə edin.");
    }

    /** Web API: ID ilə tap */
    public Course findById(int id) {
        return courseRepository.findById(id);
    }

    @Override
    public List<Course> search(String word) {
        return courseRepository.search(word);
    }

    @Override
    public Course update() {
        throw new UnsupportedOperationException("Parametrli update() istifadə edin.");
    }

    /** Web API: kursu yenilə */
    public Course update(int id, String name, String description, int teacherId) {
        return courseRepository.update(id, name, description, teacherId);
    }

    @Override
    public void delete() {
        throw new UnsupportedOperationException("delete(int id) istifadə edin.");
    }

    /** Web API: kursu sil */
    public int delete(int id) {
        return courseRepository.delete(id);
    }
}
