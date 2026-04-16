package com.sukur.educationwebapp.teacher.repository;

import com.sukur.educationwebapp.comman.MyRepository;
import com.sukur.educationwebapp.teacher.entity.Teacher;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import static com.sukur.educationwebapp.db.Db.connection;

public class TeacherRepository implements MyRepository<Teacher> {

    @Override
    public Teacher create(String name, String surname, String email, int age) {
        Teacher teacher = new Teacher().setName(name).setSurname(surname).setEmail(email).setAge(age);

        try (Connection connection = connection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO teachers (name, surname, email, age) VALUES (?, ?, ?, ?)");
            preparedStatement.setString(1, teacher.getName());
            preparedStatement.setString(2, teacher.getSurname());
            preparedStatement.setString(3, teacher.getEmail());
            preparedStatement.setInt(4, teacher.getAge());

            preparedStatement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return teacher;
    }

    @Override
    public List<Teacher> findAll() {
        List<Teacher> teachers = new ArrayList<>();

        try (Connection connection = connection()) {
            ResultSet resultSet = connection.prepareStatement("SELECT t.id AS teacher_id,\n" +
                    "       t.name,\n" +
                    "       t.surname,\n" +
                    "       t.age,\n" +
                    "       t.email,\n" +
                    "       t.phone,\n" +
                    "       t.position,\n" +
                    "       t.address,\n" +
                    "       t.status,\n" +
                    "       IFNULL(GROUP_CONCAT(CONCAT(s.name, ' ', s.surname) SEPARATOR ', '), '0') AS students\n" +
                    "FROM education.teachers t\n" +
                    "LEFT JOIN student_teacher st ON t.id = st.teacher_id\n" +
                    "LEFT JOIN students s ON st.student_id = s.id AND s.deleted = '0'\n" +
                    "WHERE t.deleted = '0' \n" +
                    "GROUP BY t.id, t.name, t.surname, t.age, t.email, t.phone, t.position, t.address, t.status;").executeQuery();

            while (resultSet.next()) {
                Teacher teacher = new Teacher()
                        .setId(resultSet.getInt("teacher_id"))
                        .setName(resultSet.getString("name"))
                        .setSurname(resultSet.getString("surname"))
                        .setAge(resultSet.getInt("age"))
                        .setEmail(resultSet.getString("email"))
                        .setPhone(resultSet.getString("phone"))
                        .setPosition(resultSet.getString("position"))
                        .setAddress(resultSet.getString("address"))
                        .setStatus(resultSet.getString("status"))
                        .setStudent(resultSet.getString("students"));
                teachers.add(teacher);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return teachers;
    }

    @Override
    public Teacher findById(int id) {
        Teacher teacher = null;

        try (Connection connection = connection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT t.id AS teacher_id,\n" +
                    "       t.name,\n" +
                    "       t.surname,\n" +
                    "       t.age,\n" +
                    "       t.email,\n" +
                    "       t.phone,\n" +
                    "       t.position,\n" +
                    "       t.address,\n" +
                    "       t.status,\n" +
                    "       IFNULL(GROUP_CONCAT(CONCAT(s.name, ' ', s.surname) SEPARATOR ', '), '0') AS students\n" +
                    "FROM education.teachers t\n" +
                    "LEFT JOIN student_teacher st ON t.id = st.teacher_id\n" +
                    "LEFT JOIN students s ON st.student_id = s.id AND s.deleted = '0'\n" +
                    "WHERE t.id = ?" +
                    "  AND t.deleted = '0' \n" +
                    "GROUP BY t.id, t.name, t.surname, t.age, t.email, t.phone, t.position, t.address, t.status;");
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                teacher = new Teacher()
                        .setId(resultSet.getInt("teacher_id"))
                        .setName(resultSet.getString("name"))
                        .setSurname(resultSet.getString("surname"))
                        .setAge(resultSet.getInt("age"))
                        .setEmail(resultSet.getString("email"))
                        .setPhone(resultSet.getString("phone"))
                        .setPosition(resultSet.getString("position"))
                        .setAddress(resultSet.getString("address"))
                        .setStatus(resultSet.getString("status"))
                        .setStudent(resultSet.getString("students"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return teacher;
    }

    @Override
    public List<Teacher> search(String word) {
        List<Teacher> teachers = new ArrayList<>();
        String trimmedWord = word.trim();
        boolean isFullName = trimmedWord.contains(" ");

        String sql = "SELECT t.id AS teacher_id,\n" +
                "       t.name,\n" +
                "       t.surname,\n" +
                "       t.age,\n" +
                "       t.email,\n" +
                "       t.phone,\n" +
                "       t.position,\n" +
                "       t.address,\n" +
                "       t.status,\n" +
                "       IFNULL(GROUP_CONCAT(CONCAT(s.name, ' ', s.surname) SEPARATOR ', '), '0') AS students\n" +
                "FROM education.teachers t\n" +
                "LEFT JOIN student_teacher st ON t.id = st.teacher_id\n" +
                "LEFT JOIN students s ON st.student_id = s.id AND s.deleted = '0'\n" +
                "WHERE " + (isFullName ? "CONCAT(t.name, ' ', t.surname) LIKE ?" : "(t.name LIKE ? OR t.surname LIKE ?)") + "\n" +
                "  AND t.deleted = '0' \n" +
                "GROUP BY t.id, t.name, t.surname, t.age, t.email, t.phone, t.position, t.address, t.status;";
        try (Connection connection = connection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            if (isFullName) {
                preparedStatement.setString(1, "%" + trimmedWord + "%");
            } else {
                preparedStatement.setString(1, "%" + trimmedWord + "%");
                preparedStatement.setString(2, "%" + trimmedWord + "%");
            }
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Teacher teacher = new Teacher()
                        .setId(resultSet.getInt("teacher_id"))
                        .setName(resultSet.getString("name"))
                        .setSurname(resultSet.getString("surname"))
                        .setAge(resultSet.getInt("age"))
                        .setEmail(resultSet.getString("email"))
                        .setPhone(resultSet.getString("phone"))
                        .setPosition(resultSet.getString("position"))
                        .setAddress(resultSet.getString("address"))
                        .setStatus(resultSet.getString("status"))
                        .setStudent(resultSet.getString("students"));
                teachers.add(teacher);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return teachers;
    }

    @Override
    public Teacher update(int id, String name, String surname, String email, int age) {
        Teacher teacher = new Teacher().setId(id).setName(name).setSurname(surname).setEmail(email).setAge(age);

        try (Connection connection = connection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE teachers SET name = ?, surname = ?, email = ?, age = ? WHERE id = ?");
            preparedStatement.setString(1, teacher.getName());
            preparedStatement.setString(2, teacher.getSurname());
            preparedStatement.setString(3, teacher.getEmail());
            preparedStatement.setInt(4, teacher.getAge());
            preparedStatement.setInt(5, id);
            preparedStatement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return teacher;
    }

    @Override
    public int delete(int id) {
        try (Connection connection = connection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE teachers t " +
                    "LEFT JOIN student_teacher st ON t.id = st.teacher_id " +
                    "SET t.deleted = '1', st.deleted = '1' " +
                    "WHERE t.id = ? AND t.deleted = '0'");
            preparedStatement.setInt(1, id);
            return preparedStatement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}
