package com.sukur.educationwebapp.teacher.entity;

public class Teacher {

    private int id;
    private String name;
    private String surname;
    private int age;
    private String email;
    private Boolean deleted;
    private String phone;
    private String position;
    private String address;
    private String status;
    private String student;

    public Teacher() {
    }

    public int getId() {
        return id;
    }

    public Teacher setId(int id) {
        this.id = id;
        return this;
    }

    public String getName() {
        return name;
    }

    public Teacher setName(String name) {
        this.name = name;
        return this;
    }

    public String getSurname() {
        return surname;
    }

    public Teacher setSurname(String surname) {
        this.surname = surname;
        return this;
    }

    public int getAge() {
        return age;
    }

    public Teacher setAge(int age) {
        this.age = age;
        return this;
    }

    public String getEmail() {
        return email;
    }

    public Teacher setEmail(String email) {
        this.email = email;
        return this;
    }

    public Boolean getDeleted() {
        return deleted;
    }

    public Teacher setDeleted(Boolean deleted) {
        this.deleted = deleted;
        return this;
    }

    public String getPhone() {
        return phone;
    }

    public Teacher setPhone(String phone) {
        this.phone = phone;
        return this;
    }

    public String getPosition() {
        return position;
    }

    public Teacher setPosition(String position) {
        this.position = position;
        return this;
    }

    public String getAddress() {
        return address;
    }

    public Teacher setAddress(String address) {
        this.address = address;
        return this;
    }

    public String getStatus() {
        return status;
    }

    public Teacher setStatus(String status) {
        this.status = status;
        return this;
    }

    public String getStudent() {
        return student;
    }

    public Teacher setStudent(String student) {
        this.student = student;
        return this;
    }

    @Override
    public String toString() {
        return id + ". " + name + " " + surname + " " + age + " " + email + " [ Students: " + student + " ] ";
    }
}
