package com.ttt.controller.post;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ttt.dto.Image2;
import com.ttt.dto.Post2;
import com.ttt.service.PostService;

@WebServlet("/post/notify")
public class ViewNotifyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	   
	public ViewNotifyServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int postNo = Integer.parseInt(request.getParameter("postNo"));
		
		//Post2 객체 가져오기
		Post2 p = new PostService().selectPostByNo(postNo);
		
		
		//file 판매기한 끝나면 "판매종료" 띄우기 위한 오늘 날짜 받아옴
		LocalDate today = LocalDate.now();
		request.setAttribute("today", today);
		
		request.setAttribute("post", p);
		
		request.getRequestDispatcher("/WEB-INF/views/post/viewpost.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
