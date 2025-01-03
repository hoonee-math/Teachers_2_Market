package com.ttt.controller.post;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/post/toshoppinglist")
public class ViewPostToShoppingListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ViewPostToShoppingListServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int postNo = Integer.parseInt(request.getParameter("postNo"));
		int memberNo = Integer.parseInt(request.getParameter("memberNo"));
		
		
		
		
		//장바구니로 이동하시겠습니까? alert창 띄우고
		// yes->/payment/shoppingList.jsp
		// no->/post/viewpost.jsp
		request.getRequestDispatcher("/WEB-INF/views/post/viewpost.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
