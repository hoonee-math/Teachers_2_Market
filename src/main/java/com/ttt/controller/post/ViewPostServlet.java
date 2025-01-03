package com.ttt.controller.post;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ttt.dto.Image2;
import com.ttt.dto.Post2;
import com.ttt.service.PostService;

@WebServlet("/post/viewpost")
public class ViewPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	   
	public ViewPostServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int postNo = Integer.parseInt(request.getParameter("postNo"));
		
		//Post2 객체 가져오기
		Post2 p = new PostService().selectPostByNo(postNo);
		
		//이미지 가져오기
		List<Image2> images = new ArrayList<>();
		try {
			images = new PostService().selectImageNo(postNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		request.setAttribute("post", p);
		request.setAttribute("images", images);
		
		request.getRequestDispatcher("/WEB-INF/views/post/viewpost.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
