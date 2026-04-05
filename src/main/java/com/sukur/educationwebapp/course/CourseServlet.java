package com.sukur.educationwebapp.course;

import com.sukur.educationwebapp.course.service.CourseService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "courseServlet", value = "/course")
public class CourseServlet extends HttpServlet {

    private final CourseService courseService = new CourseService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle GET requests if needed, e.g., for displaying forms
        response.sendRedirect("courses.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("create".equals(action)) {
            createCourse(request, response);
        } else if ("update".equals(action)) {
            updateCourse(request, response);
        } else if ("delete".equals(action)) {
            deleteCourse(request, response);
        } else {
        response.sendRedirect("courses.jsp");
        }
    }

    private void createCourse(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        int teacherId = Integer.parseInt(request.getParameter("teacherId"));

        courseService.create(name, description, teacherId);
        response.sendRedirect("courses.jsp");
    }

    private void updateCourse(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        int teacherId = Integer.parseInt(request.getParameter("teacherId"));

        courseService.update(id, name, description, teacherId);
        response.sendRedirect("courses.jsp");
    }

    private void deleteCourse(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        courseService.delete(id);
        response.sendRedirect("courses.jsp");
    }
}
