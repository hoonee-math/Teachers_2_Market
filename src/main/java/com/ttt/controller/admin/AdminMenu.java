package com.ttt.controller.admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name="adminMenu", urlPatterns = "/admin/menu")
public class AdminMenu extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminMenu() {
        super();
    }
    
    // "/admin/*" 으로 들어오는 모든 요청을 분기처리하여 각 페이지로 응답하기
    // 각 페이지에서의 내용은 ajax 요청으로 처리하기 위한 서블릿 만들기
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// AdminMenuServlet.java
		List<Map<String, Object>> posts = new ArrayList<>();

		// 더미데이터 생성
		for(int i = 1; i <= 20; i++) {
		    Map<String, Object> post = new HashMap<>();
		    Map<String, Object> member = new HashMap<>();
		    
		    member.put("memberNo", 0);
		    member.put("memberName", "관리자");

		    // 기본 데이터 설정 - ERD 컬럼명 규칙 적용
		    post.put("post_no", i);                      // 게시글 번호
		    post.put("post_title", "공지사항 테스트 제목 " + i);  // 게시글 제목
		    post.put("member", member);              // 작성자 객체
		    post.put("reg_date", new Date());            // 등록일
		    post.put("view_count", (int)(Math.random() * 100));  // 조회수
		    post.put("is_fix", i <= 2);                  // 상단고정 여부
		    post.put("product_type", 0);                 // 상품 타입(0:공지사항)
		    
		    // 제목 다양화 (2번째, 4번째 게시글)
		    if(i % 2 == 0) {
		        post.put("post_title", "[필독] 2024년 " + (i/2) + "티꿀모아 공지사항입니다.. 반드시 확인해주세요.");
		    }
		    
		    posts.add(post);
		}

		// request에 데이터 설정
		request.setAttribute("posts", posts);
		
        request.getRequestDispatcher("/WEB-INF/views/admin/adminmenu.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
