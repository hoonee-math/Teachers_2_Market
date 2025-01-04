package com.ttt.controller.post;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.ttt.dto.Member2;
import com.ttt.service.PostService;

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
			default: request.getRequestDispatcher("/WEB-INF/index.jsp").forward(request, response);
        }
	}

	// "/post/report/submit"으로 들어오는 요청에 게시글 등록 로직 실행시키기
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
        String path = uri.substring(request.getContextPath().length());
        
        if(!path.equals("/post/write/submit")) {
        	/* 잘못된 접근인 경우 */
        	request.getRequestDispatcher("/WEB-INF/index.jsp").forward(request, response);
        } else {
        	/* 요청 주소 path 값이 /post/write/submit 가 맞는 경우 */
        	
        	request.setCharacterEncoding("UTF-8");
    	    // 응답 설정
    	    response.setContentType("application/json;charset=utf-8");
    	    PrintWriter out = response.getWriter();
    	    Map<String, Object> responseData = new HashMap<>();
    	    
    	    try {
    	        // 1. 로그인 체크 (확인)
    	        Member2 loginMember = (Member2)request.getSession().getAttribute("loginMember");
    	        if(loginMember == null) {
    	            throw new RuntimeException("회원만 접근 가능합니다.");
    	        }

    	        // 2. 파라미터 받기
                // JSON 데이터 파싱
                JsonObject jsonObject = new Gson().fromJson(request.getReader(), JsonObject.class);
                
                // 트랜잭션 처리
                PostService service = new PostService();
                int result = service.insertPost(jsonObject);
                
    	        if(result > 0) {
    	            responseData.put("success", true);
    	            responseData.put("message", "게시글이 등록되었습니다.");
    	        } else {
    	            throw new RuntimeException("게시글 등록에 실패했습니다.");
    	        }
    	        
    	    } catch(Exception e) {
    	        e.printStackTrace();
    	        responseData.put("success", false);
    	        responseData.put("message", e.getMessage());
    	    }
    	    
    	    // JSON 응답 전송
    	    new Gson().toJson(responseData, out);
        	
        	
        }
	}

}
