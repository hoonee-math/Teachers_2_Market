package com.ttt.controller.board;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ttt.dto.Post2;
import com.ttt.service.BoardService;

@WebServlet("/board/list")
public class BoardListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public BoardListServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//파라미터 처리 
		String categoryNo = request.getParameter("categoryNo");
		if(categoryNo == null) categoryNo = "1";
		
		int cPage = 1;
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		} catch (NumberFormatException e) {
			cPage = 1;
		}
		
		int numPerPage = 16;
		
		BoardService service = new BoardService();
		//공지사항 조회
		List<Post2> notice = service.selectNotice();
		request.setAttribute("notices", notice);
		
		//게시글 조회 
		Map<String, Integer> param = Map.of(
				"cPage",cPage,
				"categoryNo",Integer.parseInt(categoryNo));
		
		List<Post2> posts = service.selectPostByCategory(param);
		
		//전체 게시글 수 조회
		int totalData = service.getTotalCount(Integer.parseInt(categoryNo));
		
		//페이징 처리
		int pageBarSize = 5;
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
					.append("/board/list?categoryNo=")
					.append(categoryNo)
					.append("&cPage=")
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
						.append("/board/list?categoryNo=")
						.append(categoryNo)
						.append("&cPage=")
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
					.append("/board/list?categoryNo=")
					.append(categoryNo)
					.append("&cPage=")
					.append(pageEnd + 1)
					.append("\">다음</a></li>");
		}
		pageBar.append("</ul>");
		
		request.setAttribute("posts", posts);
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
