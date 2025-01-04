package com.ttt.controller.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ttt.dto.Post2;
import com.ttt.service.AdminPostService;

@WebServlet("/admin/notify/submit")
public class AdminNotifyWriteSubmitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminNotifyWriteSubmitServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Post2 post = new Post2();
		int result = new AdminPostService().uploadPost(post);
		
		
	}

}
