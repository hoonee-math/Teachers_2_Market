package com.ttt.controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ttt.dto.Member2;
import com.ttt.service.MemberService;

@WebServlet(name="memberEnroll", urlPatterns="/member/enrollend")
public class MemberEnrollEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MemberEnrollEndServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("서블릿도착");
		String memberName = request.getParameter("memberName");
		String memberId = request.getParameter("memberId");
		
		String emailId = request.getParameter("emailId");
		String emailDomain = request.getParameter("emailDomain");
		String email = emailId + "@" + emailDomain;
		
		String memberPw = request.getParameter("memberPw");
		String phone = request.getParameter("phone");
		
		String addressNo = request.getParameter("addressNo");
		String addressRoad = request.getParameter("addressRoad");
		String addressDetail = request.getParameter("addressDetail");
		String address = "("+addressNo+") "+addressRoad+" "+addressDetail;
		
		int eduType = 0;
		int birthday = 0;
		int subjectNo = 0;
		try {
			eduType = Integer.parseInt(request.getParameter("eduType"));
			birthday = Integer.parseInt(request.getParameter("birthday"));
			subjectNo = Integer.parseInt(request.getParameter("subjectNo"));
		}catch(Exception e) {
			System.out.println("파싱오류");
			e.printStackTrace();
		};
		
		Member2 m = Member2.builder()
				.memberName(memberName)
				.memberId(memberId)
				.memberPw(memberPw)
				.phone(phone)
				.email(email)
				.address(address)
				.eduType(eduType)
				.birthday(birthday)
				.subjectNo(subjectNo)
				.build();
		
		//db에 저장하기!
		String msg, loc="/";
		
		try {
			System.out.println("디비저장시작");
			int result = new MemberService().insertMember(m);
			msg="회원가입에 성공했습니다!";
			loc="/member/login";
		}catch(Exception e) {
			e.printStackTrace();
			msg="회원가입에 실패하셨습니다. 다시 시도해주세요.";
			loc="/member/enrollmain";
		}
		
		request.setAttribute("msg",msg);
		request.setAttribute("loc",loc);
		
		request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
		
		
		
		
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
