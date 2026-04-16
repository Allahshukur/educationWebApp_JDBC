package com.sukur.educationwebapp.student.repository;

import com.sukur.educationwebapp.comman.MyRepository;
import com.sukur.educationwebapp.student.entity.Student;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import static com.sukur.educationwebapp.db.Db.connection;

public class StudentRepository implements MyRepository<Student> {

    @Override
    public Student create(String name, String surname, String email, int age) {
        Student student = new Student().setName(name).setSurname(surname).setEmail(email).setAge(age);

        try (Connection connection = connection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO students (name, surname, email, age) VALUES (?, ?, ?, ?)");
            preparedStatement.setString(1, student.getName());
            preparedStatement.setString(2, student.getSurname());
            preparedStatement.setString(3, student.getEmail());
            preparedStatement.setInt(4, student.getAge());

            preparedStatement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return student;
    }

    @Override
    public List<Student> findAll() {
        List<Student> students = new ArrayList<>();

        try (Connection connection = connection()) {
            ResultSet resultSet = connection.prepareStatement("SELECT s.id AS student_id,\n" +
                    "       s.name,\n" +
                    "       s.surname,\n" +
                    "       s.age,\n" +
                    "       s.email,\n" +
                    "       s.phone,\n" +
                    "       s.specialty,\n" +
                    "       s.address,\n" +
                    "       s.status,\n" +
                    "       IFNULL(GROUP_CONCAT(CONCAT(t.name, ' ', t.surname) SEPARATOR ', '), '0') AS teachers\n" +
                    "FROM education.students s\n" +
                    "LEFT JOIN student_teacher st ON s.id = st.student_id\n" +
                    "LEFT JOIN teachers t ON st.teacher_id = t.id AND t.deleted = '0'\n" +
                    "WHERE s.deleted = '0' \n" +
                    "GROUP BY s.id, s.name, s.surname, s.age, s.email, s.phone, s.specialty, s.address, s.status;").executeQuery();

            while (resultSet.next()) {
                Student student = new Student()
                        .setId(resultSet.getInt("student_id"))
                        .setName(resultSet.getString("name"))
                        .setSurname(resultSet.getString("surname"))
                        .setAge(resultSet.getInt("age"))
                        .setEmail(resultSet.getString("email"))
                        .setPhone(resultSet.getString("phone"))
                        .setSpecialty(resultSet.getString("specialty"))
                        .setAddress(resultSet.getString("address"))
                        .setStatus(resultSet.getString("status"))
                        .setTeacher(resultSet.getString("teachers"));
                students.add(student);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return students;
    }

    @Override
    public Student findById(int id) {
        Student student = null;

        try (Connection connection = connection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT s.id AS student_id,\n" +
                    "       s.name,\n" +
                    "       s.surname,\n" +
                    "       s.age,\n" +
                    "       s.email,\n" +
                    "       s.phone,\n" +
                    "       s.specialty,\n" +
                    "       s.address,\n" +
                    "       s.status,\n" +
                    "       IFNULL(GROUP_CONCAT(CONCAT(t.name, ' ', t.surname) SEPARATOR ', '), '0') AS teachers\n" +
                    "FROM education.students s\n" +
                    "LEFT JOIN student_teacher st ON s.id = st.student_id\n" +
                    "LEFT JOIN teachers t ON st.teacher_id = t.id AND t.deleted = '0'\n" +
                    "WHERE s.id = ?" +
                    "  AND s.deleted = '0' \n" +
                    "GROUP BY s.id, s.name, s.surname, s.age, s.email, s.phone, s.specialty, s.address, s.status;");
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                student = new Student()
                        .setId(resultSet.getInt("student_id"))
                        .setName(resultSet.getString("name"))
                        .setSurname(resultSet.getString("surname"))
                        .setAge(resultSet.getInt("age"))
                        .setEmail(resultSet.getString("email"))
                        .setPhone(resultSet.getString("phone"))
                        .setSpecialty(resultSet.getString("specialty"))
                        .setAddress(resultSet.getString("address"))
                        .setStatus(resultSet.getString("status"))
                        .setTeacher(resultSet.getString("teachers"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return student;
    }

    @Override
    public List<Student> search(String search) {
        List<Student> students = new ArrayList<>();
        String trimmedSearch = search.trim();
        boolean isFullName = trimmedSearch.contains(" ");

        String sql = "SELECT s.id AS student_id,\n" +
                "       s.name,\n" +
                "       s.surname,\n" +
                "       s.age,\n" +
                "       s.email,\n" +
                "       s.phone,\n" +
                "       s.specialty,\n" +
                "       s.address,\n" +
                "       s.status,\n" +
                "       IFNULL(GROUP_CONCAT(CONCAT(t.name, ' ', t.surname) SEPARATOR ', '), '0') AS teachers\n" +
                "FROM education.students s\n" +
                "LEFT JOIN student_teacher st ON s.id = st.student_id\n" +
                "LEFT JOIN teachers t ON st.teacher_id = t.id AND t.deleted = '0'\n" +
                "WHERE " + (isFullName ? "CONCAT(s.name, ' ', s.surname) LIKE ?" : "(s.name LIKE ? OR s.surname LIKE ?)") + "\n" +
                "  AND s.deleted = '0' \n" +
                "GROUP BY s.id, s.name, s.surname, s.age, s.email, s.phone, s.specialty, s.address, s.status;";

        try (Connection connection = connection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            if (isFullName) {
                preparedStatement.setString(1, "%" + trimmedSearch + "%");
            } else {
                preparedStatement.setString(1, "%" + trimmedSearch + "%");
                preparedStatement.setString(2, "%" + trimmedSearch + "%");
            }
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Student student = new Student()
                        .setId(resultSet.getInt("student_id"))
                        .setName(resultSet.getString("name"))
                        .setSurname(resultSet.getString("surname"))
                        .setAge(resultSet.getInt("age"))
                        .setEmail(resultSet.getString("email"))
                        .setPhone(resultSet.getString("phone"))
                        .setSpecialty(resultSet.getString("specialty"))
                        .setAddress(resultSet.getString("address"))
                        .setStatus(resultSet.getString("status"))
                        .setTeacher(resultSet.getString("teachers"));
                students.add(student);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return students;
    }

    @Override
    public Student update(int id, String name, String surname, String email, int age) {
        Student student = new Student().setId(id).setName(name).setSurname(surname).setEmail(email).setAge(age);

        try (Connection connection = connection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE students SET name = ?, surname = ?, email = ?, age = ? WHERE id = ?");
            preparedStatement.setString(1, student.getName());
            preparedStatement.setString(2, student.getSurname());
            preparedStatement.setString(3, student.getEmail());
            preparedStatement.setInt(4, student.getAge());
            preparedStatement.setInt(5, id);
            preparedStatement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return student;
    }

    @Override
    public int delete(int id) {
        try (Connection connection = connection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE students s " +
                    "LEFT JOIN student_teacher st ON s.id = st.student_id " +
                    "SET s.deleted = '1', st.deleted = '1' " +
                    "WHERE s.id = ? AND s.deleted = '0'");
            preparedStatement.setInt(1, id);
            return preparedStatement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}
