package com.ttt.controller.post;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/post/write/*")
public class WritePostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public WritePostServlet() {
        super();
    }

    // "/post/report/form"으로 들어오는 요청에 대해 게시글 등록 페이지 열어주기
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
        String path = uri.substring(request.getContextPath().length());

        switch(path) {
            case "/post/write/form":
                request.getRequestDispatcher("/WEB-INF/views/post/writepost.jsp").forward(request, response);
                break;
        }
	}

	// "/post/report/submit"으로 들어오는 요청에 게시글 등록 로직 실행시키기
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
