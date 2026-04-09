package com.sukur.new_educationwebapp;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "systemStatusServlet", value = "/system-status")
public class SystemStatusServlet extends HttpServlet {
    // Server hər dəfə redeploy olanda bu dəyişən yenidən yaranacaq (və vaxt dəyişəcək)
    private static final long START_TIME = System.currentTimeMillis();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        // Startup vaxtını JSON olaraq qaytarırıq
        response.getWriter().write("{\"startTime\": " + START_TIME + "}");
    }
}
