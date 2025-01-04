package com.ttt.controller.admin;

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
import com.ttt.dto.Member2;
import com.ttt.dto.Post2;
import com.ttt.service.AdminPostService;

@WebServlet("/admin/notify/submit")
public class AdminNotifyWriteSubmitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminNotifyWriteSubmitServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	    // 응답 설정
	    response.setContentType("application/json;charset=utf-8");
	    PrintWriter out = response.getWriter();
	    Map<String, Object> responseData = new HashMap<>();
	    
	    try {
	        // 1. 로그인 체크 (관리자 여부 확인)
	        Member2 loginMember = (Member2)request.getSession().getAttribute("loginMember");
	        if(loginMember == null || loginMember.getEduType() != 0) {
	        	// test를 위해 주석처리
	            // throw new RuntimeException("관리자만 접근 가능합니다.");
	        }
	        
	        // 2. 파라미터 받기
	        String postTitle = request.getParameter("postTitle");
	        String postContent = request.getParameter("postContent");
	        int isFix = Integer.parseInt(request.getParameter("isFix")); // 상단고정 여부
	        
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
