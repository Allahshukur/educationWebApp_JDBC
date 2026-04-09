package com.sukur.new_educationwebapp.teacher.repository;


import com.sukur.new_educationwebapp.comman.MyRepository;
import com.sukur.new_educationwebapp.teacher.entity.Teacher;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import static com.sukur.new_educationwebapp.db.Db.connection;


public class TeacherRepository implements MyRepository<Teacher> {

    @Override
    public Teacher create() {
        Teacher teacher = new Teacher();

        try (Connection connection = connection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO teachers (name, surname, email, age) VALUES (?, ?, ?, ?)");

            System.out.print("Please enter teacher name = ");
            teacher.setName(new Scanner(System.in).nextLine());
            System.out.print("Please enter teacher surname = ");
            teacher.setSurname(new Scanner(System.in).nextLine());
            System.out.print("Please enter teacher email = ");
            teacher.setEmail(new Scanner(System.in).nextLine());
            System.out.print("Please enter teacher age = ");
            teacher.setAge(new Scanner(System.in).nextInt());
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
                    "       IFNULL(GROUP_CONCAT(CONCAT(s.name, ' ', s.surname) SEPARATOR ', '), '0') AS students\n" +
                    "FROM education.teachers t\n" +
                    "LEFT JOIN student_teacher st ON t.id = st.teacher_id\n" +
                    "LEFT JOIN students s ON st.student_id = s.id AND s.deleted = '0'\n" +
                    "WHERE t.deleted = '0' \n" +
                    "GROUP BY t.id, t.name, t.surname, t.age, t.email;").executeQuery();

            while (resultSet.next()) {
                Teacher teacher = new Teacher()
                        .setId(resultSet.getInt("teacher_id"))
                        .setName(resultSet.getString("name"))
                        .setSurname(resultSet.getString("surname"))
                        .setAge(resultSet.getInt("age"))
                        .setEmail(resultSet.getString("email"))
                        .setStudent(resultSet.getString("students"));
                teachers.add(teacher);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return teachers;
    }

    @Override
    public Teacher findById() {
        Teacher teacher = null;
        System.out.print("Axtardiginiz Muellimin id sini qeyd edin: ");
        int id = new Scanner(System.in).nextInt();

        try (Connection connection = connection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT t.id AS teacher_id,\n" +
                    "       t.name,\n" +
                    "       t.surname,\n" +
                    "       t.age,\n" +
                    "       t.email,\n" +
                    "       IFNULL(GROUP_CONCAT(CONCAT(s.name, ' ', s.surname) SEPARATOR ', '), '0') AS students\n" +
                    "FROM education.teachers t\n" +
                    "LEFT JOIN student_teacher st ON t.id = st.teacher_id\n" +
                    "LEFT JOIN students s ON st.student_id = s.id AND s.deleted = '0'\n" +
                    "WHERE t.id = ?" +
                    "  AND t.deleted = '0' \n" +
                    "GROUP BY t.id, t.name, t.surname, t.age, t.email;");
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                teacher = new Teacher()
                        .setId(resultSet.getInt("teacher_id"))
                        .setName(resultSet.getString("name"))
                        .setSurname(resultSet.getString("surname"))
                        .setAge(resultSet.getInt("age"))
                        .setEmail(resultSet.getString("email"))
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
                "       IFNULL(GROUP_CONCAT(CONCAT(s.name, ' ', s.surname) SEPARATOR ', '), '0') AS students\n" +
                "FROM education.teachers t\n" +
                "LEFT JOIN student_teacher st ON t.id = st.teacher_id\n" +
                "LEFT JOIN students s ON st.student_id = s.id AND s.deleted = '0'\n" +
                "WHERE " + (isFullName ? "CONCAT(t.name, ' ', t.surname) LIKE ?" : "(t.name LIKE ? OR t.surname LIKE ?)") + "\n" +
                "  AND t.deleted = '0' \n" +
                "GROUP BY t.id, t.name, t.surname, t.age, t.email;";

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
                        .setStudent(resultSet.getString("students"));
                teachers.add(teacher);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return teachers;
    }

    @Override
    public Teacher update() {
        List<Teacher> teachers = findAll();
        System.out.print("Hansi Mellimi yenilemek isteyirsiz? = ");
        int updateNumber = new Scanner(System.in).nextInt();
        Teacher teacher = teachers.get(updateNumber - 1);
        System.out.println(teacher);
        System.out.println("Yenilemek isteyirsiz? \n Yes \n No");
        String yesNo = new Scanner(System.in).nextLine();

        try (Connection connection = connection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE teachers SET name = ?, surname = ?, age = ?, email = ? WHERE id = ?");
            if (yesNo.equalsIgnoreCase("Yes")) {
                System.out.print("Teacher Name: ");
                teacher.setName(new Scanner(System.in).nextLine());
                System.out.print("Teacher Surname: ");
                teacher.setSurname(new Scanner(System.in).nextLine());
                System.out.print("Teacher Age: ");
                teacher.setAge(new Scanner(System.in).nextInt());
                System.out.print("Teacher Email: ");
                teacher.setEmail(new Scanner(System.in).nextLine());

                preparedStatement.setString(1, teacher.getName());
                preparedStatement.setString(2, teacher.getSurname());
                preparedStatement.setInt(3, teacher.getAge());
                preparedStatement.setString(4, teacher.getEmail());
                preparedStatement.setInt(5, teacher.getId());
            }
            preparedStatement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return teacher;
    }

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
    public int delete() {
        System.out.print("Hansi Muellimi silmek isteyirsiz? ");
        int delId = new Scanner(System.in).nextInt();
        int rowsAffected = 0;

        try (Connection connection = connection();
             PreparedStatement prepareStatement = connection.prepareStatement("UPDATE teachers t " +
                     "LEFT JOIN student_teacher st ON t.id = st.teacher_id " +
                     "SET t.deleted = '1', st.deleted = '1' " +
                     "WHERE t.id = ? AND t.deleted = '0'")) {

            prepareStatement.setInt(1, delId);
            rowsAffected = prepareStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowsAffected;
    }

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
