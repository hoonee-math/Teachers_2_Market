package com.ttt.controller.post;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jsoup.Jsoup;
import org.jsoup.safety.Safelist;

import com.ttt.dto.Post2;
import com.ttt.service.PostService;

@WebServlet(name="viewNotify", urlPatterns="/post/notify")
public class ViewNotifyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	   
	public ViewNotifyServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int postNo = Integer.parseInt(request.getParameter("postNo"));
		
		//Post2 객체 가져오기
		Post2 p = new PostService().selectPostByNo(postNo);

		
        String content = p.getPostContent();
        // HTML을 안전하게 정제
        String safeHtml = Jsoup.clean(content, Safelist.relaxed());
        p.setPostContent(safeHtml);
		
		request.setAttribute("post", p);
		
		request.getRequestDispatcher("/WEB-INF/views/admin/notifyView.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
