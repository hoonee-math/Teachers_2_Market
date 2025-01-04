package com.ttt.controller.post;

import java.io.BufferedReader;
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
import com.ttt.dto.Post2;
import com.ttt.service.AdminPostService;

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
    	        // 요청 본문을 읽어옴
    	        StringBuilder buffer = new StringBuilder();
    	        BufferedReader reader = request.getReader();
    	        String line;
    	        while ((line = reader.readLine()) != null) {
    	            buffer.append(line);
    	        }
    	        
    	        // JSON 파싱
    	        JsonObject jsonObject = new Gson().fromJson(buffer.toString(), JsonObject.class);
    	        
    	        // 데이터 추출
    	        String postTitle = jsonObject.get("postTitle").getAsString();
    	        String postContent = jsonObject.get("postContent").getAsString();
    	        int isFix = jsonObject.get("isFix").getAsInt();
    	        
    	        // 3. 유효성 검사
    	        if(postTitle == null || postTitle.trim().isEmpty() ||
    	           postContent == null || postContent.trim().isEmpty()) {
    	            throw new RuntimeException("필수 입력값이 누락되었습니다.");
    	        }
    	        
    	        // 4. Post2 객체 생성
    	        Post2 post = Post2.builder()
    	            .postTitle(postTitle)
    	            .postContent(postContent)
    	            .member(loginMember)
    	            .productType(0) // 공지사항
    	            .isFix(isFix)
    	            .build();
    	        
    	        // 5. 서비스 호출
    	        int result = new AdminPostService().insertNotify(post);
    	        
    	        if(result > 0) {
    	            responseData.put("success", true);
    	            responseData.put("message", "공지사항이 등록되었습니다.");
    	            // 새로 생성된 공지사항 번호도 함께 전달
    	            responseData.put("postNo", post.getPostNo());
    	        } else {
    	            throw new RuntimeException("공지사항 등록에 실패했습니다.");
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
