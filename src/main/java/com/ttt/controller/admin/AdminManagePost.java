package com.ttt.controller.admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ttt.dto.Post2;
import com.ttt.service.PostService;

@WebServlet("/admin/manage/post")
public class AdminManagePost extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminManagePost() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 검색 파라미터 (아직 미구현, ajax로 요청 처리)
		String postType = request.getParameter("postType");
		String categoryNo = request.getParameter("categoryNo");
		String keyword = request.getParameter("keyword");
        
		// 페이징 처리를 위한 현재 페이지 정보
		int cpage = 1;
		try {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		} catch (NumberFormatException e) {
			cpage = 1;
		}

		// 페이지당 데이터 수 파라미터 처리
		int numPerPage = 10;
		
		// 현재 페이지에 해당하는 데이터만 추출
		int start = (cpage - 1) * numPerPage;
		int end = start + numPerPage;
		
		Map<String, Object> param = Map.of(
				"start", start,
				"end", end);

		// 게시글 데이터 불러오기
		List<Post2> posts = new PostService().selectAllPost(param);
		
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


		// 페이지바 생성
		StringBuilder pageBar = new StringBuilder();
		pageBar.append("<ul class=\"pagination\">");

		// 이전 페이지
		if (pageStart != 1) {
			pageBar.append("<li class=\"page-item\">").append("<a class=\"page-link\" href=\"")
					.append(request.getContextPath()).append("/admin/manage/post?cpage=").append(pageStart - 1);
			pageBar.append("\">이전</a></li>");
		}

		// 페이지 번호
		for (int i = pageStart; i <= pageEnd; i++) {
			pageBar.append("<li class=\"page-item\">");
			if (i == cpage) {
				pageBar.append("<span class=\"page-link\" style=\"background-color:white; font-weight:bold;\">")
						.append(i).append("</span>");
			} else {
				pageBar.append("<a class=\"page-link\" href=\"").append(request.getContextPath())
						.append("/admin/manage/post?cpage=").append(i);
				pageBar.append("\">").append(i).append("</a>");
			}
			pageBar.append("</li>");
		}

		// 다음 페이지
		if (pageEnd != totalPage) {
			pageBar.append("<li class=\"page-item\">").append("<a class=\"page-link\" href=\"")
					.append(request.getContextPath()).append("/admin/manage/post?cpage=").append(pageEnd + 1);
			pageBar.append("\">다음</a></li>");
		}

		pageBar.append("</ul>");
		
		
		
		// request에 데이터 저장
		request.setAttribute("posts", posts);
		request.setAttribute("pageBar", pageBar);
		request.setAttribute("cpage", cpage);
	    request.setAttribute("keyword", keyword);
		
		request.getRequestDispatcher("/WEB-INF/views/admin/managePost.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
