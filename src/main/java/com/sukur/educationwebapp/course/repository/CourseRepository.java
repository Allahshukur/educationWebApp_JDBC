package com.sukur.educationwebapp.course.repository;

import com.sukur.educationwebapp.comman.MyRepository;
import com.sukur.educationwebapp.course.entity.Course;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import static com.sukur.educationwebapp.db.Db.connection;

public class CourseRepository implements MyRepository<Course> {

    private static final String SQL_INSERT     = "INSERT INTO courses (name, description, teacher_id) VALUES (?, ?, ?)";
    private static final String SQL_SELECT_ALL = "SELECT id, name, description, teacher_id FROM courses WHERE deleted = '0'";
    private static final String SQL_SELECT_ID  = "SELECT id, name, description, teacher_id FROM courses WHERE id = ? AND deleted = '0'";
    private static final String SQL_SEARCH     = "SELECT id, name, description, teacher_id FROM courses WHERE (name LIKE ? OR description LIKE ?) AND deleted = '0'";
    private static final String SQL_UPDATE     = "UPDATE courses SET name = ?, description = ?, teacher_id = ? WHERE id = ?";
    private static final String SQL_DELETE     = "UPDATE courses SET deleted = '1' WHERE id = ?";

    /** Web API üçün: parametrlərlə yarat */
    public Course create(String name, String description, int teacherId) {
        Course course = new Course().setName(name).setDescription(description).setTeacherId(teacherId);
        try (Connection conn = connection();
             PreparedStatement ps = conn.prepareStatement(SQL_INSERT)) {
            ps.setString(1, name);
            ps.setString(2, description);
            ps.setInt(3, teacherId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return course;
    }

    @Override
    public Course create() {
        // Console versiyası — web tərəfindən istifadə edilmir
        throw new UnsupportedOperationException("Parametrli create() istifadə edin.");
    }

    @Override
    public List<Course> findAll() {
        List<Course> courses = new ArrayList<>();
        try (Connection conn = connection();
             ResultSet rs = conn.prepareStatement(SQL_SELECT_ALL).executeQuery()) {
            while (rs.next()) {
                courses.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return courses;
    }

    /** Web API üçün: ID ilə tap */
    public Course findById(int id) {
        try (Connection conn = connection();
             PreparedStatement ps = conn.prepareStatement(SQL_SELECT_ID)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public Course findById() {
        throw new UnsupportedOperationException("findById(int id) istifadə edin.");
    }

    @Override
    public List<Course> search(String word) {
        List<Course> courses = new ArrayList<>();
        try (Connection conn = connection();
             PreparedStatement ps = conn.prepareStatement(SQL_SEARCH)) {
            String like = "%" + word + "%";
            ps.setString(1, like);
            ps.setString(2, like);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                courses.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return courses;
    }

    /** Web API üçün: parametrlərlə yenilə */
    public Course update(int id, String name, String description, int teacherId) {
        try (Connection conn = connection();
             PreparedStatement ps = conn.prepareStatement(SQL_UPDATE)) {
            ps.setString(1, name);
            ps.setString(2, description);
            ps.setInt(3, teacherId);
            ps.setInt(4, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new Course().setId(id).setName(name).setDescription(description).setTeacherId(teacherId);
    }

    @Override
    public Course update() {
        throw new UnsupportedOperationException("Parametrli update() istifadə edin.");
    }

    /** Web API üçün: ID ilə sil */
    public int delete(int id) {
        try (Connection conn = connection();
             PreparedStatement ps = conn.prepareStatement(SQL_DELETE)) {
            ps.setInt(1, id);
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public int delete() {
        throw new UnsupportedOperationException("delete(int id) istifadə edin.");
    }

    /** ResultSet-dən Course obyekti yarat */
    private Course mapRow(ResultSet rs) throws Exception {
        return new Course()
                .setId(rs.getInt("id"))
                .setName(rs.getString("name"))
                .setDescription(rs.getString("description"))
                .setTeacherId(rs.getInt("teacher_id"));
    }
}
