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
		}

		// 페이지당 데이터 수 파라미터 처리
		int numPerPage = 10;

		// 더미 데이터 생성
		List<Map<String, Object>> posts = new ArrayList<>();
		
		// 더미 데이터 10개 추가
		for (int i = 1; i <= 30; i++) {
			Map<String, Object> post = new HashMap<>();
			Map<String, Object> member = new HashMap<>();
			member.put("memberNo",i);
			member.put("memberNick", "nickname"+i);
			member.put("memberName", "name"+i);
			member.put("memeberId", "id"+i);
			post.put("postNo", i);
			post.put("postDate", new Date());
			post.put("postTitle", i + "상품 제목입니다.");
			post.put("categoryNo", (int)(Math.random() * 7) + 1);
			post.put("member",member);
			post.put("isDeleted", Math.round(Math.random()));
			post.put("productType", (int)(Math.random() * 2) + 1); // 1 또는 2로 설정
			post.put("viewCount",Math.round(Math.random()));


	        // 검색 필터링 적용
	        boolean addPost = true;

			// postType 필터링 (전체(0)가 아닐 때만)
			if (postType != null && !"0".equals(postType)) {
				int postTypeNum = Integer.parseInt(postType);
				int productType = (Integer) post.get("productType");
				addPost = (productType == postTypeNum);
			}

			// categoryNo 필터링 (전체(0)가 아닐 때만)
			if (addPost && categoryNo != null && !"0".equals(categoryNo)) {
				int categoryNoNum = Integer.parseInt(categoryNo);
				int postCategoryNo = (Integer) post.get("categoryNo");
				addPost = (postCategoryNo == categoryNoNum);
			}

			// keyword 필터링 (null이 아니고 검색어가 있을 때만)
			if (addPost && keyword != null && !keyword.isEmpty()) {
				String title = post.get("postTitle").toString().toLowerCase();
				String writer = ((Map<String, Object>) post.get("member")).get("memberNick").toString().toLowerCase();
				addPost = title.contains(keyword.toLowerCase()) || writer.contains(keyword.toLowerCase());
			}
	        if(addPost) {
	            posts.add(post);
	        }
		}

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
		if (pageStart != 1) {
			pageBar.append("<li class=\"page-item\">").append("<a class=\"page-link\" href=\"")
					.append(request.getContextPath()).append("/admin/manage/post?cpage=").append(pageStart - 1);

			// 검색 파라미터 유지
			if (postType != null && !postType.isEmpty())
				pageBar.append("&postType=").append(postType);
			if (categoryNo != null && !categoryNo.isEmpty())
				pageBar.append("&categoryNo=").append(categoryNo);
			if (keyword != null && !keyword.isEmpty())
				pageBar.append("&keyword=").append(keyword);

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

				// 검색 파라미터 유지
				if (postType != null && !postType.isEmpty())
					pageBar.append("&postType=").append(postType);
				if (categoryNo != null && !categoryNo.isEmpty())
					pageBar.append("&categoryNo=").append(categoryNo);
				if (keyword != null && !keyword.isEmpty())
					pageBar.append("&keyword=").append(keyword);

				pageBar.append("\">").append(i).append("</a>");
			}
			pageBar.append("</li>");
		}

		// 다음 페이지
		if (pageEnd != totalPage) {
			pageBar.append("<li class=\"page-item\">").append("<a class=\"page-link\" href=\"")
					.append(request.getContextPath()).append("/admin/manage/post?cpage=").append(pageEnd + 1);

			// 검색 파라미터 유지
			if (postType != null && !postType.isEmpty())
				pageBar.append("&postType=").append(postType);
			if (categoryNo != null && !categoryNo.isEmpty())
				pageBar.append("&categoryNo=").append(categoryNo);
			if (keyword != null && !keyword.isEmpty())
				pageBar.append("&keyword=").append(keyword);

			pageBar.append("\">다음</a></li>");
		}

		pageBar.append("</ul>");
		
		// request에 데이터 저장
		request.setAttribute("posts", currentPageData);
		request.setAttribute("cpage", cpage);
	    request.setAttribute("postType", postType);
	    request.setAttribute("categoryNo", categoryNo);
	    request.setAttribute("keyword", keyword);
		request.setAttribute("pageBar", pageBar.toString());
		
		request.getRequestDispatcher("/WEB-INF/views/admin/managePost.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
