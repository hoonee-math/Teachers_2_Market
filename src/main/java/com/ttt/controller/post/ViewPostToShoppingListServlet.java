package com.ttt.controller.post;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ttt.dto.Cart2;
import com.ttt.dto.Member2;
import com.ttt.dto.Post2;

@WebServlet("/post/toshoppinglist")
public class ViewPostToShoppingListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ViewPostToShoppingListServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int postNo = Integer.parseInt(request.getParameter("postNo"));
		int memberNo = Integer.parseInt(request.getParameter("memberNo"));
		
		Post2 post = new Post2();
		post.setPostNo(postNo);
		
		Member2 member = new Member2();
		member.setMemberNo(memberNo);
		
		Cart2 c = Cart2.builder()
				.post(post)
				.member(member)
				.build();
		
		request.getRequestDispatcher("/WEB-INF/views/post/viewpost.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
