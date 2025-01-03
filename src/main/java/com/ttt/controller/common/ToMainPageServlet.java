package com.ttt.controller.common;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ttt.dto.Image2;
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
		
		//각 게시글별 대표 이미지 조회
	    for(Post2 post : populars) {
	        Image2 thumbnail = new BoardService().selectThumbnailByPost(post.getPostNo());
	        // Post2 객체에 이미지 설정
	        if(thumbnail != null) {
	            List<Image2> images = new ArrayList<>();
	            images.add(thumbnail);
	            post.setPostImg(images);
	        }
	    }
		
		request.setAttribute("populars", populars);
		
		request.getRequestDispatcher("/index.jsp").forward(request, response);
	}

}
