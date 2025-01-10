package com.ttt.controller.board;

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
import javax.servlet.http.HttpSession;

import com.ttt.dto.Member2;
import com.ttt.dto.Post2;
import com.ttt.service.BoardService;
import com.ttt.service.PostService;

@WebServlet("/member/board/list")
public class MemberPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MemberPostServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false); //로그인 세션 가져오기(없으면 생성 하지않음)
		Member2 m = new Member2();
		m = (Member2)session.getAttribute("loginMember");
		int memberNo = m.getMemberNo();
		
		
		// 페이징 처리를 위한 현재 페이지 정보
		int cPage = 1;
		try {
			cPage = Integer.parseInt(request.getParameter("cpage"));
		} catch (NumberFormatException e) {
			cPage = 1;
		}

		// 페이지당 데이터 수 파라미터 처리
		int numPerPage = 10;
		
		Map<String, Integer> param = Map.of(
				"cPage",cPage,
				"memberNo",memberNo);

		// 게시글 데이터 불러오기
		List<Post2> posts = new PostService().selectAllPostById(param);
		//전체 게시글 수 조회
		int totalData = posts.size();
		
		//페이징 처리
		int pageBarSize = 10;
		int totalPage = (int)Math.ceil((double)totalData/numPerPage);

		int pageStart = ((cPage - 1) / pageBarSize) * pageBarSize + 1;
		int pageEnd = Math.min(pageStart + pageBarSize - 1, totalPage);
		
		//페이지바 생성
		StringBuilder pageBar = new StringBuilder();
		pageBar.append("<ul class=\"pagination\">");
		
			//이전 버튼 생성
		if(pageStart != 1) {
			pageBar.append("<li class=\"page-item\">")
					.append("<a class=\"page-link\" href=\"")
					.append(request.getContextPath())
					.append("/board/list?cPage=")
					.append(pageStart - 1)
					.append("\">이전</a></li>");
		}
		
			//페이지 번호 생성
		for (int i=pageStart; i<=pageEnd; i++) {
			if(i==cPage) {
				pageBar.append("<li class=\"page-item\">")
						.append("<span class=\"page-link\">")
						.append(i)
						.append("</span></li>");
			} else {
				pageBar.append("<li class=\"page-item\">")
						.append("<a class=\"page-link\" href=\"")
						.append(request.getContextPath())
						.append("/board/list?cPage=")
						.append(i)
						.append("\">")
						.append(i)
						.append("</a></li>");
			}
		}
		
			//다음 페이지 버튼
		if(pageEnd != totalPage) {
			pageBar.append("<li class=\"page-item\">")
					.append("<a class=\"page-link\" href=\"")
					.append(request.getContextPath())
					.append("/board/list?cPage=")
					.append(pageEnd + 1)
					.append("\">다음</a></li>");
		}
		pageBar.append("</ul>");
		
		request.setAttribute("posts", posts);
//		request.setAttribute("pageBar", pageBar);
		
		request.getRequestDispatcher("/WEB-INF/views/admin/managePost.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
