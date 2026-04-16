package com.sukur.educationwebapp.student.service;

import com.sukur.educationwebapp.comman.MyService;
import com.sukur.educationwebapp.student.entity.Student;
import com.sukur.educationwebapp.student.repository.StudentRepository;

import java.util.List;
import java.util.Scanner;

public class StudentService implements MyService<Student> {

    private final StudentRepository studentRepository = new StudentRepository();

    @Override
    public Student create(String name, String surname, String email, int age) {
        return studentRepository.create(name, surname, email, age);
    }

    @Override
    public List<Student> findAll() {
        return studentRepository.findAll();
    }

    @Override
    public Student findById(int id) {
        return studentRepository.findById(id);
    }

    @Override
    public List<Student> search(String search) {
        return studentRepository.search(search);
    }

    @Override
    public Student update(int id, String name, String surname, String email, int age) {
        return studentRepository.update(id, name, surname, email, age);
    }

    @Override
    public int delete(int id) {
        return studentRepository.delete(id);
    }
}
