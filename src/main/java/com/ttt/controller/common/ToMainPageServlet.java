package com.ttt.controller.common;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ttt.dto.Post2;
import com.ttt.service.BoardService;

@WebServlet(name="home", urlPatterns = {"/home",""})
public class ToMainPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ToMainPageServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//인기글 조회
		List<Post2> populars = new BoardService().selectPostByPopular();
		
		
		
		
		
		
		
		
		request.getRequestDispatcher("/index.jsp").forward(request, response);
	}

}
