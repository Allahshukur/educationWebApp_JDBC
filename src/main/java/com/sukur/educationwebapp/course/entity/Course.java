package com.sukur.educationwebapp.course.entity;

public class Course {

    private int id;
    private String name;
    private String description;
    private int teacherId;
    private Boolean deleted;

    public Course() {
    }

    public int getId() {
        return id;
    }

    public Course setId(int id) {
        this.id = id;
        return this;
    }

    public String getName() {
        return name;
    }

    public Course setName(String name) {
        this.name = name;
        return this;
    }

    public String getDescription() {
        return description;
    }

    public Course setDescription(String description) {
        this.description = description;
        return this;
    }

    public int getTeacherId() {
        return teacherId;
    }

    public Course setTeacherId(int teacherId) {
        this.teacherId = teacherId;
        return this;
    }

    public Boolean getDeleted() {
        return deleted;
    }

    public Course setDeleted(Boolean deleted) {
        this.deleted = deleted;
        return this;
    }

    @Override
    public String toString() {
        return id + ". " + name + " - " + description + " (Teacher ID: " + teacherId + ")";
    }
}
