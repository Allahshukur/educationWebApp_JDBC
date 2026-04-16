package com.sukur.educationwebapp.student.entity;

public class Student {

    private int id;
    private String name;
    private String surname;
    private int age;
    private String email;
    private String phone;
    private String specialty;
    private String address;
    private String status;
    private Boolean deleted;
    private String teacher;

    public Student() {
    }

    public int getId() {
        return id;
    }

    public Student setId(int id) {
        this.id = id;
        return this;
    }

    public String getName() {
        return name;
    }

    public Student setName(String name) {
        this.name = name;
        return this;
    }

    public String getSurname() {
        return surname;
    }

    public Student setSurname(String surname) {
        this.surname = surname;
        return this;
    }

    public int getAge() {
        return age;
    }

    public Student setAge(int age) {
        this.age = age;
        return this;
    }

    public String getEmail() {
        return email;
    }

    public Student setEmail(String email) {
        this.email = email;
        return this;
    }

    public String getPhone() {
        return phone;
    }

    public Student setPhone(String phone) {
        this.phone = phone;
        return this;
    }

    public String getSpecialty() {
        return specialty;
    }

    public Student setSpecialty(String specialty) {
        this.specialty = specialty;
        return this;
    }

    public String getAddress() {
        return address;
    }

    public Student setAddress(String address) {
        this.address = address;
        return this;
    }

    public String getStatus() {
        return status;
    }

    public Student setStatus(String status) {
        this.status = status;
        return this;
    }

    public Boolean getDeleted() {
        return deleted;
    }

    public Student setDeleted(Boolean deleted) {
        this.deleted = deleted;
        return this;
    }

    public String getTeacher() {
        return teacher;
    }

    public Student setTeacher(String teacher) {
        this.teacher = teacher;
        return this;
    }

    @Override
    public String toString() {
        return id + ". " + name + " " + surname + " " + age + " " + email + " [ Teachers = " + teacher + " ] ";
    }

}
