package com.ttt.controller.admin;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.ttt.dto.Post2;
import com.ttt.service.PostService;

@WebServlet("/admin/notify/toggleFix")
public class AjaxAdminNotifyToggleFixServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AjaxAdminNotifyToggleFixServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// AJAX 응답을 위한 설정
	    response.setContentType("application/json;charset=utf-8");
	    
	    // 클라이언트로부터 전달받은 postNo
	    int postNo = Integer.parseInt(request.getParameter("postNo"));
	    
	    // 결과 저장할 Map 객체 생성
	    Map<String, Object> resultMap = new HashMap<>();
	    
	    try {
	        // 공지사항 상단고정 상태 토글 처리
	        int result = new PostService().toggleNotifyFix(postNo);
	        
	        if(result > 0) {
	            // 업데이트 성공 시, 변경된 상태값 조회
	            Post2 updatedPost = new PostService().selectPostByNoOnAdminMenu(postNo);
	            resultMap.put("success", true);
	            resultMap.put("isFix", updatedPost.getIsFix());
	        } else {
	            resultMap.put("success", false);
	            resultMap.put("message", "상태 변경에 실패했습니다.");
	        }
	        
	    } catch(Exception e) {
	        resultMap.put("success", false);
	        resultMap.put("message", "서버 오류가 발생했습니다.");
	        e.printStackTrace();
	    }
	    
	    // JSON 응답 생성 및 전송
	    new Gson().toJson(resultMap, response.getWriter());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
