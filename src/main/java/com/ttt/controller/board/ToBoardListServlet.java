package com.ttt.controller.board;

import java.io.IOException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/board/list")
public class ToBoardListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ToBoardListServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		LocalDate today = LocalDate.now();
		request.setAttribute("today", today);
		
		String categoryNo = request.getParameter("categoryNo");
		String categoryTitle="";
		switch (categoryNo) {
		case "1": categoryTitle="미취학아동 게시판";break;
		case "2": categoryTitle="초등학생 게시판";break;
		case "3": categoryTitle="중학생 게시판";break;
		case "4": categoryTitle="고등학생 게시판";break;
		case "5": categoryTitle="수험생 게시판";break;
		case "6": categoryTitle="인기글 게시판";break;
		default: categoryTitle="error";break;
		}
		request.setAttribute("categoryTitle", categoryTitle);
		request.getRequestDispatcher("/WEB-INF/views/board/boardList.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
