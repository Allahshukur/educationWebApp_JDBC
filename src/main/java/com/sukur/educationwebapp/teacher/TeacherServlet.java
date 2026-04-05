package com.sukur.educationwebapp.teacher;

import com.sukur.educationwebapp.teacher.entity.Teacher;
import com.sukur.educationwebapp.teacher.service.TeacherService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "teacherServlet", value = "/teacher")
public class TeacherServlet extends HttpServlet {

    private final TeacherService teacherService = new TeacherService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("teachers.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("create".equals(action)) {
            createTeacher(request, response);
        } else if ("update".equals(action)) {
            updateTeacher(request, response);
        } else if ("delete".equals(action)) {
            deleteTeacher(request, response);
        } else {
            response.sendRedirect("teachers.jsp");
        }
    }

    private void createTeacher(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        String email = request.getParameter("email");
        int age = Integer.parseInt(request.getParameter("age"));

        teacherService.create(name, surname, email, age);
        response.sendRedirect("teachers.jsp");
    }

    private void updateTeacher(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        String email = request.getParameter("email");
        int age = Integer.parseInt(request.getParameter("age"));

        teacherService.update(id, name, surname, email, age);
        response.sendRedirect("teachers.jsp");
    }

    private void deleteTeacher(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        teacherService.delete(id);
        response.sendRedirect("teachers.jsp");
    }
}
