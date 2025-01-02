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
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// 페이징 처리를 위한 현재 페이지 정보
	    int cpage = 1;
	    try {
	        cpage = Integer.parseInt(request.getParameter("cpage"));
	    } catch (NumberFormatException e) {
	    	e.printStackTrace();
	    }

	    // 페이지당 게시물 수
	    int numPerPage = 10;
		
		// AdminMenuServlet.java
		List<Map<String, Object>> posts = new ArrayList<>();

		// 더미데이터 생성
		for(int i = 1; i <= 20; i++) {
		    Map<String, Object> post = new HashMap<>();
		    Map<String, Object> member = new HashMap<>();
		    
		    member.put("memberNo", 0);
		    member.put("memberName", "관리자");

		    // 기본 데이터 설정 - ERD 컬럼명 규칙 적용
		    post.put("postNo", i);                      // 게시글 번호
		    post.put("postTitle", "공지사항 테스트 제목 " + i);  // 게시글 제목
		    post.put("member", member);              // 작성자 객체
		    post.put("postDate", new Date());            // 등록일
		    post.put("viewCount", (int)(Math.random() * 100));  // 조회수
		    post.put("isFix", i <= 2);                  // 상단고정 여부
		    post.put("productType", 0);                 // 상품 타입(0:공지사항)
		    
		    // 제목 다양화 (2번째, 4번째 게시글)
		    if(i % 2 == 0) {
		        post.put("postTitle", "[필독] 2024년 " + (i/2) + "티꿀모아 공지사항입니다.. 반드시 확인해주세요.");
		    }
		    
		    posts.add(post);
		}

		// request에 데이터 설정
		request.setAttribute("posts", posts);
		
		

	    // 전체 데이터 수
	    int totalData = posts.size();

	    // 전체 페이지 수 계산
	    int totalPage = (int) Math.ceil((double) totalData / numPerPage);

	    // 페이지 바 사이즈
	    int pageBarSize = 5;

	    // 페이지 바 시작 번호
	    int pageStart = (((cpage - 1) / pageBarSize) * pageBarSize) + 1;

	    // 페이지 바 종료 번호
	    int pageEnd = pageStart + pageBarSize - 1;
	    if (pageEnd > totalPage) {
	        pageEnd = totalPage;
	    }

	    // 현재 페이지에 해당하는 데이터만 추출
	    int start = (cpage - 1) * numPerPage;
	    int end = Math.min(start + numPerPage, totalData);
	    List<Map<String, Object>> currentPageData = posts.subList(start, end);

	    // 페이지바 생성
	    StringBuilder pageBar = new StringBuilder();
	    pageBar.append("<ul class=\"pagination\">");

	    // 이전 페이지
	    if(pageStart != 1) {
	        pageBar.append("<li class=\"page-item\">")
	               .append("<a class=\"page-link\" href=\"")
	               .append(request.getContextPath())
	               .append("/admin/menu?cpage=")
	               .append(pageStart - 1)
	               .append("\">이전</a></li>");
	    }

	    // 페이지 번호
	    for(int i = pageStart; i <= pageEnd; i++) {
	        if(i == cpage) {
	            pageBar.append("<li class=\"page-item\">")
	                   .append("<span class=\"page-link\" style=\"background-color:white; font-weight:bold;\">")
	                   .append(i)
	                   .append("</span></li>");
	        } else {
	            pageBar.append("<li class=\"page-item\">")
	                   .append("<a class=\"page-link\" href=\"")
	                   .append(request.getContextPath())
	                   .append("/admin/menu?cpage=")
	                   .append(i)
	                   .append("\">")
	                   .append(i)
	                   .append("</a></li>");
	        }
	    }

	    // 다음 페이지
	    if(pageEnd != totalPage) {
	        pageBar.append("<li class=\"page-item\">")
	               .append("<a class=\"page-link\" href=\"")
	               .append(request.getContextPath())
	               .append("/admin/menu?cpage=")
	               .append(pageEnd + 1)
	               .append("\">다음</a></li>");
	    }
	    pageBar.append("</ul>");

	    // request에 데이터 설정
	    request.setAttribute("posts", currentPageData);
	    request.setAttribute("pageBar", pageBar.toString());
	    
	    
		
        request.getRequestDispatcher("/WEB-INF/views/admin/adminmenu.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
