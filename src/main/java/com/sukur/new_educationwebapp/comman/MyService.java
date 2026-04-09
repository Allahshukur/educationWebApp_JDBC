package com.sukur.new_educationwebapp.comman;

import java.util.List;

public interface MyService<T> {

    T create();

    List<T> findAll();

    T findById();

    List<T> search(String search);

    T update();

    void delete();
}
