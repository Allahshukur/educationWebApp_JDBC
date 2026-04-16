package com.sukur.educationwebapp.course.repository;

import com.sukur.educationwebapp.course.entity.Course;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import static com.sukur.educationwebapp.db.Db.connection;

public class CourseRepository {

    public Course create(String courseTitle, String courseDescription, String coursePrice, String courseIcon) {
        return null;
    }

    public List<Course> findAll() {
        List<Course> courses = new ArrayList<>();

        try (Connection connection = connection()) {
            ResultSet resultSet = connection.prepareStatement("SELECT * FROM courses WHERE deleted = '0'").executeQuery();
            while (resultSet.next()) {
                Course course = new Course()
                        .setId(resultSet.getInt("id"))
                        .setCourseTitle(resultSet.getString("course_title"))
                        .setCourseDescription(resultSet.getString("course_description"))
                        .setCourseAbout(resultSet.getString("course_about"))
                        .setCourseImage(resultSet.getString("course_image"))
                        .setCourseIcon(resultSet.getString("course_icon"))
                        .setCardColorFrom(resultSet.getString("card_color_from"))
                        .setCardColorTo(resultSet.getString("card_color_to"))
                        .setCoursePrice(resultSet.getBigDecimal("course_price"))
                        .setCourseDiscountPrice(resultSet.getBigDecimal("course_discount_price"))
                        .setCourseDiscountPercent(resultSet.getInt("course_discount_percent"))
                        .setCourseLanguage(resultSet.getString("course_language"))
                        .setCourseLevel(resultSet.getString("course_level"))
                        .setStatus(resultSet.getString("status"))
                        .setDeleted(resultSet.getBoolean("deleted"));
                courses.add(course);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return courses;
    }

    public Course findById(int id) {
        Course course = null;

        try (Connection connection = connection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM courses WHERE id = ? AND deleted = '0'");
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                course = new Course()
                        .setId(resultSet.getInt("id"))
                        .setCourseTitle(resultSet.getString("course_title"))
                        .setCourseDescription(resultSet.getString("course_description"))
                        .setCourseAbout(resultSet.getString("course_about"))
                        .setCourseImage(resultSet.getString("course_image"))
                        .setCourseIcon(resultSet.getString("course_icon"))
                        .setCardColorFrom(resultSet.getString("card_color_from"))
                        .setCardColorTo(resultSet.getString("card_color_to"))
                        .setCoursePrice(resultSet.getBigDecimal("course_price"))
                        .setCourseDiscountPrice(resultSet.getBigDecimal("course_discount_price"))
                        .setCourseDiscountPercent(resultSet.getInt("course_discount_percent"))
                        .setCourseLanguage(resultSet.getString("course_language"))
                        .setCourseLevel(resultSet.getString("course_level"))
                        .setStatus(resultSet.getString("status"))
                        .setDeleted(resultSet.getBoolean("deleted"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return course;
    }
}
