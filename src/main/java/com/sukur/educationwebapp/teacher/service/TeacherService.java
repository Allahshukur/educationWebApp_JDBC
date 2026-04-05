package com.sukur.educationwebapp.teacher.service;

import com.sukur.educationwebapp.comman.MyService;
import com.sukur.educationwebapp.teacher.entity.Teacher;
import com.sukur.educationwebapp.teacher.repository.TeacherRepository;
import java.util.List;

public class TeacherService implements MyService<Teacher> {

    private final TeacherRepository teacherRepository = new TeacherRepository();

    @Override
    public Teacher create() {
        Teacher teacher = teacherRepository.create();
        System.out.println("________________________________________");
        System.out.println(teacher);
        System.out.println("----------------------------------------");
        return teacher;
    }

    public Teacher create(String name, String surname, String email, int age) {
        return teacherRepository.create(name, surname, email, age);
    }

    @Override
    public List<Teacher> findAll() {
        return teacherRepository.findAll();
    }

    @Override
    public Teacher findById() {
        return teacherRepository.findById();
    }

    @Override
    public List<Teacher> search(String word) {
        return teacherRepository.search(word);
    }

    @Override
    public Teacher update() {
        return teacherRepository.update();
    }

    public Teacher update(int id, String name, String surname, String email, int age) {
        return teacherRepository.update(id, name, surname, email, age);
    }

    @Override
    public void delete() {
       teacherRepository.delete();
    }

    public int delete(int id) {
        return teacherRepository.delete(id);
    }
}
