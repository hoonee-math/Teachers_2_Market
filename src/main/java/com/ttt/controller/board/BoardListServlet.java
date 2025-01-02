package com.ttt.controller.board;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/board/list")
public class BoardListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public BoardListServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//더미데이터 생성
		List<Map<String, Object>> posts = new ArrayList<>();
		
		for (int i=0; i<100; i++) {
			Map<String, Object> post = new HashMap<>();
			Map<String, Object> member = new HashMap<>();
			
			member.put("memberNo", 0);
			member.put("memberName", "나는 작성자!");
			
			post.put("postNo", i);
			post.put("postTitle", "게시판 " + i + "번째 더미데이터");
			post.put("postContent", i + "번째 더미데이터 글의 내용입니당");
			post.put("member2", member);
			post.put("viewCount", (int)(Math.random()*100));
			post.put("productType", (int)(Math.random()*2)+1);
			post.put("categoryNo", (int)(Math.random()*6)+1);
			post.put("subjectNo", (int)(Math.random()*7)+1);
			
			posts.add(post);
		}
		
		
		
		//페이징 처리를 위한 정보
		String categoryNo = request.getParameter("categoryNo");
		if(categoryNo == null) categoryNo = "1";

		int cPage = 1;
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		} catch (NumberFormatException e) {
			e.printStackTrace();
			cPage=1;
		}
		
		final String categoryNoFinal = categoryNo;
		List<Map<String, Object>> filteredPosts = posts.stream()
			    .filter(post -> {
			        Object category = post.get("categoryNo");
			        return category != null && category.toString().equals(categoryNoFinal);
			    })
			    .toList();

		int numPerPage = 16;
		int totalData = filteredPosts.size();
		int totalPage = (int)Math.ceil((double)totalData/numPerPage);
		
		int start = (cPage-1) * numPerPage;
		int end = Math.min(start+numPerPage, totalData);
		List<Map<String,Object>> currentPageData = filteredPosts.subList(start, end);
		
		int pageBarSize = 5;
		int pageStart = ((cPage - 1) / pageBarSize) * pageBarSize + 1;
		int pageEnd = pageStart + pageBarSize - 1;
		if (pageEnd > totalPage) {
		    pageEnd = totalPage;
		}
		
		StringBuilder pageBar = new StringBuilder();
		pageBar.append("<ul class=\"pagination\">");
		
		//이전 버튼 생성
		if(pageStart != 1) {
			pageBar.append("<li class=\"page-item\">")
					.append("<a class=\"page-link\" href=\"")
					.append(request.getContextPath())
					.append("/board/list?categoryNo=")
					.append(categoryNo)
					.append("$cPage=")
					.append(pageStart - 1)
					.append("\">이전</a></li>");
		}
		
		//페이지 번호 생성
		for (int i=pageStart; i<=pageEnd; i++) {
			if(i==cPage) {
				pageBar.append("<li class=\"page-item\">")
						.append("<a class=\"page-link\">")
						.append(i)
						.append("</a></li>");
			} else {
				pageBar.append("<li class=\"page-item\">")
						.append("<a class=\"page-link\" href=\"")
						.append(request.getContextPath())
						.append("/board/list?categoryNo=")
						.append(categoryNo)
						.append("&cPage=")
						.append(i)
						.append("\">")
						.append(i)
						.append("</a></li>");
			}
		}
		
		//다음 페이지
		if(pageEnd != totalPage) {
			pageBar.append("<li class=\"page-item\">")
					.append("<a class=\"page-link\" href=\"")
					.append(request.getContextPath())
					.append("/board/list?categoryNo=")
					.append(categoryNo)
					.append("&cPage=")
					.append(pageEnd + 1)
					.append("\">다음</a></li>");
		}
		pageBar.append("</ul>");
		
		request.setAttribute("posts", currentPageData);
		request.setAttribute("pageBar", pageBar.toString());

		
		//file 판매기한 끝나면 "판매종료" 띄우기 위한 오늘 날짜 받아옴
		LocalDate today = LocalDate.now();
		request.setAttribute("today", today);
		
		categoryNo = request.getParameter("categoryNo");
		String categoryTitle="";
		switch (categoryNo) {
		case "1": categoryTitle="미취학아동 게시판";break;
		case "2": categoryTitle="초등학생 게시판";break;
		case "3": categoryTitle="중학생 게시판";break;
		case "4": categoryTitle="고등학생 게시판";break;
		case "5": categoryTitle="수험생 게시판";break;
		case "6": categoryTitle="인기글 게시판";break;
		default: categoryTitle="error";break;
		}
		request.setAttribute("categoryTitle", categoryTitle);
		request.getRequestDispatcher("/WEB-INF/views/board/boardList.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
