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

import com.ttt.dto.Member2;
import com.ttt.service.AdminMemberService;

@WebServlet("/admin/manage/member")
public class AdminManageMemberSevlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminManageMemberSevlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	    // 페이징 처리를 위한 변수들
	    int cPage;
	    try {
	        cPage = Integer.parseInt(request.getParameter("cPage"));
	    } catch(NumberFormatException e) {
	        cPage = 1;
	    }
	    
	    int numPerPage;
	    try {
	        numPerPage = Integer.parseInt(request.getParameter("numPerPage"));
	    } catch(NumberFormatException e) {
	        numPerPage = 5; // 기본값 5명씩 출력
	    }
	    
	    List<Member2> allMembers= new AdminMemberService().selectAllMember();
	    
	    // 페이징 처리
	    int totalData = allMembers.size();
	    int totalPage = (int)Math.ceil((double)totalData/numPerPage);
	    int pageBarSize = 5;
	    int startPage = ((cPage-1)/pageBarSize) * pageBarSize + 1;
	    int endPage = startPage + pageBarSize - 1;
	    if(endPage > totalPage) endPage = totalPage;

	    // 현재 페이지 데이터 범위 계산
	    int start = (cPage-1) * numPerPage;
	    int end = Math.min(start + numPerPage, totalData);
	    
	    List<Member2> members = allMembers.subList(start, end);
	    
	    // 페이지바 HTML 생성
	    StringBuilder pageBar = new StringBuilder();
	    pageBar.append("<ul class='pagination'>");
	    
	    // 이전 페이지
	    if(startPage > 1) {
	        pageBar.append("<li><a href='javascript:changePage(" + (startPage-1) + ")'>이전</a></li>");
	    }
	    
	    // 페이지 번호
	    for(int i=startPage; i<=endPage; i++) {
	        if(i == cPage) {
	            pageBar.append("<li><span class='current'>" + i + "</span></li>");
	        } else {
	            pageBar.append("<li><a href='javascript:changePage(" + i + ")'>" + i + "</a></li>");
	        }
	    }
	    
	    // 다음 페이지
	    if(endPage < totalPage) {
	        pageBar.append("<li><a href='javascript:changePage(" + (endPage+1) + ")'>다음</a></li>");
	    }
	    
	    pageBar.append("</ul>");
	    
	    // request에 데이터 저장
	    request.setAttribute("members", members); // 전체 리스트 전달
	    request.setAttribute("pageBar", pageBar.toString());
		
		request.getRequestDispatcher("/WEB-INF/views/admin/manageMember.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
