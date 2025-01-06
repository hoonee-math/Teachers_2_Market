package com.ttt.controller.member;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import com.ttt.common.SqlSessionTemplate;

@WebServlet("/member/enrollmain")
public class ToMemberEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ToMemberEnrollServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
//		동의 체크 여부를 판단하는 로직
		String[] values = {
	            request.getParameter("sign"),
	            request.getParameter("sign2"),
	            //request.getParameter("sign3")
	        };
		// 하나라도 null이면 동의하지 않은 것으로 처리
		for (String value : values) {
            if (value == null) {
                request.setAttribute("errorMessage", "필수 항목에 동의해야 합니다.");
                request.getRequestDispatcher("/WEB-INF/views/enroll/termsofservice.jsp").forward(request, response);
                return;
            }
        }
		
		//region 리스트 조회 로직
		List<String> result = new ArrayList<>();
	
		try {
			SqlSession sqlSession = SqlSessionTemplate.getSession();
			result = sqlSession.selectList("post2.selectDistrict");
			sqlSession.commit();
			sqlSession.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		request.setAttribute("regions", result);
		
		request.getRequestDispatcher("/WEB-INF/views/enroll/enrollmain.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
