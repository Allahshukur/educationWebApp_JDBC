package com.sukur.new_educationwebapp.comman;

import java.util.List;

public interface MyRepository<T> {

    T create();

    List<T> findAll();

    T findById();

    List<T> search(String search);

    T update();

    int delete();
}
