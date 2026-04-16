package com.sukur.educationwebapp.comman;

import java.util.List;

public interface MyRepository<T> {

    T create(String name, String surname, String email, int age);

    List<T> findAll();

    T findById(int id);

    List<T> search(String search);

    T update(int id, String name, String surname, String email, int age);

    int delete(int id);
}
