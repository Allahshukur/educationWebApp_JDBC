package com.sukur.educationwebapp.student.service;

import com.sukur.educationwebapp.comman.MyService;
import com.sukur.educationwebapp.student.entity.Student;
import com.sukur.educationwebapp.student.repository.StudentRepository;

import java.util.List;
import java.util.Scanner;

public class StudentService implements MyService<Student> {

    private final StudentRepository studentRepository = new StudentRepository();

    @Override
    public Student create() {
        Student student = studentRepository.create();
        System.out.println("________________________________________");
        System.out.println(student);
        System.out.println("----------------------------------------");
        return student;
    }

    @Override
    public List<Student> findAll() {
        return studentRepository.findAll();
    }

    @Override
    public Student findById() {
        return studentRepository.findById();
    }

    @Override
    public List<Student> search(String search) {
        return studentRepository.search(search);
    }

    @Override
    public Student update() {
        return studentRepository.update();
    }

    @Override
    public void delete() {
        studentRepository.delete();
    }

    public Student update(int id, String name, String surname, String email, int age) {
        return studentRepository.update(id, name, surname, email, age);
    }

    public int delete(int id) {
        return studentRepository.delete(id);
    }
}
